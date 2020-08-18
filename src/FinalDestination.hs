module FinalDestination where
import Control.Monad.RWS
import Data.Graph
import Data.Array
import Data.Maybe (fromJust, catMaybes, isNothing, fromMaybe)
import qualified Data.Set as S
import qualified Data.Map as M
import Intermediate
import Tipos
import Tablon (buscar)
import qualified TACType as T
--import Debug.Trace (trace)

type OpSet = S.Set VarType

isLabel :: InterInstr -> Bool
isLabel (T.ThreeAddressCode T.NewLabel _ _ _) = True
isLabel _ = False

isJump :: InterInstr -> Bool
isJump (T.ThreeAddressCode T.GoTo _ _ _) = True
isJump (T.ThreeAddressCode T.Eq _ _ _) = True
isJump (T.ThreeAddressCode T.Neq _ _ _) = True
isJump (T.ThreeAddressCode T.Lt _ _ _) = True
isJump (T.ThreeAddressCode T.Lte _ _ _) = True
isJump (T.ThreeAddressCode T.Gt _ _ _) = True
isJump (T.ThreeAddressCode T.Gte _ _ _) = True
isJump (T.ThreeAddressCode T.Return _ _ _) = True
isJump (T.ThreeAddressCode T.Call _ _ _) = True
isJump _ = False

getLabel' :: Maybe Operand -> String
getLabel' (Just (T.Label s)) = s
getLabel' _ = error "no es label"

getLabel :: InterInstr -> String
getLabel (T.ThreeAddressCode T.NewLabel _ l _) = getLabel' l
getLabel (T.ThreeAddressCode T.GoTo _ _ l) = getLabel' l
getLabel (T.ThreeAddressCode T.Eq _ _ l) = getLabel' l
getLabel (T.ThreeAddressCode T.Neq _ _ l) = getLabel' l
getLabel (T.ThreeAddressCode T.Lt _ _ l) = getLabel' l
getLabel (T.ThreeAddressCode T.Lte _ _ l) = getLabel' l
getLabel (T.ThreeAddressCode T.Gt _ _ l) = getLabel' l
getLabel (T.ThreeAddressCode T.Gte _ _ l) = getLabel' l
getLabel i = error $ "no tiene label "++(show i)

partitionCode :: InterCode -> [(InterCode, Maybe InterInstr)]
partitionCode [] = []
partitionCode xs = a : partitionCode b
    where (a,b) = partitionCode' xs

partitionCode' :: InterCode -> ((InterCode, Maybe InterInstr), InterCode)
partitionCode' [] = (([], Nothing),[])
partitionCode' (x:xs) = if isJump x then (([x], Just x), xs)
                        else ((x:a, aa), b)
                    where ((a, aa),b) = partitionCode'' xs

partitionCode'' :: InterCode -> ((InterCode, Maybe InterInstr), InterCode)
partitionCode'' [] = (([], Nothing),[])
partitionCode'' (x:xs) = if isJump x then (([x], Just x), xs)
                         else if isLabel x then (([], Nothing), x:xs)
                         else ((x:a, aa), b)
                    where ((a, aa),b) = partitionCode'' xs

destination :: [((InterCode, InterInstr, Maybe InterInstr), Int)] -> String -> [Int]
destination xs i = [m | ((lider:_,_,_), m) <- xs, isLabel lider, i == getLabel lider]

destination' :: [((InterCode, InterInstr, Maybe InterInstr), Int)] -> Tablon -> Type -> [Int]
destination' xs tab t = [m | ((lider:_,_,_), m) <- xs, isLabel lider, ps (getLabel lider)]
    where fd (Entry _ _ n _) = n <= 1
          bf [] = Nothing
          bf ((Entry ti _ _ _):_) = Just ti
          ps s = sv $ bf $ filter fd (buscar s tab)
          sv (Just ti) = ti == t
          sv _ = False

