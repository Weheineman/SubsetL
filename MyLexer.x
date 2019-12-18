{
module MyLexer where

import Token
}

%wrapper "basic"

$digit = 0-9			-- digits
$alpha = [a-zA-Z]		-- alphabetic characters

tokens :-

  $white+				;
  "--".*				;
  "print"               { \s -> TokenPrint }
  "set"                 { \s -> TokenTSet }
  "int"                 { \s -> TokenTInt }
  "bool"                { \s -> TokenTBool }
  "true"                { \s -> TokenTrue }
  "false"               { \s -> TokenFalse }
  "and"                 { \s -> TokenAnd }
  "or"                  { \s -> TokenOr }
  "in"                  { \s -> TokenIn }
  "elem"                { \s -> TokenElem }
  "subset"              { \s -> TokenSubset }
  "subsetEq"            { \s -> TokenSubsetEq }
  "union"               { \s -> TokenUnion }
  "intersect"           { \s -> TokenIntersect }
  "diff"                { \s -> TokenDiff }
  "cartProduct"         { \s -> TokenCartProduct }
  "first"               { \s -> TokenFirst }
  "second"              { \s -> TokenSecond }
  "exists"              { \s -> TokenExists }
  "forall"              { \s -> TokenForAll }
  $digit+			        	{ \s -> TokenInt (read s) }
  ":="				          { \s -> TokenAss }
  ".."                  { \s -> TokenDots }
  \:                    { \s -> TokenColon }
  \;				            { \s -> TokenSemi }
  \|				            { \s -> TokenPipe }
  \[                    { \s -> TokenLBr }
  \]                    { \s -> TokenRBr }
  \{                    { \s -> TokenLCurlyBr }
  \}                    { \s -> TokenRCurlyBr }
  \(                    { \s -> TokenLParen }
  \)                    { \s -> TokenRParen }
  \,                    { \s -> TokenComma }
  \+                    { \s -> TokenPlus }
  \-                    { \s -> TokenMinus }
  \*                    { \s -> TokenTimes }
  \/                    { \s -> TokenDiv }
  \%                    { \s -> TokenMod }
  \<                    { \s -> TokenLt }
  \>                    { \s -> TokenGt }
  \=                    { \s -> TokenEq }
  \#                    { \s -> TokenCard }
  "!="                  { \s -> TokenNEq }
  $alpha [$alpha $digit \_ \']*		{ \s -> TokenId s }

{
-- Each action has type :: String -> Token

lexer = alexScanTokens
}
