module Tipos where
import qualified Data.Map as Map
import Lexer (AlexPosn)

data Type
      = Simple String
      | Composite String Type
      | Record String String
      | Subroutine String [Type] Type
      | NA
      | IDK
      | Err
      deriving (Eq)

isComp :: Type -> Bool
isComp (Composite _ _) = True
isComp (Record _ _) = True
isComp (Subroutine _ _ _) = True
isComp (Simple "BlackHole") = True
isComp _ = False

tipoSerio :: Type -> Type -> Type
tipoSerio Err ti = ti
tipoSerio ti Err = ti
tipoSerio NA _ = NA
tipoSerio _ NA = NA
tipoSerio (Simple "BlackHole") ti = if isComp ti then ti else NA
tipoSerio ti (Simple "BlackHole") = if isComp ti then ti else NA
tipoSerio t1 t2 = if t1 == t2 then t1 else NA

instance Show Type where
  show (Simple s) = s
  show (Composite "Cluster" (Simple "star")) = "Constellation"
  show (Composite s t) = '[' : (show t) ++ ']' : s
  show (Record s z) = s ++  ' ' : z
  show (Subroutine s pt rt) = (show pt) ++ '-' : '>' : (show rt) ++ ' ' : s
  show NA = "NA"
  show IDK = "IDK"
  show Err = "Err"

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
      = Func String [(Type, (String, AlexPosn) , Bool)] Type [Instr]
      | Iter String [(Type, (String, AlexPosn), Bool)] Type [Instr]
      | DUFO String [(Type, (String, AlexPosn))]
      | DGalaxy String [(Type, (String, AlexPosn))]
      deriving Show

data Instr 
      = Flotando Exp
      | Declar Type String
      | Asig Exp Exp
      | If [(Exp, [Instr])]
      | While Exp [Instr]
      | Foreach String Exp [Instr]
      | ForRange Exp Exp Exp [Instr]
      | ForC Instr Exp [Instr]
      | Break Exp
      | Continue
      | Return Exp
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

type Exp = (Expr, Type)

data Expr
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