callMeMaybe :: [((InterCode, InterInstr, Maybe InterInstr), Int)] -> Tablon -> String -> [Int]
callMeMaybe xs tab s = [m+1 | ((_,_,call), m) <- xs, isCall call, tcc call == t]
    where fd (Entry _ _ n _) = n <= 1
          bf [] = Nothing
          bf ((Entry ti _ _ _):_) = Just ti
          --ps ss = sv $ bf $ filter fd (buscar ss tab)
          --sv (Just ti) = ti == t
          --sv _ = False
          t = fromJust $ bf $ filter fd (buscar s tab)
          isCall (Just (T.ThreeAddressCode T.Call _ _ _)) = True
          isCall _ = False
          tc (T.Id (SymEntry _ (Entry ti _ _ _))) = ti
          tc _ = error "No entiendo nada"
          tcc (Just (T.ThreeAddressCode T.Call _ ac _)) = tc (fromJust ac)
          tcc _ = error "No entiendo nada"

getArcs :: [((InterCode, InterInstr, Maybe InterInstr), Int)] -> Tablon -> ((InterCode, InterInstr, Maybe InterInstr), Int) -> [Int]
getArcs _ _ ((_,_, Nothing) , n) = [n+1]
getArcs xs tab ((_,_, Just (T.ThreeAddressCode T.Call _ f _)), _) = fd f
    where fd (Just (T.Id (SymEntry s entry))) = if ps entry then destination xs s
                                                else destination' xs tab (bf entry)
          fd _ = error "Why is this allowed?"
          bf (Entry t _ _ _) = t
          ps (Entry _ (Subrutina _ _) _ _) = True
          ps _ = False
getArcs xs tab ((_,fun, Just (T.ThreeAddressCode T.Return _ _ _)), _) = callMeMaybe xs tab (getLabel fun)
getArcs xs _ ((_,_, Just inst@(T.ThreeAddressCode T.GoTo _ _ _)), _) = destination xs (getLabel inst)
getArcs xs _ ((_,_, Just inst), n) = if isJump inst then (n+1):(destination xs (getLabel inst)) else [n+1]
-- falta return

--returnArcs' :: (Maybe Type) -> [((InterCode, InterInstr, Maybe InterInstr), Int)] -> [((InterCode, InterInstr, Maybe InterInstr), Int)] -> Tablon -> 
--              -> [((InterCode, InterInstr, Maybe InterInstr), Int)]
--returnArcs tipo 

makeArcs :: [(InterCode, Maybe InterInstr)] -> Tablon -> [(InterCode, Int, [Int])]
makeArcs ys tab = Prelude.map fd zs
         where zs = zip (f dummy ys) [0..]
               fd y@((x,_,_),n) = (x, n, getArcs zs tab y)
               f current ((code@(lider:_), goto):xs) = if g lider then (code, lider, goto) : f lider xs
                                                          else (code, current, goto) : f current xs
               f _ [] = []
               f _ _ = error "Why is this allowed?"
               g i = isLabel i && ((head $ getLabel i) /= '_')
               dummy = T.ThreeAddressCode T.Add Nothing Nothing Nothing

flowGraph :: InterCode -> Tablon -> (Graph, Vertex -> (InterCode, Int, [Int]), Int -> Maybe Vertex)
flowGraph c tab = graphFromEdges $ makeArcs (partitionCode c) tab

getSymID :: T.SymEntryCompatible a => T.Operand a b -> Maybe String
getSymID  (T.Id x)  = Just $ T.getSymID x
getSymID _ = Nothing

def :: InterInstr -> Maybe Operand
def (T.ThreeAddressCode T.Assign x _ _) = x
def (T.ThreeAddressCode T.Add x _ _)    = x
def (T.ThreeAddressCode T.Minus x _ _)  = x
def (T.ThreeAddressCode T.Sub x _ _)    = x
def (T.ThreeAddressCode T.Mult x _ _)   = x
def (T.ThreeAddressCode T.Div x _ _)    = x
def (T.ThreeAddressCode T.Mod x _ _)    = x
def (T.ThreeAddressCode T.Not x _ _)    = x
def (T.ThreeAddressCode T.And x _ _)    = x
def (T.ThreeAddressCode T.Or x _ _)     = x
def (T.ThreeAddressCode T.Get x _ _)    = x
def (T.ThreeAddressCode T.New x _ _)    = x
def (T.ThreeAddressCode T.Ref x _ _)    = x
def (T.ThreeAddressCode T.Deref x _ _)  = x
def (T.ThreeAddressCode T.Call x _ _)   = x
def (T.ThreeAddressCode T.Read _ x _)   = x
def (T.ThreeAddressCode _ _ _ _)        = Nothing

