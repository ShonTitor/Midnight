module Intermediate where
import Control.Monad.RWS
import Tipos
import Parser (gatto)
import qualified TACType as T

type InterCode = [T.ThreeAddressCode String String]
type InterMonad a = RWST () InterCode (Integer, Integer) IO a

vaca :: String -> IO InterCode
vaca f = do
    (arbol, (tablon, _, _, ok, _), _) <- gatto f
    cow arbol tablon ok

cow :: Program -> Tablon -> Bool -> IO InterCode
cow (Root lis) tab ok = if ok then do
                            (_,_,c) <- runRWST (genCode lis) () (0,0)
                            return c
                        else return []

newTemp :: InterMonad (T.Operand String String)
newTemp = do
    (n,m) <- get
    put (n+1,m)
    return $ T.Variable $ '_':"t"++(show n)

lastTemp :: InterMonad (T.Operand String String)
lastTemp = do
    (n,_) <- get
    return $ T.Variable $ '_':"t"++(show $ n-1)

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
    return [T.ThreeAddressCode T.Suma (Just t) (Just op1) (Just op2)]
genCodeExp (Sub (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Resta (Just t) (Just op1) (Just op2)]
genCodeExp (Neg (e1,_)) = do
    op1 <- getOperand e1
    t <- newTemp
    return [T.ThreeAddressCode T.Resta (Just t) (Just $ T.Constant "0") (Just op1)]
genCodeExp (Mul (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Multiplicacion (Just t) (Just op1) (Just op2)]
genCodeExp (Div (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Division (Just t) (Just op1) (Just op2)]
genCodeExp (DivE (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.DivisionEntera (Just t) (Just op1) (Just op2)]
genCodeExp (Mod (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Modulo (Just t) (Just op1) (Just op2)]
-- Bool
genCodeExp (Bitand (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.Y (Just t) (Just op1) (Just op2)]
genCodeExp (Bitor (e1,_) (e2,_)) = do
    op1 <- getOperand e1
    op2 <- getOperand e2
    t <- newTemp
    return [T.ThreeAddressCode T.O (Just t) (Just op1) (Just op2)]
genCodeExp _ = do
    _ <- newTemp
    --lift $ putStrLn "Esto falta jaja salu2"
    return []

getOperand :: Expr -> InterMonad (T.Operand String String)
getOperand (Var s) = return $ T.Variable s
getOperand (IntLit n) = return $ T.Constant (show n)
getOperand (FloLit x) = return $ T.Constant (show x)
getOperand e = do
    c <- genCodeExp e
    tell c
    lastTemp
