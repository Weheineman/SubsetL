module TypeEval where

import           Common
import           State
import qualified Control.Monad.Fail            as Fail

-- Checks that the two given types are equal. If they are not,
-- a TypeError is thrown.
checkEqualType
  :: (MonadState m, MonadError m, Fail.MonadFail m)
  => Type
  -> Type
  -> Exp
  -> m ()
checkEqualType (TSet TUnit) (TSet _) ex = return ()
checkEqualType (TSet _) (TSet TUnit) ex = return ()
checkEqualType t1 t2 ex = if t1 /= t2 then throwType t1 t2 ex else return ()

-- Checks if the given program is typed correctly.
typeCheck :: Stm -> Result ()
typeCheck p = runState (typeStm p) initEnv

-- Checks the type of a statement. Statements have no return type.
typeStm :: (MonadState m, MonadError m, Fail.MonadFail m) => Stm -> m ()
typeStm (CompoundStm s1 s2) = do
  typeStm s1
  typeStm s2
typeStm (VarAssStm ty var ex) = do
  ty' <- typeExp ex
  checkEqualType ty ty' ex
  putValue var (VType ty)
  return ()
typeStm (FunDeclStm retType funId argType argId ex) = do
  ty <- typeExp $ replaceVarInExp ex argId (VType argType)
  checkEqualType retType ty ex
  putValue funId (VType $ TFun argType retType)
  return ()
typeStm (PrintStm e) = do
  typeExp e
  return ()

-- Checks the type of an Expression List.
typeExpList
  :: (MonadState m, MonadError m, Fail.MonadFail m) => ExpList -> m Type
typeExpList (SingleExp ex     ) = typeExp ex
typeExpList (ExpList ex exList) = do
  ty  <- typeExp ex
  ty' <- typeExpList exList
  checkEqualType ty' ty ex
  return ty

-- Checks the type of a binary operation, given the expected types of the
-- operands and the result.
typeBinOp
  :: (MonadState m, MonadError m, Fail.MonadFail m)
  => Type
  -> Exp
  -> Type
  -> Exp
  -> Type
  -> m Type
typeBinOp type1 expr1 type2 expr2 retType = do
  type1' <- typeExp expr1
  checkEqualType type1 type1' expr1
  type2' <- typeExp expr2
  checkEqualType type2 type2' expr2
  return retType

-- Checks the type of a binary operation between sets (of the same type).
-- If the return type is TUnit, it returns the type of the sets.
typeSetBinOp
  :: (MonadState m, MonadError m, Fail.MonadFail m)
  => Exp
  -> Exp
  -> Type
  -> m Type
typeSetBinOp expr1 expr2 retType = do
  type1 <- typeExp expr1
  type2 <- typeExp expr2
  case type1 of
    TSet _ -> case type2 of
      TSet _ -> checkEqualType type1 type2 expr2
      _      -> throwTypeMatch "set <Type>" type2 expr2
    _ -> throwTypeMatch "set <Type>" type1 expr1
  if retType == TUnit then return $ type1 else return retType

-- Checks the type of an iterator list.
typeIterList
  :: (MonadState m, MonadError m, Fail.MonadFail m) => IterList -> m ()
typeIterList (SingleIt var ex) = do
  t <- typeExp ex
  case t of
    TSet elemType -> putValue var (VType elemType)
    _      -> throwTypeMatch "set<Type>" t ex
  return ()
typeIterList (IterList var ex iterList) = do
  typeIterList (SingleIt var ex)
  typeIterList iterList

-- Frees all the variables in the IterList
cleanIterList
  :: (MonadState m, MonadError m, Fail.MonadFail m) => IterList -> m ()
cleanIterList (SingleIt var ex) = do
  delEntry var
  return ()
cleanIterList (IterList var ex iterList) = do
  cleanIterList (SingleIt var ex)
  cleanIterList iterList

-- Checks the type of a Quantifier expression.
typeQuant
  :: (MonadState m, MonadError m, Fail.MonadFail m) => IterList -> Exp -> m Type
typeQuant iterList ex = do
  typeIterList iterList
  t <- typeExp ex
  checkEqualType TBool t ex
  cleanIterList iterList
  return TBool

-- Checks the type of an expression.
typeExp :: (MonadState m, MonadError m, Fail.MonadFail m) => Exp -> m Type
typeExp (Int  _  ) = return TInt
typeExp (Bool _  ) = return TBool
typeExp (Pair f s) = do
  tf <- typeExp f
  ts <- typeExp s
  return $ TPair tf ts
