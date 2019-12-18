module Eval where

import           Common
import           State
import qualified Data.Set                      as Set
import qualified Control.Monad.Fail            as Fail

-- Pattern matching is used inside do blocks multiple times. They should never
-- fail, because at this point in the execution the types have already been
-- checked.

eval :: Stm -> Result ()
eval p = runState (evalStm p) initEnv

-- Evaluates a statement. Statements do not return values.
evalStm :: (MonadState m, MonadError m, Fail.MonadFail m) => Stm -> m ()
evalStm (CompoundStm s1 s2) = do
  evalStm s1
  evalStm s2
evalStm (VarAssStm ty var ex) = do
  val <- evalExp ex
  putValue var val
  return ()
evalStm (FunDeclStm retType funId argType argId ex) = do
  putValue funId $ VFun argId ex
  return ()
evalStm (PrintStm ex) = do
-- GUIDIOS: Como printeamos aca??? State deberia ser algo de IO.
  evalExp ex
  return ()

-- Generates a list containing all the results of evaluating the
-- expressions in the ExpList.
evalExpList :: (MonadState m, MonadError m, Fail.MonadFail m) => ExpList -> m [RetValue]
evalExpList (SingleExp ex) = do
  val <- evalExp ex
  return [val]
evalExpList (ExpList ex exList) = do
  val     <- evalExp ex
  valList <- evalExpList exList
  return (val : valList)

-- Auxiliary function for iterator evaluation.
-- Given a variable identifier,a list of possible values it can take and an
-- expression, it returns a list with the return values of the expression for
-- each possible value of the variable.
iterateList :: (MonadState m, MonadError m, Fail.MonadFail m) => Id -> [RetValue] -> Exp -> m [RetValue]
iterateList var [] _ = return []
iterateList var (val:xs) ex = do
  putValue var val
  expVal <- evalExp ex
  delEntry var
  retValList <- iterateList var xs ex
  return $ expVal : retValList


-- Auxiliary function for set comprehension evaluation.
-- Given an Iterator List and an expression, returns a list with all possible
-- values of the expression (combining all possible values of the iterators).
evalSetComp :: (MonadState m, MonadError m, Fail.MonadFail m) => IterList -> Exp -> m [RetValue]
evalSetComp (SingleIt itVar itEx) ex = do
  VSet itSet <- evalExp itEx
  iterateList itVar (Set.toList itSet) ex
evalSetComp (IterList itVar itEx itList) ex = do
  VSet itSet <- evalExp itEx
  iterateList itVar (Set.toList itSet) (SetComp itList ex)

-- Filters the elements of the first list based on the second list, a list
-- of VBool values.
evalFilter :: [RetValue] -> [RetValue] -> [RetValue]
evalFilter [] _ = []
evalFilter (val:valList) (boolVal:boolList) = case boolVal of
  VBool True  -> val : (evalFilter valList boolList)
  VBool False -> evalFilter valList boolList

-- Auxiliary function for Quantifier expression evaluation.
-- Given a Quantifier, an Interator List and an Expression, returns all possible
-- values of the expression (combining all possible values of the iterators).
evalQuant :: (MonadState m, MonadError m, Fail.MonadFail m) => Quantifier -> IterList -> Exp -> m [RetValue]
evalQuant _ (SingleIt itVar itEx) ex = do
  VSet itSet <- evalExp itEx
  iterateList itVar (Set.toList itSet) ex
evalQuant q (IterList itVar itEx itList) ex = do
  VSet itSet <- evalExp itEx
  iterateList itVar (Set.toList itSet) (Quant q itList ex)

-- Evaluates an expression.
evalExp :: (MonadState m, MonadError m, Fail.MonadFail m) => Exp -> m RetValue
evalExp (Int  i  ) = return $ VInt i
evalExp (Bool b  ) = return $ VBool b
evalExp (Pair f s) = do
  vf <- evalExp f
  vs <- evalExp s
  return $ VPair vf vs
evalExp EmptySet    = return $ VSet Set.empty
evalExp (SetExt el) = do
  valList <- evalExpList el
  return $ VSet (Set.fromList valList)
evalExp (SetComp iList ex) = do
  valList <- evalSetComp iList ex
  return $ VSet (Set.fromList valList)
evalExp (SetCompFilter iList filterEx ex) = do
  valList <-  evalSetComp iList ex
  boolList <- evalSetComp iList filterEx
  (return . VSet . Set.fromList) $ evalFilter valList boolList
evalExp (Var var) = do
  val <- getValue var
  return val
evalExp (RetVal retVal) = return retVal
evalExp (FunApp funId argEx) = do
  VFun argId funEx <- getValue funId
  argVal <- evalExp argEx
  retVal <- evalExp $ replaceVarInExp funEx argId argVal
  return retVal
evalExp (UnOp Minus ex) = do
  VInt i <- evalExp ex
  return $ VInt (-i)
