module Intermediate where
import Control.Monad.RWS
import Data.Map
import Data.Foldable
import Data.Maybe (fromJust)
import Tipos
import Parser (gatto)
import qualified TACType as T

data VarType = Temp Int Integer Type
             | SymEntry String Entry
             | Base
      deriving (Eq)
type Operand = T.Operand VarType Type
type InterInstr = T.ThreeAddressCode VarType Type
type InterCode = [InterInstr]
type InterMonad a = RWST () InterCode (Int, Int, [Operand], [Operand], Integer) IO a

instance T.SymEntryCompatible VarType where
  getSymID (Temp n _ _) = "_t"++(show n)
  getSymID (SymEntry s (Entry _ _ _ _)) = s-- ++ " (scope:"++(show a)++")"
  getSymID Base = "_base"

instance Ord VarType where
  compare a b = compare (T.getSymID a) (T.getSymID b)

instance Show VarType where
    show x = T.getSymID x

vaca :: String -> IO (InterCode, Tablon, Map String Integer)
vaca f = do
    (arbol, (tablon, _, _, ok, _, _, oof), _) <- gatto f
    cow arbol tablon ok oof

cow :: Program -> Tablon -> Bool -> OffMap -> IO (InterCode, Tablon, Map String Integer)
cow (Root lis) tab ok oof = do
    let moo' :: (Int, Int, InterCode, Map String Integer) -> String -> Entry -> IO (Int, Int, InterCode, Map String Integer)
        moo' (n, m, code, oofmap) s entry@(Entry _ (Subrutina _ scope) 1 _) = do
            (_, (a,b,_,_,off), c) <- runRWST (genCodeSub s entry) () (n,m,[],[], fromJust $ Data.Map.lookup scope oof)
            return (a, b, code++c, insert s off oofmap)
        moo' aaa _ _ = return aaa
        moo :: IO (Int, Int, InterCode, Map String Integer) -> String -> [Entry] -> IO (Int, Int, InterCode, Map String Integer)
        moo b s entries = do
            a <- b
            foldlM (\x y -> moo' x s y) a entries
        moo'' :: IO (Int, Int, InterCode, Map String Integer) -> String -> [Entry] -> (IO (Int, Int, InterCode, Map String Integer), ())
        moo'' b s entries = (moo b s entries, ())
        mu :: IO (Int, Int, InterCode,Map String Integer)
        mu = return (0,0,[],Data.Map.empty)
    if ok then do
        let (cc,_) = mapAccumWithKey moo'' mu tab
        (i,j,sc,bigoof) <- cc
        (_,(_,_,_,_,offsetmain),c) <- runRWST (genCode lis) () (i,j,[],[], fromJust $ Data.Map.lookup 1 oof)
        return ((sc++(T.ThreeAddressCode T.NewLabel Nothing (Just $ T.Label "~main") Nothing):c)++
          [T.ThreeAddressCode T.NewLabel Nothing (Just $ T.Label "~end") Nothing], tab, insert "main" offsetmain bigoof)
    else return ([], tab, insert "main" 0 Data.Map.empty)

base :: Operand
base = T.Id Base

constInt :: Integer -> Operand
constInt n = T.Constant (show n, Simple "planet")

pointerSize :: Operand
pointerSize = constInt $ anchura (Composite "~" IDK)

setType :: Operand -> Type -> Operand
setType (T.Id (SymEntry q (Entry _ a b c))) t = (T.Id (SymEntry q (Entry t a b c)))
setType (T.Constant (a,_)) t = (T.Constant (a,t))
setType (T.Id (Temp a b _)) t = (T.Id (Temp a b t))

popLoop :: InterMonad ()
popLoop = do
    (n, m, _:s1, _:s2, off) <- get
    put (n, m, s1, s2, off)

lookLoop :: InterMonad ([Operand], [Operand])
lookLoop = do
    (_, _, s1, s2, _) <- get
    return (s1, s2)

pushLoop :: Operand -> Operand -> InterMonad ()
pushLoop a b = do
    (n, m, s1, s2, off) <- get
    put (n, m, a:s1, b:s2, off)

newTemp :: InterMonad Operand
newTemp = do
    (n,m,a,b,off) <- get
    put (n+1,m,a,b,off+4)
    return $ T.Id (Temp n off IDK)

lastTemp :: InterMonad Operand
lastTemp = do
    (n,_,_,_,off) <- get
    return $ T.Id (Temp (n-1) (off-4) IDK)

newLabel :: InterMonad Operand
newLabel = do 
    (n,m,a,b,off) <- get
    put (n,m+1,a,b,off)
    return $ T.Label $ '_':(show m)

genCode :: [Instr] -> InterMonad ()
genCode [] = return ()
genCode (x:xs) = do
    genCodeInstr x
    genCode xs

genCodeSub :: String -> Entry -> InterMonad ()
genCodeSub s (Entry _ (Subrutina sequ _) 1 _) = do
    tell [T.ThreeAddressCode T.NewLabel Nothing (Just $ T.Label s) Nothing]
    genCode sequ
genCodeSub _ _ = return ()


genCodeInstr :: Instr -> InterMonad ()
-- Expresiones flotando
genCodeInstr (Flotando (e,_)) = do
    c <- genCodeExp e
    tell c
-- Selección
genCodeInstr (If xs) = do
    let genCodeIf [((b,_), sequ, _)] next = do
            btrue <- newLabel
            c1 <- genCodeExpB (b, btrue, next)
            tell c1
            tell [T.ThreeAddressCode T.NewLabel Nothing (Just btrue) Nothing]
            genCode sequ
            --tell [T.ThreeAddressCode T.GoTo Nothing Nothing (Just next)]
        genCodeIf (((b,_), sequ, _):elifs) next = do
            btrue <- newLabel
            bfalse <- newLabel
            c1 <- genCodeExpB (b, btrue, bfalse)
            tell c1
            tell [T.ThreeAddressCode T.NewLabel Nothing (Just btrue) Nothing]
            genCode sequ
            tell [T.ThreeAddressCode T.GoTo Nothing Nothing (Just next),
                  T.ThreeAddressCode T.NewLabel Nothing (Just bfalse) Nothing]
            genCodeIf elifs next
        genCodeIf _ _ = error "empty if"
    next <- newLabel
    genCodeIf xs next
    tell [T.ThreeAddressCode T.NewLabel Nothing (Just next) Nothing]
-- Repetición
genCodeInstr (While (b,_) sequ _) = do
    begin <- newLabel
    btrue <- newLabel
    bfalse <- newLabel
    c1 <- genCodeExpB (b, btrue, bfalse)
    tell $ (T.ThreeAddressCode T.NewLabel Nothing (Just begin) Nothing) : c1
    tell [T.ThreeAddressCode T.NewLabel Nothing (Just btrue) Nothing]
    pushLoop bfalse begin
    genCode sequ
    popLoop
    tell [T.ThreeAddressCode T.GoTo Nothing Nothing (Just begin),
          T.ThreeAddressCode T.NewLabel Nothing (Just bfalse) Nothing]
genCodeInstr (ForC instr (b,_) instrf sequ _) = do
    begin <- newLabel
    btrue <- newLabel
    bfalse <- newLabel
    continue <- newLabel
    c1 <- genCodeExpB (b, btrue, bfalse)
    genCodeInstr instr
    tell $ (T.ThreeAddressCode T.NewLabel Nothing (Just begin) Nothing) : c1
    tell [T.ThreeAddressCode T.NewLabel Nothing (Just btrue) Nothing]
    pushLoop bfalse continue
    genCode sequ
    tell [T.ThreeAddressCode T.NewLabel Nothing (Just continue) Nothing]
    genCodeInstr instrf
    popLoop
    tell [T.ThreeAddressCode T.GoTo Nothing Nothing (Just begin),
          T.ThreeAddressCode T.NewLabel Nothing (Just bfalse) Nothing]
genCodeInstr (ForRange k e1 e2 e3 sequ _) = do
    begin <- newLabel
    btrue <- newLabel
    bfalse <- newLabel
    continue <- newLabel
    start <- getOperand e1
    end' <- getOperand e2
    step' <- getOperand e3
    end <- newTemp
    step <- newTemp
    i <- getOperand k
    iter <- newTemp
    tell [T.ThreeAddressCode T.Assign (Just iter) (Just start) Nothing,
          T.ThreeAddressCode T.Assign (Just end) (Just end') Nothing,
          T.ThreeAddressCode T.Assign (Just step) (Just step') Nothing,
          T.ThreeAddressCode T.NewLabel Nothing (Just begin) Nothing, 
          T.ThreeAddressCode T.Lt (Just iter) (Just end) (Just btrue), 
          T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse),
          T.ThreeAddressCode T.NewLabel Nothing (Just btrue) Nothing,
          T.ThreeAddressCode T.Assign (Just i) (Just iter) Nothing]
    pushLoop bfalse continue
    genCode sequ
    popLoop
    tell [T.ThreeAddressCode T.NewLabel Nothing (Just continue) Nothing]
    tell [T.ThreeAddressCode T.Add (Just iter) (Just iter) (Just step),
          T.ThreeAddressCode T.GoTo Nothing Nothing (Just begin),
          T.ThreeAddressCode T.NewLabel Nothing (Just bfalse) Nothing]
genCodeInstr (Foreach k e sequ _) = do
    let f (_, Composite "Quasar" _) = True
        f _ = False
    if f e then do
        btrue <- newLabel
        bfalse <- newLabel
        continue <- newLabel
        t0 <- getAddress $ fst e
        t1 <- newTemp
        t2 <- newTemp
        iter <- newTemp
        i <- getOperand k
        tell [T.ThreeAddressCode T.Add (Just t1) (Just t0) (Just $ pointerSize),
              T.ThreeAddressCode T.Deref (Just t1) (Just t1) Nothing,
              T.ThreeAddressCode T.Assign (Just t2) (Just $ constInt 0) Nothing,
              T.ThreeAddressCode T.Eq (Just t1) (Just $ constInt 0) (Just bfalse),
              T.ThreeAddressCode T.NewLabel Nothing (Just btrue) Nothing,
              T.ThreeAddressCode T.Deref (Just t0) (Just t0) Nothing,
              T.ThreeAddressCode T.Add (Just iter) (Just t0) (Just $ pointerSize), 
              T.ThreeAddressCode T.Deref (Just iter) (Just iter) Nothing,
              T.ThreeAddressCode T.Assign (Just i) (Just iter) Nothing]
        pushLoop bfalse continue
        genCode sequ
        popLoop
        tell [T.ThreeAddressCode T.NewLabel Nothing (Just continue) Nothing]
        tell [T.ThreeAddressCode T.Add (Just t2) (Just t2) (Just $ constInt 1),
              T.ThreeAddressCode T.Lt (Just t2) (Just t1) (Just btrue),
              T.ThreeAddressCode T.NewLabel Nothing (Just bfalse) Nothing]
    else error "no implementado"
-- break y continue
genCodeInstr (Break b) = do
    let f :: Operand -> Integer -> [Operand] -> InterMonad ()
        f _ _ [] = return ()
        f _ _ [l] = do
            tell [T.ThreeAddressCode T.GoTo Nothing Nothing (Just l)]
        f n acum (l:ls) = do
            tell [T.ThreeAddressCode T.Eq (Just n) (Just $ constInt acum) (Just l)]
            f n (acum+1) ls
    n <- getOperand b
    labels <- lookLoop
    f n 1 (fst labels)
genCodeInstr (Continue) = do
    labels <- lookLoop
    tell [T.ThreeAddressCode T.GoTo Nothing Nothing (Just $ head $ snd labels)]
-- Asignaciones
genCodeInstr (Asig (e1@(Attr _ _),t) e2) = do
    let f (Composite s _) = elem s ["Cluster", "Quasar", "Nebula"]
        f _ = False
    if f t then do
        a1 <- getAddress e1
        a2 <- getAddress $ fst e2
        genCodeCopy t a1 a2
    else do
        a <- getAddress e1
        b <- getOperand e2
        tell [T.ThreeAddressCode T.Set (Just a) (Just $ constInt 0) (Just b)]
genCodeInstr (Asig (e1@(Access _ _),t) e2) = do
    let f (Composite s _) = elem s ["Cluster", "Quasar", "Nebula"] 
        f _ = False
    if f t then do
        a1 <- getAddress e1
        a2 <- getAddress $ fst e2
        genCodeCopy t a1 a2
    else do
        a <- getAddress e1
        b <- getOperand e2
        tell [T.ThreeAddressCode T.Set (Just a) (Just $ constInt 0) (Just b)]
genCodeInstr (Asig e1 e2) = do
    let f (_,Composite s _) = elem s ["Cluster", "Quasar", "Nebula"]
        f (_, Record _ _ _) = True
        f _ = False
    if f e1 then do
        a1 <- getAddress $ fst e1
        a2 <- getAddress $ fst e2
        if shallowable $ fst e2 then do
          shallowCopy (snd e1) a1 a2
        else do 
          genCodeCopy (snd e1) a1 a2
    else do 
      lvalue <- getOperand e1
      rvalue <- getOperand e2
      tell [T.ThreeAddressCode T.Assign (Just lvalue) (Just rvalue) Nothing]
-- Return y Yield
genCodeInstr (Return e1@(_,ti)) = do
    let isSimple (Simple _) = True
        isSimple _ = False
    o <- getOperand e1
    temp <- newTemp
    tell [T.ThreeAddressCode T.New (Just temp) (Just $ constInt $ anchura ti) Nothing]
    if isSimple ti then do
      temp2 <- newTemp
      tell [T.ThreeAddressCode T.Assign (Just temp2) (Just o) Nothing,
            T.ThreeAddressCode T.Set (Just temp) (Just $ constInt 0) (Just temp2)]
    else genCodeCopy ti temp o
    tell [T.ThreeAddressCode T.Return Nothing (Just temp) Nothing]
genCodeInstr (Yield e1) = do
    o <- getOperand e1
    tell [T.ThreeAddressCode T.Return Nothing (Just o) Nothing]
--
genCodeInstr (Declar _ _) = return ()
--genCodeInstr _ = return ()

shallowable :: Expr -> Bool
shallowable (StrLit _) = True
shallowable (CharLit _) = True
shallowable (ArrLit _) = True
shallowable (ArrInit _ _) = True
shallowable (ListLit _) = True
shallowable (DictLit _) = True
shallowable _ = False

genCodeEq :: Type -> (Operand, Operand) -> Operand -> Operand  -> InterMonad ()
genCodeEq (Composite "Cluster" tipo) (btrue, bfalse) a1 a2 = do
--    let ancho = anchura tipo -- pero como operando
    t1 <- newTemp
    t2 <- newTemp
    contador <- newTemp
    size <- newTemp
    btrue2 <- newLabel
    pepito <- newLabel
    tell [T.ThreeAddressCode T.Add (Just t1) (Just a1) (Just $ pointerSize),
          T.ThreeAddressCode T.Add (Just t2) (Just a2) (Just $ pointerSize),
          T.ThreeAddressCode T.Deref (Just t1) (Just t1) Nothing,
          T.ThreeAddressCode T.Deref (Just t2) (Just t2) Nothing,
          T.ThreeAddressCode T.Neq (Just t1) (Just t2) (Just bfalse), 
          T.ThreeAddressCode T.Assign (Just contador) (Just $ constInt 0) Nothing,
          T.ThreeAddressCode T.Assign (Just size) (Just t1) Nothing,
          T.ThreeAddressCode T.Deref (Just t1) (Just a1) Nothing,
          T.ThreeAddressCode T.Deref (Just t2) (Just a2) Nothing,
          T.ThreeAddressCode T.GoTo Nothing Nothing (Just pepito),
          T.ThreeAddressCode T.NewLabel Nothing (Just btrue2) Nothing, 
          T.ThreeAddressCode T.Add (Just t1) (Just t1) (Just $ constInt $ anchura tipo),
          T.ThreeAddressCode T.Add (Just t2) (Just t2) (Just $ constInt $ anchura tipo),
          T.ThreeAddressCode T.Add (Just contador) (Just contador) (Just $ constInt 1),
          T.ThreeAddressCode T.NewLabel Nothing (Just pepito) Nothing,
          T.ThreeAddressCode T.Eq (Just contador) (Just size) (Just btrue)]
    genCodeEq tipo (btrue2, bfalse) t1 t2

genCodeEq (Composite "Quasar" tipo) (btrue, bfalse) a1 a2 = do
    t1 <- newTemp
    t2 <- newTemp
    t3 <- newTemp
    t4 <- newTemp
    contador <- newTemp
    size <- newTemp
    btrue2 <- newLabel
    pepito <- newLabel
    tell [T.ThreeAddressCode T.Add (Just t1) (Just a1) (Just $ pointerSize),
          T.ThreeAddressCode T.Add (Just t2) (Just a2) (Just $ pointerSize),
          T.ThreeAddressCode T.Deref (Just t1) (Just t1) Nothing,
          T.ThreeAddressCode T.Deref (Just t2) (Just t2) Nothing,
          T.ThreeAddressCode T.Neq (Just t1) (Just t2) (Just bfalse), 
          T.ThreeAddressCode T.Assign (Just contador) (Just $ constInt 0) Nothing,
          T.ThreeAddressCode T.Assign (Just size) (Just t1) Nothing,
          T.ThreeAddressCode T.Deref (Just t3) (Just a1) Nothing,
          T.ThreeAddressCode T.Deref (Just t4) (Just a2) Nothing,
          T.ThreeAddressCode T.Add (Just t1) (Just t3) (Just $ pointerSize),
          T.ThreeAddressCode T.Add (Just t2) (Just t4) (Just $ pointerSize),
          T.ThreeAddressCode T.GoTo Nothing Nothing (Just pepito),
          T.ThreeAddressCode T.NewLabel Nothing (Just btrue2) Nothing, 
          T.ThreeAddressCode T.Deref (Just t3) (Just t3) Nothing,
          T.ThreeAddressCode T.Deref (Just t4) (Just t4) Nothing,
          T.ThreeAddressCode T.Add (Just t1) (Just t3) (Just $ pointerSize),
          T.ThreeAddressCode T.Add (Just t2) (Just t4) (Just $ pointerSize),
          T.ThreeAddressCode T.Add (Just contador) (Just contador) (Just $ constInt 1),
          T.ThreeAddressCode T.NewLabel Nothing (Just pepito) Nothing,
          T.ThreeAddressCode T.Eq (Just contador) (Just size) (Just btrue)]
    genCodeEq tipo (btrue2, bfalse) t1 t2

shallowCopy :: Type -> Operand -> Operand -> InterMonad ()
shallowCopy ti a1 a2 = do
    t1 <- newTemp
    t2 <- newTemp
    t3 <- newTemp
    tell [T.ThreeAddressCode T.Assign (Just t1) (Just a1) Nothing,
          T.ThreeAddressCode T.Assign (Just t2) (Just a2) Nothing]
    let f :: Integer -> InterMonad ()
        f acum = if acum <= 0 then return ()
                 else do
                    tell [T.ThreeAddressCode T.Deref (Just t3) (Just t2) Nothing,
                          T.ThreeAddressCode T.Set (Just t1) (Just $ constInt 0) (Just t3),
                          T.ThreeAddressCode T.Add (Just t1) (Just t1) (Just $ constInt 4),
                          T.ThreeAddressCode T.Add (Just t2) (Just t2) (Just $ constInt 4)]
                    f (acum-4)
    f (anchura ti)

genCodeCopy :: Type -> Operand -> Operand -> InterMonad ()
genCodeCopy (Simple _) a1 a2 = do
    t1 <- newTemp
    tell [T.ThreeAddressCode T.Deref (Just t1) (Just a2) Nothing,
          T.ThreeAddressCode T.Set (Just a1) (Just $ constInt 0) (Just t1)]
genCodeCopy (Composite "Nebula" t) a1 a2 = genCodeCopy (Composite "Cluster" (Composite "Quasar" t)) a1 a2
genCodeCopy (Composite "Cluster" t) a1 a2 = do
    t1 <- newTemp
    t2 <- newTemp
    t3 <- newTemp
    label <- newLabel
    begin <- newLabel
    end <- newLabel
    tell [T.ThreeAddressCode T.Add (Just t3) (Just a1) (Just $ pointerSize),
          T.ThreeAddressCode T.Add (Just t2) (Just a2) (Just $ pointerSize),
          T.ThreeAddressCode T.Deref (Just t1) (Just t3) Nothing,
          T.ThreeAddressCode T.Deref (Just t2) (Just t2) Nothing,
          T.ThreeAddressCode T.Gte (Just t1) (Just t2) (Just label),
          T.ThreeAddressCode T.Mult (Just t1) (Just t2) (Just $ constInt $ anchura t),
          T.ThreeAddressCode T.New (Just t1) (Just t1) Nothing,
          T.ThreeAddressCode T.Set (Just a1) (Just $ constInt 0) (Just t1),
          T.ThreeAddressCode T.NewLabel Nothing (Just label) Nothing,
          T.ThreeAddressCode T.Set (Just t3) (Just $ constInt 0) (Just t2),
          T.ThreeAddressCode T.Assign (Just t3) (Just $ constInt 0) Nothing,
          T.ThreeAddressCode T.Eq (Just t3) (Just t2) (Just end),
          T.ThreeAddressCode T.Deref (Just a1) (Just a1) Nothing, 
          T.ThreeAddressCode T.Deref (Just a2) (Just a2) Nothing,
          T.ThreeAddressCode T.NewLabel Nothing (Just begin) Nothing]
    genCodeCopy t a1 a2
    tell [T.ThreeAddressCode T.Add (Just t3) (Just t3) (Just $ constInt 1),
          T.ThreeAddressCode T.Add (Just a1) (Just a1) (Just $ constInt $ anchura t),
          T.ThreeAddressCode T.Add (Just a2) (Just a2) (Just $ constInt $ anchura t),
          T.ThreeAddressCode T.Neq (Just t3) (Just t2) (Just begin),
          T.ThreeAddressCode T.NewLabel Nothing (Just end) Nothing]
genCodeCopy (Composite "Quasar" t) a1 a2 = do
    t2 <- newTemp
    t3 <- newTemp
    t4 <- newTemp
    t5 <- newTemp
    t6 <- newTemp
    label1 <- newLabel
    label2 <- newLabel
    label3 <- newLabel
    label4 <- newLabel
    let tnodo = constInt $ anchura (Composite "~" IDK) + anchura t
    tell [T.ThreeAddressCode T.Add (Just t4) (Just a1) (Just pointerSize),
          T.ThreeAddressCode T.Add (Just t3) (Just a2) (Just pointerSize),
          T.ThreeAddressCode T.Deref (Just t2) (Just t4) Nothing,
          T.ThreeAddressCode T.Deref (Just t3) (Just t3) Nothing,
          T.ThreeAddressCode T.Set (Just t4) (Just $ constInt 0) (Just t3),
          T.ThreeAddressCode T.Assign (Just t4) (Just $ constInt 0) Nothing,
          T.ThreeAddressCode T.Eq (Just t3) (Just $ constInt 0) (Just label3),
          T.ThreeAddressCode T.Gte (Just t2) (Just t3) (Just label1),
          T.ThreeAddressCode T.Eq (Just t2) (Just $ constInt 0) (Just label2),
          T.ThreeAddressCode T.NewLabel Nothing (Just label4) Nothing,
          T.ThreeAddressCode T.Deref (Just a1) (Just a1) Nothing,
          T.ThreeAddressCode T.Deref (Just a2) (Just a2) Nothing,
          T.ThreeAddressCode T.Add (Just t6) (Just a2) (Just pointerSize),
          T.ThreeAddressCode T.Add (Just t5) (Just a1) (Just pointerSize)]
    genCodeCopy t t5 t6
    tell [T.ThreeAddressCode T.Add (Just t4) (Just t4) (Just $ constInt 1),
          T.ThreeAddressCode T.Neq (Just t4) (Just t2) (Just label4),
          T.ThreeAddressCode T.Eq (Just t4) (Just t3) (Just label3),
          T.ThreeAddressCode T.NewLabel Nothing (Just label2) Nothing,
          T.ThreeAddressCode T.New (Just t5) (Just tnodo) Nothing,
          T.ThreeAddressCode T.Set (Just a1) (Just $ constInt 0) (Just t5),
          T.ThreeAddressCode T.Deref (Just a2) (Just a2) Nothing,
          T.ThreeAddressCode T.Add (Just t6) (Just a2) (Just pointerSize),
          T.ThreeAddressCode T.Add (Just t5) (Just t5) (Just pointerSize)]
    genCodeCopy t t5 t6
    tell [T.ThreeAddressCode T.Add (Just t4) (Just t4) (Just $ constInt 1),
          T.ThreeAddressCode T.Deref (Just a1) (Just a1) Nothing,
          T.ThreeAddressCode T.Neq (Just t4) (Just t3) (Just label2),
          T.ThreeAddressCode T.GoTo Nothing Nothing (Just label3),
          T.ThreeAddressCode T.NewLabel Nothing (Just label1) Nothing,
          T.ThreeAddressCode T.Deref (Just a1) (Just a1) Nothing,
          T.ThreeAddressCode T.Deref (Just a2) (Just a2) Nothing,
          T.ThreeAddressCode T.Add (Just t6) (Just a2) (Just pointerSize),
          T.ThreeAddressCode T.Add (Just t5) (Just a1) (Just pointerSize)]
    genCodeCopy t t5 t6
    temp0 <- newTemp
    tell [T.ThreeAddressCode T.Add (Just t4) (Just t4) (Just $ constInt 1),
          T.ThreeAddressCode T.Neq (Just t4) (Just t3) (Just label1),
          T.ThreeAddressCode T.NewLabel Nothing (Just label3) Nothing,
          T.ThreeAddressCode T.Assign (Just temp0) (Just $ constInt 0) Nothing,
          T.ThreeAddressCode T.Set (Just a1) (Just $ constInt 0) (Just temp0)]

genCodeCopy (Record "Galaxy" _ ts) a1 a2 = do
    let f :: Integer -> [Type] -> InterMonad ()
        f acum (x:xs) = do tell [T.ThreeAddressCode T.Add (Just a1) (Just a1) (Just $ constInt anch),
                                 T.ThreeAddressCode T.Add (Just a2) (Just a2) (Just $ constInt anch)]
                           genCodeCopy x a1 a2
                           f (acum+anch) xs
          where anch = anchura x
        f _ [] = return ()
    f 0 ts
genCodeCopy _ _ _ = error "Copia profunda no implementada para este tipo"

genCodeExp :: Expr -> InterMonad InterCode
-- Aritmeticas
genCodeExp (Suma e1 e2) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Assign (Just t) (Just op1) Nothing, 
            T.ThreeAddressCode T.Add (Just t) (Just t) (Just op2)]
genCodeExp (Sub e1 e2) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Sub (Just t) (Just op1) (Just op2)]
genCodeExp (Neg e1) = do
    op1 <- getOperand e1
    t <- newTemp
    t2 <- newTemp
    return [T.ThreeAddressCode T.Assign (Just t2) (Just op1) Nothing, 
            T.ThreeAddressCode T.Minus (Just t) (Just t2) Nothing]
