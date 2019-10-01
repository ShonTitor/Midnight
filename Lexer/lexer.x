{
module Main (main) where
import System.IO
}

%wrapper "posn"

$digit = 0-9      -- digits
$alpha = [a-zA-Z]   -- alphabetic characters

tokens :-
  Space         {\pos s -> Space pos}
  EndofSpace    {\pos s -> EndofSpace pos}
  moon          {\pos s -> Moon pos}
  new           {\pos s -> New pos}
  full          {\pos s -> Full pos}
  planet        {\pos s -> Planet pos}
  cloud         {\pos s -> Cloud pos}
  star          {\pos s -> Star pos}
  blackhole     {\pos s -> Blackhole pos}
  cosmos        {\pos s -> Cosmos pos}
  Constellation {\pos s -> Constellation pos}
  Cluster       {\pos s -> Cluster pos}
  Quasar        {\pos s -> Quasar pos}
  Nebula        {\pos s -> Nebula pos}
  Galaxy        {\pos s -> Galaxy pos}
  Quasar        {\pos s -> Quasar pos}
  UFO           {\pos s -> UFO pos}
  Comet         {\pos s -> Comet pos}
  Satellite     {\pos s -> Satellite pos}
  terraform     {\pos s -> Terraform pos}

  print         {\pos s -> Print pos}
  read          {\pos s -> Read pos}
  around        {\pos s -> Around pos}
  range         {\pos s -> Range pos}
  pop           {\pos s -> Pop pos}
  add           {\pos s -> Add pos}
  bigbang       {\pos s -> Bigbang pos}
  if            {\pos s -> If pos}
  elseif        {\pos s -> Elseif pos}
  else          {\pos s -> Else pos}
  unless        {\pos s -> Unless pos}
  while         {\pos s -> While pos}
  until         {\pos s -> Until pos}
  orbit         {\pos s -> Orbit pos}
  \@            {\pos s -> Arroba pos}
  \(            {\pos s -> ParA pos}
  \)            {\pos s -> ParC pos}
  \[            {\pos s -> CorA pos}
  \]            {\pos s -> CorC pos}
  \{            {\pos s -> LlavA pos}
  \}            {\pos s -> LlavC pos}
  \.\.          {\pos s -> Puntopunto pos}
  \.            {\pos s -> Punto pos}
  \,            {\pos s -> Coma pos}
  \;            {\pos s -> Puntoycoma pos}
  \:            {\pos s -> Dospuntos pos}
  \~            {\pos s -> Nyangara pos}
  \+\=          {\pos s -> MasIgual pos}
  \+            {\pos s -> Mas pos}
  \-\=          {\pos s -> MenosIgual pos}
  \-            {\pos s -> Menos pos}
  \*\=          {\pos s -> MultIgual pos}
  \*            {\pos s -> Mult pos}
  \^\=          {\pos s -> PotenciaIgual pos}
  \^            {\pos s -> Potencia pos}
  \/\=          {\pos s -> DivIgual pos}
  \/            {\pos s -> Div pos}
  \/\/\=        {\pos s -> DivEnteraIgual pos}
  \/\/          {\pos s -> DivEntera pos}
  \%\=          {\pos s -> ModIgual pos}
  \%            {\pos s -> Mod pos}
  \->           {\pos s -> Flechita pos}
  >=            {\pos s -> MayorIgual pos}
  >             {\pos s -> Mayor pos}
  \<=           {\pos s -> MenorIgual pos}
  \<            {\pos s -> Menor pos}
  &&            {\pos s -> And pos}
  &             {\pos s -> Bitand pos}
  \|\|          {\pos s -> Or pos}
  \|            {\pos s -> Bitor pos}
  \=\=          {\pos s -> Igual pos}
  ¬\=           {\pos s -> Distinto pos}
  \=            {\pos s -> Asignacion pos}
  ¬             {\pos s -> Negacion pos}
  \"($printable #\")*\" {\pos s -> String (read s) pos}
  \'($printable #\')*\' {\pos s -> Char (read s) pos}
  $digit+\.$digit+       { \pos s -> Float (read s)  pos}
  $digit+       { \pos s -> Int (read s)  pos}
  $alpha [$alpha $digit \_]*   { \pos s -> Var s  pos}
  $white+       ;
  .             {\pos s -> Error s pos}

{
-- Each action has type :: String -> Token

-- The token type:
data Token =
  Space     AlexPosn |
  EndofSpace AlexPosn |
  Moon      AlexPosn |
  New       AlexPosn |
  Full      AlexPosn |
  Planet    AlexPosn |
  Cloud     AlexPosn |
  Star      AlexPosn |
  Blackhole AlexPosn |
  Cosmos    AlexPosn |
  Constellation AlexPosn |
  Cluster   AlexPosn |
  Quasar    AlexPosn |
  Nebula    AlexPosn |
  Galaxy    AlexPosn |
  UFO       AlexPosn |
  Comet     AlexPosn |
  Satellite AlexPosn |
  Terraform AlexPosn |

  Print     AlexPosn |
  Read      AlexPosn |
  Around    AlexPosn |
  Range     AlexPosn |
  Pop       AlexPosn |
  Add       AlexPosn |
  Bigbang   AlexPosn |
  If        AlexPosn |
  Elseif    AlexPosn |
  Else      AlexPosn |
  Unless    AlexPosn |
  While     AlexPosn |
  Until     AlexPosn |
  Orbit     AlexPosn |
  Arroba      AlexPosn |
  ParA      AlexPosn |
  ParC      AlexPosn |
  CorA      AlexPosn |
  CorC      AlexPosn |
  LlavA     AlexPosn |
  LlavC     AlexPosn |
  Puntopunto AlexPosn |
  Punto     AlexPosn |
  Coma      AlexPosn |
  Puntoycoma AlexPosn |
  Dospuntos AlexPosn |
  Nyangara  AlexPosn |
  MasIgual  AlexPosn |
  Mas       AlexPosn |
  MenosIgual AlexPosn |
  Menos     AlexPosn |
  MultIgual AlexPosn |
  Mult     AlexPosn |
  PotenciaIgual AlexPosn |
  Potencia  AlexPosn |
  DivIgual  AlexPosn |
  Div       AlexPosn |
  DivEnteraIgual AlexPosn |
  DivEntera AlexPosn |
  ModIgual  AlexPosn |
  Mod       AlexPosn |
  Flechita  AlexPosn |
  MayorIgual AlexPosn |
  Mayor     AlexPosn |
  MenorIgual AlexPosn |
  Menor     AlexPosn |
  And       AlexPosn |
  Bitand    AlexPosn |
  Or        AlexPosn |
  Bitor     AlexPosn |
  Igual     AlexPosn |
  Distinto  AlexPosn |
  Asignacion AlexPosn |
  Negacion  AlexPosn |
  String String AlexPosn |
  Char Char AlexPosn |
  Var String AlexPosn |
  Float Float AlexPosn |
  Int Int   AlexPosn |
  Error String AlexPosn
  deriving (Eq,Show)

isError :: Token -> Bool
isError (Error _ _) = True
isError _ = False

main = do
  f <- openFile "test.mn" ReadMode
  s <- hGetContents f
  print (filter isError (alexScanTokens s))
  hClose f
 }