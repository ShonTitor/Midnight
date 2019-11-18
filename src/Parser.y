{
module Parser where
import Data.Char
import Data.List
import Lexer
import Tablon
import Tipos
import Control.Monad.RWS
import Data.Maybe (isNothing, fromJust)
import qualified Data.Map as Map
}

%name midnight
%tokentype { Token }
%error { parseError }
%monad { MonadTablon }

%token 
      space           { TkSpace     $$ }
      end             { TkEndofSpace $$ }
      moon            { TkMoon      $$ }
      new             { TkNew       $$ }
      full            { TkFull      $$ }
      bh              { TkNull      $$ }
      planet          { TkPlanet    $$ }
      cloud           { TkCloud     $$ }
      star            { TkStar      $$ }
      blackhole       { TkBlackhole $$ }
      constellation   { TkConstellation $$ }
      cluster         { TkCluster   $$ }
      quasar          { TkQuasar    $$ }
      nebula          { TkNebula    $$ }
      galaxy          { TkGalaxy    $$ }
      ufo             { TkUFO       $$ }
      comet           { TkComet     $$ }
      satellite       { TkSatellite $$ }

      print           { TkPrint     $$ }
      read            { TkRead      $$ }
      scale           { TkScale     $$ }
      around          { TkAround    $$ }
      range           { TkRange     $$ }
      pop             { TkPop       $$ }
      add             { TkAdd       $$ }
      bigbang         { TkBigbang   $$ }
      if              { TkIf        $$ }
      elseif          { TkElseif    $$ }
      else            { TkElse      $$ }
      unless          { TkUnless    $$ }
      while           { TkWhile     $$ }
      until           { TkUntil     $$ }
      orbit           { TkOrbit     $$ }
      break           { TkBreak $$ }
      continue        { TkContinue $$ }
      return          { TkReturn $$ }
      yield           { TkYield $$ }
      '@'             { TkArroba    $$ }
      '('             { TkParA      $$ }
      ')'             { TkParC      $$ }
      '['             { TkCorA      $$ }
      ']'             { TkCorC      $$ }
      '{'             { TkLlavA     $$ }
      '}'             { TkLlavC     $$ }
      '..'            { TkPuntopunto $$ }
      '.'             { TkPunto     $$ }
      ','             { TkComa      $$ }
      ';'             { TkPuntoycoma $$ }
      ':'             { TkDospuntos $$ }
      '~'             { TkNyangara  $$ }
      '+='            { TkMasIgual  $$ }
      '+'             { TkMas       $$ }
      '-='            { TkMenosIgual $$ }
      '-'             { TkMenos     $$ }
      '*='            { TkMultIgual $$ }
      '*'             { TkMult     $$ }
      '^='            { TkPotenciaIgual $$ }
      '^'             { TkPotencia  $$ }
      '//='           { TkDivEnteraIgual $$ }
      '//'            { TkDivEntera $$ }
      '/='            { TkDivIgual  $$ }
      '/'             { TkDiv       $$ }
      '%='            { TkModIgual  $$ }
      '%'             { TkMod       $$ }
      '->'            { TkFlechita  $$ }
      '>='            { TkMayorIgual $$ }
      '>'             { TkMayor     $$ }
      '<='            { TkMenorIgual $$ }
      '<'             { TkMenor     $$ }
      '&&'            { TkAnd       $$ }
      '&'             { TkBitand    $$ }
      '||'            { TkOr        $$ }
      '|'             { TkBitor     $$ }
      '=='            { TkIgual     $$ }
      '¬='            { TkDistinto  $$ }
      '='             { TkAsignacion $$ }
      '¬'             { TkNegacion  $$ }
      str             { TkString $$ }
      chr             { TkChar $$ }
      id              { TkId $$ }
      float           { TkFloat $$ }
      int             { TkInt $$ }
%nonassoc '>' '<' '>=' '<=' '==' '¬='
%left '&&' '&' '||' '|' 
%left '¬'
%left '+' '-'
%left '*' '/' '//' '%'
%right '^'
%left '~'
%left ',' ';' '.'
%left '[' '(' '{' ']' ')' '}'
%left NEG
%%

S :: { Program } : Push Programa Pop  { $2 }

Programa :: { Program }    
      : space end                     { % return $ Root [] }
      | space Defs Seq end            { % return $ Root $3 }
      | space Defs end                { % return $ Root [] }
      | space Seq end                 { % return $ Root $2 }

Defs : DefsAux                        { reverse $1 }