genCodeExp (Mul e1 e2) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Assign (Just t) (Just op1) Nothing, 
            T.ThreeAddressCode T.Mult (Just t) (Just t) (Just op2)]
genCodeExp (Div e1 e2) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Div (Just t) (Just op1) (Just op2)]
genCodeExp (DivE e1 e2) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Div (Just t) (Just op1) (Just op2)]
genCodeExp (Mod e1 e2) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Mod (Just t) (Just op1) (Just op2)]
-- Bool
genCodeExp e@(And _ _) = do
    genCodeExpB' e
genCodeExp e@(Or _ _) = do
    genCodeExpB' e
genCodeExp e@(Not _) = do
    genCodeExpB' e
genCodeExp (Bitand e1 e2) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.And (Just t) (Just op1) (Just op2)]
genCodeExp (Bitor e1 e2) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Or (Just t) (Just op1) (Just op2)]
genCodeExp e@(Mayor _ _) = do
    genCodeExpB' e
genCodeExp e@(MayorI _ _) = do
    genCodeExpB' e
genCodeExp e@(Menor _ _) = do
    genCodeExpB' e
genCodeExp e@(MenorI _ _) = do
    genCodeExpB' e
genCodeExp e@(Eq _ _) = do
    genCodeExpB' e
genCodeExp e@(Neq _ _) = do
    genCodeExpB' e
