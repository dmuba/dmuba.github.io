
# Guía: Introducción al lenguaje R

Esta guía es una introducción para conocer los fundamentos y conceptos del lenguaje R. Se detallan los tipos de datos básicos y operaciones.

La guía está pensada para aquellos que están empezando a utilizar el lenguaje. Sin embargo, podemos arrancar a usar R sin conocerlo a fondo, ya que a diferencia de otros lenguajes, contiene funcionalidades de alto nivel para realizar fácilmente análisis estadísticos y visualizaciones. 

Una buena forma de utilizar esta guía es tener una primera lectura más general y a medida que vayas teniendo práctica con el lenguaje, utilizarla para profundizar los conocimientos. Tener buenos fundamentos de R te permitirá hacer análisis más complejos en menor tiempo, disminuir errores de programación, y generar código más eficiente. 

### Tabla de contenidos 
- [Variables](#variables)
- [Workspace](#workspace)
- [R scripts](r-scripts)
- [Tipos de datos](#tipos-de-datos)
- [logical](#logical)
- [numeric](#numeric)
- [character](#character)
- [NA](#na)
- [coercion](#coercion)
- [vector](#vector)
- [matrix](#matrix)
- [factors](#factors)
- [list](#list)
- [data.frame](#dataframe)


---

## Variables

Las variables es donde se guardan valores (para luego poder operar a partir de estos). Se las identifica con un nombre único. Y se llaman variables, justamente, porque sus valores pueden ser cambiados.

Los nombres de variables deben seguir con las siguientes reglas:
- Deben empezar con una letra.
- Pueden contener números y letras (sin acentos ni ñ)
- Se distingue mayúsculas y minúsculas (ej la variable *resultado* es distinta a *Resultado*)
- Pueden contener el caracter guión bajo: **_**
- ¡Puede contener el caracter punto! **.** (a diferencia de muchos otros lenguajes)

Se las crea con la asignación de un valor. La asignación se las hace con los operadores: **<-**, **->**, o **=**


```R
base <- 4
base
```

    [1] 4

```R
3 -> altura
altura
```

    [1] 3

```R
altura = 3
altura
```
    [1] 3


## Workspace

En el workspace se encuentran todas las variables que fuimos creando. Se puede consultar con la función **ls()**


```R
ls()
```
    [1] "altura" "base"  


Si queremos eliminar una variable usamos la función **rm()**


```R
rm(altura)
```

```R
ls()
```

    [1] "base"


## R scripts
Un script de R es una lista de operaciones que se ejecuta de principio a fin siguiendo su flujo de ejecución (normalmente orden secuencial).

Los script en R llevan la extensión **.r**. Y nos permiten guardar tareas que pueden ser ejecutadas más de una vez.

Es muy útil agregar comentarios a los scripts y así dejar documentado nuestro código. Para indicar que un texto es un comentario se utiliza el caracter **\#**. Todo lo que siga a continuación de **\#** en la misma línea de código es considerado comentario y no se ejecutará por el intérprete de R.

#### triangulo.r
```R
# crea las variables base y altura del triángulo
base <- 3
altura <- 6
# Calcula el área
area <- base * altura / 2
print(area) # imprime resultado
```
    [1] 9


## Tipos de datos

Como ya dijimos, las variables almacenan valores. Ahora, estos valores pueden ser de distintos tipos. Existen tipos de datos simples, como números o textos. O compuestos como vectores o listas.

Para consultar el tipo de datos que tiene la variable (o mejor dicho el valor almacenado) se usa la función **class()**. A continuación veremos diferentes ejemplos de uso. Para tipos de datos más complejos esta función nos proporciona información muy general, para conocer más detalles se utilizan otras funciones adicionales, como por ejemplo **is.numeric()** o **is.vector()** (siguiendo el patrón is.*algo*), para consultar por un determinado tipo o subtipo de datos.

## logical

Contienen los valores de verdad verdadero (TRUE o T) o falso (FALSE o F).


```R
TRUE
```
    [1] TRUE


```R
FALSE
```
    [1] FALSE



```R
T
```

    [1] TRUE



```R
F
```

    [1] FALSE


```R
class(TRUE)
```

    [1] 'logical'


Son el resultados de las operaciones de comparación:
- Mayor >
- Menor <
- Mayor o igual >=
- Menor o igual <=
- Igual == \[\*\]
- Distinto !=

\[\*\] *Ojo no confundirse con = que es asignación, este es un error muy normal de programación, a veces difícil de detectar, ya que puede afectar a los resultados pero no arroja error*


```R
3 <= 5
```
    [1] TRUE


```R
7 != 7
```

    [1] FALSE



```R
TRUE > FALSE
```
    [1] TRUE



```R
class(8>4)
```
    [1] 'logical'


Operaciones booleanas (Operaciones entre valores lógicos que devuelven otro valor lógico):
- And &
- OR |
- Not ! 


```R
TRUE & FALSE
```

    [1] FALSE


```R
TRUE | FALSE
```
    [1] TRUE



```R
!TRUE
```
    [1] FALSE


## numeric

Los valores numéricos contienen una jerarquía de tipos: Un numeric representa los valores reales, mientras un integer es un subconjunto que representa a los enteros.


```R
class(2.5)
```
    [1] 'numeric'



```R
class(2)
```
    [1] 'numeric'


Para indicar que un número es de tipo *integer* debe especificarse explícitamente con una **L** como sufijo.


```R
class(2L)
```

    [1] 'integer'


Comprobar subtipos de numéricos:


```R
is.numeric(2)
```

    [1] TRUE



```R
is.numeric(2L)
```

    [1] TRUE


```R
is.integer(2) 
```
    [1] FALSE



```R
is.integer(2L) 
```

    [1] TRUE


## character

El tipo de datos *character* permite representar textos en formato de cadenas de caracteres.

Una cadena de caracteres debe delimitarse entre comillas (simples o dobles).


```R
"DM uba 2019"
```

    [1] "DM uba 2019"


```R
'DM uba 2019'
```

    [1] "DM uba 2019"


```R
class("DM uba 2019")
```

    [1] 'character'


La función nchar nos devuelve el tamaño de cadena en cantidad de caracteres:


```R
nchar("DM uba 2019")
```

    [1] 11


En el caso de que el texto contenga comillas del mismo tipo que usamos para delimitar la cadena, se utiliza el caracter **\\** (caracter de escape) para idicar que la comilla de a continuación no indica clausura de la cadena.


```R
"DM uba \"2019\""
```
    [1] 'DM uba "2019"'



```R
'DM uba "2019"'
```

    [1] 'DM uba "2019"'


## NA

Para representar datos faltantes r utiliza *NA* (equivalente a NULL en SQL).

Un NA puede ser asignado inicialmente a una variable o puede ser resultado de una operación en donde no se puede determinar un resultado válido.

Este valor especial no es un tipo de datos en sí. En R este valor es del tipo de datos *logical*. Sin embargo no representa un valor de verdad como TRUE y FALSE, y es compatible con otros tipos de datos, es decir que puede indicarse un NA para *numeric*, *character*, etc.


```R
NA
```
    [1] NA



```R
class(NA)
```
    [1] 'logical'



```R
is.na(NA)
```
    [1] TRUE



```R
is.na("NA")
```
    [1] FALSE


Las operaciones con valores con *NA* dan como resultado *NA*.


```R
5 + NA + 6
```

    [1] NA



```R
TRUE & NA
```

    [1] NA



```R
"cadena" == NA
```

    [1] NA


## coercion (transformación de tipos de datos)

En ciertas ocasiones nos resultará útil convertir el tipo de datos de una variable para poder realizar alguna operación (por ejemplo de cadena a numérico). A esta operación en programación se la conoce como **casting**. Cuando R tiene que hacer esta transformación de forma forzada para compatibilizar el tipo de datos para realizar una operación, se habla de **coercion**.

Para llevar a cabo una transformación se utilizan funciones como *as.logical()*, *as.numeric()*, *as.character()*. Es decir *as.* seguido del tipo de datos a convertir.

### logical a numeric
R utiliza como traducción del valor TRUE al valor 1. Y de FALSE a 0.


```R
as.numeric(TRUE) 
```
    [1] NA

```R
as.numeric(FALSE) 
```
    [1] 0


### numeric a logical
De forma inversa traduce a 0 como FALSE, y al resto de los valores a TRUE.


```R
as.logical(122.2)
```
    [1] TRUE

```R
as.logical(-1)
```
    [1] TRUE

```R
as.logical(0)
```
    [1] FALSE


### logical o numeric a character


```R
as.character(4)
```
    [1] '4'


```R
as.character(F)
```
    [1] 'FALSE'


### character a numeric o logical

Permite pasar de character a valores numéricos o lógicos, siempre que los valores encerrados entre las comillas sean compatibles con el tipo de dato a convertir.


```R
as.numeric("4.5")
```
    [1] 4.5



```R
as.logical("T") 
```

    [1] TRUE



```R
as.logical("FALSE") 
```

    [1] FALSE



```R
as.numeric("Hola")
```
    Warning message in eval(expr, envir, enclos):
    “NAs introduced by coercion”

    [1] NA


### NA
El valor NA no puede ser transformado, es decir un faltante sigue siendo faltante en cualquier tipo de datos.


```R
as.numeric(NA)
```
    [1] NA



```R
as.logical(NA)
```
    [1] NA



```R
as.character(NA)
```
    [1] NA


## vector

Un *vector* es una secuencia de elementos de datos del **mismo tipo**. (Por ejemplo: *vector de numerics, *vector de characters*, *vector de *logicals*). Además puede tener elementos del tipo NA.

Para crear un vector usamos *c()* separando sus elementos por coma:


```R
frutas <- c("bananas", "peras", "manzanas", "manzanas", "peras")
```
    [1] "bananas"  "peras"    "manzanas" "manzanas" "peras"   



```R
is.vector(frutas)
```

    [1] TRUE



```R
class(frutas)
```
    [1] 'character'



```R
x <- c(1, 2, 3, 4)
```
    [1] 1 2 3 4



```R
is.vector(x)
```
    [1] TRUE



```R
class(x)
```
    [1] 'numeric'


Para crear un vector de números en secuencia puede usarse la siguiente operación: *valor_inicial:valor_final* (ambos valores son inclusivos)


```R
x <- 1:4
```

    [1] 1 2 3 4


Para conocer la cantidad de elementos se usa la función *length()*


```R
length(frutas)
```

    [1] 5



```R
length(x)
```

    [1] 4


Cada elemento contiene un índice. El primer elemento contiene el índice **1** (0 no es un índice). Para acceder a un elemento en particular usamos el número de índice y el operador *\[\]*.


```R
frutas[1]
```
    [1] 'bananas'

```R
frutas[5]
```
    [1] 'peras'

```R
x[3]
```
    [1] 3


Si consultamos por un elemento en un índice superior a *length()* devuelve *NA*.


```R
frutas[6]
```
    [1] NA


### Vectores con nombres

Podemos agregar nombres a los elementos. Para esto usamos la función *name()* asignando un vector de tipo *character* con el mismo número de elementos que el vector original.


```R
edades <- c(24, 55, 26, 34, 26)
nombres <- c('Javier', 'Marcela', 'Liliana', 'Claudia', 'Juan')

names(edades) <- nombres
edades
```
     Javier Marcela Liliana Claudia    Juan 
         24      55      26      34      26 


*names()* también permite devolver los nombres asignados a los elementos.


```R
edades
```

    [1] "Javier"  "Marcela" "Liliana" "Claudia" "Juan"   


Ahora se puede acceder a los elementos por su nombre:


```R
edades["Marcela"]
```

    Marcela 
         55 


```R
edades[2]
```

    Marcela 
         55 


Otras formas de crear vectores con nombres:


```R
# opición 1
names(edades) <- c('Javier', 'Marcela', 'Liliana', 'Claudia', 'Juan')
# opción 2
edades <- c(Javier=24, Marcela=55, Liliana=26, Claudia=34, Juan=26)
# opción 3
edades <- c("Javier"=24, "Marcela"=55, "Liliana"=26, "Claudia"=34, "Juan"=26)
```

### Vectores de un único elemento

En R el caso de variables con un valor de tipo de dato simple como los que vimos con anterioridad. los trata como vectores de un único elemento.


```R
mi_nombre = 'Homero'
mi_altura = 34
```

```R
is.vector(mi_nombre)
```

    [1] TRUE

```R
is.vector(mi_altura)
```
    [1] TRUE

```R
length(mi_altura)
```
    [1] 1



```R
length(mi_nombre)
```
    [1] 1

```R
nchar(mi_nombre)
```
    [1] 6


### Coercion

Los vectores tienen que ser del mismo tipo, por lo tanto realiza coercion para lograr que todos los elementos sean del mismo tipo.


```R
vec <- c(5, 3, "T", "10", 1, 2, NA, "Q")
vec
```

    [1] "5"  "3"  "T"  "10" "1"  "2"  NA   "Q" 



```R
class(vec)
```
    [1] 'character'

```R
length(vec)
```
    [1] 8


### Operaciones

Las operaciones entre dos vectores se hacen por pares de elementos según su índice.


```R
x <- c(3, 5, 10)
y <- c(2, 6, 6)
x + y
```
    [1]  5 11 16

```R
x >= y
```
    [1]  TRUE FALSE  TRUE


Cuando se realiza una operación entre un vector y un escalar (es decir un único elemento). Este se aplica sobre cada uno de los elementos del vector.


```R
x <- c(3, 5, 10)
```
```R
x + 1
```

    [1]  4  6 11

```R
x/2
```
    [1] 1.5 2.5 5.0

```R
x * 2
```
    [1]  6 10 20


```R
x^2
```
    [1]   9  25 100


Cuando los vectores no tienen el mismo tamaño, se extiende el vector de menor tamaño repitiendo la secuencia de sus elementos.


```R
x <- c(3, 5, 2, 10)
y <- c(4, 9)
x+y
```
    [1]  7 14  6 19


```R
x <- c(3, 5, 2, 10)
y <- c(4, 9, 4, 9)
x+y
```
    [1]  7 14  6 19


Concatenación entre vectores:

```R
x <- c(3, 5, 2, 10)
y <- c(4, 9)
xy = c(x, y)
xy
```

    [1]  3  5  2 10  4  9


Si queremos agregar un único elemento, usamos concatenación:


```R
x <- c(3, 5, 2, 10)
x = c(x, 44)
x
```
    [1]  3  5  2 10 44


Funciones útiles sobre vectores:


```R
x <- c(3, 5, 2, 10)
```

```R
sum(x) 
```
    [1] 20

```R
mean(x)
```
    [1] 5


```R
median(x)
```
    [1] 4

```R
sd(x)
```
    [1] 3.55902608401044


Cuidado con los missings:


```R
mean(c(7, 8, 6, NA, 10))
```
    [1] NA

```R
mean(c(7, 8, 6, NA, 10), na.rm = TRUE)
```
    [1] 7.75


### Subset

Vimos que el operador \[\] nos permite acceder a elementos del vector, pero a su vez, un elemento es un vector en sí mismo. Así que usando \[\] podemos seleccionar elementos y formar otro vector.


```R
edades <- c(Javier=24, Marcela=55, Liliana=26, Claudia=34, Juan=26)
edades
```

     Javier Marcela Liliana Claudia    Juan 
         24      55      26      34      26 


Usamos un vector de índices para seleccionar los elementos.


```R
print(edades[c(1,3)])
```

     Javier Liliana 
         24      26 


El orden sí importa:

```R
edades[c(3, 1)]
```

    Liliana  Javier 
         26      24 


También podemos usar nombres:


```R
edades[c("Javier", "Liliana")]
```

     Javier Liliana 
         24      26 


Se usan índices negativos para excluir elementos


```R
edades[-c(1,3)]
```
    Marcela Claudia    Juan 
         55      34      26 

```R
edades[-1]
```

    Marcela Liliana Claudia    Juan 
         55      26      34      26 


No se pueden excluir usando nombres:


```R
edades[-c("Javier", "Liliana")]
```

    Error in -c("Javier", "Liliana"): invalid argument to unary operator
    Traceback:



Otra forma de selección es usar vectores lógicos. Al operador \[\] debe pasarse un vector de tipo *logical* con la misma cantidad de elementos que el vector original. El valor TRUE indica que selecciona el elemento, y FALSE indica que se excluye.

A este tipo de vector de selección también se lo conoce como **máscara**.


```R
edades[c(FALSE, TRUE, FALSE, TRUE)]
```

    Marcela Claudia 
         55      34 



```R
edades[edades > 30]
```

    Marcela Claudia 
         55      34 


En el caso de pasarse menor número de elementos en la máscara, realiza extensión del vector:


```R
edades[c(T,F)] # selecciona impares
```
     Javier Liliana    Juan 
         24      26      26 

```R
edades[c(T,F,T,F,T)]
```

     Javier Liliana    Juan 
         24      26      26 


## matrix
Un vector es un arreglo de 1 dimensión., mientras que matrix es un arreglo de elementos de 2 dimensiones. Es decir que podría verse como un vector con elementos del tipo vector de igual cantidad de elementos.

Las matrices se dividen en filas (primera dimensión) y columnas (segunda dimensión)

De la misma forma que los vectores, sólo admiten elementos del **mismo tipo** o NA.

### Creación

Se especifica los elementos con un vector, y las cantidad de filas y columnas en que se van a distribuir.

```R
m <- matrix(1:6, nrow = 3)
m
```
         [,1] [,2]
    [1,]    1    4
    [2,]    2    5
    [3,]    3    6



```R
m <- matrix(1:6, ncol = 3)
m
```

         [,1] [,2] [,3]
    [1,]    1    3    5
    [2,]    2    4    6



```R
m <- matrix(1:6, nrow = 2, byrow = TRUE) 
m
```

         [,1] [,2] [,3]
    [1,]    1    2    3
    [2,]    4    5    6



```R
m <- matrix(0, nrow=2, ncol=3)
m
```

         [,1] [,2] [,3]
    [1,]    0    0    0
    [2,]    0    0    0



```R
class(m)
```
    [1] 'matrix'



```R
is.numeric(m)
```

    [1] TRUE


*nrow()* devuelve la cantidad de filas


```R
nrow(m)
```
    [1] 2


*ncol()* devuelve la cantidad de columnas


```R
ncol(m)
```
    [1] 3


*ndim()* devuelve un vector de dos elementos con cantidad de filas y cantidad de columnas


```R
dim(m)
```
    [1] 2 3



*length()* Devuelve la cantidad total de elementos


```R
length(m)
```
    [1]6


### Concatenación de filas o columnas

Con las funciones *rbind()*/*cbind* podemos concatenar filas/columnas.


```R
m = matrix(1:6, nrow=3)
m
```

         [,1] [,2]
    [1,]    1    4
    [2,]    2    5
    [3,]    3    6



```R
cbind(m, 7:9)
```

         [,1] [,2] [,3]
    [1,]    1    4    7
    [2,]    2    5    8
    [3,]    3    6    9



```R
rbind(m, matrix(c(7, 7, 8, 8), nrow=2, byrow=TRUE))
```

         [,1] [,2]
    [1,]    1    4
    [2,]    2    5
    [3,]    3    6
    [4,]    7    7
    [5,]    8    8


### Coercion


```R
m <- matrix(c(1,2,3, "A", "B", NA), nrow=2, byrow=TRUE)
m
```
         [,1] [,2] [,3]
    [1,] "1"  "2"  "3" 
    [2,] "A"  "B"  NA  



```R
is.character(m)
```
    [1] TRUE



```R
is.numeric(m)
```
    [1] FALSE


### columnas o filas con nombres

Se pueden nombrar las filas y/o columnas.


```R
m <- matrix(c(10, 20, 33, 5, 15, 30), nrow=2, ncol=3, byrow=T)
rownames(m) <- c("fila1", "fila2")
m
```

          [,1] [,2] [,3]
    fila1   10   20   33
    fila2    5   15   30



```R
m <- matrix(c(10, 20, 33, 5, 15, 30), nrow=2, ncol=3, byrow=T)
colnames(m) <- c("col1", "col2", "col3")
m
```

         col1 col2 col3
    [1,]   10   20   33
    [2,]    5   15   30


```R
m <- matrix(c(10, 20, 33, 5, 15, 30), nrow=2, ncol=3, byrow=T)
rownames(m) <- c("fila1", "fila2")
colnames(m) <- c("col1", "col2", "col3")
m
```

          col1 col2 col3
    fila1   10   20   33
    fila2    5   15   30


### Subset

De la misma manera que en vector se utiliza el operador *\[\]* para acceder a sus elementos y seleccionar sub-matrices o sub-vectores.
En este se debe especificar la selección de filas y columnas.


```R
m <- matrix(c(10, 20, 33, 5, 15, 30), nrow=2, ncol=3, byrow=T)
rownames(m) <- c("fila1", "fila2")
colnames(m) <- c("col1", "col2", "col3")
m
```

          col1 col2 col3
    fila1   10   20   33
    fila2    5   15   30


Si se quiere acceder al elemento de la primera fila y segunda columna:


```R
m[1,2]
```


    [1] 20


O utilizando nombres:


```R
m["fila1","col2"] 
```


    [1] 20


Selección de segunda fila:


```R
m[2, ]
```

    col1 col2 col3 
       5   15   30 



```R
m["fila2", ]
```

    col1 col2 col3 
       5   15   30 


Selección de tercera columna:


```R
m[, 3]
```

    fila1 fila2 
       33    30 



```R
m[, "col3"]
```

    fila1 fila2 
       33    30 


También se pueden seleccionar filas y columnas a la vez.


```R
m[c(1, 2), c(2, 3)]
```

          col2 col3
    fila1   20   33
    fila2   15   30



```R
m["fila1", c("col1", "col2")]
```

    col1 col2 
      10   20 


Se pueden excluir filas o columnas


```R
m["fila2", -3]
```

    col1 col2 
       5   15 


Se pueden usar máscaras de selección


```R
m[c(F,T), c(T,F,T)]
```

    col1 col3 
       5   30 


También se pueden seleccionar elementos (en formato de vector)


```R
m[m>15]
```

    [1] 20 33 30


### Operaciones

De la misma manera que en vectores, las operaciones son por pares de elementos.


```R
m1 <- matrix(c(10, 20, 30, 40, 50, 60), nrow=2, ncol=3, byrow=T)
m2 <- matrix(c(1:6), nrow=2, ncol=3, byrow=T)
```


```R
m1 + m2
```

         [,1] [,2] [,3]
    [1,]   11   22   33
    [2,]   44   55   66



```R
m1 * 10
```

         [,1] [,2] [,3]
    [1,]  100  200  300
    [2,]  400  500  600



```R
m1 - 20 < m2
```

          [,1]  [,2]  [,3]
    [1,]  TRUE  TRUE FALSE
    [2,] FALSE FALSE FALSE


Se pueden aplicar funciones de operaciones a nivel fila, columnas o todos sus elementos:


```R
colSums(m1)
```

    [1] 50 70 90



```R
rowSums(m1)
```

    [1]  60 150



```R
sum(m)
```


    [1] 113


## factors

Este tipo de datos se utiliza para representar datos categóricos en R.

Al igual que los vectores, una variable de tipo *factor* contiene una secuencia de elementos, pero en este caso los elementos codifican a un número de categorías finitas.

Por ejemplo partimos de un vector con marcas de gaseosas


```R
vector_gaseosas <- c("coca-cola", "manaos", "fanta", "manaos", "coca-cola", "pepsi")
vector_gaseosas
```

    [1] "coca-cola" "manaos"    "fanta"     "manaos"    "coca-cola" "pepsi"    


```R
class(vector_gaseosas)
```

    [1] 'character'



A partir de este vector se puede generar una variable de tipo *factor*. Las categorías son llamadas *levels*.

Cuando se crea una variable de tipo factor, R automáticamente genera los las categorías o *levels*.

```R
gaseosas <- factor(vector_gaseosas)
gaseosas
```

    [1] coca-cola manaos    fanta     manaos    coca-cola pepsi    
    Levels: coca-cola fanta manaos pepsi



```R
class(gaseosas)
```


    [1] 'factor'


R genera a los *levels* a partir de los valores del vector y los ordena alfabéticamente.

Si se necesita especificar todos las categorías posibles, o si se quiere dar un orden diferentes a las categorías se usa el parámetro *levels* en la creación del *factor*.


```R
provincias <- factor(c("Corrientes", "Neuquén", "Buenos Aires", "Formosa", "Mendoza", "Santa Fe", "Mendoza"),
                     levels = c("Buenos Aires", "Catamarca", 
                                "Chaco", "Chubut", "Córdoba", "Corrientes", 
                                "Entre Ríos", "Formosa", "Jujuy", 
                                "La Pampa", "La Rioja", "Mendoza", 
                                "Misiones", "Neuquén", "Río Negro", 
                                "Salta", "San Juan", "San Luis", "Santa Cruz", "Santa Fe", 
                                "Santiago del Estero", "Tierra del Fuego",
                                "Tucumán"))
provincias
```

	[1] Corrientes   Neuquén      Buenos Aires Formosa      Mendoza      Santa Fe     Mendoza     
	23 Levels: Buenos Aires Catamarca Chaco Chubut Córdoba Corrientes Entre Ríos Formosa Jujuy ... Tucumán


Con *levels()* se obtiene el listado de categorías


```R
levels(gaseosas)
```
	[1] "coca-cola" "fanta"     "manaos"    "pepsi"      


En *factor* cada elemento se representa en un valor numérico según su *level* o categoría asociada. Si se convierte a tipo numérico se puede ver su representación en *levels*.*


```R
as.numeric(gaseosas)
```
	[1] 1 3 2 3 1 4


Es posible renombrar a las categorías usando la función *levels()*


```R
# rename factors
levels(gaseosas) <- c('marca_coca', 'marca_fanta', 'marca_manaos', 'marca_pepsi')
gaseosas
```

    [1] marca_coca   marca_manaos marca_fanta  marca_manaos marca_coca  
    [6] marca_pepsi 
    Levels: marca_coca marca_fanta marca_manaos marca_pepsi


Hasta ahora con *factor* representamos datos **categóricos nominales**. Es decir que el orden de las categorías no importa. 


```R
gaseosas[1] < gaseosas[2]
```

    Warning message in Ops.factor(gaseosas[1], gaseosas[2]):
    “‘<’ not meaningful for factors”
    [1] NA


*Factor* también permite representar **categóricos ordinales**. En este caso debe pasarse en la función *factor()* como parámetro *ordered* en TRUE (por defecto es FALSE). Además en *levels* deben pasarse las categorías en orden creciente.


```R
estudios <- factor(c('universitario', 'secundario', 'universitario', 'primario'),
                   ordered = TRUE,
                   levels = c("primario", "secundario", "universitario")) 
estudios
```

    [1] universitario secundario    universitario primario     
    Levels: primario < secundario < universitario



```R
estudios[1] > estudios[2]
```
    [1] TRUE



```R
class(estudios)
```
	[1] "ordered" "factor" 


## list

Hasta ahora los tipos de datos compuestos vistos hasta ahora contienen elementos del mismo tipo. Si se quieren representar datos compuestos de distintos tipos se utiliza el tipo de dato *list*.

Este tipo de datos permite representar estructuras de datos más complejas, pero como contra es que se pierde funcionalidades que podemos hacer con otros tipos de datos (Por ejemplo realizar operaciones aritméticas, o comparaciones)

Por ejemplo si queremos representar los siguientes elementos en un *vector*, se convierten todos en *character* por *coercion*.


```R
c("Homero Simpson", "7-G", 1956, T)
```
	[1] "Homero Simpson" "7-G"            "1956"           "TRUE"     



Con *list* se pueden mantener los tipos originales.


```R
empleado <- list("Homero Simpson", "7-G", 1956, T)
str(empleado)
```

    List of 4
     $ : chr "Homero Simpson"
     $ : chr "7-G"
     $ : num 1956
     $ : logi TRUE



```R
class(empleado)
```

	[1] 'list'



```R
is.list(empleado)
```
	[1] TRUE


De la siguiente manera podemos acceder a sus elementos (operador *\[\]*):


```R
empleado[[1]]
```

	[1] Homero Simpson'



```R
empleado[[3]]
```
	[1] 1956


Los elementos de la lista se pueden nombrar.


```R
names(empleado) <- c("nombre", "sector", "anio_nacimiento", "casado")
str(empleado)
```

    List of 4
     $ nombre         : chr "Homero Simpson"
     $ sector         : chr "7-G"
     $ anio_nacimiento: num 1956
     $ casado         : logi TRUE


Ahora podemos acceder a sus elementos usando el operador $:


```R
empleado$nombre
```
	[1] 'Homero Simpson'



```R
empleado$sector
```
	[1] '7-G'



```R
empleado[["casado"]]
```
	[1] TRUE


## data.frame

Cuando se utiliza R como herramienta de análisis de datos, se trabaja con variables de tipo *data.frame*. Un *data.frame* representa un conjunto de datos. Este es nuestro objeto de estudio.

*data.frame* es un tipo de datos más complejo de los que vimos hasta ahora. Y comprende las características de todos los anteriores.

Un *data.frame* es un tipo de datos de **dos dimensiones** (como matrix)

Contiene **observaciones** o **casos**: **filas**

Y **variables** o **propiedades** asociadas a las observaciones: **columnas**

Pero a diferencia de matrix, las columnas pueden ser de distintos tipos.

Cada columna a su vez es un *vector* de un único tipo de datos, o de tipo *factor* para representar variables categóricas. Estor vectors o factors tienen la misma cantidad de elementos (cantidad de filas).

Un *data.frame* puede ser importado desde una fuentes de datos (ej archivo csv o desde una DB a través de una consulta SQL).

Para crear un *data.frame* desde cero, es decir desde código. Primero creamos las variables de tipo *vector* o *factor* que luego serán sus columnas.


```R
nombre <- c("Damián", "Lucía", "Francisca", "Javier", "Paola", "Agustín", "Alejandra")
genero <- c('M', 'F', 'F', 'M', 'F', 'M', 'F')
edad <- c(22, 19, 44, 32, 23, 55, 33)
hijos <- c(F, F, T, F, T, T, F)
educacion <- factor(c('sec', 'sec', 'uni', 'sec', 'uni', 'uni', 'pri'), levels= c('pri', 'sec', 'uni'), ordered=TRUE)
ingreso <- c(15000, 7450, 83300, NA, 22000, 65340, 9405)

df <- data.frame(nombre, genero, edad, hijos, educacion, ingreso)
df
```

         nombre genero edad hijos educacion ingreso
    1    Damián      M   22 FALSE       sec   15000
    2     Lucía      F   19 FALSE       sec    7450
    3 Francisca      F   44  TRUE       uni   83300
    4    Javier      M   32 FALSE       sec      NA
    5     Paola      F   23  TRUE       uni   22000
    6   Agustín      M   55  TRUE       uni   65340
    7 Alejandra      F   33 FALSE       pri    9405


El dataset contiene 7 observaciones (filas) y 6 variables (columnas). Las columnas se nombran a partir de las variables originales.


```R
str(df)
```

    'data.frame':	7 obs. of  6 variables:
     $ nombre   : Factor w/ 7 levels "Agustín","Alejandra",..: 3 6 4 5 7 1 2
     $ genero   : Factor w/ 2 levels "F","M": 2 1 1 2 1 2 1
     $ edad     : num  22 19 44 32 23 55 33
     $ hijos    : logi  FALSE FALSE TRUE FALSE TRUE TRUE ...
     $ educacion: Ord.factor w/ 3 levels "pri"<"sec"<"uni": 2 2 3 2 3 3 1
     $ ingreso  : num  15000 7450 83300 NA 22000 ...


Observe que se utiliza $ para indicar a las columnas, además se muestra los tipos de datos. Esto nos recuerda al tipo de datos *list*, de hecho un *data.frame* es un caso particular de *list*, con filas y columnas.


```R
class(df)
```


	[1] 'data.frame'


```R
is.list(df)
```


	[1] TRUE


También observe que las columnas *nombre* y *genero* es de tipo factor. Mientras que las variables originales eran  de *character*. Cuando se crea un *data.frame* automáticamente transforma los vectores de *character* a *factor*.

Si queremos realizar un cambio en los tipos de datos podemos hacer transformaciones de tipos sobre algunas de las columnas, accediendo a la columna con el operador $.


```R
df$nombre <- as.character(df$nombre)
str(df)
```

    'data.frame':	7 obs. of  6 variables:
     $ nombre   : chr  "Damián" "Lucía" "Francisca" "Javier" ...
     $ genero   : Factor w/ 2 levels "F","M": 2 1 1 2 1 2 1
     $ edad     : num  22 19 44 32 23 55 33
     $ hijos    : logi  FALSE FALSE TRUE FALSE TRUE TRUE ...
     $ educacion: Ord.factor w/ 3 levels "pri"<"sec"<"uni": 2 2 3 2 3 3 1
     $ ingreso  : num  15000 7450 83300 NA 22000 ...


Otra forma es especificar en la creación del *data.frame* que no se debe convertir a factor los vectores de caracteres (*nombre* y *genero* se mantienen *character*):


```R
df.2 <- data.frame(nombre, genero, edad, hijos, educacion, ingreso, stringsAsFactors = FALSE)
str(df.2)
```

    'data.frame':	7 obs. of  6 variables:
     $ nombre   : chr  "Damián" "Lucía" "Francisca" "Javier" ...
     $ genero   : chr  "M" "F" "F" "M" ...
     $ edad     : num  22 19 44 32 23 55 33
     $ hijos    : logi  FALSE FALSE TRUE FALSE TRUE TRUE ...
     $ educacion: Ord.factor w/ 3 levels "pri"<"sec"<"uni": 2 2 3 2 3 3 1
     $ ingreso  : num  15000 7450 83300 NA 22000 ...


Para consultar por la cantidad de filas, columnas, y dimensiones usamos:


```R
nrow(df)
```
	[1] 7



```R
ncol(df)
```
	[1] 6



```R
dim(df)
```
	[1] 7 6


También podemos obtener los nombres de las columnas y renombrarlas usando *names()*. 

Por ejemplo si queremos renombrar la columna 'hijos'. Podemos usar un vector con los nombres de todas las columnas, o cambiar únicamente a la columna en cuestión usando el índice de columna.


```R
names(df)
```
	[1] "nombre"    "genero"    "edad"      "hijos"     "educacion" "ingreso"  


```R
# Opción 1: modificación de todos los nombres
names(df) <- c('nombre', 'genero', 'edad', 'tiene.hijos', 'educacion', 'ingreso')

# Opción 2 modificación del nombre de una columna
names(df)[4] <- 'tiene.hijos'

names(df)
```
	[1] "nombre"      "genero"      "edad"        "tiene.hijos" "educacion"   "ingreso"    

La función *summary()* nos da información de cada una de las columnas. En columnas numéricas muestra las 5 valores de resumen de los boxplot. En caso de variables categóricas muestra frecuencias. Además indica si existen NA.

```R
summary(df)
```

        nombre          genero      edad       tiene.hijos     educacion
     Length:7           F:4    Min.   :19.00   Mode :logical   pri:1    
     Class :character   M:3    1st Qu.:22.50   FALSE:4         sec:3    
     Mode  :character          Median :32.00   TRUE :3         uni:3    
                               Mean   :32.57                            
                               3rd Qu.:38.50                            
                               Max.   :55.00                            
                                                                        
        ingreso     
     Min.   : 7450  
     1st Qu.:10804  
     Median :18500  
     Mean   :33749  
     3rd Qu.:54505  
     Max.   :83300  
     NA's   :1      


### Selección de filas y columnas

Podemos utilizar el operador *\[\]* para seleccionar **filas** y **columnas** como en **matrix**. 

- Primero se selecciona a las filas y luego a las comunas (si se daja en blanco, se selecciona todo).
- Podemos usar los nombres de columnas.
- Se pueden excluir columnas o filas.
- Se puede usar selección por máscara.

Selección de columnas:

```R
df[, c("edad", "ingreso")]
```
	  edad ingreso
	1   22   15000
	2   19    7450
	3   44   83300
	4   32      NA
	5   23   22000
	6   55   65340
	7   33    9405


```R
# Si solo se especifica a un tipo de índice (sin separador ,), se toma como selección de columnas
df[c("edad", "ingreso")]
```
	  edad ingreso
	1   22   15000
	2   19    7450
	3   44   83300
	4   32      NA
	5   23   22000
	6   55   65340
	7   33    9405


```R
df[, -c(1, 6)]
```
	  genero edad tiene.hijos educacion
	1      M   22       FALSE       sec
	2      F   19       FALSE       sec
	3      F   44        TRUE       uni
	4      M   32       FALSE       sec
	5      F   23        TRUE       uni
	6      M   55        TRUE       uni
	7      F   33       FALSE       pri

Selección de filas:

```R
df[c(1,2,5), ]
```
	  nombre genero edad tiene.hijos educacion ingreso
	1 Damián      M   22       FALSE       sec   15000
	2  Lucía      F   19       FALSE       sec    7450
	5  Paola      F   23        TRUE       uni   22000


```R
df[c(T,T,F,F,T,F,F), ]
```
	  nombre genero edad tiene.hijos educacion ingreso
	1 Damián      M   22       FALSE       sec   15000
	2  Lucía      F   19       FALSE       sec    7450
	5  Paola      F   23        TRUE       uni   22000

Selección de filas y columnas:

```R
df[c(1,2,5), 1:3]
```
	  nombre genero edad
	1 Damián      M   22
	2  Lucía      F   19
	5  Paola      F   23

Si queremos seleccionar a una **columna** para acceder a la variable de tipo *vector* o *factor*, se usa selección como en **list**


```R
df$ingreso
```

    [1] 15000  7450 83300    NA 22000 65340  9405


```R
class(df$ingreso)
```
    [1] 'numeric'


```R
df[["ingreso"]]
```

    [1] 15000  7450 83300    NA 22000 65340  9405


```R
class(df[["ingreso"]])
```

    [1] 'numeric'


En cambio con corchetes simples es selección tipo *matrix*, devolviendo un *data.frame* con una única columna.


```R
df["ingreso"]
```

      ingreso
    1   15000
    2    7450
    3   83300
    4      NA
    5   22000
    6   65340
    7    9405

```R
class(df["ingreso"])
```
    [1] 'data.frame'


Es bastante útil generar máscaras a partir de las variables, y así seleccionar casos según sus valores: 


```R
df[df$genero == 'M', c("educacion", "ingreso")]
```
	  educacion ingreso
	1       sec   15000
	4       sec      NA
	6       uni   65340


```R
df[df$tiene.hijos == T & df$educacion == 'uni',]
```
	     nombre genero edad tiene.hijos educacion ingreso
	3 Francisca      F   44        TRUE       uni   83300
	5     Paola      F   23        TRUE       uni   22000
	6   Agustín      M   55        TRUE       uni   65340


También podemos seleccionar elementos de columnas a partir de las máscaras. Las siguientes tres formas son equivalentes:


```R
df[df$tiene.hijos == T,]$edad
```
	[1] 44 23 55



```R
df$edad[df$tiene.hijos == T]
```
	[1] 44 23 55


```R
df[df$tiene.hijos == T, "edad"]
```

	[1] 44 23 55



Ejemplo, ingreso promedio de personas con título universitario:


```R
mean(df$ingreso[df$educacion=='uni'], rm.na=TRUE)
```

	[1] 56880


### Ordenamiento

Para ordenar vectores en orden creciente usamos sort()


```R
df$edad
```
	[1] 22 19 44 32 23 55 33

```R
	sort(df$edad)
```
	[1] 19 22 23 32 33 44 55



Con order() obtenemos los índices o posiciones del vector ordenado:


```R
order(df$edad)
```
	[1] 2 1 5 4 7 3 6



Si se quiere ordenar las filas usamos los índices ordenados en la selección de filas del data.frame:


```R
df[order(df$edad), ]
```
	     nombre genero edad tiene.hijos educacion ingreso
	2     Lucía      F   19       FALSE       sec    7450
	1    Damián      M   22       FALSE       sec   15000
	5     Paola      F   23        TRUE       uni   22000
	4    Javier      M   32       FALSE       sec      NA
	7 Alejandra      F   33       FALSE       pri    9405
	3 Francisca      F   44        TRUE       uni   83300
	6   Agustín      M   55        TRUE       uni   65340


Para orden decreciente usamos el parámetro decreasing = TRUE:


```R
sort(df$edad,  decreasing = TRUE)
```
	[1] 55 44 33 32 23 22 19



```R
df[order(df$edad, decreasing = TRUE), ]
```

	     nombre genero edad tiene.hijos educacion ingreso
	6   Agustín      M   55        TRUE       uni   65340
	3 Francisca      F   44        TRUE       uni   83300
	7 Alejandra      F   33       FALSE       pri    9405
	4    Javier      M   32       FALSE       sec      NA
	5     Paola      F   23        TRUE       uni   22000
	1    Damián      M   22       FALSE       sec   15000
	2     Lucía      F   19       FALSE       sec    7450



### Agregar columnas
Podemos agregar columnas al data.frame usando cbind():


```R
altura <- c(1.7, 1.61, 1.57, 1.78, 1.72, 1.68, 1.66)
df = cbind(df, altura)
df
```
	     nombre genero edad tiene.hijos educacion ingreso altura
	1    Damián      M   22       FALSE       sec   15000   1.70
	2     Lucía      F   19       FALSE       sec    7450   1.61
	3 Francisca      F   44        TRUE       uni   83300   1.57
	4    Javier      M   32       FALSE       sec      NA   1.78
	5     Paola      F   23        TRUE       uni   22000   1.72
	6   Agustín      M   55        TRUE       uni   65340   1.68
	7 Alejandra      F   33       FALSE       pri    9405   1.66


También podemos usar el operador $ para agregar una nueva columna:


```R
df$peso = c(77, 55, 77, 85, 98, 60, 58) 
df
```

	     nombre genero edad tiene.hijos educacion ingreso altura peso
	1    Damián      M   22       FALSE       sec   15000   1.70   77
	2     Lucía      F   19       FALSE       sec    7450   1.61   55
	3 Francisca      F   44        TRUE       uni   83300   1.57   77
	4    Javier      M   32       FALSE       sec      NA   1.78   85
	5     Paola      F   23        TRUE       uni   22000   1.72   98
	6   Agustín      M   55        TRUE       uni   65340   1.68   60
	7 Alejandra      F   33       FALSE       pri    9405   1.66   58


O generar nuevas columnas a partir de resultados de operaciones:


```R
df$imc = df$peso / df$altura^2
df
```
	     nombre genero edad tiene.hijos educacion ingreso altura peso      imc
	1    Damián      M   22       FALSE       sec   15000   1.70   77 26.64360
	2     Lucía      F   19       FALSE       sec    7450   1.61   55 21.21832
	3 Francisca      F   44        TRUE       uni   83300   1.57   77 31.23859
	4    Javier      M   32       FALSE       sec      NA   1.78   85 26.82742
	5     Paola      F   23        TRUE       uni   22000   1.72   98 33.12601
	6   Agustín      M   55        TRUE       uni   65340   1.68   60 21.25850
	7 Alejandra      F   33       FALSE       pri    9405   1.66   58 21.04805

```R
df$obesidad = df$imc > 30
df
```
	     nombre genero edad tiene.hijos educacion ingreso altura peso      imc obesidad
	1    Damián      M   22       FALSE       sec   15000   1.70   77 26.64360    FALSE
	2     Lucía      F   19       FALSE       sec    7450   1.61   55 21.21832    FALSE
	3 Francisca      F   44        TRUE       uni   83300   1.57   77 31.23859     TRUE
	4    Javier      M   32       FALSE       sec      NA   1.78   85 26.82742    FALSE
	5     Paola      F   23        TRUE       uni   22000   1.72   98 33.12601     TRUE
	6   Agustín      M   55        TRUE       uni   65340   1.68   60 21.25850    FALSE
	7 Alejandra      F   33       FALSE       pri    9405   1.66   58 21.04805    FALSE


