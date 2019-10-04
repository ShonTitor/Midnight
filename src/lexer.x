{
module Lexer where
import Data.List
import System.IO
}

%wrapper "posn"

$digit = 0-9      -- digits
$alpha = [a-zA-Z]   -- alphabetic characters

tokens :-
  Space         {\pos s -> TkSpace pos}
  EndofSpace    {\pos s -> TkEndofSpace pos}
  moon          {\pos s -> TkMoon pos}
  new           {\pos s -> TkNew pos}
  full          {\pos s -> TkFull pos}
  planet        {\pos s -> TkPlanet pos}
  cloud         {\pos s -> TkCloud pos}
  star          {\pos s -> TkStar pos}
  blackhole     {\pos s -> TkBlackhole pos}
  cosmos        {\pos s -> TkCosmos pos}
  Constellation {\pos s -> TkConstellation pos}
  Cluster       {\pos s -> TkCluster pos}
  Quasar        {\pos s -> TkQuasar pos}
  Nebula        {\pos s -> TkNebula pos}
  Galaxy        {\pos s -> TkGalaxy pos}
  Quasar        {\pos s -> TkQuasar pos}
  UFO           {\pos s -> TkUFO pos}
  Comet         {\pos s -> TkComet pos}
  Satellite     {\pos s -> TkSatellite pos}
  terraform     {\pos s -> TkTerraform pos}

  print         {\pos s -> TkPrint pos}
  read          {\pos s -> TkRead pos}
  around        {\pos s -> TkAround pos}
  range         {\pos s -> TkRange pos}
  pop           {\pos s -> TkPop pos}
  add           {\pos s -> TkAdd pos}
  bigbang       {\pos s -> TkBigbang pos}
  if            {\pos s -> TkIf pos}
  elseif        {\pos s -> TkElseif pos}
  else          {\pos s -> TkElse pos}
  unless        {\pos s -> TkUnless pos}
  while         {\pos s -> TkWhile pos}
  until         {\pos s -> TkUntil pos}
  orbit         {\pos s -> TkOrbit pos}
  \@            {\pos s -> TkArroba pos}
  \(            {\pos s -> TkParA pos}
  \)            {\pos s -> TkParC pos}
  \[            {\pos s -> TkCorA pos}
  \]            {\pos s -> TkCorC pos}
  \{            {\pos s -> TkLlavA pos}
  \}            {\pos s -> TkLlavC pos}
  \.\.          {\pos s -> TkPuntopunto pos}
  \.            {\pos s -> TkPunto pos}
  \,            {\pos s -> TkComa pos}
  \;            {\pos s -> TkPuntoycoma pos}
  \:            {\pos s -> TkDospuntos pos}
  \~            {\pos s -> TkNyangara pos}
  \+\=          {\pos s -> TkMasIgual pos}
  \+            {\pos s -> TkMas pos}
  \-\=          {\pos s -> TkMenosIgual pos}
  \-            {\pos s -> TkMenos pos}
  \*\=          {\pos s -> TkMultIgual pos}
  \*            {\pos s -> TkMult pos}
  \^\=          {\pos s -> TkPotenciaIgual pos}
  \^            {\pos s -> TkPotencia pos}
  \/\/\=        {\pos s -> TkDivEnteraIgual pos}
  \/\/          {\pos s -> TkDivEntera pos}
  \/\=          {\pos s -> TkDivIgual pos}
  \/            {\pos s -> TkDiv pos}
  \%\=          {\pos s -> TkModIgual pos}
  \%            {\pos s -> TkMod pos}
  \->           {\pos s -> TkFlechita pos}
  >=            {\pos s -> TkMayorIgual pos}
  >             {\pos s -> TkMayor pos}
  \<=           {\pos s -> TkMenorIgual pos}
  \<            {\pos s -> TkMenor pos}
  &&            {\pos s -> TkAnd pos}
  &             {\pos s -> TkBitand pos}
  \|\|          {\pos s -> TkOr pos}
  \|            {\pos s -> TkBitor pos}
  \=\=          {\pos s -> TkIgual pos}
  ¬\=           {\pos s -> TkDistinto pos}
  \=            {\pos s -> TkAsignacion pos}
  ¬             {\pos s -> TkNegacion pos}
  \"($printable #\")*\" {\pos s -> TkString ((read s :: String), pos)}
  \'($printable #\')*\' {\pos s -> TkChar ((read s :: Char), pos)}
  $digit+\.$digit+       { \pos s -> TkFloat ((read s :: Float),  pos)}
  $digit+       { \pos s -> TkInt ((read s :: Int),  pos)}
  $alpha [$alpha $digit \_]*   { \pos s -> TkId (s,  pos)}
  $white+       ;
  .             {\pos s -> TkError (s, pos)}

