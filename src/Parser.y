{
module Parser where
import Data.Char
import Data.List
import Lexer
import Tablon
import Tipos
import Preparser (preparser)
import Control.Monad.RWS
import Data.Maybe (isNothing, fromJust)
import qualified Data.Map as Map
}

%name parser
%tokentype { Token }
%error { parseError }
%monad { MonadTablon }

%token 
      space           { TkSpace     $$ }
      end             { TkEndofSpace $$ }
      moon            { TkMoon      $$ }
      planet          { TkPlanet    $$ }
      cloud           { TkCloud     $$ }
      star            { TkStar      $$ }
      vacuum          { TkVacuum    $$ }
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

S :: { Program } : Push2 Programa Pop2  { $2 }

Programa :: { Program }    
      : space END                     { % return $ Root [] }
      | space Defs Seq END            { % return $ Root $3 }
      | space Defs END                { % return $ Root [] }
      | space Seq END                 { % return $ Root $2 }

Defs : DefsAux                        { reverse $1 }

DefsAux : DefsAux Func                { $2 : $1 }
        | Func                        { [$1] }

FunSig : comet id Params '->' Type
        { % do
          (tablonActual, pila, n, b, _, off, oof) <- get
          put (tablonActual, pila, n, b, Just (True, $5), off, oof)
          insertarParams $3
          return $ fst $2
        }
       | satellite id Params '->' Type
        { % do
          (tablonActual, pila, n, b, _, off, oof) <- get
          put (tablonActual, pila, n, b, Just (False, $5), off, oof)
          insertarParams $3
          return $ fst $2
        }

Func  :: { () }
      : FunSig '{' Seq LQC Pop2 
        { % do 
          checkCierre $4 "{" $2
          actualizarSubrutina $1 $3 
          (tablonActual, pila, n, b, _, off, oof) <- get
          put (tablonActual, pila, n, b, Nothing, off, oof)}
          --let d = Func (fst $2) $4 $7 $9
          --insertarSubrutina (d, snd $2) }
      | RegSig '{' Regs Pop LQC    { % checkCierre $5 "{" $2 }


RegSig : ufo id                              { () -- % insertarReg $2 (fst $1) }
       | galaxy id                           { () -- % insertarReg $2 (fst $1) }