def' :: InterInstr -> OpSet
def' inst = onlyVars [def inst]

use :: InterInstr -> [Maybe Operand]
use (T.ThreeAddressCode T.Assign _ y _) = [y]
use (T.ThreeAddressCode T.Add _ y z)    = [y,z]
use (T.ThreeAddressCode T.Minus _ y _)  = [y]
use (T.ThreeAddressCode T.Sub _ y z)    = [y,z]
use (T.ThreeAddressCode T.Mult _ y z)   = [y,z]
use (T.ThreeAddressCode T.Div _ y z)    = [y,z]
use (T.ThreeAddressCode T.Mod _ y z)    = [y,z]
use (T.ThreeAddressCode T.Not _ y _)    = [y]
use (T.ThreeAddressCode T.And _ y z)    = [y,z]
use (T.ThreeAddressCode T.Or _ y z)     = [y,z]
use (T.ThreeAddressCode T.If _ y z)     = [y,z]
use (T.ThreeAddressCode T.Eq x y z)     = [x,y,z]
use (T.ThreeAddressCode T.Neq x y z)    = [x,y,z]
use (T.ThreeAddressCode T.Lt x y z)     = [x,y,z]
use (T.ThreeAddressCode T.Gt x y z)     = [x,y,z]
use (T.ThreeAddressCode T.Lte x y z)    = [x,y,z]
use (T.ThreeAddressCode T.Gte x y z)    = [x,y,z]
use (T.ThreeAddressCode T.Get _ y z)    = [y,z]
use (T.ThreeAddressCode T.Set _ y z)    = [y,z]
use (T.ThreeAddressCode T.New _ y _)    = [y]
use (T.ThreeAddressCode T.Free _ y _)   = [y]
use (T.ThreeAddressCode T.Ref _ y _)    = [y]
use (T.ThreeAddressCode T.Deref _ y _)  = [y]
use (T.ThreeAddressCode T.Param _ y _)  = [y]
use (T.ThreeAddressCode T.Call _ y z)   = [y,z]
use (T.ThreeAddressCode T.Print _ y _)  = [y]
use (T.ThreeAddressCode T.Return _ y _) = [y]
use (T.ThreeAddressCode _ _ _ _)        = []

use' :: InterInstr -> OpSet
use' inst = onlyVars $ use inst

