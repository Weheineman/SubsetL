module State where

import           Common
import           Control.Applicative            ( Applicative(..) )
import           Control.Monad                  ( ap
                                                , liftM
                                                )
import qualified Control.Monad.Fail            as Fail

-- Environment.
type Env = [(Id, RetValue)]

-- Result of a (possibly failed) stateful computation.
data Result a
    = Value (a, Env)
    | Error Error
    deriving Show

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
    throwVarNF :: Id -> m a
    throwVarEx :: Id -> m a
    throwDivZero :: Exp -> Exp -> m a
    throwTypeMatch :: String -> Type -> Exp -> m a
    throwPatternMatch :: m a

instance MonadError State where
  throwType t1 t2 ex = State (\s -> Error $ TypeError t1 t2 ex)
  throwVarNF var = State (\s -> Error $ VarNotFound var)
  throwVarEx var = State (\s -> Error $ VarExists var)
  throwDivZero ex1 ex2 = State (\s -> Error $ DivZero ex1 ex2)
  throwTypeMatch typeStr ty ex =
    State (\s -> Error $ TypeMatchError typeStr ty ex)
  throwPatternMatch = State (\s -> Error PatternMatchError)


-- A MonadState is a Monad with variable states.
class MonadError m => MonadState m where
    -- Checks if the variable is free in the current context.
    -- If it already exists, it throws an error.
    checkFree :: Id -> m ()
    -- Retrieves the value for the given variable.
    -- If it doesn't exist, it throws an error.
    getValue :: Id -> m RetValue
    -- Stores the value for the given variable.
    -- If it already exists, it throws an error.
    putValue :: Id -> RetValue -> m ()
    -- Removes the entry corresponding to the given variable.
    delEntry :: Id -> m ()

-- Current instance where the state is a list of (id, RetValue) pairs.
instance MonadState State where
  checkFree var = do
    s <- getEnv
    if hasEntry' var s then throwVarEx var else return ()
  getValue var = do
    s <- getEnv
    case getValue' var s of
      VType TUnit -> throwVarNF var
      value       -> return value
  putValue var val = do
    checkFree var
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