Regs : Push2 RegsAux    
      { % do
          let rex = reverse $2
          --insertarCampos rex
          return (rex) }
     | Push2 RegsAux ';'                                             
     { % do
          let rex = reverse $2
          --insertarCampos rex
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
          entry <- insertarVar $2 $1
          let AlexPn _ m n = $3
              t1 = $1
              exp = $4
          rval <- checkAsig $3 t1 exp
          return $ Asig (Var (fst $2) entry, $1) rval
      }
       | Exp                { Flotando $1 }
       | LValue '=' Exp     
       { % do 
          let AlexPn _ m n = $2
              exp = $3
              t1 = snd $1
          rval <- checkAsig $2 t1 exp
          return $ Asig $1 rval }
       | LValue '+=' Exp    
       { % do
          (a,b) <- checkNum ("+=", $2) $1 $3
          let AlexPn _ m n = $2
              inst = Asig $1 $3
              t1 = snd $1
              t2 = snd a
          if t1 == t2 && t2 /= Err then return $ Asig $1 (Suma a b, t2)
          else do
            printError m n ("Error de tipo: Se esperaba "++(show t1)++", se encontró "++(show t2))
            return $ Asig $1 (Suma a b, Err)
       }
       | LValue '-=' Exp
       { % do
          (a,b) <- checkNum ("-=", $2) $1 $3
          let AlexPn _ m n = $2
              inst = Asig $1 $3
              t1 = snd $1
              t2 = snd a
          if t1 == t2 && t2 /= Err then return $ Asig $1 (Sub a b, t2)
          else do
            printError m n ("Error de tipo: Se esperaba "++(show t1)++", se encontró "++(show t2))
            return $ Asig $1 (Sub a b, Err)
       }
       | LValue '*=' Exp
       { % do
          (a,b) <- checkNum ("*=", $2) $1 $3
          let AlexPn _ m n = $2
              inst = Asig $1 $3
              t1 = snd $1
              t2 = snd a
          if t1 == t2 && t2 /= Err then return $ Asig $1 (Mul a b, t2)
          else do
            printError m n ("Error de tipo: Se esperaba "++(show t1)++", se encontró "++(show t2))
            return $ Asig $1 (Mul a b, Err)
       }
       | LValue '/=' Exp
       { % do
          (a,b) <- checkNum ("/=", $2) $1 $3
          let AlexPn _ m n = $2
              inst = Asig $1 $3
              t1 = snd $1
              t2 = snd a
          if t1 == t2 && t2 /= Err then return $ Asig $1 (Div a b, t2)
          else do
            printError m n ("Error de tipo: Se esperaba "++(show t1)++", se encontró "++(show t2))
            return $ Asig $1 (Div a b, Err)
       }
       | LValue '^=' Exp
       { % do
          (a,b) <- checkNum ("^=", $2) $1 $3
          let AlexPn _ m n = $2
              inst = Asig $1 $3
              t1 = snd $1
              t2 = snd a
          if t1 == t2 && t2 /= Err then return $ Asig $1 (Pow a b, t2)
          else do
            printError m n ("Error de tipo: Se esperaba "++(show t1)++", se encontró "++(show t2))
            return $ Asig $1 (Pow a b, Err)
       }
       | LValue '//=' Exp   
       { % do
        (a,b) <- checkInt ("//=", $2) $1 $3
        return $ Asig $1 (DivE a b, snd a)  }
       | LValue '%=' Exp
       { % do
        (a,b) <- checkInt ("%=", $2) $1 $3
        return $ Asig $1 (Mod a b, snd a) }
       | break              { Break (IntLit 1, Simple "planet") }
       | break Exp          { % do 
                              checkInt' $1 (snd $2)
                              return $ Break $2 }
       | continue           { Continue }
       | return Exp         { % do
                              (_,_,_,_,tipo,_,_) <- get
                              let AlexPn _ m n = $1
                                  (exp, _) = $2
                              if isNothing tipo then do
                                printError m n ("Error: return fuera de una subrutina")
                                return $ Return (exp, Err)
                              else do
                                let (b, t) = fromJust tipo
                                if not b then do
                                  printError m n ("Error: return fuera de una subrutina")
                                  return $ Return (exp, Err)
                                else do
                                  desu <- checkAsig $1 t $2
                                  return $ Return desu}
       | return             { % do
                              (_,_,_,_,tipo,_,_) <- get
                              let AlexPn _ m n = $1
                                  exp = Var "vac" (Entry (Simple "vacuum") Literal 0 (-1))
                              if isNothing tipo then do
                                printError m n ("Error: return fuera de una subrutina")
                                return $ Return (exp, Err)
                              else do
                                let (b, t) = fromJust tipo
                                if not b then do
                                  printError m n ("Error: return fuera de una subrutina")
                                  return $ Return (exp, Err)
                                else do
                                  desu <- checkAsig $1 t (exp, Simple "vacuum")
                                  return $ Return desu }
       | yield Exp          { % do
                              (_,_,_,_,tipo,_,_) <- get
                              let AlexPn _ m n = $1
                                  (exp, _) = $2
                              if isNothing tipo then do
                                printError m n ("Error: yield fuera de un iterador")
                                return $ Yield  (exp, Err)
                              else do
                                let (b, t) = fromJust tipo
                                if b then do
                                  printError m n ("Error: yield fuera de un iterador")
                                  return $ Yield  (exp, Err)
                                else do
                                  desu <- checkAsig $1 t $2
                                  return $ Yield desu }

InstrB : Push If                                                             { $2 }
       | Push While                                                          { $2 }
       | IterHead '{' Seq LQC                                                
       { % do 
         checkCierre $4 "{" $2
         return $ $1 $3 }
       | Push orbit '(' Instr ';' Exp ';' Instr PQC '{' SeqAux2 LQC          
        {  % do
            checkCierre $9 "(" $3
            checkCierre $12 "{" $10
            checkBool' $5 (snd $6)
            n <- currentScope
            return $ ForC $4 $6 $8 (reverse $11) n }

