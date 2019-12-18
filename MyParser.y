{
module MyParser(parse) where

import MyLexer
import Common
import Token
}

%name parse
%tokentype { Token }
%error { parseError }

%token
      int             { TokenInt $$ }
      id              { TokenId $$ }
      '+'             { TokenPlus }
      '-'             { TokenMinus }
      '*'             { TokenTimes }
      '/'             { TokenDiv }
      '%'             { TokenMod }
      '..'            { TokenDots }
      '<'             { TokenLt }
      '>'             { TokenGt }
      '='             { TokenEq }
      '!='            { TokenNEq }
      '#'             { TokenCard }
      print           { TokenPrint }
      tint            { TokenTInt }
      tbool           { TokenTBool }
      set             { TokenTSet }
      true            { TokenTrue }
      false           { TokenFalse }
      and             { TokenAnd }
      or              { TokenOr }
      in              { TokenIn }
      elem            { TokenElem }
      subset          { TokenSubset }
      subsetEq        { TokenSubsetEq }
      union           { TokenUnion }
      intersect       { TokenIntersect }
      diff            { TokenDiff }
      cartProduct     { TokenCartProduct }
      first           { TokenFirst }
      second          { TokenSecond }
      exists          { TokenExists }
      forall          { TokenForAll }
      ':='            { TokenAss }
      ':'             { TokenColon }
      ';'             { TokenSemi }
      '|'             { TokenPipe }
      ','             { TokenComma }
      '['             { TokenLBr }
      ']'             { TokenRBr }
      '{'             { TokenLCurlyBr }
      '}'             { TokenRCurlyBr }
      '('             { TokenLParen }
      ')'             { TokenRParen }

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
%%

Stm
  : Type id ':=' Exp                        { VarAssStm $1 $2 $4 }
  | Type id '(' Type id ')' ':=' Exp        { FunDeclStm $1 $2 $4 $5 $8 }
  | Stm ';' Stm                             { CompoundStm $1 $3 }
  | print '(' Exp ')'                       { PrintStm $3 }

ExpList
  : Exp ',' ExpList                         { ExpList $1 $3 }
  | Exp                                     { SingleExp $1 }

Exp
  : Atom                                    { $1 }
  | UnOperation                             { $1 }
  | BinOperation                            { $1 }
  | Quantifier                              { $1 }

Atom
  : int                                     { Int $1 }
  | true                                    { Bool True }
  | false                                   { Bool False }
  | id                                      { Var $1 }
  | '[' Exp ',' Exp ']'                     { Pair $2 $4 }
  | '{' '}'                                 { EmptySet }
  | '{' ExpList '}'                         { SetExt $2 }
  | '{' IterList '|' Exp '}'                { SetComp $2 $4 }
  | '{' IterList '|' Exp '|' Exp '}'        { SetCompFilter $2 $4 $6 }
  | id '(' Exp ')'                          { FunApp $1 $3 }
  | '(' Exp ')'                             { $2 }

UnOperation
  : '-' Exp                                 { UnOp Minus $2 }
  | first Exp                               { UnOp First $2 }
  | second Exp                              { UnOp Second $2 }
  | '#' Exp                                 { UnOp Card $2 }

BinOperation
  : Exp '+' Exp                             { BinOp Add $1 $3 }
  | Exp '-' Exp                             { BinOp Sub $1 $3 }
  | Exp '*' Exp                             { BinOp Mul $1 $3 }
  | Exp '/' Exp                             { BinOp Div $1 $3 }
  | Exp '%' Exp                             { BinOp Mod $1 $3 }
  | Exp '..' Exp                            { BinOp Range $1 $3 }
  | Exp '<' Exp                             { BinOp Lt $1 $3 }
  | Exp '>' Exp                             { BinOp Gt $1 $3 }
  | Exp '=' Exp                             { BinOp Eq $1 $3 }
  | Exp '!=' Exp                            { BinOp NEq $1 $3 }
  | Exp and Exp                             { BinOp And $1 $3 }
  | Exp or Exp                              { BinOp Or $1 $3 }
  | Exp elem Exp                            { BinOp Elem $1 $3 }
  | Exp subset Exp                          { BinOp Subset $1 $3 }
  | Exp subsetEq Exp                        { BinOp SubsetEq $1 $3 }
  | Exp union Exp                           { BinOp Union $1 $3 }
  | Exp intersect Exp                       { BinOp Intersect $1 $3 }
  | Exp diff Exp                            { BinOp Diff $1 $3 }
  | Exp cartProduct Exp                     { BinOp CartProduct $1 $3 }

Quantifier
  : exists IterList ':' Exp                 { Quant Exists $2 $4 }
  | forall IterList ':' Exp                 { Quant ForAll $2 $4 }

IterList
  : id in Exp                               { SingleIt $1 $3}
  | id in Exp ',' IterList                  { IterList $1 $3 $5 }

Type
  : tint                                    { TInt }
  | tbool                                   { TBool }
  | set '<' Type '>'                        { TSet $3 }
  | '[' Type ',' Type ']'                   { TPair $2 $4 }
  | '(' Type ')'                            { $2 }
{

}