-- Accesos
genCodeExp e@(Access _ _) = do
    a <- getAddress e 
    t <- newTemp
    return [T.ThreeAddressCode T.Deref (Just t) (Just a) Nothing]
genCodeExp e@(Attr _ _) = do
    a <- getAddress e
    t <- newTemp
    return [T.ThreeAddressCode T.Deref (Just t) (Just a) Nothing]
-- Desreferenciacion
genCodeExp (Desref e1) = do
    pointer <- getOperand e1
    t0 <- newTemp
    return [T.ThreeAddressCode T.Deref (Just t0) (Just pointer) Nothing]
-- Scale
genCodeExp (Scale e1) = do
    n <- getAddress $ fst e1
    tam <- newTemp
    return [T.ThreeAddressCode T.Add (Just tam) (Just n) (Just pointerSize),
          T.ThreeAddressCode T.Deref (Just tam) (Just tam) Nothing]
-- Llamada a subrutina
genCodeExp (Funcall f a) = do
    --args <- mapM getOperand a
    let emp = sum $ Prelude.map (anchura.snd) a
    fun <- getOperand f
    params <- mapM copyParam a
    t <- newTemp
    --return $ (T.ThreeAddressCode T.Param Nothing Nothing Nothing):(params ++ [T.ThreeAddressCode T.Call (Just t) (Just fun) (Just $ constInt $ toInteger $ length params)])
    return $ (T.ThreeAddressCode T.Param Nothing Nothing Nothing):(params ++ [T.ThreeAddressCode T.Call (Just t) (Just fun) (Just $ constInt $ emp)])
    -- Print y Read