IterHead : Push orbit id AROUND Exp
          { % do
            let AlexPn _ a b = snd $3
            if not $4 then do printError a b ("Error de sintaxis: Falta la palabra clave around")
            else return ()
            let f (Composite "Quasar" t) = t
                f (Subroutine "Satellite" _ t) = t
                f _ = Err
                t1 = snd $5
                t2 = f t1
                AlexPn _ m n = $2
            if t1 /= Err && t2 == Err then
              printError m n ("Error de tipo: El tipo  "++(show t1)++" no es iterable")
            else return ()
            entry <- insertarVar $3 t2
            sc <- currentScope
            let f' seq = Foreach (Var (fst $3) entry, getTipo (Just entry)) $5 seq sc
            return f' }
         | Push orbit id AROUND range '(' Exp ',' Exp ',' Exp PQC
           { % do
             checkCierre $12 "(" $6
             entry <- insertarVar $3 (Simple "planet")
             checkInt' $6 (snd $7)
             checkInt' $8 (snd $9)
             checkInt' $10 (snd $11)
             sc <- currentScope
             let f seq = ForRange (Var (fst $3) entry, getTipo (Just entry)) $7 $9 $11 seq sc
             return f }
         | Push orbit id AROUND range '(' Exp ',' Exp PQC
           { % do
             checkCierre $10 "(" $6
             entry <- insertarVar $3 (Simple "planet")
             checkInt' $6 (snd $7)
             checkInt' $8 (snd $9)
             sc <- currentScope
             let f seq = ForRange (Var (fst $3) entry, getTipo (Just entry)) $7 $9 (IntLit 1, Simple "planet") seq sc
             return f }
         | Push orbit id AROUND range '(' Exp PQC
           { % do
             checkCierre $8 "(" $6
             entry <- insertarVar $3 (Simple "planet")
             checkInt' $6 (snd $7)
             sc <- currentScope
             let f seq = ForRange (Var (fst $3) entry, getTipo (Just entry)) (IntLit 0, Simple "planet") $7 (IntLit 1, Simple "planet") seq sc
             return f }

If : if '(' Exp PQC '{' Seq LQC                           
    { % do
      checkCierre $4 "(" $2
      checkCierre $7 "{" $5
      checkBool' $2 (snd $3)
      n <- currentScope
      return $ If [($3, $6, n)] }
   | unless '(' Exp PQC '{' Seq LQC                       
   {  % do
      checkCierre $4 "(" $2
      checkCierre $7 "{" $5
      checkBool' $2 (snd $3)
      n <- currentScope
      return $ If [((Not $3, Err), $6, n)] }
   | if '(' Exp PQC '{' Seq LQC Push Elif
   {  % do
      checkCierre $4 "(" $2
      checkCierre $7 "{" $5
      checkBool' $2 (snd $3)
      n <- currentScope
      return $ If (($3, $6, n) : $9) }

ElifAux : elseif '(' Exp PQC '{' Seq LQC Pop
        {  % do
         checkCierre $4 "(" $2
         checkCierre $7 "{" $5
         checkBool' $2 (snd $3)
         n <- currentScope
         return [($3, $6, n)] }
        | Elif Push elseif '(' Exp PQC '{' Seq LQC Pop
        {  % do
         checkCierre $6 "(" $4
         checkCierre $9 "{" $7
         checkBool' $4 (snd $5)
         n <- currentScope
         return $ ($5, $8, n) : $1 }
 
Elif : ElifAux                                         { reverse $1 }
     | ElifAux Push else  '{' Seq LQC Pop              
     {  % do
        checkCierre $6 "{" $4
        n <- currentScope
        return $ reverse $ ((Var "full" (Entry (Simple "moon") Literal 0 (-1)), Simple "bool"), $5, n) :  $1 }
     | else  '{' Seq LQC Pop                           
     {  % do
        checkCierre $4 "{" $2
        n <- currentScope
        return [((Var "full" (Entry (Simple "moon") Literal 0 (-1)), Simple "bool"), $3, n)] }



While : orbit while '(' Exp PQC '{' Seq LQC
   {  % do
      checkCierre $5 "(" $3
      checkCierre $8 "{" $6
      checkBool' $3 (snd $4)
      n <- currentScope
      return $ While $4 $7 n }
      | orbit until '(' Exp PQC '{' Seq LQC
   {  % do
      checkCierre $5 "(" $3
      checkCierre $8 "{" $6
      checkBool' $3 (snd $4)
      n <- currentScope
      return $ While (Not $4, Err) $7 n }


Params : Push2 '(' ParamsAux PQC                                   
         { % do 
           checkCierre $4 "(" $2
           let params = reverse $3
           --insertarParams params 
           return params }
       | Push '(' PQC                                          
        { % do
          checkCierre $3 "(" $2
          return [] }

ParamsAux : ParamsAux ',' Type id                         { ($3, $4, False) : $1 }
          | Type id                                       { [($1, $2, False)] }
          | ParamsAux ',' Type '@' id                     { ($3, $5, True) : $1 }
          | Type '@' id                                   { [($1, $3, True)] }

Type  : planet                    { Simple $ fst $1 }
      | cloud                     { Simple $ fst $1 }
      | star                      { Simple $ fst $1 }
      | moon                      { Simple $ fst $1 }
      | vacuum                    { Simple $ fst $1 }
      | constellation             { Composite "Cluster" (Simple "star") }
      | TComp                     { $1 }

Types : TypesAux                  { reverse $1 }

TypesAux : Type                   { [$1] }
         | TypesAux ',' Type      { $3 : $1 }

TComp : '[' Type CQC cluster      
      { % do
        checkCierre $3 "[" $1
        return $ Composite (fst $4) $2 }
      | '[' Type CQC quasar       
      { % do
        checkCierre $3 "[" $1
        return $ Composite (fst $4) $2 }
      | '[' Type CQC nebula
      { % do
        checkCierre $3 "[" $1
        return $ Composite (fst $4) $2 }
      | '~' Type                  { Composite (fst $1) $2 }
      | id galaxy                 { % do
                                      entry <- lookupExists $1
                                      if isNothing entry then return Err
                                      else do
                                          let f (Registro t _) = t
                                              f _ = Err
                                              (Entry _ kt _ _) = fromJust entry
                                              AlexPn _ m n = snd $1
                                          if (f kt) == Err then do
                                            printError m n ("Error de tipo: "++(show $ fst $1)++" no es un Galaxy")
                                            return Err
                                          else return $ f kt }
      | id ufo                    { % do
                                      entry <- lookupExists $1
                                      if isNothing entry then return Err
                                      else do
                                          let f (Registro t _) = t
                                              f _ = Err
                                              (Entry _ kt _ _) = fromJust entry
                                              AlexPn _ m n = snd $1
                                          if (f kt) == Err then do
                                            printError m n ("Error de tipo: "++(show $ fst $1)++" no es un UFO")
                                            return Err
                                          else return $ f kt }
      | '(' Types '->' Type PQC comet      
      { % do
        checkCierre $5 "(" $1
        return $ Subroutine (fst $6) $2 $4 }
      | '(' Types '->' Type PQC satellite  
      { % do
        checkCierre $5 "(" $1
        return $ Subroutine (fst $6) $2 $4 }

LValue :: { Exp }
      : id                       { % do
                                    e <- lookupExists $1
                                    if isNothing e then
                                      return (Var (fst $1) (Entry Err Variable (-1) (-1)), getTipo e)
                                    else
                                      return (Var (fst $1) (fromJust e), getTipo e) }
       | Exp '.' id               { %do 
                                    let isRecord (Record _ _ _) = True
                                        isRecord _ = False
                                        getR (Record _ r _) = r
                                        getS (Entry _ (Registro _ sc) _ _) = [sc]
                                        getS _ = []
                                        t1 = snd $1
                                        AlexPn _ m n = $2
                                        errentry = Entry Err Variable (-1) (-1)
                                    if isRecord t1 then do
                                        e1 <- lookupScope (getR t1) [1]
                                        if isNothing e1 then return (Attr $1 (fst $3, errentry), Err)
                                        else do
                                          e2 <- lookupScope (fst $3) (getS $ fromJust e1)
                                          if isNothing e2 then do
                                            printError m n ("Error de tipo: "++(show t1)++" no tiene un atributo "++(show $ fst $3))
                                            return (Attr $1 (fst $3, errentry), Err)
                                          else return (Attr $1 (fst $3, fromJust e2), getTipo e2)
                                    else if t1 == Err then return (Attr $1 (fst $3, errentry), Err)
                                    else do 
                                        printError m n ("Error de tipo: "++(show t1)++" no tiene un atributo "++(show $ fst $3))
                                        return (Attr $1 (fst $3, errentry), Err) }
       | Exp '[' Index            { % do
                                    let exp = Access $1 $3
                                        t1 = snd $1
                                        Index t2' = $3
                                        t2 = snd t2'
                                        isCom (Composite t _) = elem t ["Cluster", "Quasar", "Nebula"]
                                        isCom _ = False
                                        f (Composite _ t) = t
                                        f _ = NA
                                        g (Composite s _) = s
                                        g _ = ""
                                        AlexPn _ m n = $2
                                    if t1 == Err || t2 == Err || (f t1) == Err then
                                        return (exp, Err) 
                                    else if (not.isCom) t1 then do
                                        printError m n ("Error de tipo: "++(show t1)++" no es indexable ")
                                        return (exp, Err)
                                    else if (g t1) == "Nebula" && t2 /= (Composite "Cluster" (Simple "star")) then do
                                        printError m n ("Error de tipo: Nebula acepta claves de tipo Constellation, no "++(show t2))
                                        return (exp, Err)
                                    else if ((g t1) == "Cluster" || (g t1) == "Quasar") && t2 /= (Simple "planet") then do
                                        printError m n ("Error de tipo: Los índices deben ser enteros, no "++(show t2))
                                        return (exp, Err)
                                    else return (exp, f t1)
                                    }
    | '~' Exp                     { % do
                                    let exp = Desref $2
                                    if (snd $2) == Err then return (exp, Err)
                                    else do
                                        let f (Composite "~" tipo) = tipo
                                            f _ = Err
                                            t = f (snd $2)
                                            AlexPn _ m n = snd $1
                                        if t == Err then do
                                            printError m n ("No se puede desreferenciar el tipo " ++ (show $ snd $2))
                                            return (exp, Err)
                                        else return (exp, t) }



Index :     Exp CQC               
          { % do
            if $2 then return ()
            else lift $ putStrLn("Error de sintaxis: parece que le falto un corchete buen hombre.")
            return $ Index $1 }


Slice :     Exp '..' Exp CQC      { % do
                                    if $4 then return ()
                                    else lift $ putStrLn("Error de sintaxis: parece que le falto un corchete buen hombre.")
                                    let exp = Interval $1 $3
                                        t1 = snd $1
                                        t2 = snd $3
                                        AlexPn _ m n = $2
                                    if t1 == Err && t2 == Err then return exp
                                    else do
                                        if t1 /= (Simple "planet") && t2 /= (Simple "planet") then do
                                            printError m n ("Error de tipo: Los límites de slices deben ser enteros, no "++(show t1))
                                            printError m n ("Error de tipo: Los límites de slices deben ser enteros, no "++(show t2))
                                            return $ Interval (fst $1, Err) (fst $3, Err)
                                        else if t1 /= (Simple "planet") then do
                                            printError m n ("Error de tipo: Los límites de slices deben ser enteros, no "++(show t1))
                                            return $ Interval (fst $1, Err) $3
                                        else if t2 /= (Simple "planet") then do
                                            printError m n ("Error de tipo: Los límites de slices deben ser enteros, no "++(show t2))
                                            return $ Interval $1 (fst $3, Err)
                                        else return exp
                                     }
      |     '..' Exp CQC          { % do
                                    if $3 then return ()
                                    else lift $ putStrLn("Error de sintaxis: parece que le falto un corchete buen hombre.")
                                    let exp = Interval e0 $2
                                        e0 = (IntLit 0, Simple "planet")
                                        t = snd $2
                                        AlexPn _ m n = $1
                                    if t == Err then return exp
                                    else if t /= (Simple "planet") then do
                                            printError m n ("Error de tipo: Los límites de slices deben ser enteros, no "++(show t))
                                            return $ Interval e0 (fst $2, Err)
                                    else return exp
                                    }
      |     Exp '..' CQC          { % do
                                    if $3 then return ()
                                    else lift $ putStrLn("Error de sintaxis: parece que le falto un corchete buen hombre.")
                                    let exp = Begin $1
                                        t = snd $1
                                        AlexPn _ m n = $2
                                    if t == Err then return exp
                                    else if t /= (Simple "planet") then do
                                            printError m n ("Error de tipo: Los límites de slices deben ser enteros, no "++(show t))
                                            return $ Begin (fst $1, Err)
                                    else return exp
                                    }

Exp :: { Exp }
    : LValue                      { $1 }
    | '(' Exp PQC                 
      { % do
        checkCierre $3 "(" $1
        return $2 }
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
                                                printError m n ("Error de tipo: El tipo " ++ (show $ snd $1) ++ " no admite slices")
                                                return (exp, Err)
                                            else return (exp, t) }
    | Exp '(' Args PQC            { % do
                                    checkCierre $4 "(" $2
                                    let isSub (Subroutine _ _ _) = True
                                        isSub _ = False
                                        exp = Funcall $1 $3
                                        (_,tas) = unzip $3
                                        AlexPn _ m n = $2
                                    if isSub (snd $1) then do
                                      let (Subroutine st tps rt) = snd $1
                                          t = if st == "Comet" then rt else (snd $1)
                                      if length tas == length tps then do 
                                        let ts = zip tps tas
                                            f :: [(Type, Type)] -> Int -> MonadTablon Bool
                                            f [] _ = return True
                                            f ((t1, t2):xs) k = do
                                              if tipoAsig t1 t2 || (t1 == Simple "cloud" && t2 == Simple "planet") then do
                                                b <- f xs (k+1)
                                                return b
                                              else do 
                                                printError m n ("Error de tipo: Se esperaba "++(show t1)++" se encontró "++(show t2)++
                                                          " en en argumento #"++(show k))
                                                b <- f xs (k+1)
                                                return False
                                            g (tt, (e, ot)) = if ot == Simple "planet" && tt == Simple "cloud" then castCloud (e, ot)
                                                              else (e, ot)
                                            kchicamo = zip tps $3
                                        b <- f ts 1
                                        if b then do
                                          return (Funcall $1 (map g kchicamo), t) 
                                        else return (exp, Err)
                                      else do
                                        printError m n ("Error de tipo: El número de argumentos no coincide con el de parámetros")
                                        return (exp, Err)
                                    else return (exp, Err)
                                  }
    | print '(' Args PQC          
      { % do
        checkCierre $4 "(" $2
        return (Print $3, Composite "Cluster" (Simple "star")) }
    | read '(' PQC                
      { % do
        checkCierre $3 "(" $2
        return (Read, Composite "Cluster" (Simple "star")) }
    | bigbang '(' Type PQC        
      { % do
        checkCierre $4 "(" $2
        return (Bigbang $3, Composite "~" $3) }
    | scale '(' Exp PQC           
      { % do
        let f (Composite "~" _ ) = False
            f (Composite _ _ ) = True
            f Err = True
            f _ = False
            t = snd $3
            AlexPn _ m n = $2
        if f (snd $3) then return ()
        else printError m n ("Error de tipo: esa vaina no tiene longitud "++(show t))

        checkCierre $4 "(" $2
        return (Scale $3, Err)  }
    | Exp '.' pop '(' Args PQC    
      { % do
        checkCierre $6 "(" $4
        return (Funcall $1 $5, Err)  }
    | Exp '.' add '(' Args PQC    
      { % do
        checkCierre $6 "(" $4
        return (Funcall $1 $5, Err)  }

    | int                         { (IntLit (fst $1), Simple "planet") }
    | float                       { (FloLit (fst $1), Simple "cloud") }
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
    | Exp '/' Exp                 { % do
                                    (a,b) <- checkNum ("/", $2) $1 $3
                                    return (Div a b, if snd a == Err then Err else Simple "cloud") }
    | Exp '//' Exp                { % do
                                    (a,b) <- checkInt ("//", $2) $1 $3
                                    return (DivE a b, snd a) }
    | Exp '%' Exp                 { % do
                                    (a,b) <- checkInt ("%", $2) $1 $3
                                    return (Mod a b, snd a) }
    | Exp '^' Exp                 { % do
                                    (a,b) <- checkNum ("^", $2) $1 $3
                                    return (Pow a b, snd a) }
    | '-' Exp         %prec NEG   { %do 
                                    let (exp, t) = $2
                                        AlexPn _ m n = $1
                                    if elem t [Simple "planet", Simple "cloud", Err] then return (Neg $2, t)
                                    else do
                                      printError m n ("Error de tipo: El operador - solo admite los tipos planet y cloud, se encontró "++(show t))
                                      return (Neg $2, Err) }
    | Exp '==' Exp                { % do
                                    (a,b) <- checkSame $2 $1 $3
                                    return (Eq a b, if snd a == Err then Err else Simple "moon") }
    | Exp '¬=' Exp                { % do
                                    (a,b) <- checkSame $2 $1 $3
                                    return (Neq a b, if snd a == Err then Err else Simple "moon") }
    | Exp '>' Exp                 { % do
                                    (a,b) <- checkNum (">", $2) $1 $3
                                    return (Mayor a b, if snd a == Err then Err else (Simple "moon")) }
    | Exp '>=' Exp                { % do
                                    (a,b) <- checkNum (">=", $2) $1 $3
                                    return (MayorI a b, if snd a == Err then Err else Simple "moon") }
    | Exp '<' Exp                 { % do
                                    (a,b) <- checkNum (">", $2) $1 $3
                                    return (Menor a b, if snd a == Err then Err else Simple "moon") }
    | Exp '<=' Exp                { % do
                                    (a,b) <- checkNum ("<=", $2) $1 $3
                                    return (MenorI a b, if snd a == Err then Err else Simple "moon") }
    | Exp '&&' Exp                { % do
                                    (a,b) <- checkBool ("&&", $2) $1 $3
                                    return (And a b, snd a) }
    | Exp '&' Exp                 { % do
                                    (a,b) <- checkBool ("&", $2) $1 $3
                                    return (Bitand a b, snd a) }
    | Exp '||' Exp                { % do
                                    (a,b) <- checkBool ("||", $2) $1 $3
                                    return (Or a b, snd a) }
    | Exp '|' Exp                 { % do
                                    (a,b) <- checkBool ("|", $2) $1 $3
                                    return (Bitor a b, snd a) }
    | '¬' Exp                     { % do
                                    let t = if (snd $2) == Simple "moon" then (snd $2) else Err
                                    checkBool' $1 (snd $2)
                                    return (Not $2, t) }
    | '[' Args CQC                { % do
                                    checkCierre $3 "[" $1
                                    let (_, ts) = unzip $2
                                        exp = ListLit $2
                                        AlexPn _ m n = $1
                                        t = if null ts then IDK else foldl tipoSerio IDK ts
                                    if t == NA then do
                                      printError m n ("Error de tipo: Quasar no homogeneo")
                                      return (exp, Err)
                                    else return (exp, Composite "Quasar" t) }
    | '{' Args LQC                { % do
                                    checkCierre $3 "{" $1
                                    let (_, ts) = unzip $2
                                        exp = ArrLit $2
                                        AlexPn _ m n = $1
                                        t = if null ts then IDK else foldl tipoSerio IDK ts
                                    if t == NA then do
                                      printError m n ("Error de tipo: Cluster no homogeneo")
                                      return (exp, Err)
                                    else return (exp, Composite "Cluster" t) }
    | cluster '(' Exp PQC Type    { % do
                                    checkCierre $4 "(" $2
                                    checkInt' $2 (snd $3)
                                    return(ArrInit $3 $5, Composite "Cluster" $5) }
    | '{' DictItems LQC           { % do
                                    checkCierre $3 "{" $1
                                    let (ks, vs) = unzip $2
                                        (_, tks) = unzip ks
                                        (_, tvs) = unzip vs
                                        exp = DictLit $2
                                        t = if null tvs then IDK else foldl tipoSerio IDK tvs
                                        AlexPn _ m n = $1
                                    if all (\ti -> elem ti [Composite "Cluster" (Simple "star"), Err]) tks then
                                      if t == NA then do
                                        printError m n ("Error de tipo: Nebula no homogenea")
                                        return (exp, Err)
                                      else return (exp, Composite "Nebula" t)
                                    else do
                                      printError m n ("Error de tipo: las claves de Nebula solo pueden ser de tipo Constellation")
                                      return (exp, Err) }


