## Midnight

![alt text](https://i.imgur.com/YmgZF5V.png "Stars")

Es un lenguaje imperativo, compilado, fuertemente tipado, con alcance estático. Se enfoca en ofrecer varias alternativas para expresar las mismas estructuras y soluciones. Midnight es el lenguaje de programación donde el cielo es el límite.

## Estructura

El programa más simple (vacío) que se puede escribir es:  
```
[]
```
Dentro, se pueden escribir instrucciones. El signo de secuaciación (Colocar una instrucción para que se ejecute a continuación de otra) es `;`.
```
[
int n = 5;
print(n)
]
```
Dentro de un programa se pueden tener bloques delimitados por `{}`
```
[
{
    print("Este es un bloque);
}

{
    print("Este es otro bloque);
}
]
```

## Tipos
Hay tipos escalares y compuestos. Las variables pueden ser declaradas en cualquier parte del código siempre que no hayan sido declaradas previamente dentro del mismo alcance. Todos los tipos escalares tienen un valor por defecto. Las palabras clave para tipos simple se escriben en minúscula mientras que las de tipos compuestos van con la primera letra mayúscula.

### Escalares

- `moon` : Tiene 2 valores posibles: `new` o `full` (no, las otras fases no las tomamos en cuenta) representados por 0 y 1 respectivamente. Default: `new`.
- `planet` : Número entero de 32 bits en complemento a 2. Default: `0`.
- `cloud`: Número de punto flotante con precisión simple. Default: `0.0`.
- `star` : Caracter ASCII de 1 byte. Default: `'A'`.
- `blackhole` : Tipo con valor único `blackhole`.
- `cosmos` : el tipo tipo.

```
[
moon b = full;
planet n = 10;
cloud x = 3.14159;
star a = 'z';
]
```

### Compuestos

- `Constellation` : Cadena de caracteres.
- Apuntadores `~` : Apuntador a un espacio de memoria en el heap.
- `Cluster` : Arreglo de tamaño fijo.
- `Quasar` : Lista implementada con TBD.
- `Nebula` : Tabla de hash (cadenas de caracteres para las clavas) implementada con TBD.
- `Galaxy` : Registros.
- `UFO` : Registros variantes.
- `Comet` : Función, "método" o procedimiento.
- `Satellite` : Iterador.

```
[
Constellation s = "osa mayor";
~planet x = bigbang(scale(planet));
[star]Cluster A = ('a','b','c','d');
[planet]Quasar L = [1,2,3,4,5];
[planet]Nebula = {"Juan" : 25, "María" : 31, "Wilkerman" : 27}
]
```

### Print y Read
Las funciones `print` y `read` escriben y leen de la consola respecticamente. `read` lee únicamente el tipo `Constellation` pero posteriormente puede castearse a otros tipos.
```
[
print("Introduzca un número");
Constellation input = read();
planet n = (planet) n;
print(2^n)
]
```

### Cluster
Los `Cluster` pueden definirse por extensión (colocando cada elemento) o inicializarse con un entero que de su tamaño (en cuyo caso tiene el valor por defecto en todas las posiciones.
```
[
[planet]Cluster A = (0,1,2,3,4);
[planet]Cluster B = Array(5) of int;
orbit i around range(0,5) {
  B[i] = i;
}
]
```

### Quasar
Los `Quasar` (listas) se pueden definir por extensión o por comprensión. Se les puede insertar un elemento utilizando `.add(x,n)` donde x es el elemento a insertar y n la posición para insertarlo en la lista. `.pop(x,n)` es análogo para eliminar (y la expresión se evalúa al elemento removido). Para acceder al elemento `i` del `Quasar` `Q` se utiliza `Q[i]` (igual que un arreglo).
```
[
[planet]Quasar A = [0,1,2,3,4];
[planet]Quasar B = [2*i with orbit i around range(4)];
B.add(4)
]
```

### Nebula
`Nebula`es una tabla de hash o diccionario. Las claves son de tipo `Constellation` y se les puede insertar elementos. La sintaxis para las operaciones de insertar, eliminar y acceder son análogas a las de `Quasar` pero utilizando claves de tipo `Constellation` en lugar de índices de tipo `planet`.
```
[
[planet]Nebula N = {"perro" : 33, "gato" : 55};
N["vaca"] = 77
]
```

### Slices
Tanto `Quasar` como `Cluster` admiten slices. La notación es `[inicio..fin]` donde `inicio` y `fin` son índices y `fin` no está incluído, es decir el intervalo `[inicio,fin)`. Si es de la forma `[..fin]` entonces se empieza desde el índice 0 (el primero). Si es de la forma `[inicio..]` entonces se empieza desde el índice 0 (el primero).
```
[
[planet]Quasar A = [51,0,1,2,3,4,79];
[planet]Quasar B = A[1..6]
]
```

### Scale
Los tipos`Quasar`, `Cluster`, `Nebula`, `Constellation` admiten el uso de la función `scale()` que da la longitud (o cantidad de elementos que contiene). El tipo `cosmos` también la admite pero en lugar de retornar la longitud, retorna la cantidad de memoria que ocupa ese tipo.
```
[
[planet]Quasar A = [0,1,2,3,4];
planet x = scale(A)
]
```

### Apuntadores
El signo `~` se coloca antes de un tipo para indicar que es un apuntador a ese tipo. Por ejemplo, una variable de tipo `~planet` es un apuntador a una de tipo `planet`. La función `bigbang` permite reservar memoria en el heap. `~` también sirve para desreferenciar.
```
[
~planet z = bigbang(scale(planet));
planet x = ~z;
]
```

### Galaxy
Un `Galaxy` es un registro que agrupa varios tipos en uno.
```
[
Galaxy Perro{
    Constellation nombre;
    planet edad;
    Constellation raza
} firulais;
firulais.nombre = "Firulais";
firulais.edad = 9;
firulais.raza = "dálmata"
]
```

### UFO
Un `UFO` es un registro variante que crea una disyunción de tipos.
```
[
UFO numero { int ; float }
UFO numero n = 5;
UFO numero x = 2.72;
]
```

## Control de flujo

### Selección
Utiliza los esquemas `if`-`else if`-`else` y `switch`-`case` típicos. Además se incluye `unless` que es equivalente a un "if not".
```
[
`moon` m = full;
if (m) {
    print("perro");
}
else if (1==1) {
    print("gato");
}
else {
    print("vaca");
}
unless (m) {
    print("sapo");
}
]
```

### Repetición Indeterminada
`orbit while` itera hasta que se deje de cumplir una condición (que el tipo de una expresión `moon` pase a ser `new`) mientras que `orbit until` itera hasta que se cumpla la condición dada. `orbit(;;;)` es análogo a un for tipo C.
```
[
planet i = 0;
orbit while (i < 6) {
    print(i);
    i++
}

planet j = 0;
orbit until (j >= 6) {
    print(j);
    j++
}

orbit(int k=0 ; k < 6 ; k++) {
    print(k)
}
]
```

### Repetición Determinada
La notación para la repetición determinada es`orbit i around X` donde i es la variable de la repetición y X un `Cluster`, `Quasar`, `Constellation` o `Satellite` sobre el cual se desea iterar (para constellation estaríamos iterando sobre los `star` que lo conforman). Esta es también la notación que se usa para definir un `Quasar` por comprensión.
```
[
[cloud]Quasar L = [0.1, 0.15, 0.2, 0.25, 0.3]
orbit i around L {
    print(i);
}
]
```

### break y continue
Estando dentro de un ciclo (o dentro de varios ciclos anidados) se puede utilizar la instrucción especial `break n`, donde n es un `planet` > 0, para detener los n ciclo anidados más internos y continuar la ejecución afuera del más externo de los ciclos detenidos. Si se omite `n` se tratará como `break 1`. `continue` es similar pero en lugar de terminar el ciclo completo, termina solo la iteración actual.
```
[
[[planet]Cluster]Cluster M = ((1,2,3),(4,5,6),(7,8,9));
orbit i around range(3) {
    orbit j around range(3) {
        if M[i][j] == 7 {
            print(i);
            print(j);
            break 2
        }
    }
}
]
```

### Subrutinas
Midnight tiene subrutinas (`Comet`) de segunda clase, lo que quiere decir que se pueden guardar en una variable y pasar como parámetro pero no retornarlas en una función. Un procedimiento es una función que retorna `blackhole`.
```
[
Comet halley(planet n) -> blackhole {
    print("Este es un procedimiento");
    print(n);
}

Comet twice(planet n) -> planet {
    print("Esta es una Función");
    return 2*n;
}

(planet -> planet)Comet f = twice;
planet z = planet(2);
]
```

### Iteradores
Los  `Satellite` son similares a las subrutinas pero utilizan la palabra clave `yield` en lugar de return. Esto permite que el iterador "recuerde" en que línea se quedó y continúe desde ahí cuando se llame otra vez. No admiten recursión ni directa ni indirecta.
```
[
Satellite Primos() -> planet {
    [planet]Quasar L = [];
    planet p = 2;
    orbit while(full) {
        moon esprimo = full;
        orbit q around L {
            if p%q == 0 {
                esprimo = new;
                break;
            }
        }
        if esprimo {
            yield p;
            L.add(p);
        }
        p++;
    }
}

[planet]Satelline generador_primos = Primos();
print("esto no va a parar jaja salu2");
orbit p around generador_primos {
    print(p);
}
]
```

## Operadores
`==`: igualdad.  
`!=`: desigualdad.  
`=`: asignación.  

### Operadores aritméticos
`+`: adición.  
`-`: substrancción.  
`*`: producto.  
`^`: potencia.  
`/`: división.  
`//`: división entera.  
`%`: resto de la división entera.  
`+=`, `-=`, `*=`, `^=`, `/=`, `//=`, `%=`: aplicar y asignar. Ejemplo: `i += 1` es lo mismo que `i = i+1`.  
`>`: mayor que.  
`<`: menor que.  
`>=`: mayor o igual.  
`<=`: menor o igual.  

### Operadores lógicos
`&&`: and con cortocircuito.  
`&`: and sin cortocircuito.  
`||`: or con cortocircuito.  
`|`: or sin cortocircuito.  
`¬`: negación.  

## Extras
Estas son ideas de características para añadirle al lenguaje si da tiempo:  
- Quitar las restricciones de los iteradores.
- Funciones de primera clase.
