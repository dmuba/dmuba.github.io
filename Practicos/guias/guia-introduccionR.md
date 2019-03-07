
# Guía: Introducción al lenguaje R

Esta guía es una introducción para conocer los fundamentos del lenguaje R. Se detallan los tipos de datos básicos y operaciones.

Esta guía está pensada para aquellos que están empezando a utilizar este lenguaje. Sin embargo se pueden hacer muchas cosas en R sin conocer a fondo sus tipos de datos. Por eso, una buena forma de utilizar esta guía es darle una primera mirada para tener las herramientas básicas para arrancar, y luego utilizarla de consulta a medida que uno se familiarise con el lenguaje.

## Variables

Las variables es donde se guardan valores (para luego poder operar a partir de estos). Se las identifica con un nombre único. Y se llaman variables, justamente, porque sus valores pueden ser cambiados.

Los nombres de variables deben seguir con las siguientes reglas:
- Deben empezar con una letra.
- Pueden contener números y letras (sin acentos ni ñ)
- Se distingue mayúsculas y minúsculas (ej la variable *resultado* es distinta a *Resultado*)
- Pueden contener el caracter guíon bajo: **_**
- ¡Puede conterner el caracter punto! **.** (a diferencia de muchos otros lenguajes)

Se las crea con la asignación de un valor. La asingnación se las hace con los operadores: **<-**, **->**, o **=**


```R
base <- 4
```


```R
print(base)
```

    [1] 4



```R
3 -> altura
```


```R
print(altura)
```

    [1] 3



```R
altura = 3
```


```R
print(altura)
```

    [1] 3


## Workspace

En el workspace se encuentran todas las variables que fuimos creando. Se puede consultar con la función **ls()**


```R
ls()
print(ls())
```


<ol class=list-inline>
	<li>'altura'</li>
	<li>'base'</li>
</ol>



    [1] "altura" "base"  


Si queremos eliminar una variable usamos la función **rm()**


```R
rm(altura)
```


```R
print(ls())
```

    [1] "base"


## R script
Un script de R es una lista de operaciones que se ejecuta de principio a fin siguiendo su flujo de ejecución (normalmente orden secuencial).

Los script en R llevan la extensión **.r**. Y nos permiten guardar tareas que pueden ser ejecutadas más de una vez.

Es muy útil agregar comentarios a los scripts. Para indicar que un texto es un comentario se utiliza el caracter **\#**. Todo lo que sigua a continuación de **\#** en la misma línea de código, es considerado comentario y no se ejecutará por el interprete de R. Son útiles para dejar documentado nuestro código.

#### triangulo.r
```R
# crea las variables base y altura del triángulo
base <- 3
altura <- 6
# Calcula el área
area <- base * altura / 2
print(area) # imprime resultado
```


```R
# crea las variables base y altura del triángulo
base <- 3
altura <- 6
# Calcula el área
area <- base * altura / 2
print(area) # imprime resultado
```

    [1] 9


# Tipos de datos

Como ya dijimos, las variables almacenan valores. Ahora estos valores pueden ser de distintos tipos. Existen tipos de datos simples, como números o textos. O compuestos como vectores o listas.

Para consultar el tipo de datos que tiene la variable (o mejor dicho el valor almacenado) se usa la función **class()**. A continuación veremos diferentes ejemplos de uso. Para tipos de datos más complejos esta función nos proporciona información muy general, para conocer más detalles se utilizan otras funciones adicionales, como por ejemplo **is.numeric()** o **is.vector()** (siguiendo el patrón is.*algo*), para consultar por un determinado tipo o subtipo de datos.

# Tipos de datos simples

## logical

Contienen los valores de verdad verdadero (TRUE o T) o falso (FALSE o F).


```R
TRUE
```


TRUE



```R
FALSE
```


FALSE



```R
T
```


TRUE



```R
F
```


FALSE



```R
class(TRUE)
```


'logical'


Son el resultados de las operaciones de comparación:
- Mayor >
- Menor <
- Mayor o igual >=
- Menor o igual <=
- Igual == [\*]
- Distinto !=

[\*] *Ojo no confundirse con = que es asignación, este es un error muy normal de programación, a veces difícl de detectar, ya que puede afectar a los resultados pero no arroja error*


```R
3 <= 5
```


TRUE



```R
7 != 7
```


FALSE



```R
TRUE > FALSE
```


TRUE



```R
class(8>4)
```


'logical'


Operaciones booleanas (Operaciones entre valores lógicos que devuelven otro valor lógico):
- And &
- OR |
- Not ! 


```R
TRUE & FALSE
```


FALSE



```R
TRUE | FALSE
```


TRUE



```R
!TRUE
```


FALSE


## numeric

Los valores numéricos contienen una jerarquía de tipos: Un numeric representa los valores reales, mientras un integer es un subconjunto del tipo numeric que representa a los enteros.


```R
class(2.5)
```


'numeric'



```R
class(2)
```


'numeric'


Para indicar que un número es de tipo *integer* debe especificarse explícitamente con una **L** como sufijo.


```R
class(2L)
```


'integer'


Comprobar subtipos de numéricos:


```R
is.numeric(2)
```


TRUE



```R
is.numeric(2L)
```


TRUE



```R
is.integer(2) 
```


FALSE



```R
is.integer(2L) 
```


TRUE


## character

El tipo de datos *character* permite representar textos en formato de cadenas de caracteres.

Una cadena de caracteres debe delimitarse entre comillas (simples o dobles).


```R
print("DM uba 2019")
```

    [1] "DM uba 2019"



```R
print('DM uba 2019')
```

    [1] "DM uba 2019"



```R
class("DM uba 2019")
```


'character'


La función nchar nos devuelve el tamaño de cadena en cantidad de caracteres:


```R
nchar("DM uba 2019")
```


11


En el caso de que el texto contega comillas del mismo tipo que usamos para deliminar la cadena, se utiliza el caracter **\\** (caracter de escape) para idicar que la comilla de a continuación no indica clausura de la cadena.


```R
"DM uba \"2019\""
```


'DM uba "2019"'



```R
'DM uba "2019"'
```


'DM uba "2019"'


## NA

Para representar datos faltantes r utiliza *NA* (equivalente a NULL en SQL).

Un NA puede ser introducido inicialmente para indicar un dato faltante o puede ser resultado de una operación en donde no se puede determinar un resultado válido.

Este valor especial no es un tipo de datos en sí. En R este valor es del tipo de datos *logical*. Sin embargo no representa un valor de verdad como TRUE y FALSE, y es compatible con otros tipos de datos, es decir que puede indicarse un NA para *numeric*, *character*, etc.