Args : ArgsAux                       { reverse $1 }
     |                               { [] }

ArgsAux  : ArgsAux ',' Exp           { $3 : $1 }
         | Exp                       { [$1] }

DictItems : Exp ':' Exp ',' DictItems           { ($1, $3) : $5 }
           | Exp ':' Exp                        { [($1, $3)] }

PQC : ')' { True } | error { False }
 
CQC : ']' { True } | error { False }
 
LQC : '}' { True } | error { False }

END : end { True } | error { % do printError 0 0 "No se encontró el marcador de final del programa 'EndofSpace'" ; return False }

AROUND : around { True } | error { False }

Pop :: { () }
    :   {- Lambda -}      { % popPila }

Push  ::  { () }
      :   {- Lambda -}    { % pushPila }

Pop2 :: { () }
    :   {- Lambda -}      { % popPila' }

Push2  ::  { () }
      :   {- Lambda -}    { % pushPila' }

{
parseError :: [Token] -> a
parseError (x:_) = error $ "Error de sintaxis en la línea " ++ (show m) ++ " columna " ++ (show n)
                   where (AlexPn _ m n) = getPos x
parseError _ = error "Final inesperado del archivo."


midny = parser.alexScanTokens

type Tablon  = Map.Map String [Entry]  

checkCierre :: Bool -> String -> AlexPosn -> MonadTablon ()
checkCierre b s pos = do
                      let (AlexPn _ m n) = pos
                      if b then return () 
                      else printError m n ("Error de sintaxis: No se pudo emparejar "++s )

neko :: [Token] -> IO (Program, (Tipos.Tablon, [Integer], Integer, Bool, Maybe (Bool,Type), [Integer], OffMap), ())
neko s = do
  (_, (pretablon, _, _, b, _, off, oof), _) <- runRWST (preparser s) () initTablon
  nya <- runRWST (parser s) () (pretablon, [0], 0, b, Nothing, off, oof)
  return nya

cat :: Program -> Tipos.Tablon -> IO ()
cat arbol tablon = do
  putStrLn ""
  print arbol
  putStrLn ""
  --putStrLn $ showTablon tablon
  putStrLn $ showTablon' tablon

gatto :: String -> IO (Program, (Tipos.Tablon, [Integer], Integer, Bool, Maybe (Bool,Type), [Integer], OffMap), ())
gatto f = do
  s <- getTokens f
  nya <- neko s
  return nya

gato :: String -> IO ()
gato f = do
  putStrLn ""
  (arbol, (tablon, _, _, b, _, _, _), _) <- gatto f
  if b then cat arbol tablon else return ()
}