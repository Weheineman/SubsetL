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
  case args of
    [] -> putStrLn "No input file. Maybe the README can help."
    (fileName:_) -> run fileName


-- Runs a file stored inside the programs folder.
run :: String -> IO ()
run fileName = do
  file <- readFile $ "programs/" ++ fileName
  let ast = (MyParser.parse . MyLexer.lexer) file in do
    case typeCheck ast of
      Error typeErr -> print typeErr
      typeEnv -> do
        putStrLn "Type Check finished succesfully! Type environment:\n"
        print typeEnv
        case eval ast of
          Error evalErr -> print evalErr
          evalEnv -> do
            putStrLn "\nEvaluation finished succesfully! Eval environment:\n"
            print evalEnv
