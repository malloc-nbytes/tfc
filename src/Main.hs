module Main where

import qualified Data.Map as Map
import System.Environment (getArgs)

import Lexer
import Parser
import Interpreter
import Utility
import Token

usage :: IO ()
usage = do
  putStrLn "tfc usage:"
  putStrLn "  ./tfc <input-file>"

run :: [String] -> IO ()
run (x:y:_) = undefined
run [x] =
  let infp = x
  in do
    src <- readFile infp
    let tokens = Lexer.lexFile src
    -- putStrLn "[tfc Lexer]:"
    -- print tokens >> putStrLn ""
    let nodeProg = Parser.produceProgram tokens
    -- putStrLn "[tfc Parser]:"
    -- print nodeProg >> putStrLn ""
    let (result, outputFilepath) = Interpreter.interpret nodeProg (Global "./out.txt" 5 0 Map.empty)
    writeFile outputFilepath result
    putStrLn "[tfc] Wrote to:"
    putStrLn outputFilepath

main :: IO ()
main = do
  args <- getArgs
  case args of
    [x] -> run args
    _ -> usage
