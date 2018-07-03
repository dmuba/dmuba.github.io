# Guía LABORATORIO VIII: Algoritmo FP-Growth

Hoy vamos a trabajar con la librería el algortimo __FP-Growth__. En primera instancia vamos a calcular de forma manual el FP-Tree y luego vamos a trabajar con la librería __rCBA__ de R.

## Calculamos el FP-TREE 

Se propone calcular el FP-TREE para la siguiente tabla de secuencias:

|  #  | i(t)  |
| :-: | :---: |
|  1  | ABDE  |
|  2  | BCE   |
|  3  | ABDE  |
|  4  | ABCE  |
|  5  | ABCDE |
|  6  | BCD   |

```r
librerias_instaladas<-rownames(installed.packages())
if("arulesSequences" %in% librerias_instaladas == FALSE) {
  install.packages("arulesSequences", dependencies = TRUE)
}

library(arulesSequences)
```

## Carga del dataset
Cargamos un dataset de ejemplo -que está en el repo, con el nombre de secuencias.txt- con algunas secuencias conformadas por caracteres alfanuméricos.
```r
setwd("path/to/file/")
transactions <- read_baskets("secuencias.txt", info = c("sequenceID","eventID","SIZE"))
```
Como puede observarse, en análisis de secuencias también vamos a trabajar con transacciones. Para más información sobre el tipo de datos __transaction__ de R puede mirar el siguiente [enlace](https://www.rdocumentation.org/packages/arules/versions/1.6-1/topics/transactions-class).

## Algoritmo SPADE

Generamos las secuencias con la función __cspade__, estableciendo un soporte mínimo como parámetro.

```R
sequences <- cspade(data.transactions, parameter = list(support = 0.4), control = list(verbose = TRUE))
```

Podemos ver un resumen con información de las secuencias generadas:

```R
summary(sequences)
```

Además, es posible observar las secuencias generadas a partir de la instrucción __inspect__:

```R
inspect(sequences)
```

Otra forma de analizar las secuencias generadas por el algoritmo:

```R
as(s1, "data.frame")
```

# Consignas propuestas:
1. ¿Cuantas secuencias se generan si definimos un support=0.03? ¿y con un support=0.2? Fundamente la respuesta y compare con el algoritmo de la clase anterior.
2. Comente cuales son los items que aparecen en las secuencias con mayor soporte. ¿A qué principio obedece esto?
3. ¿Que información nos proveen los métodos __inspect__ y __summary__ sobre las secuencias? 
4. Explique que elementos de __cspade__ se observan a partir de los comandos del punto anterior.
