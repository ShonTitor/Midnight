module Main (main) where
--import Parser (gato)
import Intermediate (vaca)
import System.Environment
import Data.List (intercalate)
import Data.Graph
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
  let (_,gg@(g,f,_)) = interferenceGraph k tab
  --putStrLn $ show a
  putStrLn $ (show $ map f $ vertices g )
  putStrLn $ (show g)
  putStrLn $ (show $ dSatur gg)
  --putStrLn $ intercalate "\n" (map show e)
  putStrLn "jaja salu2"
