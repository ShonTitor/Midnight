module Main (main) where
import Parser (gato)
import System.Environment

main :: IO ()
main = do
  --putStrLn "Hola este es el main"
  (s:_) <- getArgs
  --putStrLn s
  _ <- gato s
  putStrLn "jaja salu2"
