module Tablon where
import Tipos
import Lexer (AlexPosn, AlexPosn(AlexPn))
import Control.Monad.RWS
import Data.List (intercalate)
import Data.Foldable
import Data.Maybe (isNothing)
import qualified Data.Map as Map

vacio :: Tablon
vacio = Map.empty

buscar :: String -> Tablon -> [Entry]
buscar s t = lis $ Map.lookup s t
    where
      lis Nothing = []
      lis (Just lista) = lista


printError :: Int -> Int -> String -> MonadTablon ()
printError m n msg = do
  (tab, pila, x, _, r, off, oof) <- get 
  lift $ putStrLn $ msg++" en la línea "++(show m)++" columna "++(show n)
  put (tab, pila, x, False, r, off, oof)

clash :: Entry -> Entry -> Bool
clash (Entry _ _ a _) (Entry _ _ b _) = a == b || b == 0

insertar' :: String -> Entry -> Tablon -> Tablon
insertar' s e t
    | any (clash e) vaina = error $ "(ñame) Redeclaración de \""++s++"\""
    | otherwise = Map.insert s (e : vaina) t
    where vaina = (buscar s t)

insertar :: (String, AlexPosn) -> Entry -> Tablon -> MonadTablon Tablon
insertar (s, pos) e t = do
  let vaina = buscar s t
      AlexPn _ m n = pos
  if any (clash e) vaina then do 
    printError m n $ "Redeclaración de \""++s++"\""
    return t
  else return $ Map.insert s (e : (buscar s t)) t
        

insertarV :: [String] -> [Entry] -> Tablon -> Tablon
insertarV xs ys t = foldr (uncurry insertar') t (zip xs ys)

insertarV' :: [(String,Entry)] -> Tablon -> Tablon
insertarV' xs t = foldr (uncurry insertar') t xs

offset :: Entry -> Integer
offset (Entry _ _ _ n) = n

type MonadTablon a = RWST () () (Tablon, [Integer], Integer, Bool, Maybe (Bool, Type), [Integer], Map.Map Integer Integer) IO a

initTablon :: (Tablon,[Integer], Integer, Bool, Maybe (Bool,Type), [Integer], Map.Map Integer Integer)
initTablon = (t,[0],0, True, Nothing, [0], Map.empty)
    where
        t = insertarV claves valores vacio
        --t = insertarV [] [] vacio
        mkentry ti c = Entry ti c 0 (-1)
        claves = ["vac", "new", "full", "blackhole", "moon", "planet", "cloud", "star", "vacuum", "cosmos",
                  "Cluster", "Quasar", "Nebula", "~", "Galaxy", "UFO",
                  "read", "print", "terraform", "vaporize", "astral", "recombine", "collapse", "scale", "bigbang"]
        valores = [(mkentry (Simple "vacuum") Literal),
                   (mkentry (Simple "moon") Literal),
                   (mkentry (Simple "moon") Literal),
                   (mkentry (Simple "BlackHole") Literal),
                   (mkentry (Simple "cosmos") Tipo),
                   (mkentry (Simple "cosmos") Tipo),
                   (mkentry (Simple "cosmos") Tipo),
                   (mkentry (Simple "cosmos") Tipo),
                   (mkentry (Simple "cosmos") Tipo),
                   (mkentry (Simple "cosmos") Tipo),
                   (mkentry NA Constructor),
                   (mkentry NA Constructor),
                   (mkentry NA Constructor),
                   (mkentry NA Constructor),
                   (mkentry NA Constructor),
                   (mkentry NA Constructor),
                   (mkentry (Subroutine "Comet" [IDK] (Composite "Cluster" (Simple "star"))) (Subrutina [] (-1))),
                   (mkentry (Subroutine "Comet" [IDK] (Simple "BlackHole") ) (Subrutina [] (-1))),
                   (mkentry (Subroutine "Comet" [Composite "Cluster" (Simple "star")] (Simple "planet") ) (Subrutina [] (-1))),
                   (mkentry (Subroutine "Comet" [Simple "planet"] (Simple "cloud") ) (Subrutina [] (-1))),
                   (mkentry (Subroutine "Comet" [Composite "Cluster" (Simple "star")] (Simple "cloud") ) (Subrutina [] (-1))),
                   (mkentry (Subroutine "Comet" [Simple "cloud"] (Simple "planet") ) (Subrutina [] (-1))),
                   (mkentry (Subroutine "Comet" [IDK] (Composite "Cluster" (Simple "star")) ) (Subrutina [] (-1))),
                   (mkentry (Subroutine "Comet" [IDK] (Simple "planet") ) (Subrutina [] (-1))),
                   (mkentry (Subroutine "Comet" [IDK] (Composite "~" NA)) (Subrutina [] (-1)))
                   ]