genCodeExp (Print (e1:_)) = do
    let isSimple (Simple _) = True
        isSimple _ = False
    o <- if isSimple $ snd e1 then getOperand e1 else getAddress $ fst e1
    pr <- genCodePrint o (snd e1)
    return pr 
    --[T.ThreeAddressCode T.Print Nothing (Just $ setType o ti) Nothing]
genCodeExp (Read) = do
    o <- newTemp
    return [T.ThreeAddressCode T.Read Nothing (Just o) Nothing]
    --Malloc
genCodeExp (Bigbang t1) = do
    o <- newTemp
    return [T.ThreeAddressCode T.New (Just o) (Just $ constInt $ anchura t1) Nothing]
-- RIP
genCodeExp (ArrInit tam ti) = do
    n <- getOperand tam
    nn <- newTemp
    array <- newTemp
    dv <- newTemp
    t1 <- newTemp
    return [T.ThreeAddressCode T.Assign (Just nn) (Just n) Nothing,
            T.ThreeAddressCode T.Mult (Just nn) (Just nn) (Just $ constInt $ anchura $ ti),
            T.ThreeAddressCode T.New (Just array) (Just $ nn) Nothing,
            T.ThreeAddressCode T.New (Just dv) (Just $ constInt $ anchura $ Composite "Cluster" ti) Nothing,
            T.ThreeAddressCode T.Assign (Just t1) (Just dv) Nothing,
            T.ThreeAddressCode T.Set (Just dv) (Just $ constInt $ 0) (Just array),
            T.ThreeAddressCode T.Add (Just dv) (Just dv) (Just pointerSize),
            T.ThreeAddressCode T.Set (Just dv) (Just $ constInt $ 0) (Just n)]
