module Common where

import           Token
import qualified Data.Set                      as Set

-- GUIDIOS: Imagine having error messages.
parseError :: [Token] -> a
parseError _ = error "Parse error"

-- Variable Identifier
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

-- Statements.
data Stm
    = CompoundStm Stm Stm
    | VarAssStm Type Id Exp
    | FunDeclStm Type Id Type Id Exp
    | PrintStm Exp

-- Pretty statement printing.
instance Show Stm where
  show (CompoundStm stm1 stm2) = show stm1 ++ ";\n" ++ show stm2
  show (VarAssStm ty var ex  ) = show ty ++ " " ++ show var ++ " := " ++ show ex
  show (FunDeclStm funType funId argType argId ex) =
    show funType
      ++ " "
      ++ show funId
      ++ "("
      ++ show argType
      ++ " "
      ++ show argId
      ++ ") := "
      ++ show ex
  show (PrintStm ex) = "print(" ++ show ex ++ ")"

-- Expressions.
data Exp
    = Int Integer
    | Bool Bool
    | Pair Exp Exp
    | EmptySet
    | SetExt ExpList
    | SetComp IterList Exp
    | SetCompFilter IterList Exp Exp
    | Var Id
    | RetVal RetValue
    | FunApp Id Exp
    | UnOp UnOperator Exp
    | BinOp BinOperator Exp Exp
    | Quant Quantifier IterList Exp
    deriving (Eq, Ord)

-- Pretty expression printing.
instance Show Exp where
  show (Int  i    )       = show i
  show (Bool b    )       = show b
  show (Pair e1 e2)       = "[" ++ show e1 ++ ", " ++ show e2 ++ "]"
  show EmptySet           = "{}"
  show (SetExt eList    ) = "{" ++ show eList ++ "}"
  show (SetComp iList ex) = "{" ++ show iList ++ " | " ++ show ex ++ "}"
  show (SetCompFilter iList boolEx ex) =
    "{" ++ show iList ++ " | " ++ show boolEx ++ " | " ++ show ex ++ "}"
  show (Var    var        ) = var
  show (RetVal retVal     ) = show retVal
  show (FunApp funId ex   ) = funId ++ "(" ++ show ex ++ ")"
  show (UnOp   op    ex   ) = show op ++ " " ++ show ex
  show (BinOp op ex1   ex2) = show ex1 ++ " " ++ show op ++ " " ++ show ex2
  show (Quant q  iList ex ) = show q ++ " " ++ show iList ++ " : " ++ show ex

-- Lists.
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
  -- GUIDIOS: Esto esta feo
  show (VSet s     ) = show s
  show (VFun arg ex) = arg ++ " -> " ++ show ex

-- Possible errors.
data Error
    = TypeError Type Type Exp
    | VarNotFound Id
    | VarExists Id
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
  show (VarNotFound var) = "\nVariable " ++ var ++ " used but not declared.\n"
  show (VarExists   var) = "\nVariable " ++ var ++ " already declared.\n"
  show (DivZero ex1 ex2) =
    "\nDivision by zero in expresssion:\n"
      ++ show ex1
      ++ "\ndivided by\n"
      ++ show ex2
      ++ "\n"
  show (TypeMatchError typeStr ty ex) =
    "\nExpected Type matching the following pattern: "
      ++ typeStr
      ++ "\nActual Type: "
      ++ show ty
      ++ "\nIn the expression: "
      ++ show ex
  show PatternMatchError
    = "A pattern matching has failed inside a do block. This should not happen, I'm sorry.\n"

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
replaceVarInExp (Pair ex1 ex2) var retVal =
  Pair (replaceVarInExp ex1 var retVal) (replaceVarInExp ex2 var retVal)
replaceVarInExp (SetExt el) var retVal =
  SetExt $ replaceVarInExpList el var retVal
replaceVarInExp (SetComp il ex) var retVal =
  SetComp (replaceVarInItList il var retVal) (replaceVarInExp ex var retVal)
replaceVarInExp (SetCompFilter il boolEx ex) var retVal = SetCompFilter
  (replaceVarInItList il var retVal)
  (replaceVarInExp boolEx var retVal)
  (replaceVarInExp ex var retVal)
replaceVarInExp (Var var') var retVal =
  if var' == var then RetVal retVal else (Var var')
replaceVarInExp (FunApp funId ex) var retVal =
  FunApp funId $ replaceVarInExp ex var retVal
replaceVarInExp (UnOp op ex) var retVal =
  UnOp op $ replaceVarInExp ex var retVal
replaceVarInExp (BinOp op ex1 ex2) var retVal =
  BinOp op (replaceVarInExp ex1 var retVal) (replaceVarInExp ex2 var retVal)
replaceVarInExp (Quant q iList ex) var retVal =
  Quant q (replaceVarInItList iList var retVal) (replaceVarInExp ex var retVal)
replaceVarInExp ex _ _ = ex