```R
NA
```


&lt;NA&gt;



```R
class(NA)
```


'logical'



```R
is.na(NA)
```


TRUE



```R
is.na("NA")
```


FALSE


Las operaciones con valores con *NA* dan como resultado *NA*.


```R
5 + NA + 6
```


&lt;NA&gt;



```R
TRUE & NA
```


&lt;NA&gt;



```R
"cadena" == NA
```


&lt;NA&gt;


## Coercion (transformación de tipos de datos)

En ciertas ocaciones nos resultará útil convertir el tipo de datos para realizar alguna operación (por ejemplo de cadena a numérico). A esta operación en programación se la conoce como **casting**. Cuando R tiene que hacer esta transformación de forma forzada para llevar una operación se habla de **coercion**.

Para llevar a cabo una transformación se utilizan funciones como *as.logical()*, *as.numeric()*, *as.character()*. Es decir *as.* seguido del tipo de datos a convertir.

### logical a numeric
R utiliza como tradución del valor TRUE al valor 1. Y de FALSE a 0.


```R
as.numeric(TRUE) 
```


1



```R
as.numeric(FALSE) 
```


0


### numeric a logical
De forma inversa traduce a 0 como FALSE, y al resto de los valores a TRUE.


```R
as.logical(122.2)
```


TRUE



```R
as.logical(-1)
```


TRUE



```R
as.logical(0)
```


FALSE


### logical o numeric a character


```R
as.character(4)
```


'4'



```R
as.character(F)
```


'FALSE'


### character a numeric o logical

Permite pasar de character a valores numericos o lógicos, siempre que los valores encerrados entre las comillas sean compatibles con el tipo de dato a convertir.


```R
as.numeric("4.5")
```


4.5



```R
as.logical("T") 
```


TRUE



```R
as.logical("FALSE") 
```


FALSE



```R
as.numeric("Hola")
```

    Warning message in eval(expr, envir, enclos):
    “NAs introduced by coercion”


&lt;NA&gt;


### NA
El valor NA no puede ser convertido, es decir un faltante sigue siendo faltante en caulquier tipo de datos.


```R
as.numeric(NA)
```


&lt;NA&gt;



```R
as.logical(NA)
```


&lt;NA&gt;



```R
as.character(NA)
```


NA


# Tipos de datos compuestos

## vector

Un *vector* es una secuencia de elementos de datos del **mismo tipo**. (Por ejemplo: *vector de numerics, *vector de characters*, *vector de *logicals*). Además puede tener elementos del tipo NA.

Para crear un vector usamos *c()* separando sus elementos por coma:


```R
frutas <- c("bananas", "peras", "manzanas", "manzanas", "peras")
```


```R
print(frutas)
```

    [1] "bananas"  "peras"    "manzanas" "manzanas" "peras"   



```R
is.vector(frutas)
```


TRUE



```R
class(frutas)
```


'character'



```R
x <- c(1, 2, 3, 4)
```


```R
print(x)
```

    [1] 1 2 3 4



```R
is.vector(x)
```


TRUE



```R
class(x)
```


'numeric'


Para crear un vector de numeros en secuencia puede usarse la siguiente nomenclatura: *valor_inicial:valor_final* (ambos valores son inclusivos)


```R
x <- 1:4
```


```R
print(x)
```

    [1] 1 2 3 4


Para conocer la cantidad de elementos se usa la función *length()*


```R
length(frutas)
```


5



```R
length(x)
```


4


Cada elemento contiene un índice. El primer elemento contiene el índice **1** (0 no es un índice). Para acceder a un elemento en particular usamos el número de índice y el operador *\[\]*.


```R
frutas[1]
```


'bananas'



```R
frutas[5]
```


'peras'



```R
x[3]
```


3


Si consultamos por un elemento en un índice superior a *length()* devuelve *NA*.


```R
frutas[6]
```


NA


### vectores con nombres

Podemos agregar nombres a los elementos. Para esto usamos la función *name()* asignando un vector de tipo *character* con el mismo número de elementos que el vector original.


```R
edades <- c(24, 55, 26, 34, 26)
nombres <- c('Javier', 'Marcela', 'Liliana', 'Claudia', 'Juan')
```


```R
names(edades) <- nombres
```


```R
print(edades)
```

     Javier Marcela Liliana Claudia    Juan 
         24      55      26      34      26 


*names()* también permite devolver los nombres asignados a los elementos.


```R
print(names(edades))
```

    [1] "Javier"  "Marcela" "Liliana" "Claudia" "Juan"   


Ahora se puede acceder a los elementos por su nombre:


```R
print(edades["Marcela"])
```

    Marcela 
         55 



