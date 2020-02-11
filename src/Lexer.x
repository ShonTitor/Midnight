{
module Lexer where
import Data.List
}

%wrapper "posn"

$digit = 0-9      -- digitos
$alpha = [a-zA-Z]   -- alfabéticos
@espchar = \\[nt\"\'\\] -- caracteres especiales

tokens :-
  Space         {\pos _ -> TkSpace pos}
  EndofSpace    {\pos _ -> TkEndofSpace pos}
  moon          {\pos s -> TkMoon (s,  pos)}
  planet        {\pos s -> TkPlanet (s,  pos)}
  cloud         {\pos s -> TkCloud (s,  pos)}
  star          {\pos s -> TkStar (s,  pos)}
  vacuum        {\pos s -> TkVacuum (s,  pos)}
  cosmos        {\pos s -> TkCosmos (s,  pos)}
  Constellation {\pos s -> TkConstellation (s,  pos)}
  Cluster       {\pos s -> TkCluster (s,  pos)}
  Quasar        {\pos s -> TkQuasar (s,  pos)}
  Nebula        {\pos s -> TkNebula (s,  pos)}
  Galaxy        {\pos s -> TkGalaxy (s,  pos)}
  UFO           {\pos s -> TkUFO (s,  pos)}
  Comet         {\pos s -> TkComet (s,  pos)}
  Satellite     {\pos s -> TkSatellite (s,  pos)}
  \~            {\pos s -> TkNyangara (s, pos)}

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
  yield         {\pos _ -> TkYield pos}
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
  \"([$printable # \"] | @espchar)*\" {\pos s -> TkString ((read s :: String), pos)}
  \'([$printable # \'] | @espchar)+\' {\pos s -> TkChar ((read s :: Char), pos)}
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
  TkMoon      (String, AlexPosn) |
  TkPlanet    (String, AlexPosn) |
  TkCloud     (String, AlexPosn) |
  TkStar      (String, AlexPosn) |
  TkVacuum    (String, AlexPosn) |
  TkCosmos    (String, AlexPosn) |
  TkConstellation (String, AlexPosn) |
  TkCluster   (String, AlexPosn) |
  TkQuasar    (String, AlexPosn) |
  TkNebula    (String, AlexPosn) |
  TkGalaxy    (String, AlexPosn) |
  TkUFO       (String, AlexPosn) |
  TkComet     (String, AlexPosn) |
  TkSatellite (String, AlexPosn) |
  TkNyangara  (String, AlexPosn) |
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
  TkYield     AlexPosn |
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

getPos :: Token -> AlexPosn
getPos (TkSpace      p) = p
getPos (TkEndofSpace  p) = p
getPos (TkMoon       (_,  p)) = p
getPos (TkPlanet     (_,  p)) = p
getPos (TkCloud      (_,  p)) = p
getPos (TkStar       (_,  p)) = p
getPos (TkVacuum     (_,  p)) = p
getPos (TkCosmos     (_,  p)) = p
getPos (TkConstellation  (_,  p)) = p
getPos (TkCluster    (_,  p)) = p
getPos (TkQuasar     (_,  p)) = p
getPos (TkNebula     (_,  p)) = p
getPos (TkGalaxy     (_,  p)) = p
getPos (TkUFO        (_,  p)) = p
getPos (TkComet      (_,  p)) = p
getPos (TkSatellite  (_,  p)) = p
getPos (TkPrint      p) = p
getPos (TkRead       p) = p
getPos (TkScale      p) = p
getPos (TkAround     p) = p
getPos (TkRange      p) = p
getPos (TkPop        p) = p
getPos (TkAdd        p) = p
getPos (TkBigbang    p) = p
getPos (TkIf         p) = p
getPos (TkElseif     p) = p
getPos (TkElse       p) = p
getPos (TkUnless     p) = p
getPos (TkWhile      p) = p
getPos (TkUntil      p) = p
getPos (TkOrbit      p) = p
getPos (TkBreak      p) = p
getPos (TkContinue   p) = p
getPos (TkReturn     p) = p
getPos (TkYield      p) = p
getPos (TkArroba     p) = p
getPos (TkParA       p) = p
getPos (TkParC       p) = p
getPos (TkCorA       p) = p
getPos (TkCorC       p) = p
getPos (TkLlavA      p) = p
getPos (TkLlavC      p) = p
getPos (TkPuntopunto  p) = p
getPos (TkPunto      p) = p
getPos (TkComa       p) = p
getPos (TkPuntoycoma  p) = p
getPos (TkDospuntos  p) = p
getPos (TkNyangara   (_,p)) = p
getPos (TkMasIgual   p) = p
getPos (TkMas        p) = p
getPos (TkMenosIgual  p) = p
getPos (TkMenos      p) = p
getPos (TkMultIgual  p) = p
getPos (TkMult       p) = p
getPos (TkPotenciaIgual p) = p
getPos (TkPotencia   p) = p
getPos (TkDivIgual   p) = p
getPos (TkDiv        p) = p
getPos (TkDivEnteraIgual  p) = p
getPos (TkDivEntera  p) = p
getPos (TkModIgual   p) = p
getPos (TkMod        p) = p
getPos (TkFlechita   p) = p
getPos (TkMayorIgual  p) = p
getPos (TkMayor      p) = p
getPos (TkMenorIgual  p) = p
getPos (TkMenor      p) = p
getPos (TkAnd        p) = p
getPos (TkBitand     p) = p
getPos (TkOr         p) = p
getPos (TkBitor      p) = p
getPos (TkIgual      p) = p
getPos (TkDistinto   p) = p
getPos (TkAsignacion  p) = p
getPos (TkNegacion   p) = p
getPos (TkString (_,  p)) = p
getPos (TkChar (_,  p)) = p
getPos (TkId (_,  p)) = p
getPos (TkFloat (_,  p)) = p
getPos (TkInt (_,  p)) = p
getPos (TkError (_,  p)) = p

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