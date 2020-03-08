module Main (main) where
--import Parser (gato)
import Intermediate (vaca)
import System.Environment
import Data.List (intercalate)
import FinalDestination

main :: IO ()
main = do
  let showCode x = intercalate "\n" (map (show) x)
  --putStrLn "Hola este es el main"
  (s:_) <- getArgs
  --putStrLn s
  --_ <- gato s
  k <- vaca s
  putStrLn $ showCode k
  _ <- mapM putStrLn $ map show $ makeArcs $ partitionCode k
  putStrLn "jaja salu2"
