{
module Parser where
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
      yield           { TkYield $$ }
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
%right '^'
%left '~'
%left ',' ';' '.'
%left '[' '(' '{' ']' ')' '}'
%left NEG
%%

S     : space end                     { Root [] [] }
      | space Defs Seq end            { Root $2 $3 }
      | space Defs end                { Root $2 [] }
      | space Seq end                 { Root [] $2 }

Defs : DefsAux                        { reverse $1 }

DefsAux : DefsAux Func                { $2 : $1 }
        | Func                        { [$1] }

Func  : comet id '(' Params ')' '->' Type '{' Seq '}'     { Func (fst $2) $4 $7 $9 }
      | satellite id '(' Params ')' '->' Type '{' Seq '}' { Iter (fst $2) $4 $7 $9 }
      | ufo id '{' Regs '}'                               { DUFO (fst $2) $4 }
      | galaxy id '{' Regs '}'                            { DGalaxy (fst $2) $4 }

Regs : RegsAux                                            { reverse $1 }
     | RegsAux ';'                                        { reverse $1 }

RegsAux   : RegsAux ';' Type id                           { ($3, fst $4) : $1 }
          | Type id                                       { [($1, fst $2)] }

Seq   : SeqA                { reverse $1 }
      | SeqA ';'            { reverse $1 }

SeqA   : Instr              { [$1] }
       | SeqA ';' Instr     { $3 : $1 }

Instr : Type id            { Declar $1 (fst $2) }
      | Type id '=' Exp    { DeclarI $1 (fst $2) $4 }
      | Exp                { Flotando $1 }
      | LValue '=' Exp     { Asig $1 $3 }
      | LValue '+=' Exp    { Asig $1 (Sum $1 $3) }
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
      | return             { Returnsito }
      | yield Exp          { Yield $2 }
      | InstrB             { $1 }

InstrB : If                                                 { $1 }
       | While                                              { $1 }
       | orbit id around Exp '{' Seq '}'                    { Foreach (fst $2) $4 $6 }
       | orbit id around range '(' Exp ',' Exp ',' Exp ')'  { ForRange $6 $8 $10 }
       | orbit id around range '(' Exp ',' Exp ')'          { ForRange $6 $8 (IntLit 1)}
       | orbit id around range '(' Exp ')'                  { ForRange (IntLit 0) $6 (IntLit 1)}

If : if '(' Exp ')' '{' Seq '}'                           { If [($3, $6)] }
   | unless '(' Exp ')' '{' Seq '}'                       { If [(Not $3, $6)] }
   | if '(' Exp ')' '{' Seq '}' Elif                      { If (($3, $6) : $8) }

Elif : elseif '(' Exp ')' '{' Seq '}'                     { [($3, $6)] }
     | else  '{' Seq '}'                                  { [(Full, $3)] }
     | elseif '(' Exp ')' '{' Seq '}' Elif                { ($3, $6) : $8 }

While : orbit while '(' Exp ')' '{' Seq '}'               { While $4 $7 }
      | orbit until '(' Exp ')' '{' Seq '}'               { While (Not $4) $7}
      | orbit '(' Instr ';' Exp ';' Instr ')' '{' Seq '}' { While $5 ($3 : $10 ++ [$7]) }

Params : ParamsAux                                        { reverse $1 }
       |                                                  { [] }

ParamsAux : ParamsAux ',' Type id                         { ($3, fst $4, False) : $1 }
          | Type id                                       { [($1, fst $2, False)] }
          | ParamsAux ',' Type '@' id                     { ($3, fst $5, True) : $1 }
          | Type '@' id                                   { [($1, fst $3, True)] }

Type  : planet                    { Planet }
      | cloud                     { Cloud }
      | star                      { Star }
      | moon                      { Moon }
      | blackhole                 { Blackhole }
      | constellation             { Cluster Star }
      | TComp                     { $1 }

Types : TypesAux                  { reverse $1 }

TypesAux : Type                   { [$1] }
         | TypesAux ',' Type      { $3 : $1 }

TComp : '[' Type ']' cluster      { Cluster $2 }
      | '[' Type ']' quasar       { Quasar $2 }
      | '[' Type ']' nebula       { Nebula $2 }
      | '[' Type ']' satellite    { Satellite $2 }
      | '~' Type                  { Pointer $2 }
      | id galaxy                 { Galaxy (fst $1) }
      | id ufo                    { UFO (fst $1) }
      | '(' Types '->' Type ')'   { Comet $2 $4 }

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
    | terraform '(' Exp ')'       { Terraform $3 }

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

Funcall  : Exp '(' Args ')'    { Funcall $1 $3 }

Args : ArgsAux                       { reverse $1 }
     |                               { [] }

ArgsAux  : ArgsAux ',' Exp           { $3 : $1 }
         | Exp                       { [$1] }

DictItems : Exp ':' Exp ',' DictItems           { ($1, $3) : $5 }
           | Exp ':' Exp                        { [($1, $3)] }

{
parseError :: [Token] -> a
parseError (x:_) = error $ "Error de sintaxis en la línea " ++ (show n) ++ " columna " ++ (show m)
                   where (AlexPn _ n m) = getPos x


midny = midnight.alexScanTokens

data Program
      = Root [Def] [Instr] 
      deriving Show

data Def
      = Func String [(Type, String, Bool)] Type [Instr]
      | Iter String [(Type, String, Bool)] Type [Instr]
      | DUFO String [(Type, String)]
      | DGalaxy String [(Type, String)]
      deriving Show

data Instr 
      = Flotando Exp
      | Declar Type String
      | DeclarI Type String Exp
      | Asig Exp Exp
      | If [(Exp, [Instr])]
      | While Exp [Instr]
      | Foreach String Exp [Instr]
      | ForRange Exp Exp Exp
      | Break Exp
      | Continue
      | Return Exp
      | Returnsito
      | Yield Exp
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

data Slice
      = Index Exp
      | Interval Exp Exp
      | Begin Exp
      deriving Show

data Exp
      = Funcall Exp [Exp]
      -- LValues
      | Var String
      | Access Exp Slice
      | Attr Exp String
      -- funciones de preludio
      | Print [Exp]
      | Read
      | Bigbang
      | Scale Exp
      | Pop Exp [Exp]
      | Add Exp [Exp]
      | Terraform Exp

      | Desref Exp
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
  s <- getTokens f
  return( midnight s )


main = gato "test.mn"
}