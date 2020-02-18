module Intermediate where
import Control.Monad.RWS
import Tipos
import Parser (gatto)
import qualified TACType as T

data VarType = Temp Int
             | SymEntry String Entry
type Operand = T.Operand VarType Type
type InterCode = [T.ThreeAddressCode VarType Type]
type InterMonad a = RWST () InterCode (Int, Int) IO a

instance T.SymEntryCompatible VarType where
  getSymID (Temp n) = "_t"++(show n)
  getSymID (SymEntry s _) = s

instance Show VarType where
    show x = T.getSymID x

vaca :: String -> IO InterCode
vaca f = do
    (arbol, (tablon, _, _, ok, _), _) <- gatto f
    cow arbol tablon ok

cow :: Program -> Tablon -> Bool -> IO InterCode
cow (Root lis) _ ok = if ok then do
                            (_,_,c) <- runRWST (genCode lis) () (0,0)
                            return c
                        else return []

newTemp :: InterMonad Operand
newTemp = do
    (n,m) <- get
    put (n+1,m)
    return $ T.Variable (Temp n)

lastTemp :: InterMonad Operand
lastTemp = do
    (n,_) <- get
    return $ T.Variable (Temp (n-1))

newLabel :: InterMonad Operand
newLabel = do 
    (n,m) <- get
    put (n,m+1)
    return $ T.Label m

genCode :: [Instr] -> InterMonad ()
genCode [] = return ()
genCode (x:xs) = do
    genCodeInstr x
    genCode xs

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
    genCode sequ
    tell [T.ThreeAddressCode T.GoTo Nothing Nothing (Just begin),
          T.ThreeAddressCode T.NewLabel Nothing (Just bfalse) Nothing]
genCodeInstr (ForC instr (b,_) sequ) = do
    begin <- newLabel
    btrue <- newLabel
    bfalse <- newLabel
    c1 <- genCodeExpB (b, btrue, bfalse)
    genCodeInstr instr
    tell $ (T.ThreeAddressCode T.NewLabel Nothing (Just begin) Nothing) : c1
    tell [T.ThreeAddressCode T.NewLabel Nothing (Just btrue) Nothing]
    genCode sequ
    tell [T.ThreeAddressCode T.GoTo Nothing Nothing (Just begin),
          T.ThreeAddressCode T.NewLabel Nothing (Just bfalse) Nothing]

genCodeInstr (ForRange k e1 e2 e3 sequ) = do
    begin <- newLabel
    btrue <- newLabel
    bfalse <- newLabel
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
    genCode sequ
    tell [T.ThreeAddressCode T.Add (Just iter) (Just iter) (Just step),
          T.ThreeAddressCode T.GoTo Nothing Nothing (Just begin),
          T.ThreeAddressCode T.NewLabel Nothing (Just bfalse) Nothing]
-- Asignaciones
genCodeInstr (Asig (e1@(Access _ _),_) e2) = do
    a <- getAddress e1
    b <- getOperand e2
    tell [T.ThreeAddressCode T.Set (Just a) (Just $ T.Constant ("0", Simple "planet")) (Just b)]
genCodeInstr (Asig e1 e2) = do
    lvalue <- getOperand e1
    rvalue <- getOperand e2
    tell [T.ThreeAddressCode T.Assign (Just lvalue) (Just rvalue) Nothing]
--
genCodeInstr (Declar _ _) = return ()
genCodeInstr _ = error "no c nada"

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
genCodeExpB _ = error "no c nada"

getAddress :: Expr -> InterMonad Operand
getAddress (Var s entry) = return $ T.Variable $ SymEntry s entry
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
getOperand (Var s entry,_) = return $ T.Variable $ SymEntry s entry
getOperand (IntLit n, t) = return $ T.Constant (show n, t)
getOperand (FloLit x, t) = return $ T.Constant (show x, t)
getOperand (CharLit c,t) = return $ T.Constant (show c, t)
getOperand (e,_) = do
    c <- genCodeExp e
    tell c
    lastTemp