{
-- Each action has type :: String -> Token

-- The token type:
data Token =
  TkSpace     AlexPosn |
  TkEndofSpace AlexPosn |
  TkMoon      AlexPosn |
  TkNew       AlexPosn |
  TkFull      AlexPosn |
  TkPlanet    AlexPosn |
  TkCloud     AlexPosn |
  TkStar      AlexPosn |
  TkBlackhole AlexPosn |
  TkCosmos    AlexPosn |
  TkConstellation AlexPosn |
  TkCluster   AlexPosn |
  TkQuasar    AlexPosn |
  TkNebula    AlexPosn |
  TkGalaxy    AlexPosn |
  TkUFO       AlexPosn |
  TkComet     AlexPosn |
  TkSatellite AlexPosn |
  TkTerraform AlexPosn |

  TkPrint     AlexPosn |
  TkRead      AlexPosn |
  TkAround    AlexPosn |
  TkRange     AlexPosn |
  TkPop       AlexPosn |
  TkAdd       AlexPosn |
  TkBigbang   AlexPosn |
  TkIf        AlexPosn |
  TkElseif    AlexPosn |
  TkElse      AlexPosn |
  TkUnless    AlexPosn |
  TkWhile     AlexPosn |
  TkUntil     AlexPosn |
  TkOrbit     AlexPosn |
  TkArroba      AlexPosn |
  TkParA      AlexPosn |
  TkParC      AlexPosn |
  TkCorA      AlexPosn |
  TkCorC      AlexPosn |
  TkLlavA     AlexPosn |
  TkLlavC     AlexPosn |
  TkPuntopunto AlexPosn |
  TkPunto     AlexPosn |
  TkComa      AlexPosn |
  TkPuntoycoma AlexPosn |
  TkDospuntos AlexPosn |
  TkNyangara  AlexPosn |
  TkMasIgual  AlexPosn |
  TkMas       AlexPosn |
  TkMenosIgual AlexPosn |
  TkMenos     AlexPosn |
  TkMultIgual AlexPosn |
  TkMult     AlexPosn |
  TkPotenciaIgual AlexPosn |
  TkPotencia  AlexPosn |
  TkDivIgual  AlexPosn |
  TkDiv       AlexPosn |
  TkDivEnteraIgual AlexPosn |
  TkDivEntera AlexPosn |
  TkModIgual  AlexPosn |
  TkMod       AlexPosn |
  TkFlechita  AlexPosn |
  TkMayorIgual AlexPosn |
  TkMayor     AlexPosn |
  TkMenorIgual AlexPosn |
  TkMenor     AlexPosn |
  TkAnd       AlexPosn |
  TkBitand    AlexPosn |
  TkOr        AlexPosn |
  TkBitor     AlexPosn |
  TkIgual     AlexPosn |
  TkDistinto  AlexPosn |
  TkAsignacion AlexPosn |
  TkNegacion  AlexPosn |
  TkString (String, AlexPosn) |
  TkChar (Char, AlexPosn) |
  TkId (String, AlexPosn) |
  TkFloat (Float, AlexPosn) |
  TkInt (Int, AlexPosn) |
  TkError (String, AlexPosn)
  deriving (Eq,Show)

isError :: Token -> Bool
isError (TkError _) = True
isError _ = False

getTokens f = do
  s <- readFile(f)
  return( partition (not.isError) (alexScanTokens s) )
 }