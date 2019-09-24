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

## Tipos

Hay tipos escalares y compuestos. Las variables pueden ser declaradas en cualquier parte del código siempre que no hayan sido declaradas previamente dentro del mismo alcance. Todos los tipos escalares tienen un valor por defecto. Las palabras clave para tipos simple se escriben en minúscula mientras que las de tipos compuestos van con la primera letra mayúscula.

### Escalares

- `moon` : Tiene 2 valores posibles: `new` o `full` (no, las otras fases no las tomamos en cuenta) representados por 0 y 1 respectivamente. Default: `new`.
- `planet` : Número entero de 32 bits en complemento a 2. Default: `0`.
- `cloud`: Número de punto flotante con precisión simple. Default: `0.0`.
- `star` : Caracter ASCII de 1 byte. Default: `'A'`.
- `` : el tipo tipo.
- `blackhole` : Tipo con valor único análogo al () de haskell.

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
- `Comet` : Función, método o procedimiento.
- `Orbiter` : Iterador.

```
[
Constellation s = "osa mayor";
~planet x = bigbang(scaleof(planet));
[star]Cluster A = ('a','b','c','d');
[planet]Quasar L = [1,2,3,4,5];
[planet]Nebula = {"Juan" : 25, "María" : 31, "Wilkerman" : 27}
]
```

### Cluster
Los `Cluster` pueden definirse por extensión (colocando cada elemento) o inicializarse con un entero que de su tamaño (en cuyo caso tiene el valor por defecto en todas las posiciones.
```
[
[planet]Cluster A = (0,1,2,3,4);
[planet]Cluster B = Array(5) of int;
orbit i in range(0,5) {
  B[i] = i;
}
]
```

### Quasar
Los `Quasar` (listas) se pueden definir por extensión o por comprensión. Se les puede insertar un elemento utilizando `.add(x,n)` donde x es el elemento a insertar y n la posición para insertarlo en la lista. `.pop(x,n)` es análogo para eliminar (y la expresión se evalúa al elemento removido). Para acceder al elemento `i` del `Quasar` `Q` se utiliza `Q[i]` (igual que un arreglo).
```
[
[planet]Quasar A = [0,1,2,3,4];
[planet]Quasar B = [2*i orbit i in range(4)];
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

## Control de flujo

### Selección

### Repetición