defuse :: Graph -> (Vertex -> (InterCode, Int, [Int])) -> [(Int, OpSet, OpSet)]
defuse g f = map defuse'' v
      where ffst (c,_,_) = c
            ff x = ffst $ f x
            v = indices g
            defuse'' n = pegar n (defuse' (S.empty,S.empty) (ff n))
            pegar a (b,c) = (a,b,c)

defuse' :: (OpSet, OpSet) -> InterCode -> (OpSet, OpSet)
defuse' acum [] = acum
defuse' (defs, uses) (inst:code) = defuse' (newdef, newuse) code
      where newdef = S.union defs (S.difference (def' inst) newuse)
            newuse = S.union uses (S.difference (use' inst) defs)

isVar :: Operand -> Bool
isVar (T.Id (SymEntry _ (Entry _ Variable _ _))) = True
isVar (T.Id (SymEntry _ (Entry _ (Parametro _) _ _))) = True
isVar (T.Id (Temp _ _ _)) = True
isVar _ = False

toVar :: Operand -> Maybe VarType
toVar (T.Id v@(SymEntry _ (Entry _ Variable _ _))) = Just v
toVar (T.Id v@(SymEntry _ (Entry _ (Parametro _) _ _))) = Just v
toVar (T.Id v@(Temp _ _ _)) = Just v
toVar _ = Nothing

toVar' :: Operand -> VarType
toVar' a = fromJust $ toVar a

onlyVars :: [Maybe Operand] -> OpSet
onlyVars xs = S.fromList $ catMaybes $ map toVar $ catMaybes xs

aliveVars :: Graph -> (Vertex -> (InterCode, Int, [Int])) -> [[OpSet]]
aliveVars g f = if n== 0 then [] else r3
      where defuses = defuse g f
            n = length defuses
            ffst (c,_,_) = c
            ff x = ffst $ f x
            defs = array (0,n-1) [ (ind, d) | (ind, d, _) <- defuses ]
            uses = array (0,n-1) [ (ind, u) | (ind, _, u) <- defuses ]
            emptyArr = array (0,n-1) ([ (i,S.empty) | i <- [0..n-1] ])
            (r1,r2) = aliveVars' n g f defs uses emptyArr emptyArr
            alives k = aliveVarsB (ff k) (r1 ! k) (r2 ! k)
            r3 = map alives (vertices g)


aliveVars' :: Int -> Graph
           -> (Vertex -> (InterCode, Int, [Int]))
           -> Array Int OpSet -- def 
           -> Array Int OpSet -- use
           -> Array Int OpSet -- in
           -> Array Int OpSet -- out
           -> (Array Int OpSet, Array Int OpSet) -- (in, out)
aliveVars' n g f defs uses ins outs = if ins == nextins then (nextins, nextouts)
                                      else aliveVars' n g f defs uses nextins nextouts
          where succs k = filter (<n) $ thr $ f k
                thr (_,_,a) = a
                nextout b = S.unions [ ins ! y | y <- succs b ]
                nextin b  = S.union (uses ! b) (S.difference (nextouts ! b) (defs ! b ))
                nextouts  = listArray (0,n-1) (map' nextout [0..n-1] (outs ! (n-1)))
                nextins  = listArray (0,n-1) (map' nextin [0..n-1] (S.empty))
                map' _ [] _ = []
                map' _ [_] defa = [defa]
                map' ff (x:xs) defa = (ff x) : map' ff xs defa

aliveVarsB :: InterCode -> OpSet -> OpSet -> [OpSet]
aliveVarsB code ins outs = aliveVarsB' (zip (code++[filler]) newins)
          where n = length code
                givein 0 = ins
                givein x = if x == n then outs else S.empty
                newins = map givein [0..n]
                filler = T.ThreeAddressCode T.Abort Nothing Nothing Nothing

aliveVarsB' :: [(InterInstr, OpSet)] -> [OpSet]
aliveVarsB' cosas = if cosas == next then orphans++current
                    else aliveVarsB' next
           where nextin [] = []
                 nextin [x] = [x]
                 nextin ((c1,_):(c2,i2):xs) = (c1, S.union (use' c1) (S.difference i2 (def' c1)) ) : (nextin $ (c2,i2):xs)
                 current = snd $ unzip cosas
                 next = nextin cosas
                 orph [] = []
                 orph [_] = []
                 orph ((c1,i1):b@(_,i2):xs) = (S.union i1 (S.difference (def' c1) i2)) : (orph (b:xs))
                 orphans = orph next

interferenceEdges :: [[OpSet]] -> [(VarType, VarType)]
interferenceEdges oof = map (dupla.(S.toList)) $ S.toList $ S.unions $ map (makeedges.(S.toList)) $ flatten oof
                  where makeedges (x:xs) = S.union (S.fromList [ S.fromList [x,y] | y <- xs ]) (makeedges xs)
                        makeedges [] = S.empty
                        flatten (x:xs) = x ++ flatten xs
                        flatten [] = []
                        dupla [x,y] = (x,y)
                        dupla _ = error "No"

interferenceVertices :: InterCode -> OpSet
interferenceVertices xs = S.union defs uses
                          where defs = S.unions $ map def' xs
                                uses = S.unions $ map use' xs

interferenceGraph :: InterCode -> Tablon -> (OpSet , (Graph, Vertex -> (VarType, Int, [Int]), Int -> Maybe Vertex))
interferenceGraph code tab = interferenceGraph' (interferenceVertices code, interferenceEdges $ aliveVars g f )
                  where (g,f,_) = flowGraph code tab

interferenceGraph' :: (OpSet, [(VarType, VarType)]) -> (OpSet, (Graph, Vertex -> (VarType, Int, [Int]), Int -> Maybe Vertex))
interferenceGraph' (v, e) = (v, (g, f1, f2))
        where emptySuccs = M.fromSet (\_ -> S.empty) v
              succsMap = foldl uniteUp emptySuccs e
              succs u = if isNothing (M.lookup u succsMap) then S.empty
                        else fromJust $ M.lookup u succsMap
              uniteUp m (k, a) = uniteUp' (k, a) m
              uniteUp' (k, a) m = M.insertWith S.union a (S.singleton k) (M.insertWith S.union k (S.singleton a) m)
              indexMap :: M.Map VarType Int
              indexMap = foldl (\m (k,a) -> M.insert k a m) (M.empty) (zip (S.toList v) [0..])
              getIndex u = fromJust $ M.lookup u indexMap
              (g, f1, f2) = graphFromEdges $ map (\u -> (u, getIndex u, map getIndex $ S.toList $ succs u)) $ S.toList v

dSatur :: (Graph, Vertex -> (VarType, Int, [Int]), Int -> Maybe Vertex) -> [OpSet]
dSatur gg@(g, f, _) = map (S.map ff) (dSatur' gg (S.fromList $ vertices g) (M.empty, []))
      where frt (a,_,_) = a
            ff u = frt $ f u

dSatur' :: (Graph, Vertex -> (VarType, Int, [Int]), Int -> Maybe Vertex) -> S.Set Vertex -> (M.Map Vertex Int, [S.Set Vertex])
            -> [S.Set Vertex]
dSatur' gg@(g,f,_) uncolored (colorKeys, colors) = if S.size uncolored == 0 then colors
                                                   else dSatur' gg uncolored' (colorKeys', colors')
      where satDeg u = S.size $ S.fromList $ filter (>= 0) $ map colorKey $ succs u
            degree u = length $ succs u
            succs u = thr $ f u
            thr (_,_,a) = a
            maxSatDeg = maxSatDeg' (filter (\x -> S.member x uncolored) (vertices g))
            maxSatDeg' xs@(x:_) = maxDeg' xs x
            maxSatDeg' [] = error ("algo salió terriblemente mal con dsatur "++(show $ S.size uncolored))
            maxDeg' [] big = big
            maxDeg' (u:us) big = if (satDeg u > satDeg big) || 
                                    ((satDeg u == satDeg big) && (degree u) > (degree big))
                                    then maxDeg' us u 
                                 else maxDeg' us big
            colorKey u = fromMaybe (-1) (M.lookup u colorKeys)
            uncolored' = S.delete maxSatDeg uncolored
            neighbors = S.fromList $ succs maxSatDeg
            insertIndex acum [] = (acum, [S.singleton maxSatDeg])
            insertIndex acum (c:cs) = if S.disjoint neighbors c then (acum, (S.insert maxSatDeg c) : cs)
                                      else (\(a,b) -> (a,c:b)) (insertIndex (acum+1) cs)
            (colork, colors') = insertIndex 0 colors
            colorKeys' = M.insert maxSatDeg colork colorKeys

getColors :: InterCode -> Tablon -> M.Map VarType Int
getColors code tab = M.fromList [ x | x <- colored++spills ]
          where  colors = dSatur $ snd $ interferenceGraph code tab
                 colored = pairs $ zip colors [8..25]
                 spills = pairs $ zip (drop 18 colors) (repeat 0)
                 pairs a = [ (v,n) | (s,n) <- a, v <- S.toList s ]

type FinalMonad a = RWST () String (M.Map VarType Int, S.Set VarType, M.Map String Integer, String) IO a

hasReg :: Operand -> Bool
hasReg (T.Id Base) = True
hasReg a = isVar a

isConst :: Operand -> Bool
isConst (T.Constant _) = True
isConst _ = False

labelize :: Operand -> String
labelize (T.Label ('~':s)) = s
labelize (T.Label s) = s
labelize a = show a

getType :: Operand -> Type
getType (T.Id (SymEntry _ (Entry t _ _ _))) = t
getType (T.Constant (_,t)) = t
getType (T.Id (Temp _ _ t)) = Simple "planet" --t

getOffset :: Operand -> Integer
getOffset (T.Id (SymEntry _ (Entry _ _ _ o))) = o
getOffset (T.Id (Temp _ o _)) = o
getOffset a = error ("sin offset "++(show a))

getOffset' :: VarType -> Integer
getOffset' (SymEntry _ (Entry _ _ _ o)) = o
getOffset' (Temp _ o _) = o
getOffset' a = error ("sin offset "++(show a))

getReg :: Operand -> FinalMonad Int
getReg op = do
    (m, seen, offmap, currentfun) <- get
    let var = toVar' op
        color = M.lookup var m
        isBase (T.Id Base) = True
        isBase _ = False
        isTemp (T.Id (Temp _ _ _)) = True
        isTemp _ = False
        n = if isBase op then 30
            else if isNothing color then error "variable sin colorear"
            else fromJust $ color
        off = show $ getOffset op
        opv = fromJust $ toVar op
    if isTemp op || isBase op || S.member opv seen then return ()
    else do
      put (m, S.insert opv (S.filter (\o -> (fromJust $ M.lookup o m) /= (fromJust $ color)) seen), offmap, currentfun)
      tell ("\tlw $"++(show n)++", "++off++"($fp)\n")
    return n

finalOp :: Operand -> FinalMonad String
finalOp op = do
  let lab = labelize op
  if hasReg op then do
      o <- getReg op
      if o == 0 then error "aquí se manejarían los spills... si los manejáramos"
      else return $ '$':(show o)
  else if lab == "vac" || lab == "new" then return "$0"
  else if lab == "full" then return "1"
  else return lab

finalDestination :: InterCode -> Tablon -> M.Map String Integer -> IO String
finalDestination code tab offsets = do
  (_, _, text) <- runRWST (finalCode code) () (getColors code tab, S.empty, offsets, "")
  return text

finalCode :: InterCode -> FinalMonad ()
finalCode code = do
  tell ".data\n_datos:\n.text\n"
  _ <- mapM finalInstr code
  tell "\tli $v0, 10\n\tsyscall"
  return ()

unsee :: FinalMonad ()
unsee = do
  let f op = do 
              v <- finalOp (T.Id op)
              tell ("\t# "++(show op)++" "++(show $ getOffset' op)++"\n")
              tell ("\tsw "++v++", "++(show $ getOffset' op)++"($fp)\n")
  (a,unseen,off,currentfun) <- get
  tell "\t# PANIC\n"
  _ <- mapM f (S.toList unseen)
  tell "\t# END PANIC\n"
  put (a, S.empty, off, currentfun)

unsee' :: FinalMonad ()
unsee' = do
  (a,_,off,currentfun) <- get
  put (a,S.empty,off,currentfun)

finalInstr :: InterInstr -> FinalMonad ()
finalInstr (T.ThreeAddressCode T.NewLabel _ (Just label) _) = do
  let lab = labelize label
      subr ('_':_) = False
      subr "end" = False
      subr _ = True
  tell $ lab++":\n"
  if subr lab then do 
    unsee'
    (a,b,offmap,_) <- get
    put (a,b,offmap,lab)
    if lab == "main" then do tell "\tmove $fp, $sp\n" else return ()
    tell ("\tadd $sp, $fp, "++(show $ fromJust $ M.lookup lab offmap)++"\n")
  else return ()
finalInstr (T.ThreeAddressCode T.Param Nothing Nothing Nothing) = do
  tell "\tsw $fp, ($sp)\n"
  tell "\tsw $ra, 4($sp)\n"
  tell "\tadd $sp, 12\n"
finalInstr (T.ThreeAddressCode T.Param Nothing (Just p) Nothing) = do
    let ancho = anchura $ getType p
        f :: String -> Integer -> FinalMonad ()
        f _ 0 = return ()
        f a n = do
          if n < 0 then error "no alineado"
          else do
            tell ("\tlw $a0, ("++a++")\n")
            tell ("\tsw $a0, ($sp)\n")
            tell "\tadd $sp, 4\n"
            tell ("\tadd "++a++", 4\n")
            f a (n-4)
    pp <- finalOp p
    f pp ancho
-- asignación
finalInstr (T.ThreeAddressCode T.Assign (Just x) (Just y) _) = do
    if hasReg x then do
        a <- finalOp x
        if hasReg y then do
            b <- finalOp y
            if a == b then tell "# "
            else return ()
            tell $ "\tmove "++a++(',':' ':b)++"\n"
        else if (labelize y) == "full" then tell $ "\tli "++a++(',':' ':'1':"\n")
        else if isConst y then tell $ "\tli "++a++(',':' ':(show y)++"\n")
        else tell $ "\tla "++a++(',':' ':(show y)++"\n")
    else error "asignación inválida"
finalInstr (T.ThreeAddressCode T.Add (Just x) (Just y) (Just z)) = do
    a <- finalOp x
    b <- finalOp y
    c <- finalOp z
    tell ("\tadd "++a++',':' ':b++',':' ':c++"\n")
-- lógicas y aritméticas
finalInstr (T.ThreeAddressCode T.Mult (Just x) (Just y) (Just z)) = do
    a <- finalOp x
    b <- finalOp y
    c <- finalOp z
    tell ("\tmul "++a++',':' ':b++',':' ':c++"\n")
finalInstr (T.ThreeAddressCode T.Sub (Just x) (Just y) (Just z)) = do
    a <- finalOp x
    b <- finalOp y
    c <- finalOp z
    tell ("\tsub "++a++',':' ':b++',':' ':c++"\n")
finalInstr (T.ThreeAddressCode T.Div (Just x) (Just y) (Just z)) = do
    a <- finalOp x
    b <- finalOp y
    c <- finalOp z
    tell ("\tdiv "++a++',':' ':b++',':' ':c++"\n")
finalInstr (T.ThreeAddressCode T.Mod (Just x) (Just y) (Just z)) = do
    a <- finalOp x
    b <- finalOp y
    c <- finalOp z
    tell ("\trem "++a++',':' ':b++',':' ':c++"\n")
finalInstr (T.ThreeAddressCode T.Minus (Just x) (Just y) Nothing) = do
    a <- finalOp x
    b <- finalOp y
    tell ("\tneg "++a++',':' ':b++"\n")
finalInstr (T.ThreeAddressCode T.Not (Just x) (Just y) Nothing) = do
    a <- finalOp x
    b <- finalOp y
    tell ("\tnot "++a++',':' ':b++"\n")
finalInstr (T.ThreeAddressCode T.And (Just x) (Just y) (Just z)) = do
    a <- finalOp x
    b <- finalOp y
    c <- finalOp z
    tell ("\tand "++a++',':' ':b++',':' ':c++"\n")
finalInstr (T.ThreeAddressCode T.Or (Just x) (Just y) (Just z)) = do
    a <- finalOp x
    b <- finalOp y
    c <- finalOp z
    if isConst z then tell ("\tori "++a++',':' ':b++',':' ':c++"\n")
    else tell ("\tor "++a++',':' ':b++',':' ':c++"\n")
-- branches
finalInstr (T.ThreeAddressCode T.GoTo Nothing Nothing (Just label)) = do
    l <- finalOp label
    if hasReg label then tell ("\tjr "++l++"\n")
    else tell ("\tj "++l++"\n")
finalInstr (T.ThreeAddressCode T.Eq (Just x) (Just y) (Just label)) = do
    a <- finalOp x
    b <- finalOp y
    c <- finalOp label
    tell ("\tbeq "++a++',':' ':b++',':' ':c++"\n")
finalInstr (T.ThreeAddressCode T.Neq (Just x) (Just y) (Just label)) = do
    a <- finalOp x
    b <- finalOp y
    c <- finalOp label
    tell ("\tbne "++a++',':' ':b++',':' ':c++"\n")
finalInstr (T.ThreeAddressCode T.Lt (Just x) (Just y) (Just label)) = do
    a <- finalOp x
    b <- finalOp y
    c <- finalOp label
    tell ("\tblt "++a++',':' ':b++',':' ':c++"\n")
finalInstr (T.ThreeAddressCode T.Gt (Just x) (Just y) (Just label)) = do
    a <- finalOp x
    b <- finalOp y
    c <- finalOp label
    tell ("\tbgt "++a++',':' ':b++',':' ':c++"\n")
finalInstr (T.ThreeAddressCode T.If Nothing (Just y) (Just label)) = do
    b <- finalOp y
    c <- finalOp label
    tell ("\tbnez "++b++',':' ':c++"\n")
-- no thank you finalInstr (T.ThreeAddressCode T.Lte (Just x) (Just y) (Just label)) = do
finalInstr (T.ThreeAddressCode T.Gte (Just x) (Just y) (Just label)) = do
    a <- finalOp x
    b <- finalOp y
    c <- finalOp label
    tell ("\tbge "++a++',':' ':b++',':' ':c++"\n")
-- otros 
finalInstr (T.ThreeAddressCode T.Print Nothing (Just e) Nothing) = do
    let t = getType e
    ee <- finalOp e
    if t == Simple "planet" then do
        if isConst e then tell ("\tli $a0, "++ee++"\n")
        else tell ("\tmove $a0, "++ee++"\n")
        tell "\tli $v0, 1\n"
        tell "\tsyscall\n"
        tell "\tli $v0, 11\n"
        tell "\tli $a0, 10\n"
        tell "\tsyscall\n"
    else tell ("\t# print no implementado: "++(show e)++"\n")
finalInstr (T.ThreeAddressCode T.Get (Just x) (Just y) (Just _)) = do
    a <- finalOp x
    b <- finalOp y
    if isConst y then tell ("\tlw "++a++", "++b++"\n")
    else tell ("\tlw "++a++", ("++b++")\n")
finalInstr (T.ThreeAddressCode T.Set (Just x) (Just i) (Just z)) = do
    a <- finalOp x
    b <- finalOp z
    if isConst z then do 
      tell ("\tli $a3, "++b++"\n")
      tell ("\tsw $a3, ("++a++")\n")
    else tell ("\tsw "++b++", ("++a++")\n")
-- no thank you (T.ThreeAddressCode T.Ref (Just x) (Just y) Nothing)
finalInstr (T.ThreeAddressCode T.Deref (Just x) (Just y) _) = do
    a <- finalOp x
    b <- finalOp y
    if isConst y then tell ("\tlw "++a++", "++b++"\n")
    else tell ("\tlw "++a++", ("++b++")\n")
finalInstr (T.ThreeAddressCode T.New (Just x) (Just size) _) = do
    a <- finalOp x
    b <- finalOp size
    if isConst size then tell ("\tli $v0, 9\n\tli $a0, "++b++"\n\tsyscall\n\tmove "++a++", $v0\n")
    else tell ("\tli $v0, 9\n\tmove $a0, "++b++"\n\tsyscall\n\tmove "++a++", $v0\n")
finalInstr (T.ThreeAddressCode T.Exit _ _ _) = tell "\tli $v0, 10\n\tsyscall\n"
finalInstr (T.ThreeAddressCode T.Abort _ _ _) = tell "\tli $v0, 10\n\tsyscall\n"
finalInstr (T.ThreeAddressCode T.Read Nothing (Just e) Nothing) = do
    a <- finalOp e
    tell ("\tli $v0, 9\n\tli $a0, 1024\n\tsyscall\n\tmove $a0, $v0\n\tli $a1, 1024\n\tli $v0, 8\n\tsyscall\n\tmove "++a++", $v0\n")
finalInstr (T.ThreeAddressCode T.Call (Just t) (Just l) (Just n)) = do
    ret <- finalOp t
    f <- finalOp l
    ps <- finalOp n
    unsee
    tell ("\tsub $fp, $sp, "++ps++"\n")
    if hasReg l then tell ("\tjalr "++f++"\n")
    else tell ("\tjal "++f++"\n")
    --tell ("\tsub $sp, $sp, "++ps++"\n")
    tell ("\tlw "++ret++", -4($sp) \n")
    tell ("\tlw "++ret++", ("++ret++") \n")
    tell ("\tlw $ra, -8($sp) \n")
    tell ("\tlw $fp, -12($sp) \n")
    tell ("\tsub $sp, $sp, 12\n")
finalInstr (T.ThreeAddressCode T.Return Nothing (Just t) Nothing) = do
    ret <- finalOp t
    (a,b,offmap,currentfun) <- get
    put (a,b,offmap,currentfun)
    --lift $ putStrLn (currentfun++(show offmap))
    tell ("\tsub $sp, $sp, "++(show $ fromJust $ M.lookup currentfun offmap)++"\n")
    tell "\t# RETURN\n"
    tell ("\tsw "++ret++", -4($fp) \n")
    tell "\tjr $ra\n"
finalInstr i = tell ("\t# No implementado: "++(show i)++"\n")