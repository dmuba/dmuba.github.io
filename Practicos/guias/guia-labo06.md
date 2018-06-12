# Guía LABORATORIO VI: Reglas de asociación -Paquete arules-

Vamos a trabajar con la librería __arules__ de R, puntualmente con el dataset Groceries, que representa el típico problema de la cesta de compras.

## Cargamos la librería arules

```r
librerias_instaladas<-rownames(installed.packages())
if("arules" %in% librerias_instaladas == FALSE) {
  install.packages("arules", dependencies = TRUE)
}
```

## Cargamos el dataset Groceries con las transacciones de la cesta de compras

```r
data("Groceries")
```

Para más información sobre el tipo de datos __transaction__ de R puede mirar el siguiente [enlace](https://www.rdocumentation.org/packages/arules/versions/1.6-1/topics/transactions-class).

## Reglas de asociación

Generamos las reglas con arules, estableciendo soporte y confianza mínimos como parámetro.

```R
reglas <- apriori(Groceries, parameter = list(support=0.01, confidence=0.01, target = "rules"))
 ```

Podemos verificar la cantidad de reglas generadas e inspeccionarlas (analizarlas):

```R

# Cantidad de reglas:
print(reglas)

# Reglas generadas:
inspect(reglas)
```
Como podemos observar, cada regla posee los siguientes atributos:
- __lhs__: (left-hand-sides) es la parte izquierda de la regla, o antecedente.
- __rhs__: ( right-hand-sides ) es la parte derecha de la regla, o resultado.
- __Support__:  es la frecuencia relativa de una regla sobre el total de transacciones.
- __Confidence__: Mide cuantas veces sucede el rhs cuando se presenta el lhs, para cada regla.
- __Lift__: es la confianza de la regla sobre  el  soporte  del  consecuente  dela  misma.

## Ahora, podríamos ordenar las reglas por alguna de las métricas presentadas, por ejemplo:

```R
inspect(sort(reglas, by="lift", decreasing = TRUE))
```

O podría tomar solo las primeras N (en este caso 10) reglas con mayor lift:

```R
inspect(head(sort(reglas, by="lift", decreasing = TRUE),10))
```

##Itemsets frequentes

Además, podríamos querer solo los itemsets frequentes y no las reglas:

```R
itemsets <- apriori(Groceries, parameter = list(support=0.01, confidence=0.01, target="frequent itemsets"))
inspect(itemsets)
```

## Análisis de reglas

Por otro lado, podemos analizar reglas que poseen determinado antecedente o consecuente:
```R
itemsets <- apriori(Groceries, parameter = list(support=0.01, confidence=0.01, target="frequent itemsets"))
inspect(itemsets)
```

# Consignas propuestas:
1. 
2. 
3. 
4. 
5. 
