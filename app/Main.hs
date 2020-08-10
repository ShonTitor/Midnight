module Main (main) where
--import Parser (gato)
import Intermediate (vaca)
import System.Environment
import Data.List (intercalate)
import FinalDestination

main :: IO ()
main = do
  let showCode x = intercalate "\n" (map (show) x)
  (s:_) <- getArgs
  --putStrLn s
  --_ <- gato s
  (k,tab) <- vaca s
  putStrLn $ showCode k

  --let (_,gg@(g,f,_)) = interferenceGraph k tab
  --putStrLn $ (show $ map f $ vertices g )
  --putStrLn $ (show g)
  --putStrLn $ (show $ dSatur gg)
  putStrLn $ show $ getColors k tab
  text <- finalDestination k tab
  putStrLn text
  --putStrLn "jaja salu2"
