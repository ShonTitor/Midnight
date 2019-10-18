module Tablon where
--import Parser
import Control.Monad.Trans.RWS
--import Control.Monad.IO.Class
import qualified Data.Map as Map
--import Data.Maybe

data Type
      = Planet
      | Cloud
      | Star
      | Moon
      | Cosmos
      | Blackhole
      | Cluster Type
      | Quasar Type
      | Nebula Type
      | Pointer Type
      | Satellite Type
      | Galaxy String
      | UFO String
      | Comet [Type] Type
      deriving (Eq, Show)

data Category = Tipo
              | ConsTipo
              | Variable
              | Campo
              | Subrutina
    deriving Show

data Entry = Entry {
    tipo :: Type,
    categoria :: Category,
    alcance :: Integer
    }
    deriving Show

type Tablon  = Map.Map String [Entry]

vacio :: Tablon
vacio = Map.empty

insertar :: String -> Entry -> Tablon -> Tablon
insertar s e t
    | any (clash e) vaina = error "Redefinicion"
    | otherwise = Map.insert s (e : vaina) t
    where
        vaina = lis $ Map.lookup s t
        lis (Just lista) = lista
        lis Nothing = []
        clash (Entry _ _ a) (Entry _ _ b) = a == b

insertarV :: [String] -> [Entry] -> Tablon -> Tablon
insertarV xs ys t = foldr insertar' t (zip xs ys)
    where insertar' (s,e) tab = insertar s e tab


type MonadTablon a = RWST () () (Tablon, [Integer]) IO a

initState :: (Tablon,[Integer])
initState = (t,[0])
    where
        t = insertarV claves valores vacio
        claves = ["planet", "cloud"]
        valores = [(Entry Cosmos Tipo 0), (Entry Cosmos Tipo 0)]