```R
print(edades[2])
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


TRUE



```R
is.vector(mi_altura)
```


TRUE



```R
length(mi_altura)
```


1



```R
length(mi_nombre)
```


1



```R
nchar(mi_nombre)
```


6


### Coercion en vectores

Los vectores tienen que ser del mismo tipo, por lo tanto realiza las transformaciones necesarias para lograr que todos los elementos sean del mismo tipo.


```R
vec <- c(5, 3, "T", "10", 1, 2, NA, "Q")
```


```R
print(vec)
```

    [1] "5"  "3"  "T"  "10" "1"  "2"  NA   "Q" 



```R
class(vec)
```


'character'



```R
length(vec)
```


8


### Operaciones de vectores

Las operaciones entre dos vectores se hacen por pares de elementos según su índice.


```R
x <- c(3, 5, 10)
y <- c(2, 6, 6)
print(x + y)
```

    [1]  5 11 16



```R
print(x >= y)
```

    [1]  TRUE FALSE  TRUE


Cuando se realiza una operación entre un vector y un escalar (es decir un unico elemento). Este se aplica sobre cada uno de los elementos del vecto.


```R
x <- c(3, 5, 10)
```


```R
print(x + 1)
```

    [1]  4  6 11



```R
print(x/2)
```

    [1] 1.5 2.5 5.0



```R
print(x * 2)
```

    [1]  6 10 20



```R
print(x^2)
```

    [1]   9  25 100


Cuando los vectores no tienen el mismo tamaño, se extiende el vector de menor tamaño repitiendo la secuencia de sus elementos.


```R
x <- c(3, 5, 2, 10)
y <- c(4, 9)
print(x+y)
```

    [1]  7 14  6 19



```R
x <- c(3, 5, 2, 10)
y <- c(4, 9, 4, 9)
print(x+y)
```

    [1]  7 14  6 19


Concatenación entre vectores:


```R
x <- c(3, 5, 2, 10)
y <- c(4, 9)
xy = c(x, y)
```


```R
print(xy)
```

    [1]  3  5  2 10  4  9


Si queremos agregar un único elemento, usamos concatenación:


```R
x <- c(3, 5, 2, 10)
x = c(x, 44)
print(x)
```

    [1]  3  5  2 10 44


Funciones útiles sobre vectores:


```R
x <- c(3, 5, 2, 10)
```


```R
sum(x) 
```


20



```R
mean(x)
```


5



```R
median(x)
```


4



```R
sd(x)
```


3.55902608401044


Cuidado con los missings:


```R
mean(c(7, 8, 6, NA, 10))
```


&lt;NA&gt;



```R
mean(c(7, 8, 6, NA, 10), na.rm = TRUE)
```


7.75


### Sub-vectores

Vimos que el operador \[\] nos permite acceder a elementos del vector, pero a su vez, un elemento es un vector en si mismo. Por este motivo usando \[\] podemos formar nuevos vectores a partir de los elementos de un vector.


```R
edades <- c(Javier=24, Marcela=55, Liliana=26, Claudia=34, Juan=26)
print(edades)
```

     Javier Marcela Liliana Claudia    Juan 
         24      55      26      34      26 


Usamos un vector de éndices para seleccionar los elementos.


```R
print(edades[c(1,3)])
```

     Javier Liliana 
         24      26 


El órden sí importa:


```R
print(edades[c(3, 1)])
```

    Liliana  Javier 
         26      24 


También podemos usar nombres:


```R
print(edades[c("Javier", "Liliana")])
```

     Javier Liliana 
         24      26 


Se usan índices negativos para excluir elementos


```R
print(edades[-c(1,3)])
```

    Marcela Claudia    Juan 
         55      34      26 



```R
print(edades[-1])
```

    Marcela Liliana Claudia    Juan 
         55      26      34      26 


No se puede excluir usando nombres:


```R
edades[-c("Javier", "Liliana")]
```


    Error in -c("Javier", "Liliana"): invalid argument to unary operator
    Traceback:



Otra forma de selección es usar vectores lógicos. Al operador \[\] debe pasarse un vector de tipo *logical* con la misma cantidad de elementos que el vector original. El valor TRUE indica que selecciona el elemento, y FALSE indica que se excluye.

A este tipo de vector de selección también se lo conoce como máscara.


```R
print(edades[c(FALSE, TRUE, FALSE, TRUE)])
```

    Marcela Claudia 
         55      34 



```R
print(edades[edades > 30])
```

    Marcela Claudia 
         55      34 


En el caso de pasarse menor número de elementos en la máscara, realiza extensión del vector:


```R
print(edades[c(T,F)]) # selecciona impares
```

     Javier Liliana    Juan 
         24      26      26 



```R
print(edades[c(T,F,T,F,T)])
```

     Javier Liliana    Juan 
         24      26      26 


## Matrix
Las matrices son arreglos de elementos de 2 dimensiones. De la misma forma que un vector es un arreglo de elementos de 1 dimensión. Es decir que podría verse como un vector de vectores de misma cantidad de elementos.

Las matrices se dividen en filas (primera dimensión) y columnas (segunda dimensión)

De la misma forma que los vectores sólo admiten elementos del **mismo tipo** y NA.

### Creación de matrices

Se especifica los elementos como un vector, y las cantidad de filas y columnas en que se van a distribuir.


```R
m <- matrix(1:6, nrow = 3)
print(m)
```

         [,1] [,2]
    [1,]    1    4
    [2,]    2    5
    [3,]    3    6



```R
m <- matrix(1:6, ncol = 3)
print(m)
```

         [,1] [,2] [,3]
    [1,]    1    3    5
    [2,]    2    4    6



```R
m <- matrix(1:6, nrow = 2, byrow = TRUE) 
print(m)
```

         [,1] [,2] [,3]
    [1,]    1    2    3
    [2,]    4    5    6



```R
m <- matrix(0, nrow=2, ncol=3)
print(m)
```

         [,1] [,2] [,3]
    [1,]    0    0    0
    [2,]    0    0    0



```R
class(m)
```


'matrix'



```R
is.numeric(m)
```


TRUE


*nrow()* devuelve la cantidad de filas


```R
nrow(m)
```


2


*ncol()* devuelve la cantidad de columnas


```R
ncol(m)
```


3


*ndim()* devuelve un vector de dos elementos con cantidad de filas y cantidad de columnas


```R
dim(m)
```


<ol class=list-inline>
	<li>2</li>
	<li>3</li>
</ol>



*length()* Devuelve la cantidad total de elementos


```R
length(m)
```


6


### Concatenación de filas o columnas

Con las funciones *rbind()*/*cbind* podemos concatenar filas/columnas.


```R
m = matrix(1:6, nrow=3)
print(m)
```

         [,1] [,2]
    [1,]    1    4
    [2,]    2    5
    [3,]    3    6



```R
print(cbind(m, 7:9))
```

         [,1] [,2] [,3]
    [1,]    1    4    7
    [2,]    2    5    8
    [3,]    3    6    9



```R
print(rbind(m, matrix(c(7, 7, 8, 8), nrow=2, byrow=TRUE)))
```

         [,1] [,2]
    [1,]    1    4
    [2,]    2    5
    [3,]    3    6
    [4,]    7    7
    [5,]    8    8


### Coercion en matrices


```R
m <- matrix(c(1,2,3, "A", "B", NA), nrow=2, byrow=TRUE)
print(m)
```

         [,1] [,2] [,3]
    [1,] "1"  "2"  "3" 
    [2,] "A"  "B"  NA  



```R
is.character(m)
```


TRUE



```R
is.numeric(m)
```


FALSE


### columnas o filas con nombres

En matrices se pueden nombrar a sus filas y columnas.


```R
m <- matrix(c(10, 20, 33, 5, 15, 30), nrow=2, ncol=3, byrow=T)
rownames(m) <- c("fila1", "fila2")
print(m)
```

          [,1] [,2] [,3]
    fila1   10   20   33
    fila2    5   15   30



```R
m <- matrix(c(10, 20, 33, 5, 15, 30), nrow=2, ncol=3, byrow=T)
colnames(m) <- c("col1", "col2", "col3")
print(m)
```

         col1 col2 col3
    [1,]   10   20   33
    [2,]    5   15   30



```R
m <- matrix(c(10, 20, 33, 5, 15, 30), nrow=2, ncol=3, byrow=T)
rownames(m) <- c("fila1", "fila2")
colnames(m) <- c("col1", "col2", "col3")
print(m)
```

          col1 col2 col3
    fila1   10   20   33
    fila2    5   15   30


### Subselección en matrices

De la misma manera que en vector se utiliza el operador *\[\]* para acceder a sus elementos y seleccionar sub-matrices o sub-vectores.
En este se debe especificar la selección de filas, y columnas.


```R
m <- matrix(c(10, 20, 33, 5, 15, 30), nrow=2, ncol=3, byrow=T)
rownames(m) <- c("fila1", "fila2")
colnames(m) <- c("col1", "col2", "col3")
print(m)
```

          col1 col2 col3
    fila1   10   20   33
    fila2    5   15   30


Si se quiere acceder al elemento de la primera fila y segunda columna:


```R
m[1,2]
```


20


O utilizando nombres:


```R
m["fila1","col2"] 
```


20


Selección de segunda fila:


```R
print(m[2, ])
```

    col1 col2 col3 
       5   15   30 



```R
print(m["fila2", ])
```

    col1 col2 col3 
       5   15   30 


Selección de tercera columna:


```R
print(m[, 3])
```

    fila1 fila2 
       33    30 



```R
print(m[, "col3"])
```

    fila1 fila2 
       33    30 


También se pueden seleccionar filas y columnas a la vez.


```R
print(m[c(1, 2), c(2, 3)])
```

          col2 col3
    fila1   20   33
    fila2   15   30



```R
print(m["fila1", c("col1", "col2")])
```

    col1 col2 
      10   20 


Se pueden excluir filas o columnas


```R
print(m["fila2", -3])
```

    col1 col2 
       5   15 


Se pueden usar máscaras de selección


```R
print(m[c(F,T), c(T,F,T)])
```

    col1 col3 
       5   30 


También se pueden seleccionar elementos (en formato de vector)


```R
print(m[m>15])
```

    [1] 20 33 30


### Operaciones de matrices

De la misma manera que en vectores las operaciones son por pares de elementos.


```R
m1 <- matrix(c(10, 20, 30, 40, 50, 60), nrow=2, ncol=3, byrow=T)
m2 <- matrix(c(1:6), nrow=2, ncol=3, byrow=T)
```


```R
print(m1 + m2)
```

         [,1] [,2] [,3]
    [1,]   11   22   33
    [2,]   44   55   66



```R
print(m1 * 10)
```

         [,1] [,2] [,3]
    [1,]  100  200  300
    [2,]  400  500  600



```R
print(m1 - 20 < m2)
```

          [,1]  [,2]  [,3]
    [1,]  TRUE  TRUE FALSE
    [2,] FALSE FALSE FALSE


Se pueden hacer opereraciones por fila, columnas o con todos sus elementos:


```R
print(colSums(m1))
```

    [1] 50 70 90



```R
print(rowSums(m1))
```

    [1]  60 150



```R
sum(m)
```


113


## Factors

Este tipo de datos se utiliza para representar datos categóricos en R.

Al igual que los vectores una variable de tipo *factor* contienen una secuencias de elementos, pero en este caso los elementos codifican a un número de categorías finitas.

Por ejemplo partimos de un vector con marcas de gaseosas


```R
vector_gaseosas <- c("coca-cola", "manaos", "fanta", "manaos", "coca-cola", "pepsi")
```


```R
print(vector_gaseosas)
```

    [1] "coca-cola" "manaos"    "fanta"     "manaos"    "coca-cola" "pepsi"    



```R
class(vector_gaseosas)
```


'character'


A partir de este vector se puede generar una variable de tipo *factor*. Las categorías don llamadas *levels*.

Cuando se crea una variable de tipo factor, R automáticamente genera los las categorías o *levels* asociados.


```R
gaseosas <- factor(vector_gaseosas)
```


```R
print(gaseosas)
```

    [1] coca-cola manaos    fanta     manaos    coca-cola pepsi    
    Levels: coca-cola fanta manaos pepsi



```R
class(gaseosas)
```


'factor'


R genera a los *levels* a partir de los valores del vector y los ordenas en orden alfabético.

Si se necesita especificar todos las categorías posibles, o si se quiere dar un orden diferentes a las categorías se usa el parámetro *levels* en la creación del *factor*.


```R
provincias <- factor(c("Formosa", "Corrientes", "Neuquén", "Buenos Aires", "Mendoza", "Santa Fe", "Mendoza"),
                     levels = c("Buenos Aires", "Catamarca", 
                                "Chaco", "Chubut", "Córdoba", "Corrientes", 
                                "Entre Ríos", "Formosa", "Jujuy", 
                                "La Pampa", "La Rioja", "Mendoza", 
                                "Misiones", "Neuquén", "Río Negro", 
                                "Salta", "San Juan", "San Luis", "Santa Cruz", "Santa Fe", 
                                "Santiago del Estero", "Tierra del Fuego",
                                "Tucumán"))
