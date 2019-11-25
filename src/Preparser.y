{
module Preparser where
import Data.Char
import Data.List
import Lexer
import Tablon
import Tipos
import Control.Monad.RWS
import Data.Maybe (isNothing, fromJust)
import qualified Data.Map as Map
}

%name preparser
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

S : Push Programa Pop  { () }

Programa : space end                  { () }
      | space Defs Seq end            { () }
      | space Defs end                { () }
      | space Seq end                 { () }

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
      : FunSig '{' Seq '}' Pop               { () }
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

Seq : SeqAux2                   { () }

SeqAux2   : SeqAux              { () }
          | SeqAux InstrA       { () }
          | InstrA              { () }


SeqAux  : InstrA ';'        { () }
        | SeqAux InstrA ';' { () }
        | InstrB Pop        { () }
        | SeqAux InstrB Pop { () }

Instr : InstrA              { () }
      | InstrB Pop          { () }

InstrA : Type id            { () }
       | Type id '=' Exp    { () }
       | Exp                { () }
       | LValue '=' Exp     { () }
       | LValue '+=' Exp    { () }
       | LValue '-=' Exp    { () }
       | LValue '*=' Exp    { () }
       | LValue '/=' Exp    { () }
       | LValue '//=' Exp   { () }
       | LValue '%=' Exp    { () }
       | LValue '^=' Exp    { () }
       | break              { () }
       | break Exp          { () }
       | continue           { () }
       | return Exp         { () }
       | return             { () }
       | yield Exp          { () }

InstrB : Push If                                                             { () }
       | Push While                                                          { () }
       | IterHead '{' Seq '}'                                                { () }
       | Push orbit '(' Instr ';' Exp ';' Instr ')' '{' SeqAux2 '}'          { () }

IterHead : Push orbit id around Exp { () }
         | Push orbit id around range '(' Exp ',' Exp ',' Exp ')' { () }
         | Push orbit id around range '(' Exp ',' Exp ')' { () }
         | Push orbit id around range '(' Exp ')' { () }

If : if '(' Exp ')' '{' Seq '}'           { () }
   | unless '(' Exp ')' '{' Seq '}'       { () }
   | if '(' Exp ')' '{' Seq '}' Push Elif { () }

Elif : elseif '(' Exp ')' '{' Seq '}' Pop { () }
     | else  '{' Seq '}' Pop                        { () }
     | elseif '(' Exp ')' '{' Seq '}' Pop Push Elif { () }
While : orbit while '(' Exp ')' '{' Seq '}' { () }
      | orbit until '(' Exp ')' '{' Seq '}' { () }


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

LValue : id                        { () }
       | Exp '.' id               { () }
       | Exp '[' Index            { () }



Index :     Exp ']'               { () }

Slice :     Exp '..' Exp ']'      { () }
      |     '..' Exp ']'          { () }
      |     Exp '..' ']'          { () }

Exp : LValue                      { () }
    | '(' Exp ')'                 { () }
    | Exp  '[' Slice              { () }
    | '~' Exp                     { () }
    | Exp '(' Args ')'            { () }
    | print '(' Args ')'          { () }
    | read '(' ')'                { () }
    | bigbang '(' Type ')'        { () }
    | scale '(' Exp ')'           { () }
    | Exp '.' pop '(' Args ')'    { () }
    | Exp '.' add '(' Args ')'    { () }

    | int                         { () }
    | float                       { () }
    | new                         { () }
    | full                        { () }
    | bh                          { () }
    | str                         { () }
    | chr                         { () }
    | Exp '+' Exp                 { () }
    | Exp '-' Exp                 { () }
    | Exp '*' Exp                 { () }
    | Exp '/' Exp                 { () }
    | Exp '//' Exp                { () }
    | Exp '%' Exp                 { () }
    | Exp '^' Exp                 { () }
    | '-' Exp         %prec NEG   { () }
    | Exp '==' Exp                { () }
    | Exp '¬=' Exp                { () }
    | Exp '>' Exp                 { () }
    | Exp '>=' Exp                { () }
    | Exp '<' Exp                 { () }
    | Exp '<=' Exp                { () }
    | Exp '&&' Exp                { () }
    | Exp '&' Exp                 { () }
    | Exp '||' Exp                { () }
    | Exp '|' Exp                 { () }
    | '¬' Exp                     { () }
    | '[' Args ']'                { () }
    | '{' Args '}'                { () }
    | cluster '(' Exp ')' Type    { () }
    | '{' DictItems '}'           { () }


Args : ArgsAux                       { () }
     |                               { () }

ArgsAux  : ArgsAux ',' Exp           { () }
         | Exp                       { () }

DictItems : Exp ':' Exp ',' DictItems           { () }
           | Exp ':' Exp                        { () }

Pop :: { () }
    :   {- Lambda -}      { % popPila }

Push  ::  { () }
      :   {- Lambda -}    { % pushPila }

{
parseError :: [Token] -> a
parseError (x:_) = error $ "Error de sintaxis en la línea " ++ (show m) ++ " columna " ++ (show n)
                   where (AlexPn _ m n) = getPos x
parseError _ = error "Final inesperado del archivo."

pregato f = do
  putStrLn ""
  s <- getTokens f
  (arbol, (tabla, _, _), _) <- runRWST (preparser s) () initTablon
  putStrLn ""
  print arbol
  putStrLn ""
  --putStrLn $ showTablon tabla
  putStrLn $ showTablon' tabla
  return()

}