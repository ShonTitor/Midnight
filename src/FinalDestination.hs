module FinalDestination where
import Data.Graph
import Data.Maybe (isNothing, fromJust)
import Intermediate
import Tipos
import Tablon (buscar)
import qualified TACType as T

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
partitionCode' (x:xs) = if isJump x then error "why is this allowed?" --(([x], Just x), xs)
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
          ps ss = sv $ bf $ filter fd (buscar ss tab)
          sv (Just ti) = ti == t
          sv _ = False
          t = fromJust $ bf $ filter fd (buscar s tab)
          isCall (Just (T.ThreeAddressCode T.Call _ _ _)) = True
          isCall _ = False
          tc (T.Id (SymEntry s (Entry ti _ _ _))) = ti
          tcc (Just (T.ThreeAddressCode T.Call _ ac _)) = tc (fromJust ac)

getArcs :: [((InterCode, InterInstr, Maybe InterInstr), Int)] -> Tablon -> ((InterCode, InterInstr, Maybe InterInstr), Int) -> [Int]
getArcs _ _ ((_,_, Nothing) , n) = [n+1]
getArcs xs tab ((_,_, Just (T.ThreeAddressCode T.Call _ f _)), _) = fd f
    where fd (Just (T.Id (SymEntry s entry))) = if ps entry then destination xs s
                                                else destination' xs tab (bf entry)
          fd _ = error "Why is this allowed?"
          bf (Entry t _ _ _) = t
          ps (Entry _ (Subrutina _) _ _) = True
          ps _ = False
getArcs xs tab ((_,fun, Just inst@(T.ThreeAddressCode T.Return _ _ _)), _) = callMeMaybe xs tab (getLabel fun)
getArcs xs _ ((_,_, Just inst@(T.ThreeAddressCode T.GoTo _ _ _)), _) = destination xs (getLabel inst)
getArcs xs _ ((_,_, Just inst), n) = if isJump inst then (n+1):(destination xs (getLabel inst)) else [n+1]
-- falta return

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

def :: InterInstr -> Maybe String
def (T.ThreeAddressCode T.Assign (Just x) _ _) = getSymID x
def (T.ThreeAddressCode T.Add (Just x) _ _)    = getSymID x
def (T.ThreeAddressCode T.Minus (Just x) _ _)  = getSymID x
def (T.ThreeAddressCode T.Sub (Just x) _ _)    = getSymID x
def (T.ThreeAddressCode T.Mult (Just x) _ _)   = getSymID x
def (T.ThreeAddressCode T.Div (Just x) _ _)    = getSymID x
def (T.ThreeAddressCode T.Mod (Just x) _ _)    = getSymID x
def (T.ThreeAddressCode T.Not (Just x) _ _)    = getSymID x
def (T.ThreeAddressCode T.And (Just x) _ _)    = getSymID x
def (T.ThreeAddressCode T.Or (Just x) _ _)     = getSymID x
def (T.ThreeAddressCode T.Get (Just x) _ _)    = getSymID x
def (T.ThreeAddressCode T.New (Just x) _ _)    = getSymID x
def (T.ThreeAddressCode T.Ref (Just x) _ _)    = getSymID x
def (T.ThreeAddressCode T.Deref (Just x) _ _)  = getSymID x
def (T.ThreeAddressCode T.Call (Just x) _ _)   = getSymID x
def (T.ThreeAddressCode T.Read _ (Just x) _)   = getSymID x
def (T.ThreeAddressCode _ _ _ _)               = Nothing

use :: InterInstr -> [Maybe String]
use (T.ThreeAddressCode T.Assign _ (Just y) _)      = [getSymID y]
use (T.ThreeAddressCode T.Add _ (Just y) (Just z))  = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Minus _ (Just y) _)       = [getSymID y]
use (T.ThreeAddressCode T.Sub _ (Just y) (Just z))  = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Mult _ (Just y) (Just z)) = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Div _ (Just y) (Just z))  = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Mod _ (Just y) (Just z))  = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Not _ (Just y) _)         = [getSymID y]
use (T.ThreeAddressCode T.And _ (Just y) (Just z))  = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Or _ (Just y) (Just z))   = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.If _ (Just y) _)          = [getSymID y]
use (T.ThreeAddressCode T.Eq _ (Just y) _)          = [getSymID y]
use (T.ThreeAddressCode T.Neq (Just y) (Just z) _)  = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Lt (Just y) (Just z) _)   = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Gt (Just y) (Just z) _)   = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Lte (Just y) (Just z) _)  = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Gte (Just y) (Just z) _)  = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Get _ (Just y) (Just z))  = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Set _ (Just y) (Just z))  = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.New _ (Just y) _)         = [getSymID y]
use (T.ThreeAddressCode T.Free _ (Just y) _)        = [getSymID y]
use (T.ThreeAddressCode T.Ref _ (Just y) _)         = [getSymID y]
use (T.ThreeAddressCode T.Deref _ (Just y) _)       = [getSymID y]
use (T.ThreeAddressCode T.Param _ (Just y) _)       = [getSymID y]
use (T.ThreeAddressCode T.Call _ (Just y) (Just z)) = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Call _ (Just y) (Just z)) = [getSymID y,getSymID z]
use (T.ThreeAddressCode T.Print _ (Just y) _)       = [getSymID y]
use (T.ThreeAddressCode T.Return _ (Just y) _)      = [getSymID y]
use (T.ThreeAddressCode _ _ _ _)                    = []