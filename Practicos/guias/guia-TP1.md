# Guía TP01: Comenzando a explorar los datos

En esta guía se dan algunos tips y herramientas iniciales para poder cargar y manipular a los datos para el TP01.

# Cómo cargar los datos en R.

A diferencia de los datasets utilizados en los TP de laboratorios, los archivos con los conjuntos de datos no están en formato CSV. En este caso se utilizan archivos en formato JSON lines. Este formato tiene como ventaja de poder almacenarlos en una base de datos NoSql orientada a documentos. En este caso vamos a utilizar MongoDB.

Existen al menos dos formas de cargar los datos en R. Una buena forma es instalar MongoDB e importar los archivos. Posteriormente generar un dataframe en R a partir de consultas sobre esta base de datos. Si bien esta opción es recomendable, recién se explorará el tema de bases de datos NoSQL en la semana 7. En esta guía se muestra los pasos a seguir para poder cargar los datos de esta manera para quienes quieran ir avanzando con la instalación del entorno necesario para instalar MongoDB.

La segunda opción permite cargar los dataframes en R directamente de los archivos. Esta opción les permitirá poder ir arrancando con los análisis para el TP.

## Usando MongoDB

### 1 - Instalación MongoDB

A continuación se muestran los links para descargar e instalar MongoDB. 

MongoDB es un motor de bases de datos. Este motor es un programa servidor. Así que si se instala e inicializa queda corriendo en segundo plano. Para poder acceder y consultar a las bases de datos se necesita un programa cliente. Este cliente puede ser Robo3T. Para conectarse desde este cliente al server MongoDB deberán usarse los parámetros de configuración por defecto (Address=localhost:27017). Otro cliente, como veremos después, es R cargando las correspondientes librerías.

