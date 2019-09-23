## Lenguaje pa microondas (nombre sujeto a cambios)

Es un lenguaje imperativo, compilado, fuertemente tipado, con alcance dinámico y asociación profunda. Se enfoca en ofrecer varias alternativas para expresar las mismas estructuras y soluciones.

## Estructura

El programa más simple (vacío) que se puede escribir es:  
```
[]
```
Ejemplo
```
[
int n = 5
]
```
El `;` es el signo de secuenciación (Concatenar 2 instrucciones).
```
[
int n = 5;
print(n)
]
```

## Tipos

Hay tipos escalares y compuestos. Las variables pueden ser declaradas en cualquier parte del código siempre que no hayan sido declaradas previamente dentro del mismo alcance. Todos los tipos escalares tienen un valor por defecto. Las palabras clave para tipos simple se escriben en minúscula mientras que las de tipos compuestos van con la primera letra mayúscula.

### Escalares

- `bool` : Valor de verdad `true` o `false` representados por 1 y 0 respectivamente. Default: `false`.
- `int` : Número entero de 32 bits en complemento a 2. Default: `0`.
- `float`: Número de punto flotante con precisión simple. Default: `0.0`.
- `char` : Caracter ASCII de 1 byte. Default: `'A'`.

```
[
bool b = true;
int n = 10;
float x = 3.14159;
chat a = 'z';
]
```

### Compuestos

- `String` : Cadena de caracteres.
- Apuntadores `~` : Apuntador a un espacio de memoria en el heap. Para obtener un apuntador a una variable se utiliza `@`.
- `Array` : Arreglo de tamaño fijo.
- `List` : Lista implementada con TBD.
- `Dict` : Tabla de hash implementada con TBD.
- `Struct` : Registros.
- `Union` : Registros variantes.
- `Subroutine` : Función, método, procedimiento o iterador

```
[
String s = "perro";
int n = 20;
~int x = @n;
Array[int] A = (1,2,3,4,5);
List[int] L = [1,2,3,4,5];
Dict[int] = {"Juan" : 25, "María" : 31, "Wilkerman" : 27}
]
```

### Arreglos
Los arreglos pueden definirse por extensión (colocando cada elemento) o inicializarse con un entero que de su tamaño (en cuyo caso tiene el valor por defecto en todas las posiciones.
```
[
Array[int] A = (0,1,2,3,4);
Array[int] B = Array(5) of int
for i in range(0,5) {
  B[i] = i;
}
]
```

### Listas
Las listas se pueden definir por extensión o por comprensión

## Control de flujo

### Selección

### Repetición
