module Tipos where
import qualified Data.Map as Map
import Lexer (AlexPosn)

data Type
      = Simple String
      | Composite String Type
      | Record String String [Type]
      | Subroutine String [Type] Type
      | NA
      | IDK
      | Err
      deriving (Eq)

anchura :: Type -> Integer
anchura (Record "Galaxy" _ ts) = sum $ map anchura ts
anchura (Record "UFO" _ ts) = maximum $ map anchura ts
anchura (Composite "~" _) = anchura $ Simple "planet"
anchura (Composite _ _) = (anchura $ Composite "~" IDK)+(anchura $ Simple "planet")
anchura _ = 4

isComp :: Type -> Bool
isComp (Composite _ _) = True
isComp (Record _ _ _) = True
isComp (Subroutine _ _ _) = True
isComp _ = False

tipoSerio :: Type -> Type -> Type
tipoSerio (Composite s1 t1) (Composite s2 t2) = if s1 == s2 && tipoSerio t1 t2 /= NA then 
                                                  Composite s1 (tipoSerio t1 t2)
                                                else NA
tipoSerio IDK ti = ti
tipoSerio ti IDK = ti                                                
tipoSerio NA _ = NA
tipoSerio _ NA = NA
tipoSerio Err _ = Err
tipoSerio _ Err = Err
tipoSerio t1 t2 = if t1 == t2 then t1 else NA

tipoCompa :: Type -> Type -> Bool
tipoCompa t1 t2 = tipoSerio t1 t2 /= NA

tipoAsig :: Type -> Type -> Bool
tipoAsig t1 t2 = tipoSerio t1 t2 == t1

instance Show Type where
  show (Simple s) = s
  show (Composite "Cluster" (Simple "star")) = "Constellation"
  show (Composite "Cluster" IDK) = "VoidCluster"
  show (Composite "Quasar" IDK) = "VoidQuasar"
  show (Composite "Nebula" IDK) = "VoidNebula"
  show (Composite s t) = '[' : (show t) ++ ']' : s
  show (Record s z _) = s ++  ' ' : z
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
    deriving (Show, Eq)

data Entry = Entry {
    tipo :: Type,
    categoria :: Category,
    alcance :: Integer,
    offset :: Integer
    }
    deriving (Show, Eq)

type Tablon  = Map.Map String [Entry]

data Program
      = Root [Instr] 
      deriving (Show, Eq)

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
      | Foreach Exp Exp [Instr]
      | ForRange Exp Exp Exp Exp [Instr]
      | ForC Instr Exp Instr [Instr]
      | Break Exp
      | Continue
      | Return Exp
      | Yield Exp
      deriving (Show, Eq)

isDeclar :: Instr -> Bool
isDeclar (Declar _ _) = True
isDeclar _ = False

data Slice
      = Index Exp
      | Interval Exp Exp
      | Begin Exp
      deriving (Show, Eq)

type Exp = (Expr, Type)

data Expr
      = Funcall Exp [Exp]
      -- LValues
      | Var String Entry
      | Access Exp Slice
      | Attr Exp (String, Entry)
      -- funciones de preludio
      | Print [Exp]
      | Read
      | Bigbang Type
      | Scale Exp
      | Pop Exp [Exp]
      | Add Exp [Exp]

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
      deriving (Show, Eq)