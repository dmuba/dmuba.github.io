# TOKEN BUSCADO - Aqui se establece el token que dio origen a la DB
QUERY <- ""
# Defino el directorio donde tengo los archivos json que voy a usar
setwd("")

# CHEQUEO SI DEBO INSTALAR LAS LIBRERÍAS QUE VOY A USAR Y EN SI CORRESPONDE LAS INSTALO
librerias_instaladas<-rownames(installed.packages())

# Librería: mongolite
if("mongolite" %in% librerias_instaladas == FALSE) {
  install.packages("mongolite", dependencies = TRUE)
}
library(mongolite)

# Librería: jsonlite
if("jsonlite" %in% librerias_instaladas == FALSE) {
  install.packages("mongolite", dependencies = TRUE)
}
library(jsonlite)

coleccion.tweets = mongo(collection = paste("tweets_mongo-",QUERY, sep = ""), db = "DMUBA")
coleccion.users = mongo(collection = paste("users_mongo-",QUERY, sep = ""), db = "DMUBA")

# Inserto los tweets en las dos colecciones de la DB
coleccion.tweets$import(file(paste(QUERY,"-dump_tweets.json", sep = "")))
coleccion.users$import(file(paste(QUERY,"-dump_users.json", sep = "")))

# Cargo los tweets y los usuarios en dos dataframes
tweets <- coleccion.tweets$find()
users <- coleccion.users$find()
