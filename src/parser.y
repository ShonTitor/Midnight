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
      '@'             { TkArroba      $$ }
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
%nonassoc '^'
%nonassoc '.' '[' ']' ','
%left NEG
%%

S     : space end       { Root [] }
      | space Seq end   { Root $2 }

Seq   : Instr           { [$1] }
      | Instr ';'       { [$1] }
      | Instr ';' Seq   { $1 : $3 }

Instr : Declar             { $1 }
      | LValue '=' Exp     { Asig $1 $3 }
      | LValue '+=' Exp    { Asig $1 (Sum (Lval $1) $3) }
      | LValue '-=' Exp    { Asig $1 (Sub (Lval $1) $3) }
      | LValue '*=' Exp    { Asig $1 (Mul (Lval $1) $3) }
      | LValue '/=' Exp    { Asig $1 (Div (Lval $1) $3) }
      | LValue '//=' Exp   { Asig $1 (DivE (Lval $1) $3) }
      | LValue '%=' Exp    { Asig $1 (Mod (Lval $1) $3) }
      | LValue '^=' Exp    { Asig $1 (Pow (Lval $1) $3) }
      | If                 { $1 }

If : if '(' Exp ')' '{' Seq '}'                           { If [($3, $6)] }
   | unless '(' Exp ')' '{' Seq '}'                       { If [(Not $3, $6)] }
   | if '(' Exp ')' '{' Seq '}' Elif                      { If (($3, $6) : $8) }

Elif : elseif '(' Exp ')' '{' Seq '}'                     { [($3, $6)] }
     | else  '{' Seq '}'                                  { [(Full, $3)] }
     | elseif '(' Exp ')' '{' Seq '}' Elif                { ($3, $6) : $8 }

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

LValue : id                      { Var (fst $1) }
       | LValue '.' id           { Attr $1 (fst $3) }
       | LValue Slice            { Access $1 $2 }
       | '(' LValue ')'          { $2 }

Exp : Funcall                     { $1 }
    | LValue                      { Lval $1 }
    | int                         { IntLit (fst $1) }
    | float                       { FloLit (fst $1) }
    | Exp '+' Exp                 { Sum $1 $3 }
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
    | new                         { New }
    | full                        { Full }
    | Exp '&&' Exp                { And $1 $3 }
    | Exp '&' Exp                 { Bitand $1 $3 }
    | Exp '||' Exp                { Or $1 $3 }
    | Exp '|' Exp                 { Bitor $1 $3 }
    | '¬' Exp                     { Not $2 }
    | str                         { StrLit (fst $1) }
    | chr                         { CharLit (fst $1) }

Slice : '[' Exp ']'                      { Index $2 }
      | '[' Exp ']' Slice                { ManyAc (Index $2) $4 }
      | '[' Exp '..' Exp ']'             { Interval $2 $4 }
      | '[' Exp '..' Exp ']' Slice       { ManyAc (Interval $2 $4) $6 }
      | '[' '..' Exp ']'                 { Interval (IntLit 0) $3 }
      | '[' '..' Exp ']' Slice           { ManyAc (Interval (IntLit 0) $3) $5 }
      | '[' Exp '..' ']'                 { Begin $2 }
      | '[' Exp '..' ']' Slice           { ManyAc (Begin $2) $5 }

Funcall  : LValue '(' Args ')'    { Funcall $1 $3 }
         | LValue '(' ')'         { Funcall $1 [] }

Args  : Exp ',' Args           { $1 : $3 }
      | Exp                    { [$1] }

Params : Type Exp ',' Params           { ($1, $2, False) : $4 }
       | Type Exp                    { [($1, $2, False)] }
       | Type '@' Exp ',' Params       { ($1, $3, True) : $5 }
       | Type '@' Exp                { [($1, True)] }

{
parseError :: [Token] -> a
parseError _ = error "Parse error"

midny = midnight.alexScanTokens

data Program
      = Root [Instr] 
      deriving Show

data Instr 
      = Perro String
      | Declar Type String
      | Asig LValue Exp
      | If [(Exp, [Instr])]
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

data Slice
      = ManyAc Slice Slice
      | Key String
      | Index Exp
      | Interval Exp Exp
      | Begin Exp
      deriving Show

data Exp
      = Funcall LValue [Exp]
      | Lval LValue
      | LBool Exp
      -- Numericas
      | IntLit Int
      | FloLit Float
      | Sum Exp Exp
      | Sub Exp Exp
      | Mul Exp Exp
      | Pow Exp Exp
      | Div Exp Exp
      | DivE Exp Exp
      | Mod Exp Exp
      | Neg Exp
      -- Comparaciones
      | Eq Exp Exp
      | Neq Exp Exp
      | Mayor Exp Exp
      | MayorI Exp Exp
      | Menor Exp Exp
      | MenorI Exp Exp
      -- Bool
      | New
      | Full
      | And Exp Exp
      | Bitand Exp Exp
      | Or Exp Exp
      | Bitor Exp Exp
      | Not Exp
      -- Otros
      | StrLit String
      | CharLit Char
      deriving Show

gato f = do
  s <- readFile(f)
  return( midnight $ filter (not.isError) (alexScanTokens s) )


main = gato "test.mn"
}