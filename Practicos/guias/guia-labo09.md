# Guía LABORATORIO IX: Generación de recomendaciones a partir de reglas de asociación

En esta guía se propone usar reglas de asociación con el algoritmo apriori para generar recomendaciones de películas.

El algoritmo apriori está pensado para realizar una búsqueda generalizada de patrones de ítems. Si bien
no es un algoritmo de recomendación per se, ya que es poco escalable, con las reglas generadas se pueden obtener recomendaciones
de  popularidad (reglas 1-itemset), de tipo de asociación de productos (reglas 2-itemsets), o incluso asociaciones más complejas
(>2-itemsets).

## Datos

Vamos a utilizar un dataset de Movielens. [Movielens](https://movielens.org/) es una aplicación web en donde los usuarios pueden hacer calificaciones de películas.
Esta aplicación tiene fines netamente académicos, con el objetivo de generar datasets y estudiar algoritmos de sistemas de recomendación.

Para esta actividad se realizó un preprocesamiento en los datos para que puedan ser leídos en formato transacción.
Cada transacción representa a un usuario y los itemsets de las transacciones son películas con calificaciones positivas realizadas por el usuario (al menos 3 estrellas de 5).

El set de datos está dividido en 3 partes. La primera es el set de entrenamiento, donde vamos a generar reglas.

Link de descarga: [data_movielens.zip](https://github.com/dmuba/dmuba.github.io/raw/master/Practicos/guias/datasets/data_movielens.zip)

```R
library(arules)

# carga dataset en formato transacción de gustos de películas de usuarios.  
train = read.transactions("movies_train.csv",
                          format="single", 
                          header=TRUE,
                          sep = ",",
                          cols=c("user_id", "movie_name"),
                          rm.duplicates = T)
# muestra un resumen de las transacciones
summary(train)
```

## Generación de reglas

El proceso para generar reglas de recomendación es correr aprori con las transacciones de entrenamiento.
Luego ordenar las reglas por alguna métrica, en el siguiente ejemplo se usa confianza. Este paso de ordenamiento
es muy importante para la recomendación, con este definimos el orden de prioridad que tiene una regla sobre otra
para generar una recomendación.

```R
# generación de reglas de recomendación
reglas <- apriori(train, parameter = list(support=0.05, confidence=0.05, target = "rules", minlen=1, maxlen=2))

# número de reglas obtenidas
length(reglas)

# ordena reglas por métricas
reglas<-sort(reglas, decreasing=TRUE, by="confidence")

# Elige las mejores reglas
# (este límite es por performance en la ejecución de la recomendación)
reglas<-head(reglas, 50000)

# Muestra las reglas con confiaza más alta.
inspect(head(reglas))
```

También se pueden utilizar otras métricas. La función interestMeasure() de arules permite calcular varias
métricas adicionales a las devueltas por apriori(). En la documentación de esta función se listan todas las métricas
implementadas (?interestMeasure para acceder a la documentación).

En el siguiente ejemplo se calculan: jaccard, coseno y coverage (es el soporte del antecedente de la regla). Se usa jaccard para ordenar.

```R
# generación de reglas de recomendación
reglas <- apriori(train, parameter = list(support=0.05, confidence=0.05, target = "rules", minlen=1, maxlen=2))

# numero de reglas obtenidas
length(reglas)

# Calcula más métricas
nuevas_metricas = interestMeasure(reglas, measure = c("cosine", "jaccard", "coverage"), transactions = train)

# agrega las nuevas métricas a la regla
quality(reglas) <- cbind(quality(reglas), nuevas_metricas)

# ordena reglas por Jaccard
reglas <- sort(reglas, decreasing=TRUE, by="jaccard")

# Elige las mejores reglas
reglas<-head(reglas, 50000)

inspect(head(reglas))

```

## Recomendaciones de películas usando las reglas generadas

Para recomendar películas a un usuario determinado, se utilizará su transacción como entrada, es decir, el conjunto de
películas favoritas. Se seleccionarán las reglas que coincidan en el antecedente con algún subconjunto de
películas de la transacción. Y finalmente se recomendarán las películas que forman parte de los consecuentes de las reglas
seleccionadas. Como las reglas están ordenadas siguiendo una métrica, las películas quedarán ordenadas por este score.

La siguiente función implementa este algoritmo de recomendación. Se le debe pasar como entrada una transacción,
las reglas de entrenamiento ordenadas, y la cantidad de películas que se quiere que recomiende. La salida es un
vector con ítems.

```R
# Función para recomendar items
# params:
# - transaction: transacción de un usuario
# - rules: Reglas para generar recomendaciones
# - n: cantidad de items a recomendar
# return:
# - Vector con n items a recomendar
recommend <- function (transaction, rules, n=5){
  # selecciona reglas con antecedentes que cumplan con items de la transacción
  rules_match <- as.logical(is.subset(rules@lhs, transaction))
  # excluye reglas con concecuente en transacción
  rules_match <- rules_match & !as.logical(is.subset(rules@rhs, transaction))
  # selecciona reglas
  selected_rules <- rules[rules_match]
  # retorna los primeros n items de la recomendación
  rec_items = unique(unlist(as(rhs(selected_rules), "list")))[1:n]
  return(rec_items)
}

```

Por ejemplo, si queremos hacer 5 recomendaciones al primer usuario de entrenamiento:

```R
inspect(train[1])

recommend(train[1],reglas, 5)
```

## Evaluación de recomendaciones

Para evaluar las recomendaciones usamos un set de prueba. En este conjunto de prueba, se separaron 5 películas favoritas
al azar de cada usuario para medir si existe coincidencia con las recomendaciones. Esta forma de evaluar a las recomendaciones
se la conoce como "Test offline", en donde se realiza una simulación de recomendaciones usando únicamente a los datos.

```
# lee transacciones usadas como test - ítems usados como entrada
test = read.transactions("movies_test.csv",
                          format="single", 
                          header=TRUE,
                          sep = ",",
                          cols=c("user_id","movie_name"),
                          rm.duplicates = T)

# lee transacciones de test - ítems usados para medición (5 ítems por usuario)
test_val = read.transactions("movies_test_val.csv",
                         format="single", 
                         header=TRUE,
                         sep = ",",
                         cols=c("user_id","movie_name"),
                         rm.duplicates = T)

```

Usaremos las métricas [precision, recall y F1](https://en.wikipedia.org/wiki/Precision_and_recall)
para evaluar la calidad de las recomendaciones.

El siguiente ejemplo se evalúan a los primeros 100 usuarios de test. Usando como máximo 20 películas recomendadas por usuario.

```R
# cantidad de recomendaciones a evaluar por usaurio
k = 20

# inicializa variables para promediar métricas de evaluación de cada recomendación.
precision_at_k = 0
recall_at_k = 0

# evalua 100 usuarios
for( t in 1:100){ 
  items_rec = recommend(test[t],reglas, k)
  items_rel = as(test_val[t], "list")[[1]]
  
  len_intersect = length(intersect(items_rec, items_rel))
  precision_at_k = precision_at_k + len_intersect/ length(items_rec)
  recall_at_k = recall_at_k + len_intersect/ length(items_rel)
}

# obtiene promedio de métricas
precision_at_k = precision_at_k / t
recall_at_k = recall_at_k / t
f1_at_k = 2 * (precision_at_k * recall_at_k) / (precision_at_k + recall_at_k) 

precision_at_k
recall_at_k
f1_at_k
```

## Consignas

Probar distintas configuraciones de parámetros en el entrenamiento de reglas que optimicen el valor de recall promedio por usuario en test, limitando a las salidas de recomendaciones a un tamaño 20 (k=20) 

Se propone:
- Generar un modelo baseline. Siempre es bueno comenzar evaluando el modelo más simple, en este caso el modelo más simple es genear recomendaciones por popularidad (reglas tamaño 1, ordenadas por soporte)  
- Probar distintas métricas de reglas (Ej, confianza, lift, support, jaccard, coseno, coverage)
- Probar limitando los tamaños de reglas. Por ejemplo sólo usar reglas de tamaño 1, luego agregarles las de tamaño 2, etc.
- Analice que métricas y tamaño de reglas generaron mejores resultados para este problema.

Luego de encontrar una buena configuración de parámetros, evalúe las métricas precision y recall al aumentar o disminuir el valor de k.


