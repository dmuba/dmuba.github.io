# MongoDB: Consultas e Interacción con R para TP Entregable

En esta guía, en primera instancia, vamos a explicar como crear subconjuntos de datos a partir de consultas de MongoDB para luego accederlos desde R con la idea de que puedan organizar la información y acceder a la misma de manera eficiente. Luego vamos a dejar algunas consultas complejas a modo de ejemplo para que tomen como referencia.

## Creación de Subconsultas y acceso desde R

Una forma eficiente para trabajar consta de generar nuevas colecciones en MongoDB, que sería el equivalente a crear vistas en un SGBD SQL, y luego acceder a esos datos desde R para no tener que traernos todos los datos y poder trabajar solo con el conjunto que nos interesa.

### Parte I: Creación de consultas en MongoDB

#### Creación de colecciones a partir de agregaciones de datos _aggregate_ y _$out_
Supongamos por un momento que tenemos la necesidad de generar una nueva colección con la cantidad de Tweets de nuestra colección agrupados por el atributo source (la aplicación desde la cual se realizó el tweet).
La consulta sería la siguiente:
```javascript
db.tweets_mongo_covid19.aggregate( [
    {$group: { _id: "$source", cantidad: {$sum: 1} } },
  ] )
```
En el operador _$group_ definimos, en el atributo __id_ cual es el atributo a partir del cual realizamos la agregación y luego creamos el atributo _cantidad_ con la operación de agregación.

Si quisieramos ordenar el listado, podemos incorporar el operador _$sort_:
```javascript
db.tweets_mongo_covid19.aggregate( [
    {$group: { _id: "$source", cantidad: {$sum: 1} } },
    {$sort:{"cantidad":-1} }
  ] )
```

En este caso, con el -1 sobre el atributo _cantidad_, estamos indicando que el orden sea descendente.

Por otro lado, es deseable, como planteamos antes crear colecciones, o subcolecciones, a partir de estas consultas a modo de _views_ en SQL. Eso lo logramos con el operador _$out_ de la instrucción aggregate:
```javascript
db.tweets_mongo_covid19.aggregate( [
    {$group: { _id: "$source", cantidad: {$sum: 1} } },
    {$sort:{"cantidad":-1} },
    { $out : "origenes_tweets" }
  ] )
```

El operador _$out_ generará una nueva colección denominada __origenes_tweets__.

#### Creación de vistas en MongoDB a partir del método _createView()_

En aquellos casos que deseáramos crear nuevos subconjuntos de datos que no necesariamente consten de agregaciones (resúmenes, _group by_), también podemos hacerlo en MongoDB.

Supongamos que necesitamos obtener una vista con el nombre, el _screen name_ y la cantidad de seguidores de los tweets de aquellos ususarios con mas de 100 seguidores. La consulta en MongoDB sería la siguiente:
```javascript
db.tweets_mongo_covid19.find({ followers_count: {$gt: 100} }, { name: 1, screen_name: 1, followers_count: 1, verified:1  })
```

Ahora bien, si deseamos crear una vista con esta información utilizamos el método _CreateView_ de la siguiente manera:
```javascript
db.createView("mas_100_followers", "tweets_mongo_covid19", [ 
    { $match: { followers_count: {$gt: 100} } }, 
    { $project: { name: 1, screen_name: 1, followers_count: 1, verified:1  } } ])
```

En la instrucción anterior, definimos -en el orden de aparición- las siguientes cuestiones:
- Nombre de la vista,
- Nombre de la colección consultada,
- _$match_: condiciones que deben cumplir las filas que integrarán la vista,
- _$project_: columnas que incluirá la vista.


### Parte II: Acceder a los datos mediante R

Una vez que contamos con esta colección, podemos consultarla desde R:

1. Levantamos el paquete R que quieran usar para acceder a MongoDB:
```R
# Se puede utilizar mongolite

install.packages("mongolite")

library(mongolite)
```

2. Obtenemos los datos en R desde MongoDB, los que se guardan en un dataframe:
```R
sources = mongo(collection = "origenes_tweets", db = "DMUBA" )
followers_100 = mongo(db = "DMUBA", collection = "mas_100_followers")

df_sources <- sources$find()
df_100f = followers_100$find()
```