genCodeExp (StrLit s) = genCodeExp(ArrLit ss)
    where ss = Prelude.map (\c -> (CharLit c, Simple "star")) s
genCodeExp (ArrLit es) = do
    let eltipo = tip es
        tip [] = IDK
        tip ((_,ti):_) = ti
        isSimple (Simple _) = True
        isSimple _ = False
    ini <- genCodeExp (ArrInit (IntLit (length es), Simple "planet") eltipo)
    tell ini
    dir <- lastTemp
    temp <- newTemp
    tell [T.ThreeAddressCode T.Deref (Just temp) (Just dir) Nothing]
    let f :: Integer -> [Exp] -> InterMonad ()
        f 0 _ = return ()
        f _ [] = return ()
        f acum (x:xs) = do
          if isSimple eltipo then do
            op <- getOperand x
            tell [T.ThreeAddressCode T.Set (Just temp) (Just $ constInt 0) (Just op)]
            if acum == 1 then return ()
            else tell [T.ThreeAddressCode T.Add (Just temp) (Just temp) (Just $ constInt $ anchura eltipo)]
          else error "implementar pls"
          f (acum-1) xs
    f (toInteger $ (length es)+1) es
    dirr <- newTemp
    return [T.ThreeAddressCode T.Assign (Just dirr) (Just dir) Nothing]

