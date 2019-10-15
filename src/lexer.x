{
module Lexer where
import Data.List
}

%wrapper "posn"

$digit = 0-9      -- digits
$alpha = [a-zA-Z]   -- alphabetic characters

tokens :-
  Space         {\pos _ -> TkSpace pos}
  EndofSpace    {\pos _ -> TkEndofSpace pos}
  moon          {\pos _ -> TkMoon pos}
  new           {\pos _ -> TkNew pos}
  full          {\pos _ -> TkFull pos}
  planet        {\pos _ -> TkPlanet pos}
  cloud         {\pos _ -> TkCloud pos}
  star          {\pos _ -> TkStar pos}
  blackhole     {\pos _ -> TkBlackhole pos}
  cosmos        {\pos _ -> TkCosmos pos}
  Constellation {\pos _ -> TkConstellation pos}
  Cluster       {\pos _ -> TkCluster pos}
  Quasar        {\pos _ -> TkQuasar pos}
  Nebula        {\pos _ -> TkNebula pos}
  Galaxy        {\pos _ -> TkGalaxy pos}
  Quasar        {\pos _ -> TkQuasar pos}
  UFO           {\pos _ -> TkUFO pos}
  Comet         {\pos _ -> TkComet pos}
  Satellite     {\pos _ -> TkSatellite pos}
  terraform     {\pos _ -> TkTerraform pos}

  print         {\pos _ -> TkPrint pos}
  read          {\pos _ -> TkRead pos}
  scale         {\pos _ -> TkScale pos}
  around        {\pos _ -> TkAround pos}
  range         {\pos _ -> TkRange pos}
  pop           {\pos _ -> TkPop pos}
  add           {\pos _ -> TkAdd pos}
  bigbang       {\pos _ -> TkBigbang pos}
  if            {\pos _ -> TkIf pos}
  elseif        {\pos _ -> TkElseif pos}
  else          {\pos _ -> TkElse pos}
  unless        {\pos _ -> TkUnless pos}
  while         {\pos _ -> TkWhile pos}
  until         {\pos _ -> TkUntil pos}
  orbit         {\pos _ -> TkOrbit pos}
  break         {\pos _ -> TkBreak pos}
  continue      {\pos _ -> TkContinue pos}
  return        {\pos _ -> TkReturn pos}
  \@            {\pos _ -> TkArroba pos}
  \(            {\pos _ -> TkParA pos}
  \)            {\pos _ -> TkParC pos}
  \[            {\pos _ -> TkCorA pos}
  \]            {\pos _ -> TkCorC pos}
  \{            {\pos _ -> TkLlavA pos}
  \}            {\pos _ -> TkLlavC pos}
  \.\.          {\pos _ -> TkPuntopunto pos}
  \.            {\pos _ -> TkPunto pos}
  \,            {\pos _ -> TkComa pos}
  \;            {\pos _ -> TkPuntoycoma pos}
  \:            {\pos _ -> TkDospuntos pos}
  \~            {\pos _ -> TkNyangara pos}
  \+\=          {\pos _ -> TkMasIgual pos}
  \+            {\pos _ -> TkMas pos}
  \-\=          {\pos _ -> TkMenosIgual pos}
  \-            {\pos _ -> TkMenos pos}
  \*\=          {\pos _ -> TkMultIgual pos}
  \*            {\pos _ -> TkMult pos}
  \^\=          {\pos _ -> TkPotenciaIgual pos}
  \^            {\pos _ -> TkPotencia pos}
  \/\/\=        {\pos _ -> TkDivEnteraIgual pos}
  \/\/          {\pos _ -> TkDivEntera pos}
  \/\=          {\pos _ -> TkDivIgual pos}
  \/            {\pos _ -> TkDiv pos}
  \%\=          {\pos _ -> TkModIgual pos}
  \%            {\pos _ -> TkMod pos}
  \->           {\pos _ -> TkFlechita pos}
  >=            {\pos _ -> TkMayorIgual pos}
  >             {\pos _ -> TkMayor pos}
  \<=           {\pos _ -> TkMenorIgual pos}
  \<            {\pos _ -> TkMenor pos}
  &&            {\pos _ -> TkAnd pos}
  &             {\pos _ -> TkBitand pos}
  \|\|          {\pos _ -> TkOr pos}
  \|            {\pos _ -> TkBitor pos}
  \=\=          {\pos _ -> TkIgual pos}
  ¬\=           {\pos _ -> TkDistinto pos}
  \=            {\pos _ -> TkAsignacion pos}
  ¬             {\pos _ -> TkNegacion pos}
  \"($printable #\")*\" {\pos s -> TkString ((read s :: String), pos)}
  \'($printable #\')*\' {\pos s -> TkChar ((read s :: Char), pos)}
  $digit+\.$digit+       { \pos s -> TkFloat ((read s :: Float),  pos)}
  $digit+       { \pos s -> TkInt ((read s :: Int),  pos)}
  $alpha [$alpha $digit \_]*   { \pos s -> TkId (s,  pos)}
  $white+       ;
  .             {\pos s -> TkError (head s, pos)}

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
  TkScale     AlexPosn |
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
  TkBreak     AlexPosn |
  TkContinue  AlexPosn |
  TkReturn    AlexPosn |
  TkArroba    AlexPosn |
  TkParA      AlexPosn |
  TkParC      AlexPosn |
  TkCorA      AlexPosn |
  TkCorC      AlexPosn |
  TkLlavA     AlexPosn |
  TkLlavC     AlexPosn |
  TkPuntopunto AlexPosn|
  TkPunto     AlexPosn |
  TkComa      AlexPosn |
  TkPuntoycoma AlexPosn|
  TkDospuntos AlexPosn |
  TkNyangara  AlexPosn |
  TkMasIgual  AlexPosn |
  TkMas       AlexPosn |
  TkMenosIgual AlexPosn|
  TkMenos     AlexPosn |
  TkMultIgual AlexPosn |
  TkMult      AlexPosn |
  TkPotenciaIgual AlexPosn|
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
  TkError (Char, AlexPosn)
  deriving (Eq,Show)

isError :: Token -> Bool
isError (TkError _) = True
isError _ = False

perro :: String -> ([Token], [Token])
perro s = partition (not.isError) (alexScanTokens s)

perror ( TkError (e, (AlexPn _ n m)) ) = "Caracter inválido " ++ e : " en la línea " ++ (show n) ++ " columna " ++ (show m)
perror _ = ""

getTokens f = do
  s <- readFile(f)
  let p = perro s
  _ <- mapM putStrLn (map perror (snd p))
  return (fst p)
 }