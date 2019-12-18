{
module MyLexer where

import AST
}

%wrapper "posn"

$digit = 0-9			  -- digits
$alpha = [a-zA-Z]		-- alphabetic characters

tokens :-

  $white+				;
  "--".*				;
  "set"                 { \pos str -> TokenTSet pos }
  "int"                 { \pos str -> TokenTInt pos }
  "bool"                { \pos str -> TokenTBool pos }
  "true"                { \pos str -> TokenTrue pos }
  "false"               { \pos str -> TokenFalse pos }
  "and"                 { \pos str -> TokenAnd pos }
  "or"                  { \pos str -> TokenOr pos }
  "in"                  { \pos str -> TokenIn pos }
  "elem"                { \pos str -> TokenElem pos }
  "subset"              { \pos str -> TokenSubset pos }
  "subsetEq"            { \pos str -> TokenSubsetEq pos }
  "union"               { \pos str -> TokenUnion pos }
  "intersect"           { \pos str -> TokenIntersect pos }
  "diff"                { \pos str -> TokenDiff pos }
  "cartProduct"         { \pos str -> TokenCartProduct pos }
  "first"               { \pos str -> TokenFirst pos }
  "second"              { \pos str -> TokenSecond pos }
  "exists"              { \pos str -> TokenExists pos }
  "forall"              { \pos str -> TokenForAll pos }
  $digit+			        	{ \pos str -> TokenInt pos (read str) }
  ":="				          { \pos str -> TokenAss pos }
  ".."                  { \pos str -> TokenDots pos }
  \:                    { \pos str -> TokenColon pos }
  \;				            { \pos str -> TokenSemi pos }
  \|				            { \pos str -> TokenPipe pos }
  \[                    { \pos str -> TokenLBr pos }
  \]                    { \pos str -> TokenRBr pos }
  \{                    { \pos str -> TokenLCurlyBr pos }
  \}                    { \pos str -> TokenRCurlyBr pos }
  \(                    { \pos str -> TokenLParen pos }
  \)                    { \pos str -> TokenRParen pos }
  \,                    { \pos str -> TokenComma pos }
  \+                    { \pos str -> TokenPlus pos }
  \-                    { \pos str -> TokenMinus pos }
  \*                    { \pos str -> TokenTimes pos }
  \/                    { \pos str -> TokenDiv pos }
  \%                    { \pos str -> TokenMod pos }
  \<                    { \pos str -> TokenLt pos }
  \>                    { \pos str -> TokenGt pos }
  \=                    { \pos str -> TokenEq pos }
  \#                    { \pos str -> TokenCard pos }
  "!="                  { \pos str -> TokenNEq pos }
  $alpha [$alpha $digit \_ \']*		{ \pos str -> TokenId pos str }

{
data Token =
     TokenTInt        {position :: AlexPosn}
  |  TokenTBool       {position :: AlexPosn}
  |  TokenTSet        {position :: AlexPosn}
  |  TokenTrue        {position :: AlexPosn}
  |  TokenFalse       {position :: AlexPosn}
  |  TokenAnd         {position :: AlexPosn}
  |  TokenOr          {position :: AlexPosn}
  |  TokenSubset      {position :: AlexPosn}
  |  TokenSubsetEq    {position :: AlexPosn}
  |  TokenUnion       {position :: AlexPosn}
  |  TokenIntersect   {position :: AlexPosn}
  |  TokenDiff        {position :: AlexPosn}
  |  TokenCartProduct {position :: AlexPosn}
  |  TokenIn          {position :: AlexPosn}
  |  TokenElem        {position :: AlexPosn}
  |  TokenFirst       {position :: AlexPosn}
  |  TokenSecond      {position :: AlexPosn}
  |  TokenExists      {position :: AlexPosn}
  |  TokenForAll      {position :: AlexPosn}
  |  TokenAss         {position :: AlexPosn}
  |  TokenDots        {position :: AlexPosn}
  |  TokenColon       {position :: AlexPosn}
  |  TokenSemi        {position :: AlexPosn}
  |  TokenPipe        {position :: AlexPosn}
  |  TokenLBr         {position :: AlexPosn}
  |  TokenRBr         {position :: AlexPosn}
  |  TokenLCurlyBr    {position :: AlexPosn}
  |  TokenRCurlyBr    {position :: AlexPosn}
  |  TokenLParen      {position :: AlexPosn}
  |  TokenRParen      {position :: AlexPosn}
  |  TokenComma       {position :: AlexPosn}
  |  TokenPlus        {position :: AlexPosn}
  |  TokenMinus       {position :: AlexPosn}
  |  TokenTimes       {position :: AlexPosn}
  |  TokenDiv         {position :: AlexPosn}
  |  TokenMod         {position :: AlexPosn}
  |  TokenLt          {position :: AlexPosn}
  |  TokenGt          {position :: AlexPosn}
  |  TokenEq          {position :: AlexPosn}
  |  TokenNEq         {position :: AlexPosn}
  |  TokenCard        {position :: AlexPosn}
  |  TokenId          {position :: AlexPosn, text :: String}
  |  TokenInt         {position :: AlexPosn, value :: Integer}
  deriving (Eq,Show)

-- Returns the source file position of a token.
tkPos :: Token -> FilePos
tkPos t = case position t of
  (AlexPn _ line col) -> FilePos line col

-- Each action has type :: AlexPosn -> String -> Token
lexer = alexScanTokens
}
