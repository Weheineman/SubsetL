module AST where

import qualified Data.Set                      as Set

-- Position in the source file.
data FilePos = FilePos{line :: Int, col :: Int} deriving (Eq, Ord)

-- Pretty position printing.
instance Show FilePos where
  show (FilePos l c) = "near line " ++ show l ++ ", column " ++ show c

-- Variable Identifier.
type Id = String

-- Datatypes.
data Type
    = TUnit
    | TInt
    | TBool
    | TSet Type
    | TPair Type Type
    | TFun Type Type
    deriving (Eq, Ord)

-- Pretty type printing.
instance Show Type where
  show TUnit         = "unit"
  show TInt          = "int"
  show TBool         = "bool"
  show (TSet t     ) = "set <" ++ show t ++ ">"
  show (TPair t1 t2) = "[" ++ show t1 ++ ", " ++ show t2 ++ "]"
  show (TFun  t1 t2) = show t1 ++ " -> " ++ show t2

-- Statements. The FilePos is the position of the variable or function that
-- is being declared.
data Stm
    = CompoundStm Stm Stm
    | VarAssStm Type Id Exp FilePos
    | FunDeclStm Type Id Type Id Exp FilePos

-- Pretty statement printing.
instance Show Stm where
  show (CompoundStm stm1 stm2) = show stm1 ++ ";\n" ++ show stm2
  show (VarAssStm ty var ex _) =
    show ty ++ " " ++ show var ++ " := " ++ show ex
  show (FunDeclStm funType funId argType argId ex _) =
    show funType
      ++ " "
      ++ show funId
      ++ "("
      ++ show argType
      ++ " "
      ++ show argId
      ++ ") := "
      ++ show ex

-- Returns the source file position of the variable or function that is declared
-- in the statement.
declFilePos :: Stm -> FilePos
declFilePos (VarAssStm _ _ _ pos     ) = pos
declFilePos (FunDeclStm _ _ _ _ _ pos) = pos


-- Expressions.
data Exp
    = Int Integer FilePos
    | Bool Bool FilePos
    | Pair Exp Exp FilePos
    | EmptySet FilePos
    | SetExt ExpList FilePos
    | SetComp IterList Exp FilePos
    | SetCompFilter IterList Exp Exp FilePos
    | Var Id FilePos
    | RetVal RetValue FilePos
    | FunApp Id Exp FilePos
    | UnOp UnOperator Exp FilePos
    | BinOp BinOperator Exp Exp FilePos
    | Quant Quantifier IterList Exp FilePos
    deriving (Eq, Ord)

-- Pretty expression printing.
instance Show Exp where
  show (Int  i _          ) = show i
  show (Bool b _          ) = show b
  show (Pair e1 e2 _      ) = "[" ++ show e1 ++ ", " ++ show e2 ++ "]"
  show (EmptySet _        ) = "{}"
  show (SetExt eList _    ) = "{" ++ show eList ++ "}"
  show (SetComp iList ex _) = "{" ++ show iList ++ " | " ++ show ex ++ "}"
  show (SetCompFilter iList boolEx ex _) =
    "{" ++ show iList ++ " | " ++ show boolEx ++ " | " ++ show ex ++ "}"
  show (Var    var    _     ) = var
  show (RetVal retVal _     ) = show retVal
  show (FunApp funId ex _   ) = funId ++ "(" ++ show ex ++ ")"
  show (UnOp   op    ex _   ) = show op ++ " " ++ show ex
  show (BinOp op ex1   ex2 _) = show ex1 ++ " " ++ show op ++ " " ++ show ex2
  show (Quant q  iList ex  _) = show q ++ " " ++ show iList ++ " : " ++ show ex

-- Returns the position of the expression in the file.
expFilePos :: Exp -> FilePos
expFilePos (Int  i pos                       ) = pos
expFilePos (Bool b pos                       ) = pos
expFilePos (Pair e1 e2 pos                   ) = pos
expFilePos (EmptySet pos                     ) = pos
expFilePos (SetExt eList pos                 ) = pos
expFilePos (SetComp iList ex pos             ) = pos
expFilePos (SetCompFilter iList boolEx ex pos) = pos
expFilePos (Var    var    pos                ) = pos
expFilePos (RetVal retVal pos                ) = pos
expFilePos (FunApp funId ex pos              ) = pos
expFilePos (UnOp   op    ex pos              ) = pos
expFilePos (BinOp op ex1   ex2 pos           ) = pos
expFilePos (Quant q  iList ex  pos           ) = pos

-- Expression Lists.
data ExpList
   = SingleExp Exp
   | ExpList Exp ExpList
   deriving (Eq, Ord)

-- Pretty Expression List printing.
instance Show ExpList where
  show (SingleExp ex     ) = show ex
  show (ExpList ex exList) = show ex ++ ", " ++ show exList


-- Unary operators.
data UnOperator
    = Minus
    | First
    | Second
    | Card
    deriving (Eq, Ord)

