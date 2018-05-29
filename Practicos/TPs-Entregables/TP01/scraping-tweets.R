# DATOS DE OAUTH
# APP PREVIAMENTE CREADA EN https://apps.twitter.com/
APP_NAME <- ""
API_KEY <- ""
SECRET_KEY <- ""

# SETEO DE ACTIVIDADES A REALIZAR
MONGODB_EXPORT = TRUE
# Streaming -para escuchar tweets actuales- o Search -para buscar ultimos 10 dias-
TIPO_ESCUCHA = 'Search'

# SETEO EL DIRECTORIO DONDE SE GUARDARAN LOS JSON
DIRECTORIO <- ""
setwd(DIRECTORIO)

# CHEQUEO SI DEBO INSTALAR LAS LIBRERÍAS QUE VOY A USAR Y EN SI CORRESPONDE LAS INSTALO
librerias_instaladas<-rownames(installed.packages())

# Librería: rtweet
if("rtweet" %in% librerias_instaladas == FALSE) {
  install.packages("rtweet", dependencies = TRUE)
  }

# Librería: mongolite
if("mongolite" %in% librerias_instaladas == FALSE) {
  install.packages("mongolite", dependencies = TRUE)
}

## Cargo las librerías que voy a usar
library(rtweet)
library(mongolite)

# DATOS DE LAS BÚSQUEDAS
tokens_busqueda<-c("Messi", "dólar", "Macri", "Selección", "Trump", "FMI", "Dujovne", "inflación", "Kirchner", "Carrió", "tarifas", "edenor", "sampaoli", "femicidio", "aborto", "oficialismo", "oposición", "Vidal", "Tinelli", "Tapia", "FIFA", "Gripe")
# UBICACION<-"Buenos Aires"
CANTIDAD<-600
IDIOMA <- "es"
MINUTOS<-10

for(QUERY in tokens_busqueda){ # Por cada token

  print(paste("Se procesa el token ", QUERY))
  
  # Se genera el token con la autenticación en caso de no estar generado
  if (!exists("twitter_token"))
  twitter_token <- create_token(app = APP_NAME, API_KEY, SECRET_KEY, set_renv = TRUE)
  
  if(TIPO_ESCUCHA=='Streaming'){
    tweets<-stream_tweets(
      parse = TRUE,
      q=QUERY, 
      timeout = 60*MINUTOS,
      include_rts = FALSE,
      language = IDIOMA,
      file_name = "tweets-DMUBA.json"
    )
  } else { # Busqueda en los tweets de los últimos 7-10 días
    # Se buscan los tweets en función de los parámetros
    tweets<-search_tweets(
      lang = IDIOMA,
      q=QUERY,
  #    geocode = lookup_coords(UBICACION),
      n = CANTIDAD,
      include_rts = FALSE,
      token = twitter_token,
      retryonratelimit = TRUE,
      type = "mixed"
    )
  }
  
  # Se separan los features de los usuarios
  users<- users_data(tweets)
  
  # Se agrega información de latitud y longitud en función de los parámetros de georeferenciación
  tweets <- lat_lng(tweets)
  
  # Elimino los espacios en los nombres de las variables
  names(tweets) = gsub(" ","",names(tweets)) 
  names(users) = gsub(" ","",names(users)) 
  
  if(MONGODB_EXPORT) {
    # Creo la conexión con las colecciones y la DB
    coleccion.tweets = mongo(collection = paste("tweets_mongo-",QUERY, sep = ""), db = "DMUBA")
    coleccion.users = mongo(collection = paste("users_mongo-",QUERY, sep = ""), db = "DMUBA")
    
    # Inserto los tweets en las dos colecciones de la DB
    coleccion.tweets$insert(tweets)
    coleccion.users$insert(users)
  
    coleccion.tweets$export(file(paste(QUERY,"-dump_tweets.json", sep = "")))
    coleccion.users$export(file(paste(QUERY,"-dump_users.json", sep = "")))
  }
}
