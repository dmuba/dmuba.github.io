
library(infotheo) 
ordenado <- sort(iris$Sepal.Width,decreasing = FALSE) 

# Se hace el bining y en bin_eq_freq van a quedar los nros de bin numerados del 1 al 5
bin_eq_freq <- discretize(ordenado,"equalfreq", 5)

# Creo una columna con los valores de Sepal.Width para poder calcular la media
bin_eq_freq$Sepal.Width = sort(iris$Sepal.Width,decreasing = FALSE) 

# Creo un colunma mas llamada media y la inicializo en cero
bin_eq_freq$media = rep(0,nrow(bin_eq_freq))

# Ahora para cada bin calculo la media y la asigno a la columna "media"
for(bin in 1:5){
  # Calculo la media del bin haciendo un filtro
  media.del.bin = mean(bin_eq_freq[bin_eq_freq$X == bin,]$Sepal.Width )
  
  # asigno el valor de la media del bin
  bin_eq_freq[bin_eq_freq$X == bin,]$media = media.del.bin 
}

# grafico Sepal.Width ordenado de menor a mayor
plot(sort(iris$Sepal.Width,decreasing = FALSE) , type = "l", col="red", ylab = "Sepal.Width")
# Agrego la serie de la variable media 
lines(bin_eq_freq$media,type = "l", col="blue")
