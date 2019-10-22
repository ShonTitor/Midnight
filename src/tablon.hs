module Tablon where
import Tipos
import Control.Monad.RWS
import Data.List (intercalate)
import qualified Data.Map as Map

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

lookupTablon :: String -> MonadTablon (Maybe Entry)
lookupTablon s = do
    (tablonActual, pila, _) <- get
    let pervasive (Entry _ _ x) = x == 0
    let entries = filter (\(Entry _ _ x) -> x<(head pila) && elem x pila) (buscar s tablonActual)
    let perv = filter pervasive entries
    let e | null entries = Nothing
          | null perv = Just $ head entries
          | otherwise =  Just $ head perv
    lift $ putStrLn (show e)
    lift $ putStrLn (show entries)
    return e

pushPila :: MonadTablon ()
pushPila = do
    (tablonActual, pila, n) <- get
    let m = n + 1
    put (tablonActual, m:pila, m)

popPila :: MonadTablon ()
popPila = do
    (tablonActual, pila, n) <- get
    put (tablonActual, tail pila, n)

insertarCampos :: [(Type, String)] -> MonadTablon ()
insertarCampos xs = do
    (tablonActual, pila@(tope:_), n) <- get
    let tuplas = [ (snd x, (Entry (fst x) Campo tope)) | x <- xs ]
    let tab = insertarV' tuplas tablonActual
    put (tab, pila, n)

insertarVar :: String -> Type -> MonadTablon ()
insertarVar s t = do
    (tablonActual, pila@(tope:_), n) <- get
    let tab = insertar s (Entry t Variable tope) tablonActual
    put (tab, pila, n)

insertarSubrutina :: Def -> MonadTablon ()
insertarSubrutina (Func s params tret sequ) = do
    (tablonActual, pila@(tope:_), n) <- get
    let tparams = [ t | (t, _, _) <- params ]
    let t = Comet tparams tret
    let tab = insertar s (Entry t (Subrutina sequ) tope) tablonActual
    put (tab, pila, n)
insertarSubrutina (Iter s params tret sequ) = do
    (tablonActual, pila@(tope:_), n) <- get
    let tparams = [ t | (t, _, _) <- params ]
    let t = Satellite tparams tret
    let tab = insertar s (Entry t (Subrutina sequ) tope) tablonActual
    put (tab, pila, n)
insertarSubrutina _ = error "No es una Subrutina"

insertarParams :: [(Type, String, Bool)] -> MonadTablon ()
insertarParams params = do
    (tablonActual, pila@(tope:_), n) <- get
    let tuplas = [ (s, (Entry t (Parametro b) tope)) | (t, s, b) <- params ]
    let tab = insertarV' tuplas tablonActual
    put (tab, pila, n)

insertarReg :: Def -> MonadTablon ()
insertarReg (DGalaxy s _) = do
    (tablonActual, pila@(tope:_), n) <- get
    let tab = insertar s (Entry Cosmos (Registro (Galaxy s) n) tope) tablonActual
    put (tab, pila, n)
insertarReg (DUFO s _) = do
    (tablonActual, pila@(tope:_), n) <- get
    let tab = insertar s (Entry Cosmos (Registro (UFO s) n) tope) tablonActual
    put (tab, pila, n)
insertarReg _ = error "No es un Registro"

insertarExp :: Exp -> MonadTablon ()
insertarExp (Var id) = do
    (tablonActual, pila, _) <- get
    let pervasive (Entry _ _ x) = x == 0
    let entries = filter (\(Entry _ _ x) -> x<(head pila) && elem x pila) (buscar id tablonActual)
    let perv = filter pervasive entries
    let e = head perv
    (tablonActual, pila@(tope:_), n) <- get
    let tab = insertar id (e) tablonActual
    put (tab, pila, n)

showTablon :: Tablon -> String
showTablon t = fst (Map.mapAccumWithKey f "" t) where
  f a k v =  (a ++ '\n' : k ++ '\n' : intercalate "\n" (map (show) v) ++ "\n" , ())

tablonTest' :: MonadTablon ()
tablonTest' = do
  pushPila
  insertarVar "perro" Planet
  pushPila
  insertarVar "perro" Cloud
  pushPila
  insertarVar "perro" Star
  _ <- lookupTablon "perro"
  popPila
  _ <- lookupTablon "perro"
  popPila
  _ <- lookupTablon "perro"
  _ <- lookupTablon "planet"
  popPila

tablonTest :: IO ()
tablonTest = do
  _ <- runRWST tablonTest' () initTablon
  return ()