DefsAux : DefsAux Func                { $2 : $1 }
        | Func                        { [$1] }

FunSig : comet id '(' Params ')' '->' Type
        { % do
          (t, pila, n) <- get
          put (t, 1:pila, n)
          let d = Func (fst $2) $4 $7 []
          insertarSubrutina (d, snd $2)
          popPila
          return $ fst $2
        }
       | satellite id '(' Params ')' '->' Type
        { % do
          (t, pila, n) <- get
          put (t, 1:pila, n)
          let d = Iter (fst $2) $4 $7 []
          insertarSubrutina (d, snd $2) 
          popPila
          return $ fst $2
        }

Func  :: { () }
      : FunSig '{' Seq '}' Pop    
        { % do 
          actualizarSubrutina $1 $3 }
          --let d = Func (fst $2) $4 $7 $9
          --insertarSubrutina (d, snd $2) }
      | RegSig '{' Regs Pop '}'              { () }

RegSig : ufo id                              { % insertarReg $2 (fst $1) }
       | galaxy id                           { % insertarReg $2 (fst $1) }

Regs : Push RegsAux    
      { % do
          let rex = reverse $2
          insertarCampos rex
          return (rex) }
     | Push RegsAux ';'                                             
     { % do
          let rex = reverse $2
          insertarCampos rex
          return (rex) }

RegsAux   : RegsAux ';' Type id                           { ($3, $4) : $1 }
          | Type id                                       { [($1, $2)] }

Seq : SeqAux2                   { reverse $1 }

SeqAux2   : SeqAux              { $1 }
          | SeqAux InstrA       { $2 : $1 }
          | InstrA              { [$1] }


SeqAux  : InstrA ';'        { if (isDeclar $1) then [] else [$1] }
        | SeqAux InstrA ';' { if (isDeclar $2) then $1 else $2 : $1 }
        | InstrB Pop        { [$1] }
        | SeqAux InstrB Pop { $2 : $1 }

Instr : InstrA              { $1 }
      | InstrB Pop          { $1 }

InstrA : Type id            
       { % do 
          insertarVar $2 $1
          return (Declar $1 (fst $2)) }
       | Type id '=' Exp    
       { % do 
          insertarVar $2 $1
          return (Asig (Var $ fst $2, $1) $4) }
       | Exp                { Flotando $1 }
       | LValue '=' Exp     { Asig $1 $3 }
       | LValue '+=' Exp    { Asig $1 (Suma $1 $3, Err) }
       | LValue '-=' Exp    { Asig $1 (Sub $1 $3, Err) }
       | LValue '*=' Exp    { Asig $1 (Mul $1 $3, Err) }
       | LValue '/=' Exp    { Asig $1 (Div $1 $3, Err) }
       | LValue '//=' Exp   { Asig $1 (DivE $1 $3, Err) }
       | LValue '%=' Exp    { Asig $1 (Mod $1 $3, Err) }
       | LValue '^=' Exp    { Asig $1 (Pow $1 $3, Err) }
       | break              { Break (IntLit 1, Simple "planet") }
       | break Exp          { Break $2 }
       | continue           { Continue }
       | return Exp         { Return $2 } 
       | return             { Return (Var "blackhole", Simple "BlackHole") }
       | yield Exp          { Yield $2 }

InstrB : Push If                                                             { $2 }
       | Push While                                                          { $2 }
       | Push orbit id around Exp '{' Seq '}'                                
         { % do 
           insertarVar $3 IDK 
           return  $ Foreach (fst $3) $5 $7 }
       | Push orbit id around range '(' Exp ',' Exp ',' Exp ')' '{' Seq '}'
         { % do
           insertarVar $3 (Simple "planet")
           return $ ForRange $7 $9 $11 $14 }
       | Push orbit id around range '(' Exp ',' Exp ')' '{' Seq '}'
         { % do
           insertarVar $3 (Simple "planet")
           return $ ForRange $7 $9 (IntLit 1, Simple "planet") $12 }
       | Push orbit id around range '(' Exp ')' '{' Seq '}'
         { % do
           insertarVar $3 (Simple "planet")
           return $ ForRange (IntLit 0, Simple "planet") $7 (IntLit 1, Simple "planet") $10 }
       | Push orbit '(' Instr ';' Exp ';' Instr ')' '{' SeqAux2 '}'          { ForC $4 $6 (reverse $ $8 : $11) }

