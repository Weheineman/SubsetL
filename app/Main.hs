module Main
  ( main
  )
where

import           MyLexer
import           MyParser
import           State
import           Common
import           TypeEval
import           Eval

main :: IO ()
main = do
  file <- getContents
  let ast = (MyParser.parse . MyLexer.lexer) file in do
    print ast
    print $ typeCheck ast
    case typeCheck ast of
      Error e -> return ()
      _ -> print $ eval ast