genCodeExp op = do
    _ <- newTemp
    --lift $ putStrLn "Esto falta jaja salu2"
    return []


genCodePrint :: Operand -> Type -> InterMonad InterCode
genCodePrint op ti@(Simple _) = do
    return [T.ThreeAddressCode T.Print Nothing (Just $ setType op ti) Nothing]
genCodePrint op (Composite "Cluster" ti@(Simple "star")) = do
    let isSimple (Simple _) = True
        isSimple _ = False
    point <- newTemp
    siz <- newTemp
    tell [T.ThreeAddressCode T.Deref (Just point) (Just op) Nothing, 
          T.ThreeAddressCode T.Add (Just siz) (Just op) (Just pointerSize),
          T.ThreeAddressCode T.Deref (Just siz) (Just siz) Nothing]
    contador <- newTemp
    temp <- newTemp
    lab <- newLabel
    chao <- newLabel
    recu <- genCodePrint temp ti
    return $ [T.ThreeAddressCode T.Assign (Just contador) (Just $ constInt 0) Nothing,
              T.ThreeAddressCode T.NewLabel Nothing (Just lab) Nothing,
              T.ThreeAddressCode T.Eq (Just contador)  (Just siz) (Just chao),
              T.ThreeAddressCode T.Assign (Just temp) (Just point) Nothing]
              ++ (if isSimple ti then [T.ThreeAddressCode T.Deref (Just temp) (Just temp) Nothing] else []) ++ recu ++
             [T.ThreeAddressCode T.Add (Just contador) (Just contador) (Just $ constInt 1),
              T.ThreeAddressCode T.Add (Just point) (Just point) (Just $ pointerSize),
              T.ThreeAddressCode T.GoTo Nothing Nothing (Just lab),
              T.ThreeAddressCode T.NewLabel Nothing (Just chao) Nothing]
