# Guía de Instalación MongoDB y Robo3t

## Sistemas Operativos Windows

### Servidor MongoDB

1. En primer lugar, vamos a instalar el Servidor MongoBD, para ello debemos descargarlo desde [el Sitio Web, en la Sección Community](https://www.mongodb.com/download-center/community). 
2. Una vez que descargado el instalador, se instala optando por el tipo de instalación _complete_.
3. Ahora, debemos crear una carpeta llamada _data_ en la Unidad _C:_ y dentro de ella una carpeta que denominada _data_. El path completo de estos nuevos directorios quedará de la siguiente manera: _C:\data\db_.

Ahora ya tenemos instalado el servidor mongoDB, lo que debemos hacer es iniciarlo ejecutando el archivo _mongod_ que se encuentra en el directorio de instalación, generalmente en _C:\Program Files\MongoDB\Server\<VERSION_INSTALADA>\bin_.

En caso que no sepas como hacerlo, seguí las siguientes instrucciones:
1. Abrimos una Consola de Windows escribiendo _cmd_ en la barra de búsqueda de la barra inferior de Windows.
2. Escribimos _cd _C:\Program Files\MongoDB\Server\<VERSION_INSTALADA>\bin_
3. Escribimos _mongod_.

### Robo3T


![crear col](./img/crearcol.png)


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

