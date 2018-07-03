# Guía LABORATORIO VIII: Algoritmo FP-Growth

Hoy vamos a trabajar con la librería el algortimo __FP-Growth__. En primera instancia vamos a calcular de forma manual el FP-Tree y luego vamos a trabajar con la librería __rCBA__ de R.

Podemos obtener información adicional sobre la librería rCBA en el siguiente [enlace](https://cran.r-project.org/web/packages/rCBA/rCBA.pdf).

## Calculamos el FP-TREE 

Se propone calcular el FP-TREE para la siguiente tabla de items:

|  #  | i(t)  |
| :-: | :---: |
|  1  | ZMRE  |
|  2  | MSE   |
|  3  | ZMRE  |
|  4  | ZMSE  |
|  5  | ZMSRE |

```r
librerias_instaladas<-rownames(installed.packages())
if("rCBA" %in% librerias_instaladas == FALSE) {
  install.packages("rCBA", dependencies = TRUE)
}

library(rCBA)
```

## Carga del dataset
Cargamos como ejemplo el dataset __iris__, de la siguiente manera:
```r
data("iris")

train <- sapply(iris,as.factor)
train <- data.frame(train, check.names=FALSE)
transactions <- as(train,"transactions")
```

Podemos ejecutar la función __fpgrowth__ a partir de un data.frame o un objeto transaction.

Para más información sobre el tipo de datos __transaction__ de R puede mirar el siguiente [enlace](https://www.rdocumentation.org/packages/arules/versions/1.6-1/topics/transactions-class).

## Algoritmo FP-Growth

Generamos las secuencias frecuentes con la función __fpgrowth__, estableciendo los parámetros:

```R
reglas<-fpgrowth(transactions, support = 0.01, confidence = 0.7, maxLength = 3, consequent = NULL, verbose = TRUE, parallel = TRUE)
```
Como podemos observar, cada regla posee los siguientes atributos:
- __support__ (soporte): Establecemos el soporte mínimo de las reglas.
- __confidence__ (confianza): Confianza mínima.
- __maxLength__ (largo máximo): Largo máximo de las reglas.
- __consecuent__ (consecuent): Se establece si se filtra de acuerdo a un consecuente.
- __verbose__ (verborrágico): Establecemos si deseamos que el proceso de generación brinde información en pantalla.
- __parallel__ (paralelo): Se define si se desean realizar los cálculos en paralelo.

Luego, podemos ver un resumen con información de las reglas generadas:

```R
summary(reglas)
```

Además, es posible observar las reglas generadas a partir de la instrucción __inspect__:

```R
inspect(reglas)
```

A su vez, podemos realizar con las reglas generadas todas las operaciones que hacíamos en [arules en la Guía de Laboratorio 6] (https://github.com/dmuba/dmuba.github.io/blob/master/Practicos/guias/guia-labo06.md)

# Consignas propuestas:
1. Genere el FP-Tree de la tabla.
2. Incorpore los items en R y ejecute el algoritmo.
3. Altere los valores de los parámetros e indique que sucede/observa en cada caso con la cantidad y calidad de las secuencias generadas.
4. Compare esta técnica con __apriori__. Que sucede en términos de eficiencia?