- [Instalador para Windows (64-bit)](https://fastdl.mongodb.org/win32/mongodb-win32-x86_64-2008plus-ssl-3.6.4-signed.msi)
- [Mac/Linux](https://www.mongodb.com/download-center?#community)
- Cliente para MongoDB [Robo3T](https://robomongo.org/download")

### 2 - Importar los datos

MongoDB provee un comando que puede ser ejecutado en la consola del sistema operativo para importar los archivos json line a colecciones de documentos. Para adelantar un poco el vocabulario, una colección en MongoDB es equivalente a una tabla en SQL, y un documento a una fila.

Este comando es [mongoimport](https://docs.mongodb.com/manual/reference/program/mongoimport/), con el parámetro --db se especifica la base de datos a usar (no es necesario crearla, si no existe una base de datos con ese nombre, la crea) luego con --collection se especifica el nombre de la colección que queremos crear para volcar los documentos, y finalmente con el parámetro --file se indica el archivo que contiene a los datos.

La forma de llamar al comando es el siguiente:

```
mongoimport --db <db_name> --collection <collection_name> --file <file path>
```

A continuación se muestra el resultado de ejecución en consola de las importaciones de los archivos del TP.

```
mongoimport --db precios_caba --collection sucursales --file sucursales.json
2019-04-30T11:24:17.100-0300	connected to: localhost
2019-04-30T11:24:17.150-0300	imported 837 documents
```

```
> mongoimport --db precios_caba --collection productos --file productos.json 
2019-04-30T11:26:11.707-0300	connected to: localhost
2019-04-30T11:26:11.740-0300	imported 1000 documents
```

```
> mongoimport --db precios_caba --collection precios --file precios.json 
2019-04-30T11:26:59.562-0300	connected to: localhost
2019-04-30T11:27:02.561-0300	[##......................] precios_caba.precios	23.9MB/250MB (9.6%)
2019-04-30T11:27:05.564-0300	[####....................] precios_caba.precios	45.6MB/250MB (18.3%)
2019-04-30T11:27:08.563-0300	[#####...................] precios_caba.precios	62.0MB/250MB (24.8%)
2019-04-30T11:27:11.562-0300	[########................] precios_caba.precios	83.8MB/250MB (33.6%)
2019-04-30T11:27:14.561-0300	[#########...............] precios_caba.precios	102MB/250MB (40.8%)
2019-04-30T11:27:17.561-0300	[###########.............] precios_caba.precios	125MB/250MB (49.9%)
2019-04-30T11:27:20.584-0300	[##############..........] precios_caba.precios	146MB/250MB (58.7%)
2019-04-30T11:27:23.561-0300	[################........] precios_caba.precios	168MB/250MB (67.4%)
2019-04-30T11:27:26.562-0300	[##################......] precios_caba.precios	188MB/250MB (75.5%)
2019-04-30T11:27:29.561-0300	[####################....] precios_caba.precios	213MB/250MB (85.4%)
2019-04-30T11:27:32.561-0300	[######################..] precios_caba.precios	235MB/250MB (94.2%)
2019-04-30T11:27:34.562-0300	[########################] precios_caba.precios	250MB/250MB (100.0%)
2019-04-30T11:27:34.562-0300	imported 1584661 documents
```

### 3 - Instalación paquete de R

Para conectarse a MongoDB desde R puede utilizarse alguna de estas dos librerías: mongolite o Rmongo. 

#### Opción mongolite:

```R
install.package("mongolite")
```
- [Dependencias para Linux/Mac](https://jeroen.github.io/mongolite/)
- En Windows no es necesario instalar dependencias

#### Opción Rmongo:

```R
install.packages("RMongo")
```

### 4 - Carga del dataset a partir de consulta en MongoDB

Ahora sí, desde R se puede generar una conexión a MongoDB, y generar queries para consultar todos los documentos de una colección y cargarlos en un dataframe.

```R
library(mongolite)

sucursales <- mongo(collection = "sucursales", db = "precios_caba")$find()
productos <- mongo(collection = "productos", db = "precios_caba")$find()
precios <- mongo(collection = "precios", db = "precios_caba")$find()
```

```R
library(RMongo)
db <- mongoDbConnect('precios_caba')

sucursales <- dbGetQuery(db, 'sucursales', "")
productos <- dbGetQuery(db, 'productos', "")
precios <- dbGetQuery(db, 'precios', "")
```


## Carga de datos desde R

Para cargar los archivos de datos de TP en dataframes de R sin tener que instalar MongoDB, puede usarse el paquete jsonlite.

## 1 - Instalación de package

```R
install.packages("jsonlite")
```

## 2 - Carga de datos

```R
library(jsonlite)
sucursales = stream_in(file("sucursales.json",open="r"))
productos = stream_in(file("productos.json",open="r"))
precios = stream_in(file("precios.json",open="r"))
```


# Transformación de datos con dplyr

El paquete dplyr es una alternativa interesante a las funciones por defecto de R (merge, aggregate, apply, etc) para integrar, transformar y manipular datos.

Los siguientes tutoriales dan un pantallazo de las funcionalidades de selección de columnas, filtrado de casos, creación de nuevas variables, agrupación y aplicación de funciones de agrupación.
- https://rpubs.com/justmarkham/dplyr-tutorial
- https://rpubs.com/Jo_/dplyr_pipe (en español)

Como funcionalidad de integración de datos, la libraría perimte hacer joins de dataframes al estilo SQL.
- https://dplyr.tidyverse.org/reference/join.html (documentación)

# Transformación de filas a columnas y viceversa

La función reshape de R puede ser de mucha utilidad para este TP. Se utiliza en dataframes que contienen varias filas que representan una misma entidad, pero en distintos estados o distintas mediciones. Este comando permite agrupar entidades en una única fila, y en las columnas se representan los distintos estados o mediciones de la misma. Además admite el caso inverso, es decir pasar de múltiples columnas a múltiples filas. Estas operaciones pueden ser útiles para manipular las mediciones de precios.

La siguiente refrerencia explica y muestra ejemplos de la función:
- https://stats.idre.ucla.edu/r/faq/how-can-i-reshape-my-data-in-r/


