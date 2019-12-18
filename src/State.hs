module State where

import           AST
import           Control.Applicative            ( Applicative(..) )
import           Control.Monad                  ( ap
                                                , liftM
                                                )
import qualified Control.Monad.Fail            as Fail

-- Environment.
type Env = [(Id, RetValue)]

-- Environment formatting.
envToStr :: Env -> String
envToStr [] = ""
envToStr ((var, retVal) : env) =
  var ++ " := " ++ show retVal ++ "\n" ++ envToStr env

-- Result of a (possibly failed) stateful computation.
data Result a
    = Value (a, Env)
    | Error Error

-- Pretty Result printing.
instance Show (Result a) where
  show (Value (_, env)) = envToStr env
  show (Error err     ) = "Error\n" ++ show err

-- Possible errors.
data Error
    = TypeError Type Type Exp
    | VarNotFound Id FilePos
    | VarExists Id FilePos
    | DivZero Exp Exp
    | TypeMatchError String Type Exp
    | PatternMatchError

-- Pretty error printing.
instance Show Error where
  show (TypeError t1 t2 ex) =
    "\nExpected Type:"
      ++ show t1
      ++ "\nActual Type:"
      ++ show t2
      ++ "\nIn the expression:"
      ++ show ex
      ++ "\n"
      ++ (show . expFilePos) ex
      ++ ".\n"
  show (VarNotFound var pos) =
    "\nVariable " ++ var ++ " used but not declared " ++ show pos ++ ".\n"
  show (VarExists var pos) =
    "\nVariable "
      ++ var
      ++ " already declared. Second declaration "
      ++ show pos
      ++ ".\n"
  show (DivZero ex1 ex2) =
    "\nDivision by zero in expresssion:\n"
      ++ show ex1
      ++ "\n"
      ++ (show . expFilePos) ex1
      ++ "\n"
      ++ "\ndivided by\n"
      ++ show ex2
      ++ "\n"
      ++ (show . expFilePos) ex2
      ++ ".\n"
  show (TypeMatchError typeStr ty ex) =
    "\nExpected Type matching the following pattern: "
      ++ typeStr
      ++ "\nActual Type: "
      ++ show ty
      ++ "\nIn the expression: "
      ++ show ex
      ++ "\n"
      ++ (show . expFilePos) ex
      ++ ".\n"
  show PatternMatchError
    = "A pattern matching has failed inside a do block. This should not happen, I'm sorry.\n"


-- Initial state (empty environment).
initEnv :: Env
initEnv = []

-- Returns true iff there is an entry for the given variable.
hasEntry' :: Id -> Env -> Bool
hasEntry' var [] = False
hasEntry' var ((var', val) : xs) =
  if var == var' then True else hasEntry' var xs

-- Retrieves the value for the given variable in the environment.
getValue' :: Id -> Env -> RetValue
getValue' _ [] = VType TUnit
getValue' var ((var', val) : xs) | var == var' = val
                                 | otherwise   = getValue' var xs

-- Stores the value for the given variable.
putValue' :: Id -> RetValue -> Env -> Env
putValue' var val env = (var, val) : env

-- Removes the entry corresponding to the given variable.
delEntry' :: Id -> Env -> Env
delEntry' _ [] = []
delEntry' var ((var', val) : xs) | var == var' = xs
                                 | otherwise = (var', val) : (delEntry' var xs)

-- State monad.
newtype State a = State { runState :: Env -> Result a }

instance Monad State where
  return x = State (\s -> Value (x, s))
  m >>= f = State $ \s -> case runState m s of
    Error err     -> Error err
    Value (v, s') -> runState (f v) s'

-- A Monad has to be an instance of Functor.
instance Functor State where
  fmap = liftM

-- A Monad has to be an instance of Applicative.
instance Applicative State where
  pure  = return
  (<*>) = ap

-- Functions to manipulate the environment.
getEnv :: State Env
getEnv = State $ \s -> Value (s, s)

putEnv :: Env -> State ()
putEnv newState = State $ \s -> Value ((), newState)

-- A MonadError is a Monad that can throw errors.
class Monad m => MonadError m where
    throwType :: Type -> Type -> Exp -> m a
    throwVarNF :: Id -> FilePos -> m a
    throwVarEx :: Id -> FilePos -> m a
    throwDivZero :: Exp -> Exp -> m a
    throwTypeMatch :: String -> Type -> Exp -> m a
    throwPatternMatch :: m a

instance MonadError State where
  throwType t1 t2 ex = State (\s -> Error $ TypeError t1 t2 ex)
  throwVarNF var pos = State (\s -> Error $ VarNotFound var pos)
  throwVarEx var pos = State (\s -> Error $ VarExists var pos)
  throwDivZero ex1 ex2 = State (\s -> Error $ DivZero ex1 ex2)
  throwTypeMatch typeStr ty ex =
    State (\s -> Error $ TypeMatchError typeStr ty ex)
  throwPatternMatch = State (\s -> Error PatternMatchError)


-- A MonadState is a Monad with variable states.
class MonadError m => MonadState m where
    -- Checks if the variable is free in the current context.
    -- If it already exists, it throws an error.
    checkFree :: Id -> FilePos -> m ()
    -- Retrieves the value for the given variable.
    -- If it doesn't exist, it throws an error.
    getValue :: Id -> FilePos -> m RetValue
    -- Stores the value for the given variable.
    -- If it already exists, it throws an error.
    putValue :: Id -> RetValue -> FilePos -> m ()
    -- Removes the entry corresponding to the given variable.
    delEntry :: Id -> m ()

-- Current instance where the state is a list of (id, RetValue) pairs.
instance MonadState State where
  checkFree var pos = do
    s <- getEnv
    if hasEntry' var s then throwVarEx var pos else return ()
  getValue var pos = do
    s <- getEnv
    case getValue' var s of
      VType TUnit -> throwVarNF var pos
      value       -> return value
  putValue var val pos = do
    checkFree var pos
    s <- getEnv
    putEnv $ putValue' var val s
  delEntry var = do
    s <- getEnv
    putEnv $ delEntry' var s


-- Pattern matching is used in Eval.hs where it should not fail (since the types
-- are checked beforehand in typeEval. To do this, State must be an instance of
-- MonadFail.
instance Fail.MonadFail State where
  fail str = throwPatternMatch
