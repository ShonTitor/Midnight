{
module Parser where
import Data.Char
import Data.List
import Lexer
import Tablon
import Tipos
import Control.Monad.RWS
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

Func  :: { Def }
      : comet id '(' Params ')' '->' Type '{' Seq '}' Pop    
        { % do
          let d = Func (fst $2) $4 $7 $9
          insertarSubrutina (d, snd $2)
          return d }
      | satellite id '(' Params ')' '->' Type '{' Seq '}' Pop 
        { % do
          let d = Iter (fst $2) $4 $7 $9
          insertarSubrutina (d, snd $2)
          return d }
      | ufo id '{' Regs Pop '}'                               
        { % do
          let a = DUFO (fst $2) $4
          insertarReg (a, snd $2)
          return a }
      | galaxy id '{' Regs Pop '}'                            
        { % do 
          let a = DGalaxy (fst $2) $4
          insertarReg (a, snd $2)
          return a }

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
          return (Asig (Var $ fst $2) $4) }
       | Exp                { Flotando $1 }
       | LValue '=' Exp     { Asig $1 $3 }
       | LValue '+=' Exp    { Asig $1 (Suma $1 $3) }
       | LValue '-=' Exp    { Asig $1 (Sub $1 $3) }
       | LValue '*=' Exp    { Asig $1 (Mul $1 $3) }
       | LValue '/=' Exp    { Asig $1 (Div $1 $3) }
       | LValue '//=' Exp   { Asig $1 (DivE $1 $3) }
       | LValue '%=' Exp    { Asig $1 (Mod $1 $3) }
       | LValue '^=' Exp    { Asig $1 (Pow $1 $3) }
       | break              { Break (IntLit 1) }
       | break Exp          { Break $2 }
       | continue           { Continue }
       | return Exp         { Return $2 } 
       | return             { Return (Var "blackhole") }
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
           return $ ForRange $7 $9 (IntLit 1) $12 }
       | Push orbit id around range '(' Exp ')' '{' Seq '}'
         { % do
           insertarVar $3 (Simple "planet")
           return $ ForRange (IntLit 0) $7 (IntLit 1) $10 }
       | Push orbit '(' Instr ';' Exp ';' Instr ')' '{' SeqAux2 '}'          { ForC $4 $6 (reverse $ $8 : $11) }

If : if '(' Exp ')' '{' Seq '}'                           { If [($3, $6)] }
   | unless '(' Exp ')' '{' Seq '}'                       { If [(Not $3, $6)] }
   | if '(' Exp ')' '{' Seq '}' Push Elif                 { If (($3, $6) : $9) }

Elif : elseif '(' Exp ')' '{' Seq '}' Pop                 { [($3, $6)] }
     | else  '{' Seq '}' Pop                              { [(Var "full", $3)] }
     | elseif '(' Exp ')' '{' Seq '}' Pop Push Elif       { ($3, $6) : $10 }

While : orbit while '(' Exp ')' '{' Seq '}'               { While $4 $7 }
      | orbit until '(' Exp ')' '{' Seq '}'               { While (Not $4) $7 }


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
      | id galaxy                 { Record (fst $2) (fst $1) }
      | id ufo                    { Record (fst $2) (fst $1) }
      | '(' Types '->' Type ')' comet      { Subroutine (fst $6) $2 $4 }
      | '(' Types '->' Type ')' satellite  { Subroutine (fst $6) $2 $4 }

LValue : id                       { Var (fst $1) }
       | Exp '.' id               { Attr $1 (fst $3) }
       | Exp Index                { Access $1 $2 }

Index : '[' Exp ']'               { Index $2 }

Slice : '[' Exp '..' Exp ']'      { Interval $2 $4 }
      | '[' '..' Exp ']'          { Interval (IntLit 0) $3 }
      | '[' Exp '..' ']'          { Begin $2 }

Exp : LValue                      { $1 }
    | '(' Exp ')'                 { $2 }
    | Exp Slice                   { Access $1 $2 }
    | '~' Exp                     { Desref $2 }
    | Funcall                     { $1 }
    | print '(' Args ')'          { Print $3 }
    | read '(' ')'                { Read }
    | bigbang '(' ')'             { Bigbang }
    | scale '(' Exp ')'           { Scale $3 }
    | Exp '.' pop '(' Args ')'    { Pop $1 $5 }
    | Exp '.' add '(' Args ')'    { Add $1 $5 }

    | int                         { IntLit (fst $1) }
    | float                       { FloLit (fst $1) }
    | Exp '+' Exp                 { Suma $1 $3 }
    | Exp '-' Exp                 { Sub $1 $3 }
    | Exp '*' Exp                 { Mul $1 $3 }
    | Exp '/' Exp                 { Div $1 $3 }
    | Exp '//' Exp                { DivE $1 $3 }
    | Exp '%' Exp                 { Mod $1 $3 }
    | Exp '^' Exp                 { Pow $1 $3 }
    | '-' Exp         %prec NEG   { Neg $2 }
    | Exp '==' Exp                { Eq $1 $3 }
    | Exp '¬=' Exp                { Neq $1 $3 }
    | Exp '>' Exp                 { Mayor $1 $3 }
    | Exp '>=' Exp                { MayorI $1 $3 }
    | Exp '<' Exp                 { Menor $1 $3 }
    | Exp '<=' Exp                { MenorI $1 $3 }
    | new                         { Var $ fst $1 }
    | full                        { Var $ fst $1 }
    | bh                          { Var $ fst $1 }
    | Exp '&&' Exp                { And $1 $3 }
    | Exp '&' Exp                 { Bitand $1 $3 }
    | Exp '||' Exp                { Or $1 $3 }
    | Exp '|' Exp                 { Bitor $1 $3 }
    | '¬' Exp                     { Not $2 }
    | str                         { StrLit (fst $1) }
    | chr                         { CharLit (fst $1) }
    | '[' Args ']'                { ListLit $2 }
    | '{' Args '}'                { ArrLit $2 }
    | cluster '(' Exp ')' Type    { ArrInit $3 $5 }
    | '{' DictItems '}'           { DictLit $2 }

Funcall  : Exp '(' Args ')'       { Funcall $1 $3 }

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
parseError _ = error "Falta el terminador \"EndofSpace\""


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