If : if '(' Exp ')' '{' Seq '}'                           { If [($3, $6)] }
   | unless '(' Exp ')' '{' Seq '}'                       { If [((Not $3, Err), $6)] }
   | if '(' Exp ')' '{' Seq '}' Push Elif                 { If (($3, $6) : $9) }

Elif : elseif '(' Exp ')' '{' Seq '}' Pop                 { [($3, $6)] }
     | else  '{' Seq '}' Pop                              { [((Var "full", Simple "bool"), $3)] }
     | elseif '(' Exp ')' '{' Seq '}' Pop Push Elif       { ($3, $6) : $10 }

While : orbit while '(' Exp ')' '{' Seq '}'               { While $4 $7 }
      | orbit until '(' Exp ')' '{' Seq '}'               { While (Not $4, Err) $7 }


Params : Push ParamsAux                                   
         { % do 
           let params = reverse $2
           insertarParams params 
           return params }
       | Push                                             { [] }

ParamsAux : ParamsAux ',' Type id                         { ($3, $4, False) : $1 }
          | Type id                                       { [($1, $2, False)] }
          | ParamsAux ',' Type '@' id                     { ($3, $5, True) : $1 }
          | Type '@' id                                   { [($1, $3, True)] }

Type  : planet                    { Simple $ fst $1 }
      | cloud                     { Simple $ fst $1 }
      | star                      { Simple $ fst $1 }
      | moon                      { Simple $ fst $1 }
      | blackhole                 { Simple $ fst $1 }
      | constellation             { Composite "Cluster" (Simple "star") }
      | TComp                     { $1 }

Types : TypesAux                  { reverse $1 }

TypesAux : Type                   { [$1] }
         | TypesAux ',' Type      { $3 : $1 }

TComp : '[' Type ']' cluster      { Composite (fst $4) $2 }
      | '[' Type ']' quasar       { Composite (fst $4) $2 }
      | '[' Type ']' nebula       { Composite (fst $4) $2 }
      | '~' Type                  { Composite (fst $1) $2 }
      | id galaxy                 { % do
                                      lookupExists $1
                                      return $ Record (fst $2) (fst $1) }
      | id ufo                    { % do
                                      lookupExists $1
                                      return $ Record (fst $2) (fst $1) }
      | '(' Types '->' Type ')' comet      { Subroutine (fst $6) $2 $4 }
      | '(' Types '->' Type ')' satellite  { Subroutine (fst $6) $2 $4 }

LValue :: { Exp }
      : id                       { % do
                                    e <- lookupExists $1
                                    return (Var (fst $1), getTipo e) }
       | Exp '.' id               { %do 
                                    let isRecord (Record _ _) = True
                                        isRecord _ = False
                                        getR (Record _ r) = r
                                        getS (Entry _ (Registro _ sc) _) = [sc]
                                        t1 = snd $1
                                        AlexPn _ m n = $2
                                    if isRecord t1 then do
                                        e1 <- lookupTablon $ getR t1
                                        e2 <- lookupScope (fst $3) (getS $ fromJust e1)
                                        if isNothing e2 then do
                                          lift $ putStrLn ("Error de tipo: "++(show t1)++" no tiene un atributo "++(show $ fst $3)
                                                            ++" en la línea "++(show m)++" columna "++(show n))
                                          return (Attr $1 (fst $3), Err)
                                        else return (Attr $1 (fst $3), getTipo e2)
                                    else if t1 == Err then return (Attr $1 (fst $3), Err)
                                    else do 
                                        lift $ putStrLn ("Error de tipo: "++(show t1)++" no tiene un atributo "++(show $ fst $3)
                                                          ++" en la línea "++(show m)++" columna "++(show n))
                                        return (Attr $1 (fst $3), Err) }
       | Exp '[' Index            { % do
                                    let exp = Access $1 $3
                                        t1 = snd $1
                                        Index t2' = $3
                                        t2 = snd t2'
                                        isComp (Composite t _) = elem t ["Cluster", "Quasar", "Nebula"]
                                        isComp _ = False
                                        f (Composite _ t) = t
                                        g (Composite s _) = s
                                        AlexPn _ m n = $2
                                    if t1 == Err || t2 == Err || (f t1) == Err then
                                        return (exp, Err) 
                                    else if (not.isComp) t1 then do
                                        lift $ putStrLn ("Error de tipo: "++(show t1)++" no es indexable "
                                                          ++" en la línea "++(show m)++" columna "++(show n))
                                        return (exp, Err)
                                    else if (g t1) == "Nebula" && t2 /= (Composite "Cluster" (Simple "star")) then do
                                        lift $ putStrLn ("Error de tipo: Nebula acepta claves de tipo Constellation, no "++(show t2)
                                                          ++" en la línea "++(show m)++" columna "++(show n))
                                        return (exp, Err)
                                    else if ((g t1) == "Cluster" || (g t1) == "Quasar") && t2 /= (Simple "planet") then do
                                        lift $ putStrLn ("Error de tipo: Los índices deben ser enteros, no "++(show t2)
                                                          ++" en la línea "++(show m)++" columna "++(show n))
                                        return (exp, Err)
                                    else return (exp, f t1)
                                    }