lookupTablon :: String -> MonadTablon (Maybe Entry)
lookupTablon s = do
    (_, pila, _, _, _, _, _) <- get
    e <- lookupScope s pila
    return e

lookupScope :: String -> [Integer] -> MonadTablon (Maybe Entry)
lookupScope s pila = do
    (tablonActual, _, _, _, _, _, _) <- get
    let match n (Entry _ _ m _) = n == m
        pervasive entry = match 0 entry
        entries = buscar s tablonActual
        candidatos = [entry | n <- pila, entry <- entries, match n entry]
        e | null entries = Nothing
          | pervasive $ head entries = Just $ head entries
          | null candidatos = Nothing
          | otherwise = Just $ head candidatos
    return e

lookupExists :: (String, AlexPosn) -> MonadTablon (Maybe Entry)
lookupExists (s, pos) = do
    entry <- lookupTablon s
    let AlexPn _ m n = pos
    if isNothing entry then do
      printError m n $ "Variable no declarada \""++s++"\""
      return Nothing
    else return entry

getTipo :: Maybe Entry -> Type
getTipo Nothing = Err
getTipo (Just (Entry t _ _ _)) = t

castCloud :: Exp -> Exp
castCloud e = (Funcall (Var "vaporize" (Entry (Subroutine "Comet" [Simple "planet"] (Simple "cloud") ) (Subrutina [] (-1)) 0 (-1)), NA) [e], Simple "cloud")

checkNum :: (String, AlexPosn) -> Exp -> Exp -> MonadTablon (Exp, Exp)
checkNum (op, AlexPn _ m n) a@(e1, t1) b@(e2, t2) = do
  if t1 == t2 && elem t1 [Err, Simple "planet", Simple "cloud"] then return (a,b)
  else do
    let cast e = castCloud e
    if      (t1, t2) == (Simple "planet", Simple "cloud") then return (cast a, b)
    else if (t2, t1) == (Simple "planet", Simple "cloud") then return (a, cast b)
    else do
      if not $ elem t1 [Err, Simple "planet", Simple "cloud"]
        then printError m n ("Error de tipo: El operador " ++ op ++ " solo admite los tipos planet y cloud, se encontró "++(show t1))
      else return ()
      if not $ elem t2 [Err, Simple "planet", Simple "cloud"]
        then printError m n ("Error de tipo: El operador " ++ op ++ " solo admite los tipos planet y cloud, se encontró "++(show t2))
      else return ()
      return ((e1, Err), (e2, Err))

checkSame :: AlexPosn -> Exp -> Exp -> MonadTablon (Exp, Exp)
checkSame (AlexPn _ m n) a@(e1, t1) b@(e2, t2) = do
  if tipoCompa t1 t2 then return (a,b)
  else if t1 == Simple "cloud" && t2 == Simple "planet" then return (a, castCloud b)
  else do
    if t1 == Err || t2 == Err then return ()
    else printError m n ("Error de tipo: Los tipos  "++(show t1)++" y "++(show t2)++" no son comparables")
    return ((e1, Err), (e2, Err))