# Algunas consultas mas de ejemplo

__¿Cuál es la proporción de tweets que contienen al menos una marca (RT o fav)?__

Cantidad con al menos una marca:
```javascript
db.tweets_mongo_covid19.count({ "$or" : [{"favorite_count" : {"$gt" : 0}}, 
                                         {"retweet_count" : {"$gt" : 0}}]})
```

Tweets con al menos una marca:
```javascript
db.tweets_mongo_covid19.find({ "$or" : [{"favorite_count" : {"$gt" : 0}}, 
                                        {"retweet_count" : {"$gt" : 0}}]})
```

Proporción sobre el Total de Tweets:
```javascript
db.tweets_mongo_covid19.count({ "$or" : [{"favorite_count" : {"$gt" : 0}}, 
                                         {"retweet_count" : {"$gt" : 0}}]
                              }) /db.tweets_mongo_covid19.count()*100
```
Cuantas veces un hashtag fue utilizado por un usuario
```javascript
//Cuantas veces un usuario utilizo un hashtag
db.tweets_mongo_covid19.aggregate(
  [
    {$project: {"hashtags": 1, "screen_name": 1, _id: 0}},
    {$unwind: "$hashtags"},
    {$match: {"hashtags": {$ne: null}}},
    {$group: {_id: {"usuarios": "$screen_name", 
                    "hashtags": "$hashtags"}, 
                    count: {$sum: 1}}},
    {$sort: {count: -1}},
    {$project: {"usuario": "$_id.usuarios","hashtag": "$_id.hashtags", "count": 1, "_id": 0}},
    {$out: "hashtag_usados_x_usuario"}
  ]
)
```

Agregación de resumen de tweets por usuario. Con cantidad de tweets, fecha del primer y último tweet, cantidad de RT y favs que recibió, cantidad tweets que son RT o citas. Ordena por cantidad de tweets y RT.
```javascript
db.tweets_mongo_covid19.aggregate( [
    {$group: { _id: "$user_id", 
                screen_name: { $first: "$screen_name" }, 
                tweets: {$sum: 1},
                fecha_primero: { $min: "$created_at" }, 
                fecha_ultimo: { $max: "$created_at" }, 
                retweet_count: {$sum: "$retweet_count"},
                favorite_count: {$sum: "$favorite_count"},
                num_quote: {$sum: { $cond: ["$is_quote", 1, 0]}},
                num_retweet: {$sum: { $cond: ["$is_retweet", 1, 0]}},
                }},
    {$sort:{"tweets": -1, "retweet_count": -1} }
  ] )
```

Agregación que combina información de uso de hashtags de un usuario (colección de tweets) y estadísticas del usuario (colección de usuarios).

```javascript
db.tweets_mongo_covid19.aggregate(
  [
    {$project: {"hashtags": 1, "screen_name": 1, _id: 0}},
    {$unwind: "$hashtags"},
    {$match: {"hashtags": {$ne: null}}},
    {$group: {_id: {"usuarios": "$screen_name", 
                    "hashtags": "$hashtags"}, 
                    count: {$sum: 1}}},
    {$sort: {count: -1}},
    {$project: {"usuario": "$_id.usuarios","hashtag": "$_id.hashtags", "count": 1, "_id": 0}},
    {$lookup:  {
       from: "users_mongo_covid19",
       localField: "usuario",
       foreignField: "screen_name",
       as: "join_usuarios"
     }
    },
    {$project: 
        {
            "usuario": 1,"hashtag": 1, "count": 1,
            "followers_count": {"$arrayElemAt": ["$join_usuarios.followers_count", 0]},
            "friends_count": {"$arrayElemAt": ["$join_usuarios.friends_count", 0]},
            "favourites_count": {"$arrayElemAt": ["$join_usuarios.favourites_count", 0]},
            "statuses_count": {"$arrayElemAt": ["$join_usuarios.statuses_count", 0]},
            "_id": 0}},
    
    {$out: "N_hashtag_usados_stats"}
  ]
)
```
En el pipeline de agregación se incorporan las instrucciones:

- lookup: que permite hacer el join entre la agregación de _tweets_ y la colección de _users_.
- arrayElemAt: para obtener el primer elemento de un array.




