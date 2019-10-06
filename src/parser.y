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
       | ExpNum           { Int $1 }

Slice : '[' str ']'                            { Key (fst $2) }
      | '[' str ']' Slice                      { ManyAc (Key (fst $2)) $4 }
      | '[' ExpNum ']'                         { Index $2 }
      | '[' ExpNum ']' Slice                   { ManyAc (Index $2) $4 }
      | '[' ExpNum '..' ExpNum ']'             { Interval $2 $4 }
      | '[' ExpNum '..' ExpNum ']' Slice       { ManyAc (Interval $2 $4) $6 }
      | '[' '..' ExpNum ']'                    { Interval (IntLit 0) $3 }
      | '[' '..' ExpNum ']' Slice              { ManyAc (Interval (IntLit 0) $3) $5 }
      | '[' ExpNum '..' ']'                    { Begin $2 }
      | '[' ExpNum '..' ']' Slice              { ManyAc (Begin $2) $5 }

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

ExpNum : int                      { IntLit (fst $1) }
       | IntAux '+' ExpNum        { Sum $1 $3 }
       | IntAux '-' ExpNum        { Sub $1 $3 }
       | IntAux '*' ExpNum        { Mul $1 $3 }
       | IntAux '^' ExpNum        { Pow $1 $3 }
       | IntAux '//' ExpNum       { Div $1 $3 }
       | IntAux '%' ExpNum        { Mod $1 $3 }
       | '-' ExpNum               { Neg $2 }
       | IntAux '+' LValue        { Sum $1 (LNum $3) }
       | IntAux '-' LValue        { Sub $1 (LNum $3) }
       | IntAux '*' LValue        { Mul $1 (LNum $3) }
       | IntAux '^' LValue        { Pow $1 (LNum $3) }
       | IntAux '//' LValue       { Div $1 (LNum $3) }
       | IntAux '%' LValue        { Mod $1 (LNum $3) }
       | '-' LValue               { Neg (LNum $2) }
       | '(' ExpNum ')'           { $2 }

IntAux : int                      { IntLit (fst $1) }
       | float                    { FloLit (fst $1) }
       | LValue                   { LNum $1 }
       | '(' ExpNum ')'           { $2 }

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
      | Int ExpNum
      deriving Show

data Slice
      = ManyAc Slice Slice
      | Key String
      | Index ExpNum
      | Interval ExpNum ExpNum
      | Begin ExpNum
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

data ExpNum
      = IntLit Int
      | FloLit Float
      | LNum LValue
      | Sum ExpNum ExpNum
      | Sub ExpNum ExpNum
      | Mul ExpNum ExpNum
      | Pow ExpNum ExpNum
      | Div ExpNum ExpNum
      | Mod ExpNum ExpNum
      | Neg ExpNum
      deriving Show

gato f = do
  s <- readFile(f)
  return( partition (not.isError) (alexScanTokens s) )


main = gato "test.mn"
}