checkAsig :: AlexPosn -> Type -> Exp -> MonadTablon Exp
checkAsig (AlexPn _ m n) t1 b@(e2, t2) = do
  if tipoAsig t1 t2 then return b
  else if t1 == Simple "cloud" && t2 == Simple "planet" then return $ castCloud b
  else do
    if t1 == Err || t2 == Err then return ()
    else printError m n ("Error de tipo: Se esperaba "++(show t1)++", se encontró "++(show t2))
    return (e2, Err)

checkT :: Type -> (String, AlexPosn) -> Exp -> Exp -> MonadTablon (Exp, Exp)
checkT t (op, AlexPn _ m n) a@(e1, t1) b@(e2, t2) = do
  if t1 == t2 && elem t1 [Err, t] then return (a,b)
  else do
    if t1 /= t || t1 == Err
      then printError m n ("Error de tipo: El operador " ++ op ++ " solo admite el tipo "++(show t)++", se encontró "++(show t1))
      else return ()
    if t2 /= t || t2 == Err
      then printError m n ("Error de tipo: El operador " ++ op ++ " solo admite el tipo "++(show t)++", se encontró "++(show t2))
      else return ()
    return ((e1, Err), (e2, Err))

checkInt :: (String, AlexPosn) -> Exp -> Exp -> MonadTablon (Exp, Exp)
checkInt = checkT (Simple "planet")

checkBool :: (String, AlexPosn) -> Exp -> Exp -> MonadTablon (Exp, Exp)
checkBool = checkT (Simple "moon")

-- checkT pero para una sola
checkT' :: Type -> AlexPosn -> Type -> MonadTablon Bool
checkT' t1 (AlexPn _ m n) t2 = do
  if t2 /= Err && t2 /= t1
    then do
    printError m n ("Error de tipo: Se esperaba "++(show t1)++", se encontró "++(show t2))
    return False
  else return True

checkInt' :: AlexPosn -> Type -> MonadTablon Bool
checkInt' = checkT' (Simple "planet")

checkBool' :: AlexPosn -> Type -> MonadTablon Bool
checkBool' = checkT' (Simple "moon")

pushPila' :: MonadTablon ()
pushPila' = do
    (tablonActual, pila, n, b, r, off, oof) <- get
    let m = n + 1
    put (tablonActual, m:pila, m, b, r, 0:off, oof)

popPila' :: MonadTablon ()
popPila' = do
    (tablonActual, p:pila, n, b, r, o:off, oof) <- get
    put (tablonActual, pila, n, b, r, off, Map.insert p o oof)

pushPila :: MonadTablon ()
pushPila = do
    (tablonActual, pila, n, b, r, off, oof) <- get
    let m = n + 1
    put (tablonActual, m:pila, m, b, r, off, oof)

popPila :: MonadTablon ()
popPila = do
    (tablonActual, pila, n, b, r, off, oof) <- get
    put (tablonActual, tail pila, n, b, r, off, oof)

currentScope :: MonadTablon Integer
currentScope = do
    (_, _, n, _, _, _, _) <- get
    return n

insertarCampos :: [(Type, (String, AlexPosn))] -> String -> MonadTablon ()
insertarCampos xs ts = do
    (tablonActual, pila@(tope:_), n, _, _, o:_, _) <- get
    let tuplas = [ (snd x, (Entry (fst x) Campo tope y)) | (x, y) <- (zip xs (f $ o:anchuras)) ]
        anchuras = map (anchura.fst) xs
        f [] = []
        f [x] = [x]
        f (x:y:zs) = if ts == "UFO" then repeat x else x:(f $ (x+y):zs)
        ancho = sum anchuras
    tab <- foldlM (flip $ uncurry insertar) tablonActual tuplas
    (_, _, _, bb, r, toff:off, oof) <- get
    put (tab, pila, n, bb, r, (toff+ancho):off, oof)

