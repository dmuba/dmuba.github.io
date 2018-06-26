# Guía LABORATORIO VII: Análisis de Secuencias

Hoy vamos a trabajar con la librería __arulesSecuences__ de R para explorar los algoritmos __SPADE__ y __GSP__ que fueron abordados en la clase.

## Cargamos/Instalamos la librería arulesSecuences

```r
librerias_instaladas<-rownames(installed.packages())
if("arulesSecuences" %in% librerias_instaladas == FALSE) {
  install.packages("arulesSecuences", dependencies = TRUE)
}

library(arulesSecuences)
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
secuences <- cspade(data.transactions, parameter = list(support = 0.4), control = list(verbose = TRUE))
```

Podemos ver un resumen con información de las secuencias generadas:

```R
summary(secuences)
```

Además, es posible observar las secuencias generadas a partir de la instrucción __inspect__:

```R
inspect(secuences)
```

# Consignas propuestas:
1. ¿Cuantas reglas se generan si definimos un support=0.01? ¿y con un support=0.1? Fundamente la respuesta.
2. Comente cuales son los productos mas comprados por los clientes. ¿Y las asociaciones mas fuertes?
3. ¿Cuales son las 20 reglas con lift mas alto? ¿Que significa esto?
4. ¿Cuales son los productos que hacen que los clientes compren "whole milk"?
5. Cuando un cliente compra "waffles", que otros productos compra con mayor frecuencia?
6. ¿Cuando es importante una confianza alta? 
