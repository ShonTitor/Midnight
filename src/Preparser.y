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

Programa : space END                  { () }
      | space Defs Seq END            { () }
      | space Defs END                { () }
      | space Seq END                 { () }

Defs : DefsAux                        { reverse $1 }

DefsAux : DefsAux Func                { $2 : $1 }
        | Func                        { [$1] }

FunSig : comet id Params '->' Type
        { % do
          (t, pila, n, b) <- get
          put (t, 1:pila, n, b)
          let d = Func (fst $2) $3 $5 []
          insertarSubrutina (d, snd $2)
          popPila
          return $ fst $2
        }
       | satellite id Params '->' Type
        { % do
          (t, pila, n, b) <- get
          put (t, 1:pila, n, b)
          let d = Iter (fst $2) $3 $5 []
          insertarSubrutina (d, snd $2) 
          popPila
          return $ fst $2
        }

Func  :: { () }
      : FunSig '{' Seq LQC Pop               { () }
      | RegSig '{' Regs Pop LQC              { () }

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
       | IterHead '{' Seq LQC                                                { () }
       | Push orbit '(' Instr ';' Exp ';' Instr PQC '{' SeqAux2 LQC          { () }

IterHead : Push orbit id AROUND Exp { () }
         | Push orbit id AROUND range '(' Exp ',' Exp ',' Exp PQC { () }
         | Push orbit id AROUND range '(' Exp ',' Exp PQC { () }
         | Push orbit id AROUND range '(' Exp PQC { () }

If : if '(' Exp PQC '{' Seq LQC           { () }
   | unless '(' Exp PQC '{' Seq LQC       { () }
   | if '(' Exp PQC '{' Seq LQC Push Elif { () }

ElifAux : elseif '(' Exp PQC '{' Seq LQC Pop           { () }
        | Elif Push elseif '(' Exp PQC '{' Seq LQC Pop { () }
 
Elif : ElifAux                                         { () }
     | ElifAux Push else  '{' Seq LQC Pop              { () }
     | else  '{' Seq LQC Pop                      { () }

While : orbit while '(' Exp PQC '{' Seq LQC { () }
      | orbit until '(' Exp PQC '{' Seq LQC { () }


Params : Push '(' ParamsAux PQC
         { % do 
           let params = reverse $3
           insertarParams params 
           return params }
       | Push '('  PQC                                    { [] }

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

TComp : '[' Type CQC cluster      { Composite (fst $4) $2 }
      | '[' Type CQC quasar       { Composite (fst $4) $2 }
      | '[' Type CQC nebula       { Composite (fst $4) $2 }
      | '~' Type                  { Composite (fst $1) $2 }
      | id galaxy                 { Record (fst $2) (fst $1) }
      | id ufo                    { Record (fst $2) (fst $1) }
      | '(' Types '->' Type PQC comet      { Subroutine (fst $6) $2 $4 }
      | '(' Types '->' Type PQC satellite  { Subroutine (fst $6) $2 $4 }

LValue : id                        { () }
       | Exp '.' id               { () }
       | Exp '[' Index            { () }



Index :     Exp CQC               { () }

Slice :     Exp '..' Exp CQC      { () }
      |     '..' Exp CQC          { () }
      |     Exp '..' CQC          { () }

Exp : LValue                      { () }
    | '(' Exp PQC                 { () }
    | Exp  '[' Slice              { () }
    | '~' Exp                     { () }
    | Exp '(' Args PQC            { () }
    | print '(' Args PQC          { () }
    | read '(' PQC                { () }
    | bigbang '(' Type PQC        { () }
    | scale '(' Exp PQC           { () }
    | Exp '.' pop '(' Args PQC    { () }
    | Exp '.' add '(' Args PQC    { () }

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
    | '[' Args CQC                { () }
    | '{' Args LQC                { () }
    | cluster '(' Exp PQC Type    { () }
    | '{' DictItems LQC           { () }


Args : ArgsAux                       { () }
     |                               { () }

ArgsAux  : ArgsAux ',' Exp           { () }
         | Exp                       { () }

DictItems : Exp ':' Exp ',' DictItems           { () }
           | Exp ':' Exp                        { () }

PQC : ')' { True } | error { False }
 
CQC : ']' { True } | error { False }
 
LQC : '}' { True } | error { False }

END : end { True } | error { False }

AROUND : around { True } | error { False }

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
  (arbol, (tabla, _, _, _), _) <- runRWST (preparser s) () initTablon
  putStrLn ""
  print arbol
  putStrLn ""
  --putStrLn $ showTablon tabla
  putStrLn $ showTablon' tabla
  return()

}