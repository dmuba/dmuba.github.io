install.packages("RMongo")

library(RMongo)

tweets <- mongoDbConnect('Tweets')
print(dbShowCollections(tweets))

query <- dbGetQuery(tweets, 'txt_tweets', "")
tweets_corpus_df <- query[c('screen_name', 'text')]

head(tweets_corpus_df)

summary(tweets_corpus_df)

str(tweets_corpus_df)


library(tm)
library(stringr)

dfCorpus = Corpus(VectorSource(enc2utf8(tweets_corpus_df$text)), readerControl = list(language = "es"))
inspect(dfCorpus[1])

# Convert the text to lower case
corpus.pro <- tm_map(dfCorpus, content_transformer(tolower))

# Remove numbers
corpus.pro <- tm_map(corpus.pro, removeNumbers)



# Remove spanish common stopwords
corpus.pro <- tm_map(corpus.pro, removeWords, stopwords("spanish"))

# Remove punctuations
corpus.pro <- tm_map(corpus.pro, removePunctuation)

# Eliminate extra white spaces
corpus.pro <- tm_map(corpus.pro, stripWhitespace)

inspect(corpus.pro[1])

corpus.pro <- tm_map(corpus.pro, function(x) return(gsub('dólar','dolar',x)))
corpus.pro <- tm_map(corpus.pro, function(x) return(gsub('http.+ ','',x)))


dtm <- TermDocumentMatrix(corpus.pro, 
          control = list(
              stopwords(kind="es"),
              removePunctuation = TRUE,
              #stemming = TRUE, 
              stopwords = TRUE,
              global = c(3, 100)
              
              #weighting = function(x) weightTfIdf(x, normalize = TRUE))
          ))

dtm

m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(term = names(v),frec=v)
top100=head(d, 50)

inspect(dtm[,1:30])


library("wordcloud")
library(RColorBrewer)
par(bg="grey30")
wordcloud(d$term, d$frec,col=terrain.colors(length(d$term), alpha=0.9), random.order=FALSE, rot.per=0.3 )

# -------------------------------------------------------------------
require(proxy)

# cosine_dist_mat <- as.matrix(dist(as.matrix(dtm), method = "cosine"))
# 
# 
# fit <- cmdscale(cosine_dist_mat, eig=TRUE, k=2) # k is the number of dim
# -------------------------------------------------------------------

# Distancia del coseno
top100.dtm = dtm[as.character(top100$term)[1:50],]
cosine_dist_mat <- as.matrix(dist(as.matrix(top100.dtm), method = "cosine"))


distancia = dist(cosine_dist_mat)

fit <- cmdscale(cosine_dist_mat, eig=TRUE, k=2) # k is the number of dim

x <- fit$points[,1]
y <- fit$points[,2]


par(bg="white")
plot(x, y, xlab="Coordinate 1", ylab="Coordinate 2", main="Escalado Multidimensional - Top 100 términos", type="n")
text(x, y, labels = rownames(fit$points), cex=.7, col = c("#e41a1c","#377eb8","#4daf4a","#984ea3")[as.factor(floor(log(top100$frec)))]) 


table(floor(log(top100$frec)))

head(fit$points)
