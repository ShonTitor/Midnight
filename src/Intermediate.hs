module Intermediate where
import Control.Monad.RWS
import Data.Map
import Data.Foldable
import Tipos
import Parser (gatto)
import qualified TACType as T

data VarType = Temp Int
             | SymEntry String Entry
             | Base
type Operand = T.Operand VarType Type
type InterInstr = T.ThreeAddressCode VarType Type
type InterCode = [InterInstr]
type InterMonad a = RWST () InterCode (Int, Int, [Operand], [Operand]) IO a

instance T.SymEntryCompatible VarType where
  getSymID (Temp n) = "_t"++(show n)
  getSymID (SymEntry s _) = s
  getSymID Base = "_base"

instance Show VarType where
    show x = T.getSymID x

vaca :: String -> IO (InterCode, Tablon)
vaca f = do
    (arbol, (tablon, _, _, ok, _, _), _) <- gatto f
    cow arbol tablon ok

cow :: Program -> Tablon -> Bool -> IO (InterCode, Tablon)
cow (Root lis) tab ok = do
    let moo' :: (Int, Int, InterCode) -> String -> Entry -> IO (Int, Int, InterCode)
        moo' (n, m, code) s entry = do
            (_, (a,b,_,_), c) <- runRWST (genCodeSub s entry) () (n,m,[],[])
            return (a, b, code++c)
        moo :: IO (Int, Int, InterCode) -> String -> [Entry] -> IO (Int, Int, InterCode)
        moo b s entries = do
            a <- b
            foldlM (\x y -> moo' x s y) a entries
        moo'' :: IO (Int, Int, InterCode) -> String -> [Entry] -> (IO (Int, Int, InterCode), ())
        moo'' b s entries = (moo b s entries, ())
        mu :: IO (Int, Int, InterCode)
        mu = return (0,0,[])
    if ok then do
        let (cc,_) = mapAccumWithKey moo'' mu tab
        (i,j,sc) <- cc
        (_,(_,_,_,_),c) <- runRWST (genCode lis) () (i,j,[],[])
        return ((sc++(T.ThreeAddressCode T.NewLabel Nothing (Just $ T.Label "~main") Nothing):c)++
          [T.ThreeAddressCode T.NewLabel Nothing (Just $ T.Label "~end") Nothing], tab)
    else return ([], tab)

base :: Operand
base = T.Id Base

popLoop :: InterMonad ()
popLoop = do
    (n, m, _:s1, _:s2) <- get
    put (n, m, s1, s2)

lookLoop :: InterMonad ([Operand], [Operand])
lookLoop = do
    (_, _, s1, s2) <- get
    return (s1, s2)

pushLoop :: Operand -> Operand -> InterMonad ()
pushLoop a b = do
    (n, m, s1, s2) <- get
    put (n, m, a:s1, b:s2)

newTemp :: InterMonad Operand
newTemp = do
    (n,m,a,b) <- get
    put (n+1,m,a,b)
    return $ T.Id (Temp n)

lastTemp :: InterMonad Operand
lastTemp = do
    (n,_,_,_) <- get
    return $ T.Id (Temp (n-1))

newLabel :: InterMonad Operand
newLabel = do 
    (n,m,a,b) <- get
    put (n,m+1,a,b)
    return $ T.Label $ '_':(show m)

genCode :: [Instr] -> InterMonad ()
genCode [] = return ()
genCode (x:xs) = do
    genCodeInstr x
    genCode xs

genCodeSub :: String -> Entry -> InterMonad ()
genCodeSub s (Entry _ (Subrutina sequ) 1 _) = do
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
    let genCodeIf [((b,_), sequ)] next = do
            btrue <- newLabel
            c1 <- genCodeExpB (b, btrue, next)
            tell c1
            tell [T.ThreeAddressCode T.NewLabel Nothing (Just btrue) Nothing]
            genCode sequ
            --tell [T.ThreeAddressCode T.GoTo Nothing Nothing (Just next)]
        genCodeIf (((b,_), sequ):elifs) next = do
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
genCodeInstr (While (b,_) sequ) = do
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
genCodeInstr (ForC instr (b,_) instrf sequ) = do
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
genCodeInstr (ForRange k e1 e2 e3 sequ) = do
    begin <- newLabel
    btrue <- newLabel
    bfalse <- newLabel
    continue <- newLabel
    start <- getOperand e1
    end <- getOperand e2
    step <- getOperand e3
    i <- getOperand k
    iter <- newTemp
    tell [T.ThreeAddressCode T.Assign (Just iter) (Just start) Nothing,
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
genCodeInstr (Foreach k e sequ) = do
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
        tell [T.ThreeAddressCode T.Add (Just t1) (Just t0) (Just $ T.Constant ("4", Simple "planet")),
              T.ThreeAddressCode T.Deref (Just t1) (Just t1) Nothing,
              T.ThreeAddressCode T.Assign (Just t2) (Just $ T.Constant ("0", Simple "planet")) Nothing,
              T.ThreeAddressCode T.Eq (Just t1) (Just $ T.Constant ("0", Simple "planet")) (Just bfalse),
              T.ThreeAddressCode T.NewLabel Nothing (Just btrue) Nothing,
              T.ThreeAddressCode T.Deref (Just t0) (Just t0) Nothing,
              T.ThreeAddressCode T.Add (Just iter) (Just t0) (Just $ T.Constant ("4", Simple "planet")), 
              T.ThreeAddressCode T.Deref (Just iter) (Just iter) Nothing,
              T.ThreeAddressCode T.Assign (Just i) (Just iter) Nothing]
        pushLoop bfalse continue
        genCode sequ
        popLoop
        tell [T.ThreeAddressCode T.NewLabel Nothing (Just continue) Nothing]
        tell [T.ThreeAddressCode T.Add (Just t2) (Just t2) (Just $ T.Constant ("1", Simple "planet")),
              T.ThreeAddressCode T.Lt (Just t2) (Just t1) (Just btrue),
              T.ThreeAddressCode T.NewLabel Nothing (Just bfalse) Nothing]
    else error "no implementado"
-- break y continue
genCodeInstr (Break b) = do
    let f :: Operand -> Int -> [Operand] -> InterMonad ()
        f _ _ [] = return ()
        f _ _ [l] = do
            tell [T.ThreeAddressCode T.GoTo Nothing Nothing (Just l)]
        f n acum (l:ls) = do
            tell [T.ThreeAddressCode T.Eq (Just n) (Just $ T.Constant (show acum, Simple "planet")) (Just l)]
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
        tell [T.ThreeAddressCode T.Set (Just a) (Just $ T.Constant ("0", Simple "planet")) (Just b)]
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
        tell [T.ThreeAddressCode T.Set (Just a) (Just $ T.Constant ("0", Simple "planet")) (Just b)]
genCodeInstr (Asig e1 e2) = do
    let f (_,Composite s _) = elem s ["Cluster", "Quasar", "Nebula"] 
        f _ = False
    lvalue <- getOperand e1
    rvalue <- getOperand e2
    if f e1 then do
        a1 <- getAddress $ fst e1
        a2 <- getAddress $ fst e2
        genCodeCopy (snd e1) a1 a2
    else tell [T.ThreeAddressCode T.Assign (Just lvalue) (Just rvalue) Nothing]
-- Return y Yield
genCodeInstr (Return e1) = do
    o <- getOperand e1
    tell [T.ThreeAddressCode T.Return Nothing (Just o) Nothing]
genCodeInstr (Yield e1) = do
    o <- getOperand e1
    tell [T.ThreeAddressCode T.Return Nothing (Just o) Nothing]
--
genCodeInstr (Declar _ _) = return ()
--genCodeInstr _ = return ()

genCodeCopy :: Type -> Operand -> Operand -> InterMonad ()
genCodeCopy (Simple _) a1 a2 = do
    t1 <- newTemp
    tell [T.ThreeAddressCode T.Deref (Just t1) (Just a2) Nothing,
          T.ThreeAddressCode T.Set (Just a1) (Just $ T.Constant ("0", Simple "planet")) (Just t1)]
genCodeCopy (Composite "Cluster" t) a1 a2 = do
    t1 <- newTemp
    t2 <- newTemp
    t3 <- newTemp
    label <- newLabel
    begin <- newLabel
    end <- newLabel
    tell [T.ThreeAddressCode T.Add (Just t3) (Just a1) (Just $ T.Constant (show $ anchura (Composite "~" IDK), Simple "planet")),
          T.ThreeAddressCode T.Add (Just t2) (Just a2) (Just $ T.Constant (show $ anchura (Composite "~" IDK), Simple "planet")),
          T.ThreeAddressCode T.Deref (Just t1) (Just t3) Nothing,
          T.ThreeAddressCode T.Deref (Just t2) (Just t2) Nothing,
          T.ThreeAddressCode T.Gte (Just t1) (Just t2) (Just label),
          T.ThreeAddressCode T.Mult (Just t1) (Just t2) (Just $ T.Constant (show $ anchura t, Simple "planet")),
          T.ThreeAddressCode T.New (Just t1) (Just t1) Nothing,
          T.ThreeAddressCode T.Set (Just a1) (Just $ T.Constant ("0", Simple "planet")) (Just t1),
          T.ThreeAddressCode T.NewLabel Nothing (Just label) Nothing,
          T.ThreeAddressCode T.Set (Just t3) (Just $ T.Constant ("0", Simple "planet")) (Just t2),
          T.ThreeAddressCode T.Assign (Just t3) (Just $ T.Constant ("0", Simple "planet")) Nothing,
          T.ThreeAddressCode T.Eq (Just t3) (Just t2) (Just end),
          T.ThreeAddressCode T.Deref (Just a1) (Just a1) Nothing, 
          T.ThreeAddressCode T.Deref (Just a2) (Just a2) Nothing,
          T.ThreeAddressCode T.NewLabel Nothing (Just begin) Nothing]
    genCodeCopy t a1 a2
    tell [T.ThreeAddressCode T.Add (Just t3) (Just t3) (Just $ T.Constant ("1", Simple "planet")),
          T.ThreeAddressCode T.Add (Just a1) (Just a1) (Just $ T.Constant (show $ anchura t, Simple "planet")),
          T.ThreeAddressCode T.Add (Just a2) (Just a2) (Just $ T.Constant (show $ anchura t, Simple "planet")),
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
    let tnodo = T.Constant (show $ anchura  (Composite "~" IDK) + anchura t, Simple "planet") 
    tell [T.ThreeAddressCode T.Add (Just t4) (Just a1) (Just $ T.Constant (show $ anchura (Composite "~" IDK), Simple "planet")),
          T.ThreeAddressCode T.Add (Just t3) (Just a2) (Just $ T.Constant (show $ anchura (Composite "~" IDK), Simple "planet")),
          T.ThreeAddressCode T.Deref (Just t2) (Just t4) Nothing,
          T.ThreeAddressCode T.Deref (Just t3) (Just t3) Nothing,
          T.ThreeAddressCode T.Set (Just t4) (Just $ T.Constant ("0", Simple "planet")) (Just t3),
          T.ThreeAddressCode T.Assign (Just t4) (Just $ T.Constant ("0", Simple "planet")) Nothing,
          T.ThreeAddressCode T.Eq (Just t3) (Just $ T.Constant ("0", Simple "planet")) (Just label3),
          T.ThreeAddressCode T.Gte (Just t2) (Just t3) (Just label1),
          T.ThreeAddressCode T.Eq (Just t2) (Just $ T.Constant ("0", Simple "planet")) (Just label2),
          T.ThreeAddressCode T.NewLabel Nothing (Just label4) Nothing,
          T.ThreeAddressCode T.Deref (Just a1) (Just a1) Nothing,
          T.ThreeAddressCode T.Deref (Just a2) (Just a2) Nothing,
          T.ThreeAddressCode T.Add (Just t6) (Just a2) (Just $ T.Constant ("4", Simple "planet")),
          T.ThreeAddressCode T.Add (Just t5) (Just a1) (Just $ T.Constant ("4", Simple "planet"))]
    genCodeCopy t t5 t6
    tell [T.ThreeAddressCode T.Add (Just t4) (Just t4) (Just $ T.Constant ("1", Simple "planet")),
          T.ThreeAddressCode T.Neq (Just t4) (Just t2) (Just label4),
          T.ThreeAddressCode T.Eq (Just t4) (Just t3) (Just label3),
          T.ThreeAddressCode T.NewLabel Nothing (Just label2) Nothing,
          T.ThreeAddressCode T.New (Just t5) (Just tnodo) Nothing,
          T.ThreeAddressCode T.Set (Just a1) (Just $ T.Constant ("0", Simple "planet")) (Just t5),
          T.ThreeAddressCode T.Deref (Just a2) (Just a2) Nothing,
          T.ThreeAddressCode T.Add (Just t6) (Just a2) (Just $ T.Constant ("4", Simple "planet")),
          T.ThreeAddressCode T.Add (Just t5) (Just t5) (Just $ T.Constant ("4", Simple "planet"))]
    genCodeCopy t t5 t6
    tell [T.ThreeAddressCode T.Add (Just t4) (Just t4) (Just $ T.Constant ("1", Simple "planet")),
          T.ThreeAddressCode T.Deref (Just a1) (Just a1) Nothing,
          T.ThreeAddressCode T.Neq (Just t4) (Just t3) (Just label2),
          T.ThreeAddressCode T.GoTo Nothing Nothing (Just label3),
          T.ThreeAddressCode T.NewLabel Nothing (Just label1) Nothing,
          T.ThreeAddressCode T.Deref (Just a1) (Just a1) Nothing,
          T.ThreeAddressCode T.Deref (Just a2) (Just a2) Nothing,
          T.ThreeAddressCode T.Add (Just t6) (Just a2) (Just $ T.Constant ("4", Simple "planet")),
          T.ThreeAddressCode T.Add (Just t5) (Just a1) (Just $ T.Constant ("4", Simple "planet"))]
    genCodeCopy t t5 t6
    tell [T.ThreeAddressCode T.Add (Just t4) (Just t4) (Just $ T.Constant ("1", Simple "planet")),
          T.ThreeAddressCode T.Neq (Just t4) (Just t3) (Just label1),
          T.ThreeAddressCode T.NewLabel Nothing (Just label3) Nothing,
          T.ThreeAddressCode T.Set (Just a1) (Just $ T.Constant ("0", Simple "planet")) (Just $ T.Constant ("0", Simple "planet"))]
genCodeCopy _ _ _ = error "No implementado, copia profunda"

genCodeExp :: Expr -> InterMonad InterCode
-- Aritmeticas
genCodeExp (Suma e1 e2) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Add (Just t) (Just op1) (Just op2)]
genCodeExp (Sub e1 e2) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Sub (Just t) (Just op1) (Just op2)]
genCodeExp (Neg e1) = do
    op1 <- getOperand e1
    t <- newTemp
    return [T.ThreeAddressCode T.Minus (Just t) (Just op1) Nothing]
genCodeExp (Mul e1 e2) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Mult (Just t) (Just op1) (Just op2)]
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
    return [T.ThreeAddressCode T.Add (Just tam) (Just n) (Just $ T.Constant ("4", Simple "planet")),
          T.ThreeAddressCode T.Deref (Just tam) (Just tam) Nothing]
