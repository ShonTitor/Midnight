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
              | Parametro
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
insertarV xs ys t = insertarV' (zip xs ys) t

insertarV' :: [(String,Entry)] -> Tablon -> Tablon
insertarV' xs t = foldr insertar' t xs
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

pushTablon :: MonadTablon ()
pushTablon = do
    (tablonActual, pila) <- get
    let pilaNueva = (head pila) + 1
    put (tablonActual, pilaNueva:pila)

popPila :: MonadTablon ()
popPila = do
    (tablonActual, pila) <- get
    put (tablonActual, tail pila)

tablontest :: IO ()
tablontest = do 
  _ <- execRWST main' () initTablon
  return ()

--insertarDecl :: String -> Type -> MonadTablon ()
--insertarDecl id tipo' = do
--    (tablonActual, pila@(pila:_)) <- get
--    insertar id {tipo',,} tablonActual

    --let info = replicate (length ids) (SymbolInfo tipo' pila Variable)
   -- addToSymTab ids info actualSymTab scopes

insertarCampos :: [(Type, String)] -> MonadTablon ()
insertarCampos xs = do
    (tablonActual,pila@(tope:_)) <- get
    let tuplas = [ (snd x, (Entry (fst x) Campo tope)) | x <- xs ]
    let tab = insertarV' tuplas tablonActual
    put (tab,pila)

insertarVar :: String -> Type -> MonadTablon ()
insertarVar id tipo = do
    (tablonActual,pila@(tope:_)) <- get
    let tab = insertar id (Entry tipo Variable tope) tablonActual
    put (tab,pila)