insertarVar :: (String, AlexPosn) -> Type -> MonadTablon Entry
insertarVar s t = do
    (tablonActual, pila@(tope:_), n, _, _, dir:_, _) <- get
    let entry = (Entry t Variable tope dir)
        ancho = anchura t
    tab <- insertar s entry tablonActual
    (_, _, _, bb, r, toff:off, oof) <- get
    put (tab, pila, n, bb, r, (toff+ancho):off, oof)
    return entry

insertarSubrutina :: (Def, AlexPosn) -> MonadTablon ()
insertarSubrutina ((Func s params tret sequ), pos) = do
    (tablonActual, pila@(tope:_), n, _, _, _, _) <- get
    let tparams = [ t | (t, _, _) <- params ]
        ti = Subroutine "Comet" tparams tret
    tab <- insertar (s,pos) (Entry ti (Subrutina sequ n) tope (-1)) tablonActual
    (_, _, _, b, r, off, oof) <- get
    put (tab, pila, n, b, r, off, oof)
insertarSubrutina ((Iter s params tret sequ), pos) = do
    (tablonActual, pila@(tope:_), n, _, _, _, _) <- get
    let tparams = [ t | (t, _, _) <- params ]
        ti = Subroutine "Satellite" tparams tret
    tab <- insertar (s, pos) (Entry ti (Subrutina sequ n) tope (-1)) tablonActual
    (_, _, _, b, r, off, oof) <- get
    put (tab, pila, n, b, r, off, oof)
insertarSubrutina _ = error "No es una Subrutina"

actualizarSubrutina :: String -> [Instr] -> MonadTablon ()
actualizarSubrutina s sequ = do
    (tablonActual, pila, n, b, r, off, oof) <- get
    let f (Entry _ _ k _) = k == 1 
        entries = buscar s tablonActual
        g (l,x:xs) = if f x then (x, l++xs)
                     else g (x:l, xs)
        g (_,_) = error "error raro"
        gg = g ([],entries)
        Entry t (Subrutina _ m) _ _ = fst gg
        e = Entry t (Subrutina sequ m) 1 (-1)
        updated = e : (snd gg)
        tab = Map.insert s updated tablonActual
    put (tab, pila, n, b, r, off, oof)

actualizarRegistro :: String -> [Type] -> MonadTablon ()
actualizarRegistro s tipos = do
    (tablonActual, pila, n, b, r, off, oof) <- get
    let f (Entry _ _ k _) = k == 1 
        entries = buscar s tablonActual
        g (l,x:xs) = if f x then (x, l++xs)
                     else g (x:l, xs)
        g (_,_) = error "error raro"
        gg = g ([],entries)
        Entry t kt _ _ = fst gg
        h (Registro (Record q w _) i) = Registro (Record q w tipos) i
        h _ = error "error raro"
        e = Entry t (h kt) 1 (-1)
        updated = e : (snd gg)
        tab = Map.insert s updated tablonActual
    put (tab, pila, n, b, r, off, oof)

insertarParams :: [(Type, (String, AlexPosn), Bool)] -> MonadTablon ()
insertarParams params = do
    (tablonActual, pila@(tope:_), n, _, _, o:_, _) <- get
    let tuplas = [ (s, (Entry t (Parametro b) tope y)) | ((t, s, b), y) <- (zip params (f $ o:anchuras)) ]
        fstt (a,_,_) = a
        anchuras = map (anchura.fstt) params
        f [] = []
        f [x] = [x]
        f (x:y:zs) = x:(f $ (x+y):zs)
        ancho = sum anchuras
    tab <- foldlM (flip $ uncurry insertar) tablonActual tuplas
    (_, _, _, bb, r, toff:off, oof) <- get
    put (tab, pila, n, bb, r, (toff+ancho):off, oof)

insertarReg :: (String, AlexPosn) -> String -> MonadTablon ()
insertarReg (s, pos) tr = do
    (tablonActual, pila@(tope:_), n, _, _, _, _) <- get
    tab <- insertar (s, pos) (Entry (Simple "cosmos") (Registro (Record tr s [])  (n+1)) tope (-1)) tablonActual
    (_, _, _, b, r, off, oof) <- get
    put (tab, pila, n, b, r, off, oof)

