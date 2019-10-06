{
module Main where
import Data.Char
import Data.List
import Lexer
}

%name midnight
%tokentype { Token }
%error { parseError }

%token 
      space           { TkSpace     $$ }
      end             { TkEndofSpace $$ }
      moon            { TkMoon      $$ }
      new             { TkNew       $$ }
      full            { TkFull      $$ }
      planet          { TkPlanet    $$ }
      cloud           { TkCloud     $$ }
      star            { TkStar      $$ }
      blackhole       { TkBlackhole $$ }
      cosmos          { TkCosmos    $$ }
      constellation   { TkConstellation $$ }
      cluster         { TkCluster   $$ }
      quasar          { TkQuasar    $$ }
      nebula          { TkNebula    $$ }
      galaxy          { TkGalaxy    $$ }
      ufo             { TkUFO       $$ }
      comet           { TkComet     $$ }
      satellite       { TkSatellite $$ }
      terraform       { TkTerraform $$ }

      print           { TkPrint     $$ }
      read            { TkRead      $$ }
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
      arroba          { TkArroba      $$ }
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
%%

S     : space end       { Root Empty }
      | space Seq end   { Root $2 }

Seq   : Instr           { One $1 }
      | Instr ';'       { One $1 }
      | Instr ';' Seq   { Many $1 $3 }

Instr : Declar                { $1 }
      | LValue '=' RValue     { Asig $1 $3 }

Declar : Type id        { Declar $1 (fst $2) }

Type  : planet          { Planet }
      | cloud           { Cloud }
      | star            { Star }
      | moon            { Moon }
      | TComp           { $1 }

TComp : '[' Type ']' cluster      { Cluster $2 }
      | '[' Type ']' quasar       { Quasar $2 }
      | '[' Type ']' nebula       { Nebula $2 }
      | '~' Type                  { Pointer $2 }

LValue : id              { Var (fst $1) }
       | id '.' id       { Attr (Var (fst $1)) (fst $3) }
       | id '.' id Slice { Access (Attr (Var (fst $1)) (fst $3)) $4 }
       | id Slice '.' id { Attr (Access (Var (fst $1)) $2) (fst $4) }
       | id Slice        { Access (Var (fst $1)) $2 }
       | '(' LValue ')'  { $2 }

RValue : LValue           { Lval $1 }
       | ExpBool          { Bool $1 }

Slice : '[' str ']'               { Dict (fst $2) }
      | '[' str ']' Slice         { ManyAc (Dict (fst $2)) $4 }

ExpBool : BoolLit                 { $1 }
        | BoolAux '&&' ExpBool    { And $1 $3 }
        | BoolAux '&' ExpBool     { Bitand $1 $3 }
        | BoolAux '||' ExpBool    { Or $1 $3 }
        | BoolAux '|' ExpBool     { Bitor $1 $3 }
        | '¬' ExpBool             { Not $2 }
        | BoolAux '&&' LValue     { And $1 (LBool $3) }
        | BoolAux '&' LValue      { Bitand $1 (LBool $3) }
        | BoolAux '||' LValue     { Or $1 (LBool $3) }
        | BoolAux '|' LValue      { Bitor $1 (LBool $3) }
        | '¬' LValue              { Not (LBool $2) }
        | '(' ExpBool ')'         { $2 }

BoolLit : new                     { New }
        | full                    { Full }

BoolAux : BoolLit                 { $1 }
        | LValue                  { LBool $1 }
        | '(' ExpBool ')'         { $2 }

{
parseError :: [Token] -> a
parseError _ = error "Parse error"

midny = midnight.alexScanTokens

data Program
      = Root Seq 
      deriving Show

data Seq
      = Empty
      | One Instr
      | Many Instr Seq
      deriving Show

data Instr 
      = Perro String
      | Declar Type String
      | Asig LValue RValue
      deriving Show

data Type
      = Planet
      | Cloud
      | Star
      | Moon
      | Cluster Type
      | Quasar Type
      | Nebula Type
      | Pointer Type
      deriving Show

data LValue
      = Var String
      | Access LValue Slice
      | Attr LValue String
      deriving Show

data RValue
      = Lval LValue
      | Bool ExpBool
      deriving Show

data Slice
      = ManyAc Slice Slice
      | Dict String
      deriving Show

data ExpBool
      = New
      | Full
      | And ExpBool ExpBool
      | Bitand ExpBool ExpBool
      | Or ExpBool ExpBool
      | Bitor ExpBool ExpBool
      | Not ExpBool
      | LBool LValue
      deriving Show


gato f = do
  s <- readFile(f)
  return( partition (not.isError) (alexScanTokens s) )


main = gato "test.mn"
}