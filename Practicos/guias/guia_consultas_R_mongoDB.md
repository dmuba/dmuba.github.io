# MongoDB: Consultas e Interacción con R para TP Entregable

En esta guía, en primera instancia, vamos a explicar como crear subconjuntos de datos a partir de consultas de MongoDB para luego accederlos desde R con la idea de que puedan organizar la información y acceder a la misma de manera eficiente. Luego vamos a dejar algunas consultas complejas a modo de ejemplo para que tomen como referencia.

## Creación de Subconsultas y acceso desde R

Una forma eficiente para trabajar consta de generar nuevas colecciones en MongoDB, que sería el equivalente a crear vistas en un SGBD SQL, y luego acceder a esos datos desde R para no tener que traernos todos los datos y poder trabajar solo con el conjunto que nos interesa.

### Parte I: Creación de consultas en MongoDB

Supongamos por un momento que tenemos la necesidad de generar una nueva colección con la cantidad de Tweets de nuestra colección agrupados por el atributo source (la aplicación desde la cual se realizó el tweet).
La consulta sería la siguiente:
```mongodb
db.tweets_mongo_covid19.aggregate( [
    {$group: { _id: "$source", cantidad: {$sum: 1} } },
  ] )
```
En el operador _$group_ definimos, en el atributo __id_ cual es el atributo a partir del cual realizamos la agregación y luego creamos el atributo _cantidad_ con la operación de agregación.

Si quisieramos ordenar el listado, podemos incorporar el operador _$sort_:
```mongodb
db.tweets_mongo_covid19.aggregate( [
    {$group: { _id: "$source", cantidad: {$sum: 1} } },
    {$sort:{"cantidad":-1} }
  ] )
```

En este caso, con el -1 sobre el atributo _cantidad_, estamos indicando que el orden sea descendente.

Por otro lado, es deseable, como planteamos antes crear colecciones, o subcolecciones, a partir de estas consultas a modo de _views_ en SQL. Eso lo logramos con el operador _$out_ de la instrucción aggregate:
```mongodb
db.tweets_mongo_covid19.aggregate( [
    {$group: { _id: "$source", cantidad: {$sum: 1} } },
    {$sort:{"cantidad":-1} },
    { $out : "origenes_tweets" }
  ] )
```

El operador _$out_ generará una nueva colección denominada __origenes_tweets__.

## Parte II: Acceder a los documentos

Una vez que contamos con esta colección, podemos consultarla desde R:

1. Levantamos el paquete R que quieran usar para acceder a MongoDB:
```R
# Se puede utilizar mongolite

install.packages("mongolite")

library(mongolite)
```

2. Leemos los datos:
```R
sources = mongo(collection = "origenes_tweets", db = "DMUBA" )
query <- sources$find('{}')
```

# Algunas consultas mas de ejemplo

__¿Cuál es la proporción de tweets que contienen al menos una marca (RT o fav)?__

Cantidad con al menos una marca:
```mongodb
db.tweets_mongo_covid19.count({ "$or" : [{"favorite_count" : {"$gt" : 0}}, {"retweet_count" : {"$gt" : 0}}]})
```

Tweets con al menos una marca:
```mongodb
db.tweets_mongo_covid19.find({ "$or" : [{"favorite_count" : {"$gt" : 0}}, {"retweet_count" : {"$gt" : 0}}]})
```

Proporción sobre el Total de Tweets:
```mongodb
db.tweets_mongo_covid19.count({ "$or" : [{"favorite_count" : {"$gt" : 0}}, {"retweet_count" : {"$gt" : 0}}]})/db.tweets_mongo_covid19.count()*100
```