typeExp EmptySet    = return $ TSet TUnit
typeExp (SetExt el) = do
  tl <- typeExpList el
  return $ TSet tl
typeExp (SetComp iList ex) = do
  typeIterList iList
  t <- typeExp ex
  cleanIterList iList
  return $ TSet t
typeExp (SetCompFilter iList filterEx ex) = do
  typeIterList iList
  filterT <- typeExp filterEx
  t       <- typeExp ex
  cleanIterList iList
  checkEqualType TBool filterT filterEx
  return $ TSet t
typeExp (Var var) = do
  -- This pattern matching should never fail because all
  -- the values in the environment are VTypes.
  VType t <- getValue var
  return t
typeExp (RetVal (VType t)) = do
  return t
typeExp (FunApp funId ex) = do
  exType        <- typeExp ex
  -- This pattern matching should never fail because all
  -- the values in the environment are VTypes.
  VType funType <- getValue funId
  case funType of
    TFun argType retType -> do
      checkEqualType argType exType ex
      return retType
    _ -> throwTypeMatch ("Type -> Type for identifier " ++ funId)
                        funType
                        (FunApp funId ex)
typeExp (UnOp Minus ex) = do
  t <- typeExp ex
  checkEqualType TInt t ex
  return TInt
typeExp (UnOp First ex) = do
  t <- typeExp ex
  case t of
    TPair t1 _ -> return t1
    _          -> throwTypeMatch "[Type, Type]" t ex
typeExp (UnOp Second ex) = do
  t <- typeExp ex
  case t of
    TPair _ t2 -> return t2
    _          -> throwTypeMatch "[Type, Type]" t ex
typeExp (UnOp Card ex) = do
  t <- typeExp ex
  case t of
    TSet _ -> return TInt
    _      -> throwTypeMatch "set <Type>" t ex
typeExp (BinOp Add   ex1 ex2) = typeBinOp TInt ex1 TInt ex2 TInt
typeExp (BinOp Sub   ex1 ex2) = typeBinOp TInt ex1 TInt ex2 TInt
typeExp (BinOp Mul   ex1 ex2) = typeBinOp TInt ex1 TInt ex2 TInt
typeExp (BinOp Div   ex1 ex2) = typeBinOp TInt ex1 TInt ex2 TInt
typeExp (BinOp Mod   ex1 ex2) = typeBinOp TInt ex1 TInt ex2 TInt
typeExp (BinOp Range ex1 ex2) = typeBinOp TInt ex1 TInt ex2 (TSet TInt)
typeExp (BinOp Lt    ex1 ex2) = typeBinOp TInt ex1 TInt ex2 TBool
typeExp (BinOp Gt    ex1 ex2) = typeBinOp TInt ex1 TInt ex2 TBool
typeExp (BinOp Eq    ex1 ex2) = do
  t1 <- typeExp ex1
  t2 <- typeExp ex2
  checkEqualType t1 t2 ex2
  return TBool
typeExp (BinOp NEq  ex1 ex2) = typeExp (BinOp Eq ex1 ex2)
typeExp (BinOp And  ex1 ex2) = typeBinOp TBool ex1 TBool ex2 TBool
typeExp (BinOp Or   ex1 ex2) = typeBinOp TBool ex1 TBool ex2 TBool
typeExp (BinOp Elem ex1 ex2) = do
  t1 <- typeExp ex1
  t2 <- typeExp ex2
  checkEqualType (TSet t1) t2 ex2
  return TBool
typeExp (BinOp Subset      ex1 ex2) = typeSetBinOp ex1 ex2 TBool
typeExp (BinOp SubsetEq    ex1 ex2) = typeSetBinOp ex1 ex2 TBool
typeExp (BinOp Union       ex1 ex2) = typeSetBinOp ex1 ex2 TUnit
typeExp (BinOp Intersect   ex1 ex2) = typeSetBinOp ex1 ex2 TUnit
typeExp (BinOp Diff        ex1 ex2) = typeSetBinOp ex1 ex2 TUnit
typeExp (BinOp CartProduct ex1 ex2) = do
  type1 <- typeExp ex1
  type2 <- typeExp ex2
  case type1 of
    TSet elemType1 -> case type2 of
      TSet elemType2 -> (return . TSet) $ TPair elemType1 elemType2
      _              -> throwTypeMatch "set <Type>" type2 ex2
    _ -> throwTypeMatch "set <Type>" type1 ex1
typeExp (Quant Exists iterList ex) = typeQuant iterList ex
typeExp (Quant ForAll iterList ex) = typeQuant iterList ex
