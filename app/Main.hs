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
  (code,tab,offsets) <- vaca s
  putStrLn $ showCode code
  putStrLn "\n"
  text <- finalDestination code tab offsets
  putStrLn text
  --putStrLn "jaja salu2"