genCodePrint op (Composite "Cluster" ti) = do
    let isSimple (Simple _) = True
        isSimple _ = False
    point <- newTemp
    siz <- newTemp
    tell [T.ThreeAddressCode T.Deref (Just point) (Just op) Nothing, 
          T.ThreeAddressCode T.Add (Just siz) (Just op) (Just pointerSize),
          T.ThreeAddressCode T.Deref (Just siz) (Just siz) Nothing]
    contador <- newTemp
    temp <- newTemp
    lab <- newLabel
    chao <- newLabel
    recu <- genCodePrint temp ti
    return $ [T.ThreeAddressCode T.Assign (Just contador) (Just $ constInt 0) Nothing,
              T.ThreeAddressCode T.Print Nothing (Just $ T.Constant ("'{'", Simple "star")) Nothing,
              T.ThreeAddressCode T.Eq (Just contador)  (Just siz) (Just chao),
              T.ThreeAddressCode T.NewLabel Nothing (Just lab) Nothing,
              T.ThreeAddressCode T.Assign (Just temp) (Just point) Nothing]
              ++ (if isSimple ti then [T.ThreeAddressCode T.Deref (Just temp) (Just temp) Nothing] else []) ++ recu ++
             [T.ThreeAddressCode T.Add (Just contador) (Just contador) (Just $ constInt 1),
              T.ThreeAddressCode T.Add (Just point) (Just point) (Just $ pointerSize),
              T.ThreeAddressCode T.Eq (Just contador)  (Just siz) (Just chao),
              T.ThreeAddressCode T.Print Nothing (Just $ T.Constant ("','", Simple "star")) Nothing,
              T.ThreeAddressCode T.GoTo Nothing Nothing (Just lab),
              T.ThreeAddressCode T.NewLabel Nothing (Just chao) Nothing,
              T.ThreeAddressCode T.Print Nothing (Just $ T.Constant ("'}'", Simple "star")) Nothing]
genCodePrint _ _ = error "print no implementado"

copyParam :: Exp -> InterMonad InterInstr
copyParam e@(_,ti) = do
    let isSimple (Simple _) = True
        isSimple _ = False
    t <- newTemp
    a <- getOperand e
    if isSimple ti then do
      t2 <- newTemp
      tell [T.ThreeAddressCode T.Assign (Just t2) (Just a) Nothing,
            T.ThreeAddressCode T.New (Just t) (Just $ constInt $ anchura ti) Nothing,
            T.ThreeAddressCode T.Set (Just t) (Just $ constInt $ 0) (Just t2)]
    else do 
      tell [T.ThreeAddressCode T.New (Just t) (Just $ constInt $ anchura ti) Nothing]
      genCodeCopy ti t a
    return $ T.ThreeAddressCode T.Param Nothing (Just t) Nothing

genCodeExpB' :: Expr -> InterMonad InterCode
genCodeExpB' e = do
    btrue <- newLabel
    bfalse <- newLabel
    next <- newLabel
    code <- genCodeExpB (e, btrue, bfalse)
    t <- newTemp
    return $ code ++ [T.ThreeAddressCode T.NewLabel Nothing (Just btrue) Nothing,
                      T.ThreeAddressCode T.Assign (Just t) (Just $ T.Constant ("full", Simple "moon")) Nothing,
                      T.ThreeAddressCode T.GoTo Nothing Nothing (Just next),
                      T.ThreeAddressCode T.NewLabel Nothing (Just bfalse) Nothing,
                      T.ThreeAddressCode T.Assign (Just t) (Just $ T.Constant ("new", Simple "moon")) Nothing,
                      T.ThreeAddressCode T.NewLabel Nothing (Just next) Nothing
                      ]

