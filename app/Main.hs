module Main (main) where
import Parser (gato)
import Intermediate (vaca)
import System.Environment
import Data.List (intercalate)

main :: IO ()
main = do
  --putStrLn "Hola este es el main"
  (s:_) <- getArgs
  --putStrLn s
  k <- gato s
  k <- vaca s
  putStrLn $ intercalate "\n" (map (show) k)
  putStrLn "jaja salu2"
