module Tablon where
import Parser
import Control.Monad.Trans.RWS
--import Control.Monad.IO.Class
import qualified Data.Map as Map
--import Data.Maybe


data Category = Perro
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
insertarV [] [] t = t
insertarV (x:xs) (y:ys) t = insertar x y (insertarV xs ys t)
insertarV _ _ _ = error "No concuerda el tamaño de las listas"


type MonadTablon a = RWST () () (Tablon, [Integer]) IO a