genCodeExpB :: (Expr, Operand, Operand) -> InterMonad InterCode
genCodeExpB (Var "full" _, btrue, _) = return [T.ThreeAddressCode T.GoTo Nothing Nothing (Just btrue)]
genCodeExpB (Var "new" _, _, bfalse) = return [T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB (Not (e1,_), btrue, bfalse) = genCodeExpB (e1, bfalse, btrue)
-- Sin corto circuito
genCodeExpB (e@(Bitand _ _), btrue, bfalse) = do
    code <- genCodeExp e
    t <- lastTemp
    return $ code ++ [T.ThreeAddressCode T.If Nothing (Just t) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB (e@(Bitor _ _), btrue, bfalse) = do
    code <- genCodeExp e
    t <- lastTemp
    return $ code ++ [T.ThreeAddressCode T.If Nothing (Just t) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
-- Con corto circuito
genCodeExpB ((And (e1,_) (e2,_)), btrue, bfalse) = do
    b1true <- newLabel
    code1 <- genCodeExpB (e1, b1true, bfalse)
    code2 <- genCodeExpB (e2, btrue, bfalse)
    return $ code1 ++ (T.ThreeAddressCode T.NewLabel Nothing (Just b1true) Nothing) : code2
genCodeExpB ((Or (e1,_) (e2,_)), btrue, bfalse) = do
    b1false <- newLabel
    code1 <- genCodeExpB (e1, btrue, b1false)
    code2 <- genCodeExpB (e2, btrue, bfalse)
    return $ code1 ++ (T.ThreeAddressCode T.NewLabel Nothing (Just b1false) Nothing) : code2
-- Comparaciones
genCodeExpB ((Eq e1 e2), btrue, bfalse) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    temp <- newTemp
    return [T.ThreeAddressCode T.Assign (Just temp) (Just op1) Nothing,
            T.ThreeAddressCode T.Eq (Just temp) (Just op2) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB ((Neq e1 e2), btrue, bfalse) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    temp <- newTemp
    return [T.ThreeAddressCode T.Assign (Just temp) (Just op1) Nothing,
            T.ThreeAddressCode T.Neq (Just op1) (Just op2) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB ((Mayor e1 e2), btrue, bfalse) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    temp <- newTemp
    return [T.ThreeAddressCode T.Assign (Just temp) (Just op1) Nothing,
            T.ThreeAddressCode T.Gt (Just op1) (Just op2) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB ((MayorI e1 e2), btrue, bfalse) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    temp <- newTemp
    return [T.ThreeAddressCode T.Assign (Just temp) (Just op1) Nothing,
            T.ThreeAddressCode T.Gte (Just op1) (Just op2) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB ((Menor e1 e2), btrue, bfalse) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    temp <- newTemp
    return [T.ThreeAddressCode T.Assign (Just temp) (Just op1) Nothing,
            T.ThreeAddressCode T.Lt (Just op1) (Just op2) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB ((MenorI e1 e2), btrue, bfalse) = genCodeExpB (Not ((Mayor e1 e2),Simple "moon"), btrue, bfalse)
    --op1 <- getOperand e1
    --op2 <- getOperand e2
    --temp <- newTemp
    --return [T.ThreeAddressCode T.Assign (Just temp) (Just op1) Nothing,
    --        T.ThreeAddressCode T.Lte (Just op1) (Just op2) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]

genCodeExpB (e, btrue, bfalse) = do
    let op2 = T.Constant ("new", Simple "moon")
    op1 <- getOperand (e, Simple "moon")
    temp <- newTemp
    return [T.ThreeAddressCode T.Assign (Just temp) (Just op1) Nothing,
            T.ThreeAddressCode T.Eq (Just op1) (Just op2) (Just bfalse), T.ThreeAddressCode T.GoTo Nothing Nothing (Just btrue)]
--genCodeExpB exp = error $ "no c nada expresion: "++(show exp)

getAddress :: Expr -> InterMonad Operand
getAddress (Var _ entry) = do
    t0 <- newTemp
    tell [T.ThreeAddressCode T.Add (Just t0) (Just base) (Just $ constInt $ offset entry)]
    return t0
getAddress (Attr (e, _) (_, entry)) = do
    a <- getAddress e
    t0 <- newTemp
    tell [T.ThreeAddressCode T.Add (Just t0) (Just a) (Just $ constInt $ offset entry)]
    return t0
getAddress (Access (e, ti) (Index (n, ta))) = do
    let f (Composite s _) = s
        f _ = error "esto no deberia pasar"
        g (Composite _ t) = t
        g _ = error "esto no deberia pasar"
        fti = f ti
        te = g ti
    a <- getAddress e
    if fti == "Cluster" then do
        i <- getOperand (n, ta)
        ii <- newTemp
        t0 <- newTemp
        t1 <- newTemp
        tell [T.ThreeAddressCode T.Deref (Just t0) (Just a) Nothing,
              T.ThreeAddressCode T.Assign (Just ii) (Just i) Nothing,
              T.ThreeAddressCode T.Mult (Just t1) (Just ii) (Just $ constInt $ anchura te),
              T.ThreeAddressCode T.Add (Just t0) (Just t0) (Just t1)]
        return t0
    else if fti == "Quasar" then do
        i <- getOperand (n, ta)
        btrue <- newLabel
        bfalse <- newLabel
        t0 <- newTemp
        t1 <- newTemp
        t2 <- newTemp
        tell [T.ThreeAddressCode T.Assign (Just t0) (Just $ constInt 0) Nothing,
              T.ThreeAddressCode T.Assign (Just t1) (Just a) Nothing,
              T.ThreeAddressCode T.Eq (Just i) (Just $ constInt 0) (Just btrue),
              T.ThreeAddressCode T.NewLabel Nothing (Just bfalse) Nothing, 
              T.ThreeAddressCode T.Deref (Just t1) (Just t1) Nothing,
              T.ThreeAddressCode T.Add (Just t0) (Just t0) (Just $ constInt 1),
              T.ThreeAddressCode T.Neq (Just t0) (Just i) (Just bfalse),
              T.ThreeAddressCode T.NewLabel Nothing (Just btrue) Nothing,
              T.ThreeAddressCode T.Add (Just t2) (Just t1) (Just pointerSize)]
        return t2
    else error "no c"
getAddress e = do
    c <- genCodeExp e
    tell c
    lastTemp


getOperand :: Exp -> InterMonad Operand
getOperand (Var s entry,_) = return $ T.Id $ SymEntry s entry
getOperand (IntLit n, t) = return $ T.Constant (show n, t)
getOperand (FloLit x, t) = return $ T.Constant (show x, t)
getOperand (CharLit c,t) = return $ T.Constant (show c, t)
getOperand (e,_) = do
    c <- genCodeExp e
    tell c
    lastTemp
