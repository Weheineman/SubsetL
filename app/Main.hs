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
import           System.Environment


main :: IO ()
main = do
  args <- getArgs
  file <- readFile $ "programs/" ++ (head args)
  let ast = (MyParser.parse . MyLexer.lexer) file in do
    print ast
    print $ typeCheck ast
    case typeCheck ast of
      Error e -> return ()
      _ -> print $ eval ast
