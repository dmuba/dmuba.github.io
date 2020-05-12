# Guía de Instalación MongoDB y Robo3T

## Sistemas Operativos Windows

### Servidor MongoDB

1. En primer lugar, vamos a instalar el Servidor MongoBD, para ello debemos descargarlo desde [el Sitio Web, en la Sección Community](https://www.mongodb.com/download-center/community) y descargamos el Server (en la Sección Server) para nuestro Sistema Operativo Windows. 
2. Una vez que descargado el instalador, se instala optando por el tipo de instalación __complete__.
3. Ahora, debemos crear una carpeta llamada __data__ en la Unidad __C:__ y dentro de ella una carpeta que denominada __db__. El path completo de estos nuevos directorios quedará de la siguiente manera: __C:\data\db__.

A continuación podemos observar gráficamente estas últimas instrucciones:
![Instalar MongoDB](./img/instalar_mongo.png)

Ahora ya tenemos instalado el servidor mongoDB, lo que debemos hacer es iniciarlo ejecutando el archivo __mongod__ que se encuentra en el directorio de instalación, generalmente en __C:\Program Files\MongoDB\Server\<VERSION_INSTALADA>\bin__. 
En caso que no sepas como hacerlo, seguí las siguientes instrucciones:
1. Abrimos una Consola de Windows escribiendo _cmd_ en la barra de búsqueda de la barra inferior de Windows.
2. Escribimos __cd C:\Program Files\MongoDB\Server\<VERSION_INSTALADA>\bin__.
3. Escribimos __mongod__ y damos Enter.

A continuación podemos observar gráficamente estas últimas instrucciones:
![crear col](./img/ejecutar_mongo.png =300x300)


### Robo3T




## Sistemas Operativos UNIX

Tutorial con ejemplos de mongolite [[Ir]](https://jeroen.github.io/mongolite/query-data.html).

```R
# Queries con mongolite

# Recuperar los tweets que tienen más de 10 favoritos

q1 = tweets$find(query = '{"favorite_count":{"$gte": 10}}', 
                 limit = 10, 
                 fields='{"screen_name": "TRUE", "text": "TRUE", "favorite_count": "TRUE"}')

# Recuperar los tweets donde el código de pais es AR
q2 = tweets$find(query = '{"country_code": "AR"}', limit = 100)

# Recuperar los tweets que dicen inflaci.n 
q3 = tweets$find(query = '{"text": {"$regex": "inflaci.n", "$options" : "i"}}', limit = 100)

# Agregaciones con $aggregate y $project
# Contamos para cada usuario la cantidad de tweets N y el promedio de favoritos de sus publicaciones 

q4 = tweets$aggregate(
  '[{"$group":{"_id": "$screen_name", 
               "N": {"$sum":1}, 
                "PROM": {"$avg": "$favorite_count"}}}, 
    {"$project": {"screen_name": 1, "N": 1, "PROM":1}}]',
  options = '{"allowDiskUse":true}'
)




```

