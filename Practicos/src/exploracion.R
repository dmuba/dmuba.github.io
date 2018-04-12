# --------------------------------------------
#    Ejemplos para la clase de data mining
# --------------------------------------------

# Caritas de Chernoff
library(aplpack)
ds.iris = iris
ds.iris$Species2 = as.numeric(ds.iris$Species)

set.seed(1234)
sample_rows = sample(1:nrow(iris), 25)
faces(ds.iris[sample_rows,-c(5)], face.type = 0, labels =ds.iris[sample_rows,]$Species )

suma_w = 0
suma_xw = 0
for(i in 1:nrow(ds.iris)){
  w = length(ds.iris[ds.iris$Sepal.Length == ds.iris$Sepal.Length[i],])  
  suma_xw = suma_xw + w*ds.iris$Sepal.Length[i]
  suma_w = suma_w + w
}

print(suma_xw/suma_w)
median(ds.iris$Sepal.Length)
mean(ds.iris$Sepal.Length)

pesos = c(8,43,47,50,56,61,63,71,74,75,78,82,87,92,98,105,115,117,120,200)
qqnorm(pesos)

# "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"
boxplot(Petal.Width~Species, data = ds.iris, main="Petal.Width")
names(ds.iris)

x1=cbind(5,1:100)
norm(x1)
k=2
che = (1 - 1/k^2)*150
che
med = mean(ds.iris$Petal.Width)
st = sd(ds.iris$Petal.Width)
m3ds = med + k*st
m3di = med - k*st
nrow(ds.iris[ds.iris$Petal.Width <= m3di || ds.iris$Petal.Width >= m3ds,])


# QQNorm a mano!
n = nrow(ds.iris)
a = 0.5
ds.iris$pi  <- (1:n-a)/(n+1-2*a) 
ds.iris$phiInv  <- qnorm(ds.iris$pi) 
y = sort(ds.iris$Sepal.Length)
plot(ds.iris$phiInv, y, xlab = "Cuantiles Normal Estándar", ylab = "Sepal Len")
qqline(y)
qqnorm(y)


plot( ((1:nrow(ds.iris) - 1:nrow(ds.iris)/nrow(ds.iris))/nrow(ds.iris) ) , sort(ds.iris$Sepal.Length))
abline()
qqnorm(ds.iris$Sepal.Length)

# "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"
par(mfrow=c(2,2))
hist(ds.iris$Sepal.Length, main = "Sepal.Length")
hist(ds.iris$Sepal.Width, main = "Sepal.Width")
hist(ds.iris$Petal.Length, main = "Petal.Length")
hist(ds.iris$Petal.Width, main = "Petal.Width")

# QQNorm
par(mfrow=c(2,2))
fi = (1:nrow(ds.iris) - 1:nrow(ds.iris)/nrow(ds.iris))/nrow(ds.iris)
plot( fi , sort(ds.iris$Sepal.Length), ylab = "Sepal.Length")
plot( fi , sort(ds.iris$Sepal.Width), ylab = "Sepal.Width")
plot( fi , sort(ds.iris$Petal.Length), ylab = "Petal.Length")
plot( fi , sort(ds.iris$Petal.Width), ylab = "Petal.Width")

# -----------------
#    QQ Plots
# -----------------
par(mfrow=c(1,3))
lim = range(ds.iris[ds.iris$Species == 'setosa',]$Sepal.Width, ds.iris[ds.iris$Species == 'versicolor',]$Sepal.Width)
qqplot(ds.iris[ds.iris$Species == 'setosa',]$Sepal.Width, 
       ds.iris[ds.iris$Species == 'versicolor',]$Sepal.Width, 
       plot.it = T,
       xlim=lim,
       ylim=lim,
       xlab = "Sepal.Width (Setosa)",
       ylab = "Sepal.Width (Versicolor)",
       main = "QQ: Sepal Width - Setosa vs Versicolor"
)

lim = range(ds.iris[ds.iris$Species == 'setosa',]$Sepal.Width,
            ds.iris[ds.iris$Species == 'virginica',]$Sepal.Width)
qqplot(ds.iris[ds.iris$Species == 'setosa',]$Sepal.Width,
       ds.iris[ds.iris$Species == 'virginica',]$Sepal.Width, 
       plot.it = T,
       xlim=lim,
       ylim=lim,
       xlab = "Sepal.Width (setosa)",
       ylab = "Sepal.Width (Virginica)",
       main = "QQ: Sepal Width - Setosa vs Virginica"
)

lim = range(ds.iris[ds.iris$Species == 'versicolor',]$Sepal.Width,
            ds.iris[ds.iris$Species == 'virginica',]$Sepal.Width)
qqplot(ds.iris[ds.iris$Species == 'versicolor',]$Sepal.Width,
       ds.iris[ds.iris$Species == 'virginica',]$Sepal.Width, 
       plot.it = T,
       xlim=lim,
       ylim=lim,
       xlab = "Sepal.Width (Versicolor)",
       ylab = "Sepal.Width (Virginica)",
       main = "QQ: Sepal Width - Versicolor vs Virginica"
)

# Scatter Plots
par(mfrow=c(1,1))
plot(ds.iris[c(3,4)], main="Petal: Length vs Width")
plot(ds.iris[c(3,4)], main="Petal: Length vs Width", col=c('red','blue','green')[ds.iris$Species])
plot(ds.iris[-c(5)], main="Dataset Iris", col=c('red','blue','green')[ds.iris$Species])

# Coordenadas paralelas
parcoord(ds.iris[c(1:4)], col = c('red','blue','green')[ds.iris$Species])

# Chi^2 Test
mc = matrix(c(250, 200, 50, 1000), nrow=2, ncol=2, byrow = T)
mc
chisq.test(mc) 



