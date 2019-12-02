module PruebasSpec where

import Test.Hspec
import Lexer
import Parser
import Tipos
import Tablon

spec :: SpecWith ()
spec = describe "Pruebas" $ do
  
  describe "Lexer" $ do
    it "acepta 'a' como un literal de caracter válido" $ do
      let tokens = alexScanTokens "'a'"

      case tokens of
        [TkChar (char, _)] -> char `shouldBe` 'a'
        _ -> error $ show tokens ++ "rechaza 'a' como literal de caracter"

    it "acepta 'b' como un literal de caracter válido" $ do
      let tokens = alexScanTokens "'b'"

      case tokens of
        [TkChar (char, _)] -> char `shouldBe` 'b'
        _ -> error $ show tokens ++ "rechaza 'b' como literal de caracter"

    it "acepta 'Z' como un literal de caracter válido" $ do
      let tokens = alexScanTokens "'Z'"

      case tokens of
        [TkChar (char, _)] -> char `shouldBe` 'Z'
        _ -> error $ show tokens ++ "rechaza 'a' como literal de caracter"

    it "acepta ~ como un token Nyangara válido" $ do
      let tokens = alexScanTokens "~"

      case tokens of
        [TkNyangara (string, _)] -> string `shouldBe` "~"
        _ -> error $ show tokens ++ "rechaza '~' como literal de caracter"

    it "acepta '\\n' como un caracter especial válido" $ do
      let tokens = alexScanTokens "'\\n'"

      case tokens of
        [TkChar (char, _)] -> char `shouldBe` '\n'
        _ -> error $ show tokens ++ "rechaza '\n' como literal de caracter"

    it "acepta '\\t' como un caracter especial válido" $ do
      let tokens = alexScanTokens "'\\t'"

      case tokens of
        [TkChar (char, _)] -> char `shouldBe` '\t'
        _ -> error $ show tokens ++ "rechaza '\t' como literal de caracter"

    it "acepta '\\\\' como un caracter especial válido" $ do
      let tokens = alexScanTokens "'\\\\'"

      case tokens of
        [TkChar (char, _)] -> char `shouldBe` '\\'
        _ -> error $ show tokens ++ "rechaza '\\' como literal de caracter"

    it "acepta @ como un token Arroba válido" $ do
      let tokens = alexScanTokens "@"

      case tokens of
        [TkArroba (_)] -> True
        _ -> error $ show tokens ++ "rechaza @ como token valido"

    it "acepta ( como un token ParA válido" $ do
      let tokens = alexScanTokens "("

      case tokens of
        [TkParA (_)] -> True
        _ -> error $ show tokens ++ "rechaza ( como token valido"

    it "acepta ) como un token ParC válido" $ do
      let tokens = alexScanTokens ")"

      case tokens of
        [TkParC (_)] -> True
        _ -> error $ show tokens ++ "rechaza ) como token valido"

    it "acepta [ como un token CorA válido" $ do
      let tokens = alexScanTokens "["

      case tokens of
        [TkCorA (_)] -> True
        _ -> error $ show tokens ++ "rechaza [ como token valido"

    it "acepta ] como un token CorC válido" $ do
      let tokens = alexScanTokens "]"

      case tokens of
        [TkCorC (_)] -> True
        _ -> error $ show tokens ++ "rechaza ) como token valido"

    it "acepta { como un token LlavA válido" $ do
      let tokens = alexScanTokens "{"

      case tokens of
        [TkLlavA (_)] -> True
        _ -> error $ show tokens ++ "rechaza { como token valido"

    it "acepta } como un token LlavC válido" $ do
      let tokens = alexScanTokens "}"

      case tokens of
        [TkLlavC (_)] -> True
        _ -> error $ show tokens ++ "rechaza } como token valido"

    it "acepta . como un token Punto válido" $ do
      let tokens = alexScanTokens "."

      case tokens of
        [TkPunto (_)] -> True
        _ -> error $ show tokens ++ "rechaza . como token valido"

    it "acepta .. como un token Puntopunto válido" $ do
      let tokens = alexScanTokens ".."

      case tokens of
        [TkPuntopunto (_)] -> True
        _ -> error $ show tokens ++ "rechaza .. como token valido"

    it "acepta , como un token Coma válido" $ do
      let tokens = alexScanTokens ","

      case tokens of
        [TkComa (_)] -> True
        _ -> error $ show tokens ++ "rechaza , como token valido"

    it "acepta ; como un token Puntoycoma válido" $ do
      let tokens = alexScanTokens ";"

      case tokens of
        [TkPuntoycoma (_)] -> True
        _ -> error $ show tokens ++ "rechaza ; como token valido"

    it "acepta : como un token Dospuntos válido" $ do
      let tokens = alexScanTokens ":"

      case tokens of
        [TkDospuntos (_)] -> True
        _ -> error $ show tokens ++ "rechaza : como token valido"

    it "acepta += como un token MasIgual válido" $ do
      let tokens = alexScanTokens "+="

      case tokens of
        [TkMasIgual (_)] -> True
        _ -> error $ show tokens ++ "rechaza += como token valido"

    it "acepta + como un token Mas válido" $ do
      let tokens = alexScanTokens "+"

      case tokens of
        [TkMas (_)] -> True
        _ -> error $ show tokens ++ "rechaza + como token valido"

    it "acepta -= como un token MenosIgual válido" $ do
      let tokens = alexScanTokens "-="

      case tokens of
        [TkMenosIgual (_)] -> True
        _ -> error $ show tokens ++ "rechaza -= como token valido"

    it "acepta - como un token Menos válido" $ do
      let tokens = alexScanTokens "-"

      case tokens of
        [TkMenos (_)] -> True
        _ -> error $ show tokens ++ "rechaza - como token valido"

    it "acepta *= como un token MultIgual válido" $ do
      let tokens = alexScanTokens "*="

      case tokens of
        [TkMultIgual (_)] -> True
        _ -> error $ show tokens ++ "rechaza *= como token valido"

    it "acepta * como un token Mult válido" $ do
      let tokens = alexScanTokens "*"

      case tokens of
        [TkMult (_)] -> True
        _ -> error $ show tokens ++ "rechaza * como token valido"

    it "acepta ^= como un token PotenciaIgual válido" $ do
      let tokens = alexScanTokens "^="

      case tokens of
        [TkPotenciaIgual (_)] -> True
        _ -> error $ show tokens ++ "rechaza ^= como token valido"

    it "acepta ^ como un token Potencia válido" $ do
      let tokens = alexScanTokens "^"

      case tokens of
        [TkPotencia (_)] -> True
        _ -> error $ show tokens ++ "rechaza ^ como token valido"

    it "acepta // como un token DivEntera válido" $ do
      let tokens = alexScanTokens "//"

      case tokens of
        [TkDivEntera (_)] -> True
        _ -> error $ show tokens ++ "rechaza // como token valido"

    it "acepta //= como un token DivEnteraIgual válido" $ do
      let tokens = alexScanTokens "//="

      case tokens of
        [TkDivEnteraIgual (_)] -> True
        _ -> error $ show tokens ++ "rechaza //= como token valido"

    it "acepta /= como un token DivIgual válido" $ do
      let tokens = alexScanTokens "/="

      case tokens of
        [TkDivIgual (_)] -> True
        _ -> error $ show tokens ++ "rechaza /= como token valido"

    it "acepta / como un token Div válido" $ do
      let tokens = alexScanTokens "/"

      case tokens of
        [TkDiv (_)] -> True
        _ -> error $ show tokens ++ "rechaza / como token valido"

    it "acepta %= como un token ModIgual válido" $ do
      let tokens = alexScanTokens "%="

      case tokens of
        [TkModIgual (_)] -> True
        _ -> error $ show tokens ++ "rechaza %= como token valido"

    it "acepta % como un token Mod válido" $ do
      let tokens = alexScanTokens "%"

      case tokens of
        [TkMod (_)] -> True
        _ -> error $ show tokens ++ "rechaza % como token valido"

    it "acepta -> como un token Flechita válido" $ do
      let tokens = alexScanTokens "->"

      case tokens of
        [TkFlechita (_)] -> True
        _ -> error $ show tokens ++ "rechaza -> como token valido"

    it "acepta >= como un token MayorIgual válido" $ do
      let tokens = alexScanTokens ">="

      case tokens of
        [TkMayorIgual (_)] -> True
        _ -> error $ show tokens ++ "rechaza >= como token valido"

    it "acepta > como un token Mayor válido" $ do
      let tokens = alexScanTokens ">"

      case tokens of
        [TkMayor (_)] -> True
        _ -> error $ show tokens ++ "rechaza > como token valido"

    it "acepta <= como un token MenorIgual válido" $ do
      let tokens = alexScanTokens "<="

      case tokens of
        [TkMenorIgual (_)] -> True
        _ -> error $ show tokens ++ "rechaza <= como token valido"

    it "acepta < como un token Menor válido" $ do
      let tokens = alexScanTokens "<"

      case tokens of
        [TkMenor (_)] -> True
        _ -> error $ show tokens ++ "rechaza < como token valido"

    it "acepta && como un token And válido" $ do
      let tokens = alexScanTokens "&&"

      case tokens of
        [TkAnd (_)] -> True
        _ -> error $ show tokens ++ "rechaza && como token valido"

    it "acepta & como un token Bitand válido" $ do
      let tokens = alexScanTokens "&"

      case tokens of
        [TkBitand (_)] -> True
        _ -> error $ show tokens ++ "rechaza & como token valido"

    it "acepta || como un token Or válido" $ do
      let tokens = alexScanTokens "||"

      case tokens of
        [TkOr (_)] -> True
        _ -> error $ show tokens ++ "rechaza || como token valido"

    it "acepta | como un token Bitor válido" $ do
      let tokens = alexScanTokens "|"

      case tokens of
        [TkBitor (_)] -> True
        _ -> error $ show tokens ++ "rechaza | como token valido"

    it "acepta == como un token Igual válido" $ do
      let tokens = alexScanTokens "=="

      case tokens of
        [TkIgual (_)] -> True
        _ -> error $ show tokens ++ "rechaza == como token valido"

    it "acepta ¬= como un token Distinto válido" $ do
      let tokens = alexScanTokens "¬="

      case tokens of
        [TkDistinto (_)] -> True
        _ -> error $ show tokens ++ "rechaza '¬=' como literal de caracter"

    it "acepta = como un token Asignacion válido" $ do
      let tokens = alexScanTokens "="

      case tokens of
        [TkAsignacion (_)] -> True
        _ -> error $ show tokens ++ "rechaza = como token valido"

    it "acepta ¬ como un token Negacion válido" $ do
      let tokens = alexScanTokens "¬"

      case tokens of
        [TkNegacion (_)] -> True
        _ -> error $ show tokens ++ "rechaza ¬ como token valido"

    it "acepta 42 como un token Int válido" $ do
      let tokens = alexScanTokens "42"

      case tokens of
        [TkInt (num,_)] -> num `shouldBe` 42
        _ -> error $ show tokens ++ "rechaza 42 como token valido"

    it "acepta 3.1415 como un token Float válido" $ do
      let tokens = alexScanTokens "3.1415"

      case tokens of
        [TkFloat (num,_)] -> num `shouldBe` 3.1415
        _ -> error $ show tokens ++ "rechaza 3.1415 como token valido"

  describe "Parser" $ do
    let nyaa s = neko (fst $ perro s)

    it "acepta un programa vacío" $ do
      (arbol, _, _) <- nyaa "Space EndofSpace"

      arbol `shouldBe` Root []

    it "acepta un perro flotando" $ do
      (arbol, _, _) <- nyaa "Space \"perro\" EndofSpace"

      arbol `shouldBe` Root [Flotando (StrLit "perro", Composite "Cluster" (Simple "star")) ]

  describe "Tablon" $ do
    let nyaa s = neko (fst $ perro s)

    it "acepta un planeta perro" $ do
      (_, (tablon, _, _), _) <- nyaa "Space planet perro; EndofSpace"

      buscar "perro" tablon `shouldBe` [Entry (Simple "planet") Variable 1]