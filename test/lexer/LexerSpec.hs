module LexerSpec where

import Test.Hspec
import Lexer

spec :: SpecWith ()
spec = describe "Lexer" $ do
  
  describe "caracteres" $ do
    it "acepta 'a' como un literal de caracter válido" $ do
      let tokens = alexScanTokens "'a'"

      case tokens of
        [TkChar (char, _)] -> char `shouldBe` 'a'
        _ -> error $ show tokens ++ "rechaza 'a' como literal de caracter"

    it "acepta 'Z' como un literal de caracter válido" $ do
      let tokens = alexScanTokens "'Z'"

      case tokens of
        [TkChar (char, _)] -> char `shouldBe` 'Z'
        _ -> error $ show tokens ++ "rechaza 'a' como literal de caracter"