{
module MyParser(parse) where

import MyLexer
import AST
}

%name parse
%tokentype { Token }
%error { parseError }

%token
      int             { TokenInt _  _ }
      id              { TokenId _ _ }
      '~'             { TokenNeg _ }
      '+'             { TokenPlus _  }
      '-'             { TokenMinus _  }
      '*'             { TokenTimes _  }
      '/'             { TokenDiv _  }
      '%'             { TokenMod _  }
      '..'            { TokenDots _  }
      '<'             { TokenLt _  }
      '>'             { TokenGt _  }
      '='             { TokenEq _  }
      '!='            { TokenNEq _  }
      '#'             { TokenCard _  }
      tint            { TokenTInt _  }
      tbool           { TokenTBool _  }
      set             { TokenTSet _  }
      true            { TokenTrue _  }
      false           { TokenFalse _  }
      and             { TokenAnd _  }
      or              { TokenOr _  }
      in              { TokenIn _  }
      elem            { TokenElem _  }
      subset          { TokenSubset _  }
      subsetEq        { TokenSubsetEq _  }
      union           { TokenUnion _  }
      intersect       { TokenIntersect _  }
      diff            { TokenDiff _  }
      cartProduct     { TokenCartProduct _  }
      first           { TokenFirst _  }
      second          { TokenSecond _  }
      exists          { TokenExists _  }
      forall          { TokenForAll _  }
      ':='            { TokenAss _  }
      ':'             { TokenColon _  }
      ';'             { TokenSemi _  }
      '|'             { TokenPipe _  }
      ','             { TokenComma _  }
      '['             { TokenLBr _  }
      ']'             { TokenRBr _  }
      '{'             { TokenLCurlyBr _ }
      '}'             { TokenRCurlyBr _ }
      '('             { TokenLParen _ }
      ')'             { TokenRParen _ }

%right ';'
%left ':='
%right '|' ':'
%left exists forall
%left and or
%left '=' '!='
%left subset subsetEq elem union intersect diff cartProduct first second '#'
%left '..'
%left '<' '>'
%left '+' '-'
%left '*' '/' '%'
%right '~'
%%

Stm
  : Type id ':=' Exp                 { VarAssStm $1 (text $2) $4 (tkPos $2) }
  | Type id '(' Type id ')' ':=' Exp { FunDeclStm $1 (text $2) $4 (text $5) $8 (tkPos $2) }
  | Stm ';' Stm                      { CompoundStm $1 $3 }

ExpList
  : Exp ',' ExpList                         { ExpList $1 $3 }
  | Exp                                     { SingleExp $1 }

Exp
  : Atom                                    { $1 }
  | UnOperation                             { $1 }
  | BinOperation                            { $1 }
  | Quantifier                              { $1 }

Atom
  : int                                     { Int (value $1) (tkPos $1) }
  | true                                    { Bool True (tkPos $1) }
  | false                                   { Bool False (tkPos $1) }
  | id                                      { Var (text $1) (tkPos $1) }
  | '[' Exp ',' Exp ']'                     { Pair $2 $4 (tkPos $1) }
  | '{' '}'                                 { EmptySet (tkPos $1) }
  | '{' ExpList '}'                         { SetExt $2 (tkPos $1) }
  | '{' IterList '|' Exp '}'                { SetComp $2 $4 (tkPos $1) }
  | '{' IterList '|' Exp '|' Exp '}'        { SetCompFilter $2 $4 $6 (tkPos $1) }
  | id '(' Exp ')'                          { FunApp (text $1) $3 (tkPos $1) }
  | '(' Exp ')'                             { $2 }

UnOperation
  : '~' Exp                                 { UnOp Minus $2 (tkPos $1) }
  | first Exp                               { UnOp First $2 (tkPos $1) }
  | second Exp                              { UnOp Second $2 (tkPos $1) }
  | '#' Exp                                 { UnOp Card $2 (tkPos $1) }

BinOperation
  : Exp '+' Exp                      { BinOp Add $1 $3 (expFilePos $1) }
  | Exp '-' Exp                      { BinOp Sub $1 $3 (expFilePos $1) }
  | Exp '*' Exp                      { BinOp Mul $1 $3 (expFilePos $1) }
  | Exp '/' Exp                      { BinOp Div $1 $3 (expFilePos $1) }
  | Exp '%' Exp                      { BinOp Mod $1 $3 (expFilePos $1) }
  | Exp '..' Exp                     { BinOp Range $1 $3 (expFilePos $1) }
  | Exp '<' Exp                      { BinOp Lt $1 $3 (expFilePos $1) }
  | Exp '>' Exp                      { BinOp Gt $1 $3 (expFilePos $1) }
  | Exp '=' Exp                      { BinOp Eq $1 $3 (expFilePos $1) }
  | Exp '!=' Exp                     { BinOp NEq $1 $3 (expFilePos $1) }
  | Exp and Exp                      { BinOp And $1 $3 (expFilePos $1) }
  | Exp or Exp                       { BinOp Or $1 $3 (expFilePos $1) }
  | Exp elem Exp                     { BinOp Elem $1 $3 (expFilePos $1) }
  | Exp subset Exp                   { BinOp Subset $1 $3 (expFilePos $1) }
  | Exp subsetEq Exp                 { BinOp SubsetEq $1 $3 (expFilePos $1) }
  | Exp union Exp                    { BinOp Union $1 $3 (expFilePos $1) }
  | Exp intersect Exp                { BinOp Intersect $1 $3 (expFilePos $1) }
  | Exp diff Exp                     { BinOp Diff $1 $3 (expFilePos $1) }
  | Exp cartProduct Exp              { BinOp CartProduct $1 $3 (expFilePos $1) }

Quantifier
  : exists IterList ':' Exp                 { Quant Exists $2 $4 (tkPos $1) }
  | forall IterList ':' Exp                 { Quant ForAll $2 $4 (tkPos $1) }

IterList
  : id in Exp                               { SingleIt (text $1) $3}
  | id in Exp ',' IterList                  { IterList (text $1) $3 $5 }

Type
  : tint                                    { TInt }
  | tbool                                   { TBool }
  | set '<' Type '>'                        { TSet $3 }
  | '[' Type ',' Type ']'                   { TPair $2 $4 }
  | '(' Type ')'                            { $2 }
{

parseError :: [Token] -> a
parseError [] = error "Unknown Parse Error. Maybe at the end of the file?"
parseError (t : _) = error $ "Parse error " ++ (show . tkPos) t ++ "."

}