Index :     Exp ']'               { Index $1 }

Slice :     Exp '..' Exp ']'      { % do
                                    let exp = Interval $1 $3
                                        t1 = snd $1
                                        t2 = snd $3
                                        AlexPn _ m n = $2
                                    if t1 == Err && t2 == Err then return exp
                                    else do
                                        if t1 /= (Simple "planet") && t2 /= (Simple "planet") then do
                                            lift $ putStrLn ("Error de tipo: Los límites de slices deben ser enteros, no "++(show t1)
                                                              ++" en la línea "++(show m)++" columna "++(show n))
                                            lift $ putStrLn ("Error de tipo: Los límites de slices deben ser enteros, no "++(show t2)
                                                              ++" en la línea "++(show m)++" columna "++(show n))
                                            return $ Interval (fst $1, Err) (fst $3, Err)
                                        else if t1 /= (Simple "planet") then do
                                            lift $ putStrLn ("Error de tipo: Los límites de slices deben ser enteros, no "++(show t1)
                                                              ++" en la línea "++(show m)++" columna "++(show n))
                                            return $ Interval (fst $1, Err) $3
                                        else if t2 /= (Simple "planet") then do
                                            lift $ putStrLn ("Error de tipo: Los límites de slices deben ser enteros, no "++(show t2)
                                                              ++" en la línea "++(show m)++" columna "++(show n))
                                            return $ Interval $1 (fst $3, Err)
                                        else return exp
                                     }
      |     '..' Exp ']'          { % do
                                    let exp = Interval e0 $2
                                        e0 = (IntLit 0, Simple "planet")
                                        t = snd $2
                                        AlexPn _ m n = $1
                                    if t == Err then return exp
                                    else if t /= (Simple "planet") then do
                                            lift $ putStrLn ("Error de tipo: Los límites de slices deben ser enteros, no "++(show t)
                                                              ++" en la línea "++(show m)++" columna "++(show n))
                                            return $ Interval e0 (fst $2, Err)
                                    else return exp
                                    }
      |     Exp '..' ']'          { % do
                                    let exp = Begin $1
                                        t = snd $1
                                        AlexPn _ m n = $2
                                    if t == Err then return exp
                                    else if t /= (Simple "planet") then do
                                            lift $ putStrLn ("Error de tipo: Los límites de slices deben ser enteros, no "++(show t)
                                                              ++" en la línea "++(show m)++" columna "++(show n))
                                            return $ Begin (fst $1, Err)
                                    else return exp
                                    }