porRefExp' :: (String, Entry) -> Expr -> Expr
porRefExp' a (Funcall exp exps)  = Funcall (porRefExp a exp) (map (porRefExp a) exps)
        -- LValues
--porRefExp' v1 v2@( Var s ( Entry t c a o ) ) = if v1 == v2 then newExp else v2                      -- Revisar: Actually da error y falla
--        where newExp = Desref ( Var s (Entry tt c a o) , tt)
--              tt = Composite "~" t
               --3 tipos de slices:
porRefExp' a (Access exp (Index exp2))         = Access (porRefExp a exp) (Index (porRefExp a exp2))
porRefExp' a (Access exp (Interval exp2 exp3)) = Access (porRefExp a exp) (Interval (porRefExp a exp2) (porRefExp a exp3))
porRefExp' a (Access exp (Begin exp2))         = Access (porRefExp a exp) (Begin (porRefExp a exp2))
porRefExp' a (Attr exp (string, entry))        = Attr (porRefExp a exp) (string, entry)               -- Revisar
         -- funciones de preludio
porRefExp' a (Print exps)     = Print (map (porRefExp a) exps)
porRefExp' a (Scale exp)      = Scale (porRefExp a exp)
porRefExp' a (Pop exp exps)   = Pop (porRefExp a exp) (map (porRefExp a) exps)
porRefExp' a (Add exp exps)   = Add (porRefExp a exp) (map (porRefExp a) exps)
porRefExp' a (Desref exp)     = Desref (porRefExp a exp)
        -- Numericas
porRefExp' a (Suma exp1 exp2)  = Suma (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (Sub exp1 exp2)   = Sub (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (Mul exp1 exp2)   = Mul (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (Pow exp1 exp2)   = Pow (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (Div exp1 exp2)   = Div (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (DivE exp1 exp2)  = DivE (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (Mod exp1 exp2)   = Mod (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (Neg exp)         = Neg (porRefExp a exp)
        -- Comparaciones
porRefExp' a (Eq exp1 exp2)     = Eq (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (Neq exp1 exp2)    = Neq (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (Mayor exp1 exp2)  = Mayor (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (MayorI exp1 exp2) = MayorI (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (Menor exp1 exp2)  = Menor (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (MenorI exp1 exp2) = MenorI (porRefExp a exp1) (porRefExp a exp2)
      -- Bool
porRefExp' a (And exp1 exp2)    = And (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (Bitand exp1 exp2) = Bitand (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (Or exp1 exp2)     = Or (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (Bitor exp1 exp2)  = Bitor (porRefExp a exp1) (porRefExp a exp2)
porRefExp' a (Not exp)          = Not (porRefExp a exp)
      -- Otros
porRefExp' a (ArrLit exps) = ArrLit (map (porRefExp a) exps)
porRefExp' a (ArrInit exp tipo) = ArrInit (porRefExp a exp) tipo                               -- RevisaR
porRefExp' a (ListLit exps) = ListLit (map (porRefExp a) exps)
--porRefExp' a (DictLit exps) = DictLit (map (porRefExp a) exps)                               -- Revisar:  exps es de la forma [(Exp,Exp)] uwu

porRefExp' _ exp = exp

--Funcion incompleta:
porRefExp :: (String, Entry) -> Exp -> Exp   
porRefExp a exp = exp

showTablon :: Tablon -> String
showTablon t = fst (Map.mapAccumWithKey f "" t) where
  f a k v =  (a ++ '\n' : k ++ '\n' : intercalate "\n" (map (show) v) ++ "\n" , ())

showTablon' :: Tablon -> String
showTablon' t = showTablon $ ñame
  where ñame = Map.filter (not.apio) t
        papa (Entry _ _ 0 _) = True
        papa _ = False
        apio a = all papa a