```


```R
print(provincias)
```

    [1] Formosa      Corrientes   Neuquén      Buenos Aires Mendoza     
    [6] Santa Fe     Mendoza     
    23 Levels: Buenos Aires Catamarca Chaco Chubut Córdoba ... Tucumán


Con *levels()* se obtiene el listado de categorías


```R
levels(gaseosas)
```


<ol class=list-inline>
	<li>'coca-cola'</li>
	<li>'fanta'</li>
	<li>'manaos'</li>
	<li>'pepsi'</li>
</ol>



En *factor* cada elemento se representa en un valor numérico según su *level* o categoría asociada. Si se convierte a tipo numérico se puede ver su representación en *levels*.*


```R
as.numeric(gaseosas)
```


<ol class=list-inline>
	<li>1</li>
	<li>3</li>
	<li>2</li>
	<li>3</li>
	<li>1</li>
	<li>4</li>
</ol>



Es posible renombrar a las categorías usando la función *levels()*


```R
# rename factors
levels(gaseosas) <- c('marca_coca', 'marca_fanta', 'marca_manaos', 'marca_pepsi')
```


```R
print(gaseosas)
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


&lt;NA&gt;


*Factor* también permite representar **categóricos ordinales**. En este caso debe pasarse en la función *factor()* como parámetro a ordered en TRUE (por defecto este es FALSE). Además en *levels* deben pasarse las categorías en orden creciente.


```R
estudios <- factor(c('universitario', 'secundario', 'universitario', 'primario'),
                   ordered = TRUE,
                   levels = c("primario", "secundario", "universitario")) 
```


```R
print(estudios)
```

    [1] universitario secundario    universitario primario     
    Levels: primario < secundario < universitario



```R
estudios[1] > estudios[2]
```


TRUE



```R
class(estudios)
```


<ol class=list-inline>
	<li>'ordered'</li>
	<li>'factor'</li>
</ol>



## List

