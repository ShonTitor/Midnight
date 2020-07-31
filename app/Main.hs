module Main (main) where
--import Parser (gato)
import Intermediate (vaca)
import System.Environment
import Data.List (intercalate)
import Data.Array (indices)
import FinalDestination

main :: IO ()
main = do
  let showCode x = intercalate "\n" (map (show) x)
  --putStrLn "Hola este es el main"
  (s:_) <- getArgs
  --putStrLn s
  --_ <- gato s
  (k,tab) <- vaca s
  putStrLn $ showCode k
  --_ <- mapM putStrLn $ map show $ makeArcs (partitionCode k) tab
  let (a,f,_) = flowGraph k tab
  putStrLn $ show a
  putStrLn $ intercalate "\n" (map show (defuse k tab))
  putStrLn "jaja salu2"
