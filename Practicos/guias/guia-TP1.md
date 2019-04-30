
# Cómo levantar los datos en R.

## Usando MongoDB

### 1 - Instalación MongoDB

- [Instalador para Windows (64-bit)](https://fastdl.mongodb.org/win32/mongodb-win32-x86_64-2008plus-ssl-3.6.4-signed.msi)
- [Mac/Linux](https://www.mongodb.com/download-center?#community)
- Opcional:  Cliente para MongoDB [Robo3T](https://robomongo.org/download")

### 2 - Importar los datos

```
> mongoimport --db precios_caba --collection sucursales --file sucursales.json
2019-04-30T11:24:17.100-0300	connected to: localhost
2019-04-30T11:24:17.150-0300	imported 837 documents
```

```
> mongoimport --db precios_caba --collection sucursales --file sucursales.json
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