Hasta ahora los tipos de datos compuestos permiten representar elementos del mismo tipo. Si se quieren representar datos de distintos tipos en una misma variable se utiliza el tipo de dato *list*.

Este tipo de datos permite representar estructuras de datos más complejas, pero como contra es que se pierde funcionalidaddes que podemos hacer con otros tipos de datos (Por ejemplo realizar operaciones aritméticas, o comparaciones)

Por ejemplo si quremos representar los siguientes elementos en un *vector*, se convierten todos en *character* por *coercion*


```R
c("Homero Simpson", "7-G", 1956, T)
```


<ol class=list-inline>
	<li>'Homero Simpson'</li>
	<li>'7-G'</li>
	<li>'1956'</li>
	<li>'TRUE'</li>
</ol>



Con *list* se pueden mantener los tipos originales.


```R
empleado <- list("Homero Simpson", "7-G", 1956, T)
```


```R
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


'list'



```R
is.list(empleado)
```


TRUE


De la siguiente manera podemos acceder a sus elementos (operador *\[\]*):


```R
empleado[[1]]
```


'Homero Simpson'



```R
empleado[[3]]
```


1956


Los elementos de la lista se pueden nombrar.


```R
names(empleado) <- c("nombre", "sector", "anio_nacimiento", "casado")
```


```R
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


'Homero Simpson'



```R
empleado$sector
```


'7-G'



```R
empleado[["casado"]]
```


TRUE


# Data Frame

Cuando utilicemos R normalmente vamos a trabajar con variables de tipo *data.frame*. Un *data.frame* representa un conjunto de datos. Este es nuestro objeto de estudio.

*data.frame* es un tipo de datos más complejo de los que vimos hasta ahora. Y comprende las características de todos los tipos de datos anteriores.

Un *data.frame* es un tipo de datos de **dos dimensiones** (como matrix)

Contiene **observaciones** o **casos**: **filas**

Y **variables** o **propiedades** asociadas a las observaciones: **columnas**

Pero a diferencia de la matrices, las columnas pueden ser de distintos tipos.

Cada columna a su vez es un *vector* de un único tipo de datos, o de tipo *factor* para representar variables categóricas.

Un *data.frame* puede ser importado desde una fuentes de datos (ej archivo csv o desde una DB a traves de una consulta SQL).

Para crear un data.frame desde cero, es decir desde códifo. Primero creamos las variables de tipo *vector* o *factor* que luego serán sus columnas. Todos tienen que tener la misma cantidad de elementos.


```R
nombre <- c("Damián", "Lucía", "Francisca", "Javier", "Paola", "Agustín", "Alejandra")
genero <- c('M', 'F', 'F', 'M', 'F', 'M', 'F')
edad <- c(22, 19, 44, 32, 23, 55, 33)
hijos <- c(F, F, T, F, T, T, F)
educacion <- factor(c('sec', 'sec', 'uni', 'sec', 'uni', 'uni', 'pri'), levels= c('pri', 'sec', 'uni'), ordered=TRUE)
ingreso <- c(15000, 7450, 83300, NA, 22000, 65340, 9405)
```


```R
df <- data.frame(nombre, genero, edad, hijos, educacion, ingreso)
```


```R
print(df)
```

         nombre genero edad hijos educacion ingreso
    1    Damián      M   22 FALSE       sec   15000
    2     Lucía      F   19 FALSE       sec    7450
    3 Francisca      F   44  TRUE       uni   83300
    4    Javier      M   32 FALSE       sec      NA
    5     Paola      F   23  TRUE       uni   22000
    6   Agustín      M   55  TRUE       uni   65340
    7 Alejandra      F   33 FALSE       pri    9405


El dataset contiene 7 observaciones y 6 variables. Las columnas se nombran a partir de las variables originales.


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


Observe que se utiliza $ para indicar a las columnas, además se indica los tipos de datos. Esto nos recuerda al tipo de datos *list*, de hecho un *data.frame* es un caso particular de *list*, con filas y columnas.


```R
class(df)
```


'data.frame'



```R
is.list(df)
```


TRUE


También observe que la columna *nombre* es de tipo factor. Mientras que la variable original era un vector de *character*. Cuando se crea un *data.frame* autumáticamente transforma los vectores de *character* a *factor*.

De todas formas si queremos realizar un cambio en los tipos de datos podemos hacer casting sobre algunas de las variables, accediendo con el operador $.


```R
df$nombre <- as.character(df$nombre)
```


```R
str(df)
```

    'data.frame':	7 obs. of  6 variables:
     $ nombre   : chr  "Damián" "Lucía" "Francisca" "Javier" ...
     $ genero   : Factor w/ 2 levels "F","M": 2 1 1 2 1 2 1
     $ edad     : num  22 19 44 32 23 55 33
     $ hijos    : logi  FALSE FALSE TRUE FALSE TRUE TRUE ...
     $ educacion: Ord.factor w/ 3 levels "pri"<"sec"<"uni": 2 2 3 2 3 3 1
     $ ingreso  : num  15000 7450 83300 NA 22000 ...


Otra forma es especificar en la creación del *data.frame* que no queremos convertir a factor las cadenas de caracteres. En este caso además mantiene genero como *character*:


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


7



```R
ncol(df)
```


6



```R
dim(df)
```


<ol class=list-inline>
	<li>7</li>
	<li>6</li>
</ol>



También podemos obtener los nombres de las columnas y renombrarlas usando *names()*. Por ejemplo si queremos renombrar la columna 'hijos'. Podemos usar un vector con los nombres de todas las columnas, o cambiar únicamente a la columna en cuestión usando el índice de columna.


```R
names(df)
```


<ol class=list-inline>
	<li>'nombre'</li>
	<li>'genero'</li>
	<li>'edad'</li>
	<li>'hijos'</li>
	<li>'educacion'</li>
	<li>'ingreso'</li>
</ol>




```R
names(df) <- c('nombre', 'genero', 'edad', 'tiene.hijos', 'educacion', 'ingreso')
```


```R
names(df)[4] <- 'tiene.hijos'
```


```R
names(df)
```


<ol class=list-inline>
	<li>'nombre'</li>
	<li>'genero'</li>
	<li>'edad'</li>
	<li>'tiene.hijos'</li>
	<li>'educacion'</li>
	<li>'ingreso'</li>
</ol>



La función *summary()* nos da información de cada una de las columnas. En valores numéricos muestra las 5 valores de resumen de los boxplot. En caso de varialbes categóricas muestra frecuencias. Además indica si existen NA.


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


## Selección de filas y columnas

Podemos utilizar el operador *\[\]* para seleccionar **filas** y **columnas** como en **matrix**. 

