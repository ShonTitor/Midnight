module Main (main) where
--import Parser (gato)
import Intermediate (vaca)
import System.Environment
import Data.List (intercalate)
import FinalDestination
--import Tablon (showTablon)

main :: IO ()
main = do
  let showCode x = intercalate "\n" (map (show) x)
  (s:_) <- getArgs
  (code,tab,offsets) <- vaca s
  putStrLn $ showCode code
  putStrLn "\n"
  text <- finalDestination code tab offsets
  putStrLn text
  writeFile ("./"++s++".s") text
  --putStrLn $ showTablon tab
  --putStrLn "jaja salu2"
