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
%nonassoc '.' '[' ']' '(' ')' ','
%nonassoc add pop print read
%left NEG
%%

S     : space end          { Root [] }
      | space Seq end      { Root $2 }

Seq   : Instr              { [$1] }
      | Instr ';'          { [$1] }
      | Instr ';' Seq      { $1 : $3 }

Instr : Type id            { Declar $1 (fst $2) }
      | Type id '=' Exp    { DeclarI $1 (fst $2) $4 }
      | Exp                { Flotando $1 }
      | LValue '=' Exp     { Asig $1 $3 }
      | LValue '+=' Exp    { Asig $1 (Sum (Lval $1) $3) }
      | LValue '-=' Exp    { Asig $1 (Sub (Lval $1) $3) }
      | LValue '*=' Exp    { Asig $1 (Mul (Lval $1) $3) }
      | LValue '/=' Exp    { Asig $1 (Div (Lval $1) $3) }
      | LValue '//=' Exp   { Asig $1 (DivE (Lval $1) $3) }
      | LValue '%=' Exp    { Asig $1 (Mod (Lval $1) $3) }
      | LValue '^=' Exp    { Asig $1 (Pow (Lval $1) $3) }
      | If                 { $1 }
      | While              { $1 }
      | orbit id around Exp '{' Seq '}'                    { Foreach (fst $2) $4 $6 }
      | orbit id around range '(' Exp ',' Exp ',' Exp ')'  { ForRange $6 $8 $10 }
      | orbit id around range '(' Exp ',' Exp ')'          { ForRange $6 $8 (IntLit 1)}
      | orbit id around range '(' Exp ')'                  { ForRange (IntLit 0) $6 (IntLit 1)}
      | break              { Break (IntLit 1) }
      | break Exp          { Break $2 }
      | continue           { Continue }
      | Func               {  }
      | return Exp         { Return $2 } 
      | return             { Returnsito } 

If : if '(' Exp ')' '{' Seq '}'                           { If [($3, $6)] }
   | unless '(' Exp ')' '{' Seq '}'                       { If [(Not $3, $6)] }
   | if '(' Exp ')' '{' Seq '}' Elif                      { If (($3, $6) : $8) }

Elif : elseif '(' Exp ')' '{' Seq '}'                     { [($3, $6)] }
     | else  '{' Seq '}'                                  { [(Full, $3)] }
     | elseif '(' Exp ')' '{' Seq '}' Elif                { ($3, $6) : $8 }

While : orbit while '(' Exp ')' '{' Seq '}'               { While $4 $7 }
      | orbit until '(' Exp ')' '{' Seq '}'               { While (Not $4) $7}
      | orbit '(' Instr ';' Exp ';' Instr ')' '{' Seq '}' { While $5 ($3 : $10 ++ [$7]) }

Func  : comet id '(' Params ')' '{' Seq '}'               { Func $2 $4 $7 }
      | comet id '(' ')' '{' Seq '}'                      { Func $2 [] $6 }
      | satellite id '(' Params ')' '{' Seq '}'           { Func $2 $4 $7 }
      | satellite id '(' ')' '{' Seq '}'                  { Func $2 [] $6 }

Params : Type Exp ',' Params         { ($1, $2, False) : $4 }
       | Type Exp                    { [($1, $2, False)] }
       | Type '@' Exp ',' Params     { ($1, $3, True) : $5 }
       | Type '@' Exp                { [($1, True)] }

Type  : planet          { Planet }
      | cloud           { Cloud }
      | star            { Star }
      | moon            { Moon }
      | blackhole       { Blackhole }
      | constellation   { Cluster Star }
      | TComp           { $1 }

Types : Type            { [$1] }
      | Type ',' Types  { $1 : $3 }

TComp : '[' Type ']' cluster      { Cluster $2 }
      | '[' Type ']' quasar       { Quasar $2 }
      | '[' Type ']' nebula       { Nebula $2 }
      | '[' Type ']' satellite    { Satellite $2 }
      | '~' Type                  { Pointer $2 }
      | galaxy id                 { Galaxy (fst $2) }
      | ufo id                    { UFO (fst $2) }
      | '(' Types '->' Type ')'   { Comet $2 $4 }

LValue : id                      { Var (fst $1) }
       | LValue '.' id           { Attr $1 (fst $3) }
       | LValue Slice            { Access $1 $2 }

Exp : '(' Exp ')'                 { $2 }
    | Funcall                     { $1 }
    | print '(' Args ')'          { Print $3 }
    | read '(' ')'                { Read }
    | bigbang '(' ')'             { Bigbang }
    | scale '(' Exp ')'           { Scale $3 }
    | terraform '(' Exp ')'       { Terraform $3 }

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
    | '[' Args ']'                { ListLit $2 }
    | '{' Args '}'                { ArrLit $2 }
    | cluster '(' Exp ')' Type    { ArrInit $3 $5 }
    | '{' DictItems '}'           { DictLit $2 }


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

Args  : Exp ',' Args              { $1 : $3 }
      | Exp                       { [$1] }

DictItems : Exp ':' Exp ',' DictItems           { ($1, $3) : $5 }
           | Exp ':' Exp                        { [($1, $3)] }

{
parseError :: [Token] -> a
parseError _ = error "Parse error"

midny = midnight.alexScanTokens

data Program
      = Root [Instr] 
      deriving Show

data Instr 
      = Flotando Exp
      | Declar Type String
      | DeclarI Type String Exp
      | Asig LValue Exp
      | If [(Exp, [Instr])]
      | While Exp [Instr]
      | Foreach String Exp [Instr]
      | ForRange Exp Exp Exp
      | Break Exp
      | Continue
      | Return Exp
      | Returnsito
      deriving Show

data Type
      = Planet
      | Cloud
      | Star
      | Moon
      | Blackhole
      | Cluster Type
      | Quasar Type
      | Nebula Type
      | Pointer Type
      | Satellite Type
      | Galaxy String
      | UFO String
      | Comet [Type] Type
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
      | Print [Exp]
      | Read
      | Bigbang
      | Scale Exp
      | Terraform Exp

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
      | ArrLit [Exp]
      | ArrInit Exp Type
      | ListLit [Exp]
      | DictLit [(Exp, Exp)]
      deriving Show

gato f = do
  s <- readFile(f)
  return( midnight $ filter (not.isError) (alexScanTokens s) )


main = gato "test.mn"
}