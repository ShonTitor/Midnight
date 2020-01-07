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

    it "acepta Space como un token Space válido" $ do
      let tokens = alexScanTokens "Space"

      case tokens of
        [TkSpace (_)] -> True
        _ -> error $ show tokens ++ "rechaza Space como token valido"

    it "acepta EndofSpace como un token EndofSpace válido" $ do
      let tokens = alexScanTokens "EndofSpace"

      case tokens of
        [TkEndofSpace (_)] -> True
        _ -> error $ show tokens ++ "rechaza Space como token valido"

    it "acepta new como un token New válido" $ do
      let tokens = alexScanTokens "new"

      case tokens of
        [TkNew (string, _)] -> string `shouldBe` "new"
        _ -> error $ show tokens ++ "rechaza new como token valido"

    it "acepta full como un token Full válido" $ do
      let tokens = alexScanTokens "full"

      case tokens of
        [TkFull (string, _)] -> string `shouldBe` "full"
        _ -> error $ show tokens ++ "rechaza full como token valido"

    it "acepta blackhole como un token Null válido" $ do
      let tokens = alexScanTokens "blackhole"

      case tokens of
        [TkNull (string, _)] -> string `shouldBe` "blackhole"
        _ -> error $ show tokens ++ "rechaza blackhole como token valido"

    it "acepta moon como un token Moon válido" $ do
      let tokens = alexScanTokens "moon"

      case tokens of
        [TkMoon (string, _)] -> string `shouldBe` "moon"
        _ -> error $ show tokens ++ "rechaza moon como token valido"

    it "acepta planet como un token Planet válido" $ do
      let tokens = alexScanTokens "planet"

      case tokens of
        [TkPlanet (string, _)] -> string `shouldBe` "planet"
        _ -> error $ show tokens ++ "rechaza planet como token valido"

    it "acepta cloud como un token Cloud válido" $ do
      let tokens = alexScanTokens "cloud"

      case tokens of
        [TkCloud (string, _)] -> string `shouldBe` "cloud"
        _ -> error $ show tokens ++ "rechaza cloud como token valido"

    it "acepta star como un token Star válido" $ do
      let tokens = alexScanTokens "star"

      case tokens of
        [TkStar (string, _)] -> string `shouldBe` "star"
        _ -> error $ show tokens ++ "rechaza star como token valido"

    it "acepta BlackHole como un token Blackhole válido" $ do
      let tokens = alexScanTokens "BlackHole"

      case tokens of
        [TkBlackhole (string, _)] -> string `shouldBe` "BlackHole"
        _ -> error $ show tokens ++ "rechaza BlackHole como token valido"

    it "acepta cosmos como un token Cosmos  válido" $ do
      let tokens = alexScanTokens "cosmos"

      case tokens of
        [TkCosmos (string, _)] -> string `shouldBe` "cosmos"
        _ -> error $ show tokens ++ "rechaza cosmos como token valido"

    it "acepta Constellation como un token Constellation válido" $ do
      let tokens = alexScanTokens "Constellation"

      case tokens of
        [TkConstellation (string, _)] -> string `shouldBe` "Constellation"
        _ -> error $ show tokens ++ "rechaza Constellation como token valido"

    it "acepta Cluster como un token Cluster válido" $ do
      let tokens = alexScanTokens "Cluster"

      case tokens of
        [TkCluster (string, _)] -> string `shouldBe` "Cluster"
        _ -> error $ show tokens ++ "rechaza Cluster como token valido"

    it "acepta Quasar como un token Quasar válido" $ do
      let tokens = alexScanTokens "Quasar"

      case tokens of
        [TkQuasar (string, _)] -> string `shouldBe` "Quasar"
        _ -> error $ show tokens ++ "rechaza Quasar como token valido"

    it "acepta Nebula como un token Nebula válido" $ do
      let tokens = alexScanTokens "Nebula"

      case tokens of
        [TkNebula (string, _)] -> string `shouldBe` "Nebula"
        _ -> error $ show tokens ++ "rechaza Nebula como token valido"

    it "acepta Galaxy como un token Galaxy válido" $ do
      let tokens = alexScanTokens "Galaxy"

      case tokens of
        [TkGalaxy (string, _)] -> string `shouldBe` "Galaxy"
        _ -> error $ show tokens ++ "rechaza Galaxy como token valido"

    it "acepta UFO como un token UFO válido" $ do
      let tokens = alexScanTokens "UFO"

      case tokens of
        [TkUFO (string, _)] -> string `shouldBe` "UFO"
        _ -> error $ show tokens ++ "rechaza UFO como token valido"

    it "acepta Comet como un token Comet válido" $ do
      let tokens = alexScanTokens "Comet"

      case tokens of
        [TkComet (string, _)] -> string `shouldBe` "Comet"
        _ -> error $ show tokens ++ "rechaza Comet como token valido"

    it "acepta Satellite como un token Satellite válido" $ do
      let tokens = alexScanTokens "Satellite"

      case tokens of
        [TkSatellite (string, _)] -> string `shouldBe` "Satellite"
        _ -> error $ show tokens ++ "rechaza Satellite como token valido"

    it "acepta print como un token Print válido" $ do
      let tokens = alexScanTokens "print"

      case tokens of
        [TkPrint (_)] -> True
        _ -> error $ show tokens ++ "rechaza print como token valido"

    it "acepta read como un token Read válido" $ do
      let tokens = alexScanTokens "read"

      case tokens of
        [TkRead (_)] -> True
        _ -> error $ show tokens ++ "rechaza read como token valido"

    it "acepta scale como un token Scale válido" $ do
      let tokens = alexScanTokens "scale"

      case tokens of
        [TkScale (_)] -> True
        _ -> error $ show tokens ++ "rechaza scale como token valido"

    it "acepta around como un token Around válido" $ do
      let tokens = alexScanTokens "around"

      case tokens of
        [TkAround (_)] -> True
        _ -> error $ show tokens ++ "rechaza around como token valido"

    it "acepta range como un token Range válido" $ do
      let tokens = alexScanTokens "range"

      case tokens of
        [TkRange (_)] -> True
        _ -> error $ show tokens ++ "rechaza range como token valido"

    it "acepta pop como un token Pop válido" $ do
      let tokens = alexScanTokens "pop"

      case tokens of
        [TkPop (_)] -> True
        _ -> error $ show tokens ++ "rechaza pop como token valido"

    it "acepta add como un token Add válido" $ do
      let tokens = alexScanTokens "add"

      case tokens of
        [TkAdd (_)] -> True
        _ -> error $ show tokens ++ "rechaza add como token valido"

    it "acepta bigbang como un token Bigbang válido" $ do
      let tokens = alexScanTokens "bigbang"

      case tokens of
        [TkBigbang (_)] -> True
        _ -> error $ show tokens ++ "rechaza bigbang como token valido"

    it "acepta if como un token If válido" $ do
      let tokens = alexScanTokens "if"

      case tokens of
        [TkIf (_)] -> True
        _ -> error $ show tokens ++ "rechaza if como token valido"

    it "acepta elseif como un token Elseif válido" $ do
      let tokens = alexScanTokens "elseif"

      case tokens of
        [TkElseif (_)] -> True
        _ -> error $ show tokens ++ "rechaza elseif como token valido"

    it "acepta else como un token Else válido" $ do
      let tokens = alexScanTokens "else"

      case tokens of
        [TkElse (_)] -> True
        _ -> error $ show tokens ++ "rechaza else como token valido"

    it "acepta unless como un token Unless válido" $ do
      let tokens = alexScanTokens "unless"

      case tokens of
        [TkUnless (_)] -> True
        _ -> error $ show tokens ++ "rechaza unless como token valido"

    it "acepta while como un token While válido" $ do
      let tokens = alexScanTokens "while"

      case tokens of
        [TkWhile (_)] -> True
        _ -> error $ show tokens ++ "rechaza while como token valido"

    it "acepta until como un token Until válido" $ do
      let tokens = alexScanTokens "until"

      case tokens of
        [TkUntil (_)] -> True
        _ -> error $ show tokens ++ "rechaza until como token valido"

    it "acepta orbit como un token Orbit válido" $ do
      let tokens = alexScanTokens "orbit"

      case tokens of
        [TkOrbit (_)] -> True
        _ -> error $ show tokens ++ "rechaza orbit como token valido"

    it "acepta break como un token Break válido" $ do
      let tokens = alexScanTokens "break"

      case tokens of
        [TkBreak (_)] -> True
        _ -> error $ show tokens ++ "rechaza break como token valido"

    it "acepta continue como un token Continue válido" $ do
      let tokens = alexScanTokens "continue"

      case tokens of
        [TkContinue (_)] -> True
        _ -> error $ show tokens ++ "rechaza continue como token valido"

    it "acepta return como un token Return válido" $ do
      let tokens = alexScanTokens "return"

      case tokens of
        [TkReturn (_)] -> True
        _ -> error $ show tokens ++ "rechaza return como token valido"

    it "acepta yield como un token Yield válido" $ do
      let tokens = alexScanTokens "yield"

      case tokens of
        [TkYield (_)] -> True
        _ -> error $ show tokens ++ "rechaza yield como token valido"

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

    it "acepta perro como un token Id válido" $ do
      let tokens = alexScanTokens "perro"

      case tokens of
        [TkId (string, _)] -> string `shouldBe` "perro"
        _ -> error $ show tokens ++ "rechaza perro como token valido"

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
      (_, (tablon, _, _, _), _) <- nyaa "Space planet perro; EndofSpace"

      buscar "perro" tablon `shouldBe` [Entry (Simple "planet") Variable 1]