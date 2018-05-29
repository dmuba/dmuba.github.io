# Guía LABORATORIO IV: Bases de datos textuales

Vamos a trabajar con R y los paquetes: 

 - [tm](https://cran.r-project.org/web/packages/tm/index.html)
 - [mongolite](https://cran.r-project.org/web/packages/mongolite/index.html). Manual de usuario [[Abrir]](https://jeroen.github.io/mongolite/)
 - Parte de los ejemplos fueron extraídos desde [www.springboard.com](https://www.springboard.com/blog/text-mining-in-r/)

## Parte I: Acceder a los documentos

a) Leer los documentos desde MongoDB

Leer una colección de tweets desde la base MongoDB que utilizamos en la guía anterior. Esto lo vamos a realizar directamente desde R con el siguiente conjunto de instrucciones.

Levantar el paquete R que quieran usar para acceder a MongoDB

```R
# Se puede utilizar RMongo o mongolite

install.packages("RMongo")

library(RMongo)
```

Leemos los datos

```R
# Mi base se llama Tweets
tweets <- mongoDbConnect('Tweets')
print(dbShowCollections(tweets))

```

Traemos todos los tweets

```R
# No filtro ningún dato, me traigo todo
query <- dbGetQuery(tweets, 'txt_tweets', "")

# Ahora solo me quedo con las columnas del usuario y el texto del tweet
tweets_corpus_df <- query[c('screen_name', 'text')]

```

Exploremos un poco qué es lo que recuperamos

```R
head(tweets_corpus_df)

summary(tweets_corpus_df)

str(tweets_corpus_df)
```



## Parte II: Tokenizar y Generar la Matríz Documento-Término

Acá vamos a utilizar el paquete tm

```R

library(tm)

```

Creamos el corpus en formato crudo

```R
dfCorpus = Corpus(VectorSource(enc2utf8(tweets_corpus_df$text)))

# Recuperamos el primer tweet
inspect(dfCorpus[1])

```

Ahora comenzamos con algunas tareas de preprocesamiento

```R
# Convertimos el texto a minúsculas
corpus.pro <- tm_map(dfCorpus, content_transformer(tolower))

# removemos números
corpus.pro <- tm_map(corpus.pro, removeNumbers)

# Removemos palabras vacias en español
corpus.pro <- tm_map(corpus.pro, removeWords, stopwords("spanish"))

# Removemos puntuaciones
corpus.pro <- tm_map(corpus.pro, removePunctuation)

# Eliminamos espacios
corpus.pro <- tm_map(corpus.pro, stripWhitespace)

# Recuperamos el primer tweet
inspect(corpus.pro[1])

```


Generamos la Matríz de Documento-Término

```R
dtm <- TermDocumentMatrix(corpus.pro)

# Resumen de la dtm
dtm
```

    <<TermDocumentMatrix (terms: 3083, documents: 745)>>
    Non-/sparse entries: 6323/2290512
    Sparsity           : 100%
    Maximal term length: 67
    Weighting          : term frequency (tf)





Miremos cuales son los términos más frecuentes

```R
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(term = names(v),frec=v)
head(d, 50)

top50 = head(d, 50)
```

## Parte III: Visualizar los resultados


### Nube de Etiquetas
Ahora visualice por medio de una nube de etiquetas cuáles son los principales términos.
Para esto vamos a utilizar dos nuevos paquetes __wordcloud__ y __RColorBrewer__.

```R

library("wordcloud")
library(RColorBrewer)
par(bg="grey30") # Fijamos el fondo en color gris

wordcloud(d$term, d$frec, col=terrain.colors(length(d$term), alpha=0.9), random.order=FALSE, rot.per=0.3 )

```

### Escalado multidimensional

Vamos a filtrar los 50 términos más frecuentes para realizar un scalado Multidimensional y analizar qué términos están más cerca en los datos originales.

```R
library(proxy)

N=50

# Distancia del coseno
top50.dtm = dtm[as.character(top50$term)[1:N],]
cosine_dist_mat <- as.matrix(dist(as.matrix(top50.dtm), method = "cosine"))

fit <- cmdscale(cosine_dist_mat, eig=TRUE, k=2) # k is the number of dim

x <- fit$points[,1]
y <- fit$points[,2]


par(bg="white")
plot(x, y, xlab="Coordinate 1", ylab="Coordinate 2", main="Escalado Multidimensional - Top 100 términos", type="n")
text(x, y, labels = rownames(fit$points), cex=.7, col = c("#e41a1c","#377eb8","#4daf4a","#984ea3")[as.factor(floor(log(top100$frec)))]) 

```