evalExp (UnOp First ex) = do
  VPair val _ <- evalExp ex
  return val
evalExp (UnOp Second ex) = do
  VPair _ val <- evalExp ex
  return val
evalExp (UnOp Card ex) = do
  VSet set <- evalExp ex
  return $ VInt ((toInteger . Set.size) set)
evalExp (BinOp Add ex1 ex2) = do
  VInt i1 <- evalExp ex1
  VInt i2 <- evalExp ex2
  return $ VInt (i1 + i2)
evalExp (BinOp Sub ex1 ex2) = do
  VInt i1 <- evalExp ex1
  VInt i2 <- evalExp ex2
  return $ VInt (i1 - i2)
evalExp (BinOp Mul ex1 ex2) = do
  VInt i1 <- evalExp ex1
  VInt i2 <- evalExp ex2
  return $ VInt (i1 * i2)
evalExp (BinOp Div ex1 ex2) = do
  VInt i1 <- evalExp ex1
  VInt i2 <- evalExp ex2
  if i2 == 0 then throwDivZero ex1 ex2 else return $ VInt (i1 `div` i2)
evalExp (BinOp Mod ex1 ex2) = do
  VInt i1 <- evalExp ex1
  VInt i2 <- evalExp ex2
  if i2 == 0 then throwDivZero ex1 ex2 else return $ VInt (i1 `mod` i2)
evalExp (BinOp Range ex1 ex2) = do
  VInt i1 <- evalExp ex1
  VInt i2 <- evalExp ex2
  return $ VSet ((Set.fromList . map VInt) [i1 .. i2])
  -- if i1 > i2
  --   then throwRange ex1 i1 ex2 i2
  --   else return $ VSet ((Set.fromList . map VInt) [i1 .. i2])
evalExp (BinOp Lt ex1 ex2) = do
  VInt i1 <- evalExp ex1
  VInt i2 <- evalExp ex2
  return $ VBool (i1 < i2)
evalExp (BinOp Gt ex1 ex2) = do
  VInt i1 <- evalExp ex1
  VInt i2 <- evalExp ex2
  return $ VBool (i1 > i2)
evalExp (BinOp Eq ex1 ex2) = do
  v1 <- evalExp ex1
  v2 <- evalExp ex2
  return $ VBool (v1 == v2)
evalExp (BinOp NEq ex1 ex2) = do
  v1 <- evalExp ex1
  v2 <- evalExp ex2
  return $ VBool (v1 /= v2)
evalExp (BinOp And ex1 ex2) = do
  VBool b1 <- evalExp ex1
  VBool b2 <- evalExp ex2
  return $ VBool (b1 && b2)
evalExp (BinOp Or ex1 ex2) = do
  VBool b1 <- evalExp ex1
  VBool b2 <- evalExp ex2
  return $ VBool (b1 || b2)
evalExp (BinOp Elem ex1 ex2) = do
  element  <- evalExp ex1
  VSet set <- evalExp ex2
  return $ VBool (element `Set.member` set)
evalExp (BinOp Subset ex1 ex2) = do
  VSet set1 <- evalExp ex1
  VSet set2 <- evalExp ex2
  return $ VBool (set1 `Set.isProperSubsetOf` set2)
evalExp (BinOp SubsetEq ex1 ex2) = do
  VSet set1 <- evalExp ex1
  VSet set2 <- evalExp ex2
  return $ VBool (set1 `Set.isSubsetOf` set2)
evalExp (BinOp Union ex1 ex2) = do
  VSet set1 <- evalExp ex1
  VSet set2 <- evalExp ex2
  return $ VSet (set1 `Set.union` set2)
evalExp (BinOp Intersect ex1 ex2) = do
  VSet set1 <- evalExp ex1
  VSet set2 <- evalExp ex2
  return $ VSet (set1 `Set.intersection` set2)
evalExp (BinOp Diff ex1 ex2) = do
  VSet set1 <- evalExp ex1
  VSet set2 <- evalExp ex2
  return $ VSet (set1 `Set.difference` set2)
evalExp (BinOp CartProduct ex1 ex2) = do
  VSet set1 <- evalExp ex1
  VSet set2 <- evalExp ex2
  let f = (\(x, y) -> VPair x y) in
    (return . VSet) $ Set.map f (set1 `Set.cartesianProduct` set2)
evalExp (Quant Exists iterList ex) = do
  retValList <- evalQuant Exists iterList ex
  let vOr = (\(VBool x) (VBool y) -> VBool $ x || y) in
    return $ foldl vOr (VBool False) retValList
evalExp (Quant ForAll iterList ex) = do
  retValList <- evalQuant Exists iterList ex
  let vAnd = (\(VBool x) (VBool y) -> VBool $ x && y) in
    return $ foldl vAnd (VBool True) retValList
