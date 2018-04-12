#
# Ejemplo de búsqueda de outliers con LOF
#

library(Rlof)

# Leemos el dataset Iris
ds.iris = iris

# Calculamos los scores de LOF
# Con k=5
scores = lof(ds.iris[-c(5)], k=5, cores = 3)

# Graficamos la densidad
plot(density(scores))

# Filtramos los Top5 con mayor scores
outliers = order(scores, decreasing=T)[1:5]
print(outliers)

# Podemos ver los registros identificados como outliers
print(ds.iris[outliers,])

# --------------------------------------------------------------------------
#    Ejemplo1: Graficamos los outliers
# --------------------------------------------------------------------------
# 1) Los coloreo
ds.iris$col.out = '#ff0000'
ds.iris[outliers,]$col.out = '#0000ff'

# 2) Defino los símbolos
ds.iris$pch = 'o'
ds.iris[outliers,]$pch = '+'

# 3) Grafico el scatter plot
plot(ds.iris[c(1:4)], col=ds.iris$col.out, pch=ds.iris$pch)


# --------------------------------------------------------------------------
#  Ejemplo 2: Colorear cada uno de los outliers y cambiar el color también
# --------------------------------------------------------------------------
# Graficas cada uno de los outliers con un color y un caracter diferente
ds.iris$col.out = '#ff0000'
colores=c("#1b9e77","#d95f02","#7570b3","#e7298a","#66a61e")
simb=c('G','K','H','@','A')
for(i in 1:length(colores)){
  ds.iris[outliers[i],]$col.out = colores[i]
  ds.iris[outliers[i],]$pch = simb[i]
}
plot(ds.iris[c(1:4)], col=ds.iris$col.out, pch=ds.iris$pch)