- Primero se selecciona a las filas y luego a las comunas (si se daja en blanco, se selecciona todo).
- Podemos usar los nombres de columnas.
- Se solo se utiliza un solo tipo de índice se considera selección de columnas.
- Se pueden excluir columnas o filas.
- Se puede usar selección por máscara


```R
df[, c("edad", "ingreso")]
```


<table>
<thead><tr><th scope=col>edad</th><th scope=col>ingreso</th></tr></thead>
<tbody>
	<tr><td>22   </td><td>15000</td></tr>
	<tr><td>19   </td><td> 7450</td></tr>
	<tr><td>44   </td><td>83300</td></tr>
	<tr><td>32   </td><td>   NA</td></tr>
	<tr><td>23   </td><td>22000</td></tr>
	<tr><td>55   </td><td>65340</td></tr>
	<tr><td>33   </td><td> 9405</td></tr>
</tbody>
</table>




```R
df[c("edad", "ingreso")]
```


<table>
<thead><tr><th scope=col>edad</th><th scope=col>ingreso</th></tr></thead>
<tbody>
	<tr><td>22   </td><td>15000</td></tr>
	<tr><td>19   </td><td> 7450</td></tr>
	<tr><td>44   </td><td>83300</td></tr>
	<tr><td>32   </td><td>   NA</td></tr>
	<tr><td>23   </td><td>22000</td></tr>
	<tr><td>55   </td><td>65340</td></tr>
	<tr><td>33   </td><td> 9405</td></tr>
</tbody>
</table>




```R
df[, -c(1, 6)]
```


<table>
<thead><tr><th scope=col>genero</th><th scope=col>edad</th><th scope=col>tiene.hijos</th><th scope=col>educacion</th></tr></thead>
<tbody>
	<tr><td>M    </td><td>22   </td><td>FALSE</td><td>sec  </td></tr>
	<tr><td>F    </td><td>19   </td><td>FALSE</td><td>sec  </td></tr>
	<tr><td>F    </td><td>44   </td><td> TRUE</td><td>uni  </td></tr>
	<tr><td>M    </td><td>32   </td><td>FALSE</td><td>sec  </td></tr>
	<tr><td>F    </td><td>23   </td><td> TRUE</td><td>uni  </td></tr>
	<tr><td>M    </td><td>55   </td><td> TRUE</td><td>uni  </td></tr>
	<tr><td>F    </td><td>33   </td><td>FALSE</td><td>pri  </td></tr>
</tbody>
</table>




```R
df[c(1,2,5), ]
```


<table>
<thead><tr><th></th><th scope=col>nombre</th><th scope=col>genero</th><th scope=col>edad</th><th scope=col>tiene.hijos</th><th scope=col>educacion</th><th scope=col>ingreso</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>Damián</td><td>M     </td><td>22    </td><td>FALSE </td><td>sec   </td><td>15000 </td></tr>
	<tr><th scope=row>2</th><td>Lucía </td><td>F     </td><td>19    </td><td>FALSE </td><td>sec   </td><td> 7450 </td></tr>
	<tr><th scope=row>5</th><td>Paola </td><td>F     </td><td>23    </td><td> TRUE </td><td>uni   </td><td>22000 </td></tr>
</tbody>
</table>




```R
df[c(T,T,F,F,T,F,F), ]
```


<table>
<thead><tr><th></th><th scope=col>nombre</th><th scope=col>genero</th><th scope=col>edad</th><th scope=col>tiene.hijos</th><th scope=col>educacion</th><th scope=col>ingreso</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>Damián</td><td>M     </td><td>22    </td><td>FALSE </td><td>sec   </td><td>15000 </td></tr>
	<tr><th scope=row>2</th><td>Lucía </td><td>F     </td><td>19    </td><td>FALSE </td><td>sec   </td><td> 7450 </td></tr>
	<tr><th scope=row>5</th><td>Paola </td><td>F     </td><td>23    </td><td> TRUE </td><td>uni   </td><td>22000 </td></tr>
</tbody>
</table>



Si queremos seleccionar a una **columna** para obtener la variable de tipo *vector* o *factor*, usamos selección como en **list**


```R
print(df$ingreso)
```

    [1] 15000  7450 83300    NA 22000 65340  9405



```R
class(df$ingreso)
```


'numeric'



```R
print(df[["ingreso"]])
```

    [1] 15000  7450 83300    NA 22000 65340  9405



```R
class(df[["ingreso"]])
```


'numeric'


En cambio con corchetes simples es selección tipo *matrix* devolviendo un *data.frame* con una única columna.


