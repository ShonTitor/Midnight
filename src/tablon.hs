module Tablon where
import Tipos
import Control.Monad.RWS
import qualified Data.Map as Map
--import Data.Maybe

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

type MonadTablon a = RWST () () (Tablon, [Integer], Integer) IO a

initTablon :: (Tablon,[Integer], Integer)
initTablon = (t,[0],0)
    where
        t = insertarV claves valores vacio
        claves = ["planet", "cloud"]
        valores = [(Entry Cosmos Tipo 0), (Entry Cosmos Tipo 0)]

pushPila :: MonadTablon ()
pushPila = do
    (tablonActual, pila, n) <- get
    let m = n + 1
    put (tablonActual, m:pila, m)

popPila :: MonadTablon ()
popPila = do
    (tablonActual, pila, n) <- get
    put (tablonActual, tail pila, n)

--insertarDecl :: String -> Type -> MonadTablon ()
--insertarDecl id tipo' = do
--    (tablonActual, pila@(pila:_)) <- get
--    insertar id {tipo',,} tablonActual

    --let info = replicate (length ids) (SymbolInfo tipo' pila Variable)
   -- addToSymTab ids info actualSymTab scopes

insertarCampos :: [(Type, String)] -> MonadTablon ()
insertarCampos xs = do
    (tablonActual, pila@(tope:_), n) <- get
    let tuplas = [ (snd x, (Entry (fst x) Campo tope)) | x <- xs ]
    let tab = insertarV' tuplas tablonActual
    put (tab, pila, n)

insertarVar :: String -> Type -> MonadTablon ()
insertarVar id tipo = do
    (tablonActual, pila@(tope:_), n) <- get
    let tab = insertar id (Entry tipo Variable tope) tablonActual
    put (tab, pila, n)

insertarSubrutina :: Def -> MonadTablon ()
insertarSubrutina (Func id params tret seq) = do
    (tablonActual, pila@(tope:_), n) <- get
    let tparams = [ t | (t, _, _) <- params ]
    let tipo = Comet tparams tret
    let tab = insertar id (Entry tipo (Subrutina seq) tope) tablonActual
    put (tab, pila, n)
insertarSubrutina (Iter id params tret seq) = do
    (tablonActual, pila@(tope:_), n) <- get
    let tparams = [ t | (t, _, _) <- params ]
    let tipo = Satellite tparams tret
    let tab = insertar id (Entry tipo (Subrutina seq) tope) tablonActual
    put (tab, pila, n)

insertarParams :: [(Type, String, Bool)] -> MonadTablon ()
insertarParams params = do
    (tablonActual, pila@(tope:_), n) <- get
    let tuplas = [ (s, (Entry t (Parametro b) tope)) | (t, s, b) <- params ]
    let tab = insertarV' tuplas tablonActual
    put (tab, pila, n)

insertarReg :: Def -> MonadTablon ()
insertarReg (DGalaxy id _) = do
    (tablonActual, pila@(tope:_), n) <- get
    let tab = insertar id (Entry Cosmos (Registro (Galaxy id) n) tope) tablonActual
    put (tab, pila, n)
insertarReg (DUFO id _) = do
    (tablonActual, pila@(tope:_), n) <- get
    let tab = insertar id (Entry Cosmos (Registro (UFO id) n) tope) tablonActual
    put (tab, pila, n)