Exp :: { Exp }
    : LValue                      { $1 }
    | '(' Exp ')'                 { $2 }
    | Exp  '[' Slice                   { % do
                                        let g sl@(Interval _ _) = sl
                                            g (Begin a) = Interval a (Scale $1, Simple "planet")
                                            exp = Access $1 (g $3)
                                            f (Composite "Nebula" _) = Err
                                            f (Composite "~" _) = Err
                                            f tipo@(Composite _ _) = tipo
                                            f _ = Err
                                            Interval (_, ti) (_,tf) = g $3
                                            t = if ti == Err || tf == Err then Err else f (snd $1)
                                            AlexPn _ m n = $2
                                        if (snd $1) == Err then return (exp, Err)
                                        else do
                                            if t == Err then do
                                                lift $ putStrLn ("Error de tipo: El tipo " ++ (show $ snd $1) ++ " no admite slices"
                                                                ++" en la línea "++(show m)++" columna "++(show n))
                                                return (exp, Err)
                                            else return (exp, t) }
    | '~' Exp                     { % do
                                    let exp = Desref $2
                                    if (snd $2) == Err then return (exp, Err)
                                    else do
                                        let f (Composite "~" tipo) = tipo
                                            f _ = Err
                                            t = f (snd $2)
                                            AlexPn _ m n = snd $1
                                        if t == Err then do
                                            lift $ putStrLn ("No se puede desreferenciar el tipo " ++ (show $ snd $2)
                                                             ++" en la línea "++(show m)++" columna "++(show n))
                                            return (exp, Err)
                                        else return (exp, t) }
    | Exp '(' Args ')'            { (Funcall $1 $3, Err) }
    | print '(' Args ')'          { (Print $3, Composite "Cluster" (Simple "star")) }
    | read '(' ')'                { (Read, Composite "Cluster" (Simple "star")) }
    | bigbang '(' Type ')'        { (Bigbang, Composite "~" $3) }
    | scale '(' Exp ')'           { (Scale $3, Err) }
    | Exp '.' pop '(' Args ')'    { (Pop $1 $5, Err) }
    | Exp '.' add '(' Args ')'    { (Add $1 $5, Err) }
    | int                         { (IntLit (fst $1), Simple "planet") }
    | float                       { (FloLit (fst $1), Simple "cloud") }
    | new                         { (Var $ fst $1, Simple "moon") }
    | full                        { (Var $ fst $1, Simple "moon") }
    | bh                          { (Var $ fst $1, Simple "BlackHole") }
    | str                         { (StrLit (fst $1), Composite "Cluster" (Simple "star")) }
    | chr                         { (CharLit (fst $1), Simple "star") }
    | Exp '+' Exp                 { % do
                                    (a,b) <- checkNum ("+", $2) $1 $3
                                    return (Suma a b, snd a) }
    | Exp '-' Exp                 { % do
                                    (a,b) <- checkNum ("-", $2) $1 $3
                                    return (Sub a b, snd a) }
    | Exp '*' Exp                 { % do
                                    (a,b) <- checkNum ("*", $2) $1 $3
                                    return (Mul a b, snd a) }
    | Exp '/' Exp                 { (Div $1 $3, Err) }
    | Exp '//' Exp                { (DivE $1 $3, Err) }
    | Exp '%' Exp                 { (Mod $1 $3 , Err)}
    | Exp '^' Exp                 { % do
                                    (a,b) <- checkNum ("^", $2) $1 $3
                                    return (Pow a b, snd a) }
    | '-' Exp         %prec NEG   { (Neg $2, Err) }
    | Exp '==' Exp                { (Eq $1 $3, Err) }
    | Exp '¬=' Exp                { (Neq $1 $3, Err) }
    | Exp '>' Exp                 { (Mayor $1 $3, Err) }
    | Exp '>=' Exp                { (MayorI $1 $3, Err) }
    | Exp '<' Exp                 { (Menor $1 $3, Err) }
    | Exp '<=' Exp                { (MenorI $1 $3, Err) }
    | Exp '&&' Exp                { (And $1 $3, Err) }
    | Exp '&' Exp                 { (Bitand $1 $3, Err) }
    | Exp '||' Exp                { (Or $1 $3, Err) }
    | Exp '|' Exp                 { (Bitor $1 $3, Err) }
    | '¬' Exp                     { (Not $2, Err) }
    | '[' Args ']'                { (ListLit $2, Err) }
    | '{' Args '}'                { (ArrLit $2, Err) }
    | cluster '(' Exp ')' Type    { (ArrInit $3 $5, Err) }
    | '{' DictItems '}'           { (DictLit $2, Err) }


Args : ArgsAux                       { reverse $1 }
     |                               { [] }

ArgsAux  : ArgsAux ',' Exp           { $3 : $1 }
         | Exp                       { [$1] }

DictItems : Exp ':' Exp ',' DictItems           { ($1, $3) : $5 }
           | Exp ':' Exp                        { [($1, $3)] }

Pop :: { () }
    :   {- Lambda -}      { % popPila }

Push  ::  { () }
      :   {- Lambda -}    { % pushPila }

{
parseError :: [Token] -> a
parseError (x:_) = error $ "Error de sintaxis en la línea " ++ (show m) ++ " columna " ++ (show n)
                   where (AlexPn _ m n) = getPos x
parseError _ = error "Final inesperado del archivo."


midny = midnight.alexScanTokens

type Tablon  = Map.Map String [Entry]

gato f = do
  putStrLn ""
  s <- getTokens f
  (arbol, (tabla, _, _), _) <- runRWST (midnight s) () initTablon
  putStrLn ""
  print arbol
  putStrLn ""
  --putStrLn $ showTablon tabla
  putStrLn $ showTablon' tabla
  return()


}