```R
print(df["ingreso"])
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


'data.frame'


Es bastante útil generar máscaras a partir de las variables, y así seleccionar casos según sus valores: 


```R
df[df$genero == 'M', c("educacion", "ingreso")]
```


<table>
<thead><tr><th></th><th scope=col>educacion</th><th scope=col>ingreso</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>sec  </td><td>15000</td></tr>
	<tr><th scope=row>4</th><td>sec  </td><td>   NA</td></tr>
	<tr><th scope=row>6</th><td>uni  </td><td>65340</td></tr>
</tbody>
</table>




```R
df[df$tiene.hijos == T & df$educacion == 'uni',]
```


<table>
<thead><tr><th></th><th scope=col>nombre</th><th scope=col>genero</th><th scope=col>edad</th><th scope=col>tiene.hijos</th><th scope=col>educacion</th><th scope=col>ingreso</th></tr></thead>
<tbody>
	<tr><th scope=row>3</th><td>Francisca</td><td>F        </td><td>44       </td><td>TRUE     </td><td>uni      </td><td>83300    </td></tr>
	<tr><th scope=row>5</th><td>Paola    </td><td>F        </td><td>23       </td><td>TRUE     </td><td>uni      </td><td>22000    </td></tr>
	<tr><th scope=row>6</th><td>Agustín  </td><td>M        </td><td>55       </td><td>TRUE     </td><td>uni      </td><td>65340    </td></tr>
</tbody>
</table>



También podemos seleccionar columnas a partir de las máscaras. Las siguientes tres formas son equivalentes:


```R
df[df$tiene.hijos == T,]$edad
```


<ol class=list-inline>
	<li>44</li>
	<li>23</li>
	<li>55</li>
</ol>




```R
df$edad[df$tiene.hijos == T]
```


<ol class=list-inline>
	<li>44</li>
	<li>23</li>
	<li>55</li>
</ol>




```R
df[df$tiene.hijos == T, "edad"]
```


<ol class=list-inline>
	<li>44</li>
	<li>23</li>
	<li>55</li>
</ol>



Ejemplo, ingreso promedio de personas con título universitario:


```R
mean(df$ingreso[df$educacion=='uni'], rm.na=TRUE)
```


56880


## Ordenamiento de filas

Para ordenar vectores en orden creciente usamos sort()


```R
df$edad
```


<ol class=list-inline>
	<li>22</li>
	<li>19</li>
	<li>44</li>
	<li>32</li>
	<li>23</li>
	<li>55</li>
	<li>33</li>
</ol>




```R
sort(df$edad)
```


<ol class=list-inline>
	<li>19</li>
	<li>22</li>
	<li>23</li>
	<li>32</li>
	<li>33</li>
	<li>44</li>
	<li>55</li>
</ol>



Con order obtenemos los índices o posiciones del vector del ordenamiento:


```R
order(df$edad)
```


<ol class=list-inline>
	<li>2</li>
	<li>1</li>
	<li>5</li>
	<li>4</li>
	<li>7</li>
	<li>3</li>
	<li>6</li>
</ol>



Si se quiere ordenar las filas usamos los índices ordenados en la selección de filas del data.frame:


```R
df[order(df$edad), ]
```


<table>
<thead><tr><th></th><th scope=col>nombre</th><th scope=col>genero</th><th scope=col>edad</th><th scope=col>tiene.hijos</th><th scope=col>educacion</th><th scope=col>ingreso</th></tr></thead>
<tbody>
	<tr><th scope=row>2</th><td>Lucía    </td><td>F        </td><td>19       </td><td>FALSE    </td><td>sec      </td><td> 7450    </td></tr>
	<tr><th scope=row>1</th><td>Damián   </td><td>M        </td><td>22       </td><td>FALSE    </td><td>sec      </td><td>15000    </td></tr>
	<tr><th scope=row>5</th><td>Paola    </td><td>F        </td><td>23       </td><td> TRUE    </td><td>uni      </td><td>22000    </td></tr>
	<tr><th scope=row>4</th><td>Javier   </td><td>M        </td><td>32       </td><td>FALSE    </td><td>sec      </td><td>   NA    </td></tr>
	<tr><th scope=row>7</th><td>Alejandra</td><td>F        </td><td>33       </td><td>FALSE    </td><td>pri      </td><td> 9405    </td></tr>
	<tr><th scope=row>3</th><td>Francisca</td><td>F        </td><td>44       </td><td> TRUE    </td><td>uni      </td><td>83300    </td></tr>
	<tr><th scope=row>6</th><td>Agustín  </td><td>M        </td><td>55       </td><td> TRUE    </td><td>uni      </td><td>65340    </td></tr>
</tbody>
</table>




```R
df
```


<table>
<thead><tr><th scope=col>nombre</th><th scope=col>genero</th><th scope=col>edad</th><th scope=col>tiene.hijos</th><th scope=col>educacion</th><th scope=col>ingreso</th></tr></thead>
<tbody>
	<tr><td>Damián   </td><td>M        </td><td>22       </td><td>FALSE    </td><td>sec      </td><td>15000    </td></tr>
	<tr><td>Lucía    </td><td>F        </td><td>19       </td><td>FALSE    </td><td>sec      </td><td> 7450    </td></tr>
	<tr><td>Francisca</td><td>F        </td><td>44       </td><td> TRUE    </td><td>uni      </td><td>83300    </td></tr>
	<tr><td>Javier   </td><td>M        </td><td>32       </td><td>FALSE    </td><td>sec      </td><td>   NA    </td></tr>
	<tr><td>Paola    </td><td>F        </td><td>23       </td><td> TRUE    </td><td>uni      </td><td>22000    </td></tr>
	<tr><td>Agustín  </td><td>M        </td><td>55       </td><td> TRUE    </td><td>uni      </td><td>65340    </td></tr>
	<tr><td>Alejandra</td><td>F        </td><td>33       </td><td>FALSE    </td><td>pri      </td><td> 9405    </td></tr>
</tbody>
</table>



Para order decreciente usamos el parámetro decreasing = TRUE:


```R
sort(df$edad,  decreasing = TRUE)
```


<ol class=list-inline>
	<li>55</li>
	<li>44</li>
	<li>33</li>
	<li>32</li>
	<li>23</li>
	<li>22</li>
	<li>19</li>
</ol>




```R
df[order(df$edad, decreasing = TRUE), ]
```


<table>
<thead><tr><th></th><th scope=col>nombre</th><th scope=col>genero</th><th scope=col>edad</th><th scope=col>tiene.hijos</th><th scope=col>educacion</th><th scope=col>ingreso</th></tr></thead>
<tbody>
	<tr><th scope=row>6</th><td>Agustín  </td><td>M        </td><td>55       </td><td> TRUE    </td><td>uni      </td><td>65340    </td></tr>
	<tr><th scope=row>3</th><td>Francisca</td><td>F        </td><td>44       </td><td> TRUE    </td><td>uni      </td><td>83300    </td></tr>
	<tr><th scope=row>7</th><td>Alejandra</td><td>F        </td><td>33       </td><td>FALSE    </td><td>pri      </td><td> 9405    </td></tr>
	<tr><th scope=row>4</th><td>Javier   </td><td>M        </td><td>32       </td><td>FALSE    </td><td>sec      </td><td>   NA    </td></tr>
	<tr><th scope=row>5</th><td>Paola    </td><td>F        </td><td>23       </td><td> TRUE    </td><td>uni      </td><td>22000    </td></tr>
	<tr><th scope=row>1</th><td>Damián   </td><td>M        </td><td>22       </td><td>FALSE    </td><td>sec      </td><td>15000    </td></tr>
	<tr><th scope=row>2</th><td>Lucía    </td><td>F        </td><td>19       </td><td>FALSE    </td><td>sec      </td><td> 7450    </td></tr>
</tbody>
</table>



## Agregar columnas
Podemos agregar columnas al dataframa usando cbind():


```R
altura <- c(1.7, 1.61, 1.57, 1.78, 1.72, 1.68, 1.66)
df = cbind(df, altura)
df
```


<table>
<thead><tr><th scope=col>nombre</th><th scope=col>genero</th><th scope=col>edad</th><th scope=col>tiene.hijos</th><th scope=col>educacion</th><th scope=col>ingreso</th><th scope=col>altura</th></tr></thead>
<tbody>
	<tr><td>Damián   </td><td>M        </td><td>22       </td><td>FALSE    </td><td>sec      </td><td>15000    </td><td>1.70     </td></tr>
	<tr><td>Lucía    </td><td>F        </td><td>19       </td><td>FALSE    </td><td>sec      </td><td> 7450    </td><td>1.61     </td></tr>
	<tr><td>Francisca</td><td>F        </td><td>44       </td><td> TRUE    </td><td>uni      </td><td>83300    </td><td>1.57     </td></tr>
	<tr><td>Javier   </td><td>M        </td><td>32       </td><td>FALSE    </td><td>sec      </td><td>   NA    </td><td>1.78     </td></tr>
	<tr><td>Paola    </td><td>F        </td><td>23       </td><td> TRUE    </td><td>uni      </td><td>22000    </td><td>1.72     </td></tr>
	<tr><td>Agustín  </td><td>M        </td><td>55       </td><td> TRUE    </td><td>uni      </td><td>65340    </td><td>1.68     </td></tr>
	<tr><td>Alejandra</td><td>F        </td><td>33       </td><td>FALSE    </td><td>pri      </td><td> 9405    </td><td>1.66     </td></tr>
</tbody>
</table>



También podemos usar el operador $ para agregar la nueva columna:


```R
df$peso = c(77, 55, 77, 85, 98, 60, 58) 
```


```R
df
```


<table>
<thead><tr><th scope=col>nombre</th><th scope=col>genero</th><th scope=col>edad</th><th scope=col>tiene.hijos</th><th scope=col>educacion</th><th scope=col>ingreso</th><th scope=col>altura</th><th scope=col>peso</th></tr></thead>
<tbody>
	<tr><td>Damián   </td><td>M        </td><td>22       </td><td>FALSE    </td><td>sec      </td><td>15000    </td><td>1.70     </td><td>77       </td></tr>
	<tr><td>Lucía    </td><td>F        </td><td>19       </td><td>FALSE    </td><td>sec      </td><td> 7450    </td><td>1.61     </td><td>55       </td></tr>
	<tr><td>Francisca</td><td>F        </td><td>44       </td><td> TRUE    </td><td>uni      </td><td>83300    </td><td>1.57     </td><td>77       </td></tr>
	<tr><td>Javier   </td><td>M        </td><td>32       </td><td>FALSE    </td><td>sec      </td><td>   NA    </td><td>1.78     </td><td>85       </td></tr>
	<tr><td>Paola    </td><td>F        </td><td>23       </td><td> TRUE    </td><td>uni      </td><td>22000    </td><td>1.72     </td><td>98       </td></tr>
	<tr><td>Agustín  </td><td>M        </td><td>55       </td><td> TRUE    </td><td>uni      </td><td>65340    </td><td>1.68     </td><td>60       </td></tr>
	<tr><td>Alejandra</td><td>F        </td><td>33       </td><td>FALSE    </td><td>pri      </td><td> 9405    </td><td>1.66     </td><td>58       </td></tr>
</tbody>
</table>



O generar nuevas columnas a partir de operaciones


```R
df$imc = df$peso / df$altura^2
```


```R
df
```


<table>
<thead><tr><th scope=col>nombre</th><th scope=col>genero</th><th scope=col>edad</th><th scope=col>tiene.hijos</th><th scope=col>educacion</th><th scope=col>ingreso</th><th scope=col>altura</th><th scope=col>peso</th><th scope=col>imc</th></tr></thead>
<tbody>
	<tr><td>Damián   </td><td>M        </td><td>22       </td><td>FALSE    </td><td>sec      </td><td>15000    </td><td>1.70     </td><td>77       </td><td>26.64360 </td></tr>
	<tr><td>Lucía    </td><td>F        </td><td>19       </td><td>FALSE    </td><td>sec      </td><td> 7450    </td><td>1.61     </td><td>55       </td><td>21.21832 </td></tr>
	<tr><td>Francisca</td><td>F        </td><td>44       </td><td> TRUE    </td><td>uni      </td><td>83300    </td><td>1.57     </td><td>77       </td><td>31.23859 </td></tr>
	<tr><td>Javier   </td><td>M        </td><td>32       </td><td>FALSE    </td><td>sec      </td><td>   NA    </td><td>1.78     </td><td>85       </td><td>26.82742 </td></tr>
	<tr><td>Paola    </td><td>F        </td><td>23       </td><td> TRUE    </td><td>uni      </td><td>22000    </td><td>1.72     </td><td>98       </td><td>33.12601 </td></tr>
	<tr><td>Agustín  </td><td>M        </td><td>55       </td><td> TRUE    </td><td>uni      </td><td>65340    </td><td>1.68     </td><td>60       </td><td>21.25850 </td></tr>
	<tr><td>Alejandra</td><td>F        </td><td>33       </td><td>FALSE    </td><td>pri      </td><td> 9405    </td><td>1.66     </td><td>58       </td><td>21.04805 </td></tr>
</tbody>
</table>




```R
df$obesidad = df$imc > 30
```


```R
df
```


<table>
<thead><tr><th scope=col>nombre</th><th scope=col>genero</th><th scope=col>edad</th><th scope=col>tiene.hijos</th><th scope=col>educacion</th><th scope=col>ingreso</th><th scope=col>altura</th><th scope=col>peso</th><th scope=col>imc</th><th scope=col>obesidad</th></tr></thead>
<tbody>
	<tr><td>Damián   </td><td>M        </td><td>22       </td><td>FALSE    </td><td>sec      </td><td>15000    </td><td>1.70     </td><td>77       </td><td>26.64360 </td><td>FALSE    </td></tr>
	<tr><td>Lucía    </td><td>F        </td><td>19       </td><td>FALSE    </td><td>sec      </td><td> 7450    </td><td>1.61     </td><td>55       </td><td>21.21832 </td><td>FALSE    </td></tr>
	<tr><td>Francisca</td><td>F        </td><td>44       </td><td> TRUE    </td><td>uni      </td><td>83300    </td><td>1.57     </td><td>77       </td><td>31.23859 </td><td> TRUE    </td></tr>
	<tr><td>Javier   </td><td>M        </td><td>32       </td><td>FALSE    </td><td>sec      </td><td>   NA    </td><td>1.78     </td><td>85       </td><td>26.82742 </td><td>FALSE    </td></tr>
	<tr><td>Paola    </td><td>F        </td><td>23       </td><td> TRUE    </td><td>uni      </td><td>22000    </td><td>1.72     </td><td>98       </td><td>33.12601 </td><td> TRUE    </td></tr>
	<tr><td>Agustín  </td><td>M        </td><td>55       </td><td> TRUE    </td><td>uni      </td><td>65340    </td><td>1.68     </td><td>60       </td><td>21.25850 </td><td>FALSE    </td></tr>
	<tr><td>Alejandra</td><td>F        </td><td>33       </td><td>FALSE    </td><td>pri      </td><td> 9405    </td><td>1.66     </td><td>58       </td><td>21.04805 </td><td>FALSE    </td></tr>
</tbody>
</table>