-- Pretty Unary Operator printing.
instance Show UnOperator where
  show Minus  = "-"
  show First  = "first"
  show Second = "second"
  show Card   = "#"

-- Binary Operators.
data BinOperator
    = Add
    | Sub
    | Mul
    | Div
    | Mod
    | Range
    | Lt
    | Gt
    | Eq
    | NEq
    | And
    | Or
    | Elem
    | Subset
    | SubsetEq
    | Union
    | Intersect
    | Diff
    | CartProduct
    deriving (Eq, Ord)

-- Pretty Binary Operator printing.
instance Show BinOperator where
  show Add         = "+"
  show Sub         = "-"
  show Mul         = "*"
  show Div         = "/"
  show Mod         = "%"
  show Range       = ".."
  show Lt          = "<"
  show Gt          = ">"
  show Eq          = "="
  show NEq         = "!="
  show And         = "and"
  show Or          = "or"
  show Elem        = "elem"
  show Subset      = "subset"
  show SubsetEq    = "subsetEq"
  show Union       = "union"
  show Intersect   = "intersect"
  show Diff        = "diff"
  show CartProduct = "cartProduct"

-- Quantifiers.
data Quantifier
    = Exists
    | ForAll
    deriving (Eq, Ord)

-- Pretty Quantifier printing.
instance Show Quantifier where
  show Exists = "exists"
  show ForAll = "forall"

-- Iterator Lists.
data IterList
    = SingleIt Id Exp
    | IterList Id Exp IterList
    deriving (Eq, Ord)

-- Pretty Iterator List printing.
instance Show IterList where
  show (SingleIt var ex      ) = var ++ " in " ++ show ex
  show (IterList var ex iList) = show (SingleIt var ex) ++ ", " ++ show iList

-- Possible return values.
data RetValue
    = VInt Integer
    | VBool Bool
    | VPair RetValue RetValue
    | VSet (Set.Set RetValue)
    | VType Type
    | VFun Id Exp
    deriving (Eq, Ord)

-- Pretty value printing.
instance Show RetValue where
  show (VInt  i    ) = show i
  show (VBool b    ) = show b
  show (VType t    ) = show t
  show (VPair v1 v2) = "(" ++ show v1 ++ ", " ++ show v2 ++ ")"
  show (VSet s     ) = show s
  show (VFun arg ex) = arg ++ " -> " ++ show ex


-- Replaces all ocurrences of the given variable in the Iterator List by the
-- given return value.
replaceVarInItList :: IterList -> Id -> RetValue -> IterList
replaceVarInItList (SingleIt var' ex) var retVal =
  SingleIt var' $ replaceVarInExp ex var retVal
replaceVarInItList (IterList var' ex iList) var retVal = IterList
  var'
  (replaceVarInExp ex var retVal)
  (replaceVarInItList iList var retVal)

-- Replaces all ocurrences of the given variable in the expression list by the
-- given return value.
replaceVarInExpList :: ExpList -> Id -> RetValue -> ExpList
replaceVarInExpList (SingleExp ex) var retVal =
  SingleExp $ replaceVarInExp ex var retVal
replaceVarInExpList (ExpList ex exList) var retVal = ExpList
  (replaceVarInExp ex var retVal)
  (replaceVarInExpList exList var retVal)


-- Replaces all ocurrences of the given variable in the expression by the given
-- return value.
replaceVarInExp :: Exp -> Id -> RetValue -> Exp
replaceVarInExp (Pair ex1 ex2 pos) var retVal =
  Pair (replaceVarInExp ex1 var retVal) (replaceVarInExp ex2 var retVal) pos
replaceVarInExp (SetExt el pos) var retVal =
  SetExt (replaceVarInExpList el var retVal) pos
replaceVarInExp (SetComp il ex pos) var retVal =
  SetComp (replaceVarInItList il var retVal) (replaceVarInExp ex var retVal) pos
replaceVarInExp (SetCompFilter il boolEx ex pos) var retVal = SetCompFilter
  (replaceVarInItList il var retVal)
  (replaceVarInExp boolEx var retVal)
  (replaceVarInExp ex var retVal)
  pos
replaceVarInExp (Var var' pos) var retVal =
  if var' == var then RetVal retVal pos else Var var' pos
replaceVarInExp (FunApp funId ex pos) var retVal =
  FunApp funId (replaceVarInExp ex var retVal) pos
replaceVarInExp (UnOp op ex pos) var retVal =
  UnOp op (replaceVarInExp ex var retVal) pos
replaceVarInExp (BinOp op ex1 ex2 pos) var retVal =
  BinOp op (replaceVarInExp ex1 var retVal) (replaceVarInExp ex2 var retVal) pos
replaceVarInExp (Quant q iList ex pos) var retVal = Quant
  q
  (replaceVarInItList iList var retVal)
  (replaceVarInExp ex var retVal)
  pos
replaceVarInExp ex _ _ = ex
