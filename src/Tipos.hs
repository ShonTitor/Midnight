module Tipos where
import qualified Data.Map as Map

data Type
      = Simple String
      | Composite String Type
      | Record String String
      | Subroutine String [Type] Type
      | NA
      deriving (Eq, Show)

data Category = Tipo
              | Constructor
              | Parametro Bool
              | Variable
              | Literal
              | Registro Type Integer
              | Campo
              | Subrutina [Instr]
    deriving Show

data Entry = Entry {
    tipo :: Type,
    categoria :: Category,
    alcance :: Integer
    }
    deriving Show

type Tablon  = Map.Map String [Entry]

data Program
      = Root [Instr] 
      deriving Show

data Def
      = Func String [(Type, String, Bool)] Type [Instr]
      | Iter String [(Type, String, Bool)] Type [Instr]
      | DUFO String [(Type, String)]
      | DGalaxy String [(Type, String)]
      deriving Show

data Instr 
      = Flotando Exp
      | Declar Type String
      | Asig Exp Exp
      | If [(Exp, [Instr])]
      | While Exp [Instr]
      | Foreach String Exp [Instr]
      | ForRange Exp Exp Exp [Instr]
      | Break Exp
      | Continue
      | Return Exp
      | Returnsito
      | Yield Exp
      deriving Show

isDeclar :: Instr -> Bool
isDeclar (Declar _ _) = True
isDeclar _ = False

data Slice
      = Index Exp
      | Interval Exp Exp
      | Begin Exp
      deriving Show

data Exp
      = Funcall Exp [Exp]
      -- LValues
      | Var String
      | Access Exp Slice
      | Attr Exp String
      -- funciones de preludio
      | Print [Exp]
      | Read
      | Bigbang
      | Scale Exp
      | Pop Exp [Exp]
      | Add Exp [Exp]
      | Terraform Exp

      | Desref Exp
      -- Numericas
      | IntLit Int
      | FloLit Float
      | Suma Exp Exp
      | Sub Exp Exp
      | Mul Exp Exp
      | Pow Exp Exp
      | Div Exp Exp
      | DivE Exp Exp
      | Mod Exp Exp
      | Neg Exp
      -- Comparaciones
      | Eq Exp Exp
      | Neq Exp Exp
      | Mayor Exp Exp
      | MayorI Exp Exp
      | Menor Exp Exp
      | MenorI Exp Exp
      -- Bool
      | New
      | Full
      | And Exp Exp
      | Bitand Exp Exp
      | Or Exp Exp
      | Bitor Exp Exp
      | Not Exp
      -- Otros
      | StrLit String
      | CharLit Char
      | ArrLit [Exp]
      | ArrInit Exp Type
      | ListLit [Exp]
      | DictLit [(Exp, Exp)]
      deriving Show