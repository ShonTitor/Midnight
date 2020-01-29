module Intermediate where
import Control.Monad.RWS
import Tipos
import Parser (gatto)
import qualified TACType as T

data VarType = VarType String
type Operand = T.Operand VarType String
type InterCode = [T.ThreeAddressCode VarType String]
type InterMonad a = RWST () InterCode (Int, Int) IO a

instance T.SymEntryCompatible VarType where
  getSymID (VarType s) = s

instance Show VarType where
    show (VarType s) = s

wrapVar :: String -> VarType
wrapVar s = VarType s

vaca :: String -> IO InterCode
vaca f = do
    (arbol, (tablon, _, _, ok, _), _) <- gatto f
    cow arbol tablon ok

cow :: Program -> Tablon -> Bool -> IO InterCode
cow (Root lis) tab ok = if ok then do
                            (_,_,c) <- runRWST (genCode lis) () (0,0)
                            return c
                        else return []

newTemp :: InterMonad Operand
newTemp = do
    (n,m) <- get
    put (n+1,m)
    return $ T.Variable (wrapVar $ '_':"t"++(show n))

lastTemp :: InterMonad Operand
lastTemp = do
    (n,_) <- get
    return $ T.Variable (wrapVar $ '_':"t"++(show $ n-1))

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
genCodeInstr (Flotando (exp,_)) = do
    c <- genCodeExp exp
    tell c
genCodeInstr _ = return ()

genCodeExp :: Expr -> InterMonad InterCode
-- Aritmeticas
genCodeExp (Suma (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Add (Just t) (Just op1) (Just op2)]
genCodeExp (Sub (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Sub (Just t) (Just op1) (Just op2)]
genCodeExp (Neg (e1,_)) = do
    op1 <- getOperand e1
    t <- newTemp
    return [T.ThreeAddressCode T.Minus (Just t) (Just op1) Nothing]
genCodeExp (Mul (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Mult (Just t) (Just op1) (Just op2)]
genCodeExp (Div (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Div (Just t) (Just op1) (Just op2)]
genCodeExp (DivE (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Div (Just t) (Just op1) (Just op2)]
genCodeExp (Mod (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Mod (Just t) (Just op1) (Just op2)]
-- Bool
genCodeExp e@(And _ _) = do
    genCodeExpB' e
genCodeExp e@(Or _ _) = do
    genCodeExpB' e
genCodeExp (Bitand (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.And (Just t) (Just op1) (Just op2)]
genCodeExp (Bitor (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Or (Just t) (Just op1) (Just op2)]
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
                      T.ThreeAddressCode T.Assign (Just t) (Just $ T.Constant ("1", "")) Nothing,
                      T.ThreeAddressCode T.GoTo Nothing Nothing (Just next),
                      T.ThreeAddressCode T.NewLabel Nothing (Just bfalse) Nothing,
                      T.ThreeAddressCode T.Assign (Just t) (Just $ T.Constant ("0", "")) Nothing,
                      T.ThreeAddressCode T.NewLabel Nothing (Just next) Nothing
                      ]

genCodeExpB :: (Expr, Operand, Operand) -> InterMonad InterCode
genCodeExpB (Var "full", btrue, _) = return [T.ThreeAddressCode T.GoTo Nothing Nothing (Just btrue)]
genCodeExpB (Var "new", _, bfalse) = return [T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB (Not (e1,_), btrue, bfalse) = genCodeExpB (e1, bfalse, btrue)
genCodeExpB (e@(Bitand _ _), btrue, bfalse) = do
    code <- genCodeExp e
    t <- lastTemp
    return $ code ++ [T.ThreeAddressCode T.If Nothing (Just t) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB (e@(Bitor _ _), btrue, bfalse) = do
    code <- genCodeExp e
    t <- lastTemp
    return $ code ++ [T.ThreeAddressCode T.If Nothing (Just t) (Just btrue), T.ThreeAddressCode T.GoTo Nothing Nothing (Just bfalse)]
genCodeExpB (e@(And (e1,_) (e2,_)), btrue, bfalse) = do
    b1true <- newLabel
    code1 <- genCodeExpB (e1, b1true, bfalse)
    code2 <- genCodeExpB (e2, btrue, bfalse)
    return $ code1 ++ (T.ThreeAddressCode T.NewLabel Nothing (Just b1true) Nothing) : code2

genCodeExpB (e@(Or (e1,_) (e2,_)), btrue, bfalse) = do
    b1false <- newLabel
    code1 <- genCodeExpB (e1, btrue, b1false)
    code2 <- genCodeExpB (e2, btrue, bfalse)
    return $ code1 ++ (T.ThreeAddressCode T.NewLabel Nothing (Just b1false) Nothing) : code2

genCodeExpB _ = error "no c nada"

getOperand :: Expr -> InterMonad Operand
getOperand (Var s) = return $ T.Variable $ wrapVar s
getOperand (IntLit n) = return $ T.Constant (show n, "")
getOperand (FloLit x) = return $ T.Constant (show x, "")
getOperand e = do
    c <- genCodeExp e
    tell c
    lastTemp
