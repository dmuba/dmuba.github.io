# Guía LABORATORIO VI: Reglas de asociación con arules

Vamos a trabajar con la librería __arules__ de R, puntualmente con el dataset Groceries, que representa el típico problema de la cesta de compras.

## Cargamos/Instalamos la librería arules

```r
librerias_instaladas<-rownames(installed.packages())
if("arules" %in% librerias_instaladas == FALSE) {
  install.packages("arules", dependencies = TRUE)
}

library(arules)
```

## Carga del dataset
Cargamos el dataset Groceries con las transacciones de la cesta de compras

```r
data("Groceries")
```

Para más información sobre el tipo de datos __transaction__ de R puede mirar el siguiente [enlace](https://www.rdocumentation.org/packages/arules/versions/1.6-1/topics/transactions-class).

## Reglas de asociación

Generamos las reglas con arules, estableciendo soporte y confianza mínimos como parámetro.

```R
reglas <- apriori(Groceries, parameter = list(support=0.01, confidence=0.01, target = "rules"))
 ```

Podemos verificar la cantidad de reglas generadas:

```R
# Cantidad de reglas:
print(reglas)
```

Es posible trabajar con las reglas generadas a partir de la instrucción __inspect__:

```R
# Reglas generadas:
inspect(reglas)
```

Como podemos observar, cada regla posee los siguientes atributos:
- __lhs__: (left-hand-sides) es la parte izquierda de la regla, o antecedente.
- __rhs__: ( right-hand-sides ) es la parte derecha de la regla, o resultado.
- __Support__:  es la frecuencia relativa de una regla sobre el total de transacciones.
- __Confidence__: Mide cuantas veces sucede el rhs cuando se presenta el lhs, para cada regla.
- __Lift__: es la confianza de la regla sobre  el  soporte  del  consecuente  de la  misma.

## Análisis de las Reglas
Podríamos ordenar las reglas por alguna de las métricas presentadas, por ejemplo:

```R
inspect(sort(reglas, by="lift", decreasing = TRUE))
```

O podríamos tomar solo las primeras N (en este caso 10) reglas con mayor lift:

```R
inspect(head(sort(reglas, by="lift", decreasing = TRUE),10))
```

Por otro lado, podemos analizar reglas que poseen determinado antecedente o consecuente:

Las reglas que poseen como antecedente -lhs- a la cerveza en botella (bottled beer):
```R
reglas_beer <- apriori(Groceries, parameter = list(support=0.01, confidence=0.01, target = "rules"), appearance = list(lhs="bottled beer"))
inspect(reglas_beer)
```

Las reglas que poseen como consecuente -rhs- a la mantequilla (butter):
```R
reglas_butter <- apriori(Groceries, parameter = list(support=0.01, confidence=0.01, target = "rules"), appearance = list(rhs="butter"))
inspect(reglas_butter)
```

## Itemsets frequentes
Además, podríamos querer generar solo los itemsets frequentes y no las reglas:

```R
itemsets <- apriori(Groceries, parameter = list(support=0.01, confidence=0.01, target="frequent itemsets"))
inspect(itemsets)
```

## Cargando un dataset como transactions en R
Con la librería arules, debemos trabajar con el objeto transactions, que podemos cargarlo de la siguiente manera:
```R
transactions = read.transactions("iris.csv", sep = ",")
rules = apriori(transactions, parameter=list(target="rules", confidence=0.25, support=0.2))
```

También podemos transformar un dataframe al objeto transactions:
```R
transactions <- as(as.data.frame(apply(data, 2, as.factor)), "transactions")
rules = apriori(transactions, parameter=list(target="rules", confidence=0.25, support=0.2))
```

## Filtrar reglas con _subset_

Filtramos reglas que contengan **waffles** en el antecedente.

```R
rules.sub <- subset(reglas, subset = lhs %pin% "waffles")
```

# Consignas propuestas:
1. ¿Cuantas reglas se generan si definimos un support=0.01? ¿y con un support=0.1? Fundamente la respuesta.
2. Comente cuales son los productos mas comprados por los clientes. ¿Y las asociaciones mas fuertes?
3. ¿Cuales son las 20 reglas con lift mas alto? ¿Que significa esto?
4. ¿Cuales son los productos que hacen que los clientes compren "whole milk"?
5. Cuando un cliente compra "waffles", que otros productos compra con mayor frecuencia?
6. ¿Cuando es importante una confianza alta? 
