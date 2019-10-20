module Tablon where
import Control.Monad.RWS
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

buscar :: String -> Tablon -> [Entry]
buscar s t = lis $ Map.lookup s t
    where
      lis Nothing = []
      lis (Just lista) = lista

insertar :: String -> Entry -> Tablon -> Tablon
insertar s e t
    | any (clash e) vaina = error "Redefinicion"
    | otherwise = Map.insert s (e : vaina) t
    where
        vaina = buscar s t
        clash (Entry _ _ a) (Entry _ _ b) = a == b

insertarV :: [String] -> [Entry] -> Tablon -> Tablon
insertarV xs ys t = foldr insertar' t (zip xs ys)
    where insertar' (s,e) tab = insertar s e tab


type MonadTablon a = RWST () () (Tablon, [Integer]) IO a

initTablon :: (Tablon,[Integer])
initTablon = (t,[0])
    where
        t = insertarV claves valores vacio
        claves = ["planet", "cloud"]
        valores = [(Entry Cosmos Tipo 0), (Entry Cosmos Tipo 0)]

wan :: MonadTablon ()
wan = put initTablon

idk :: MonadTablon ()
idk = do
  (perro,pila) <- get
  put (perro,69:pila)

main' :: MonadTablon ()
main' = do
  lift $ putStrLn "salu3"
  idk
  a <- get
  lift $ putStrLn (show a)
  idk
  b <- get
  lift $ putStrLn (show b)
  return ()

tablontest :: IO ()
tablontest = do 
  _ <- execRWST main' () initTablon
  return ()