-- Llamada a subrutina
genCodeExp (Funcall f a) = do
    let g op = T.ThreeAddressCode T.Param Nothing (Just op) Nothing
    args <- mapM getOperand a
    fun <- getOperand f
    t <- newTemp
    return $ Prelude.map g args ++ [T.ThreeAddressCode T.Call (Just t) (Just fun) (Just $ T.Constant (show $ length args, Simple "planet"))]
    -- Print y Read
genCodeExp (Print (e1:_)) = do
    o <- getOperand e1
    return [T.ThreeAddressCode T.Print Nothing (Just o) Nothing]
genCodeExp (Read) = do
    o <- newTemp
    return [T.ThreeAddressCode T.Read Nothing (Just o) Nothing]
    --Malloc
genCodeExp (Bigbang t1) = do
    o <- newTemp
    return [T.ThreeAddressCode T.New (Just o) (Just $ T.Constant (show $ anchura t1, Simple "planet")) Nothing]
-- RIP
genCodeExp _ = do
    _ <- newTemp
    --lift $ putStrLn "Esto falta jaja salu2"
    return []

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
    return [T.ThreeAddressCode T.Eq (Just op1) (Just op2) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB ((Neq e1 e2), btrue, bfalse) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    return [T.ThreeAddressCode T.Neq (Just op1) (Just op2) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB ((Mayor e1 e2), btrue, bfalse) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    return [T.ThreeAddressCode T.Gt (Just op1) (Just op2) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB ((MayorI e1 e2), btrue, bfalse) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    return [T.ThreeAddressCode T.Gte (Just op1) (Just op2) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB ((Menor e1 e2), btrue, bfalse) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    return [T.ThreeAddressCode T.Lt (Just op1) (Just op2) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB ((MenorI e1 e2), btrue, bfalse) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    return [T.ThreeAddressCode T.Lte (Just op1) (Just op2) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB (exp, btrue, bfalse) = do
    let op2 = T.Constant ("new", Simple "moon")
    op1 <- getOperand (exp, Simple "moon")
    return [T.ThreeAddressCode T.Eq (Just op1) (Just op2) (Just bfalse), T.ThreeAddressCode T.GoTo Nothing Nothing (Just btrue)]
genCodeExpB exp = error $ "no c nada expresion: "++(show exp)

getAddress :: Expr -> InterMonad Operand
getAddress (Var _ entry) = do
    t0 <- newTemp
    tell [T.ThreeAddressCode T.Add (Just t0) (Just base) (Just $ T.Constant (show $ offset entry, Simple "planet"))]
    return t0
getAddress (Attr (e, _) (_, entry)) = do
    a <- getAddress e
    t0 <- newTemp
    tell [T.ThreeAddressCode T.Add (Just t0) (Just a) (Just $ T.Constant (show $ offset entry, Simple "planet"))]
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
        t0 <- newTemp
        t1 <- newTemp
        tell [T.ThreeAddressCode T.Deref (Just t0) (Just a) Nothing,
              T.ThreeAddressCode T.Mult (Just t1) (Just i) (Just $ T.Constant (show $ anchura te, Simple "planet")),
              T.ThreeAddressCode T.Add (Just t0) (Just t0) (Just t1)]
        return t0
    else if fti == "Quasar" then do
        i <- getOperand (n, ta)
        btrue <- newLabel
        bfalse <- newLabel
        t0 <- newTemp
        t1 <- newTemp
        t2 <- newTemp
        tell [T.ThreeAddressCode T.Assign (Just t0) (Just $ T.Constant ("0", Simple "planet")) Nothing,
              T.ThreeAddressCode T.Assign (Just t1) (Just a) Nothing,
              T.ThreeAddressCode T.Eq (Just i) (Just $ T.Constant ("0", Simple "planet")) (Just btrue),
              T.ThreeAddressCode T.NewLabel Nothing (Just bfalse) Nothing, 
              T.ThreeAddressCode T.Deref (Just t1) (Just t1) Nothing,
              T.ThreeAddressCode T.Add (Just t0) (Just t0) (Just $ T.Constant ("1", Simple "planet")),
              T.ThreeAddressCode T.Neq (Just t0) (Just i) (Just bfalse),
              T.ThreeAddressCode T.NewLabel Nothing (Just btrue) Nothing,
              T.ThreeAddressCode T.Add (Just t2) (Just t1) (Just $ T.Constant (show $ anchura (Composite "~" te), Simple "planet"))]
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
