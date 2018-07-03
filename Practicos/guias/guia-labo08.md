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
if("rCBA" %in% librerias_instaladas == FALSE) {
  install.packages("arulesSequences", dependencies = TRUE)
}

library(rCBA)
```

## Carga del dataset
Cargamos el dataset anterior, de la siguiente manera:
```r
setwd("path/to/file/")
transactions <- read_baskets("secuencias.txt", info = c("sequenceID","eventID","SIZE"))
```
Como puede observarse, en análisis de secuencias también vamos a trabajar con transacciones. Para más información sobre el tipo de datos __transaction__ de R puede mirar el siguiente [enlace](https://www.rdocumentation.org/packages/arules/versions/1.6-1/topics/transactions-class).

## Algoritmo FP-Growth

Generamos las secuencias frecuentes con la función __fpgrowth__, estableciendo los parámetros:

```R
sequences<-fpgrowth(train, support = 0.01, confidence = 1, maxLength = 5, consequent = NULL, verbose = TRUE, parallel = TRUE)
```
Como podemos observar, cada regla posee los siguientes atributos:
- __support__ (soporte): Establecemos el soporte mínimo de las secuencias.
- __confidence__ (confianza): Confianza mínima.
- __maxLength__ (largo máximo): Largo máximo de las candidatas.
- __consecuent__ (consecuent): Se establece si se filtra de acuerdo a un consecuente.
- __verbose__ (verborrágico): Establecemos si deseamos que el proceso de generación de secuencias genere información en pantalla.
- __parallel__ (paralelo): Se define si se desean realizar los cálculos en paralelo.

Luego, podemos ver un resumen con información de las secuencias generadas:

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
1. Genere el FP-Tree de la tabla.
2. Incorpore las secuencias en R y ejecute el algoritmo.
3. Altere los valores de los parámetros e indique que sucede/observa en cada caso con la cantidad y calidad de las secuencias generadas.
4. Explique que elementos de __cspade__ se observan a partir de los comandos del punto anterior.
