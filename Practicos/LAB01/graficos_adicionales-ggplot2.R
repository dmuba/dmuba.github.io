#########################################
#########  GRÁFICOS CON GGPLOT2 #########
#########################################

# Cargo el dataset iris
data(iris)

# Cargo las librerias instaladas en un vector de chars
librerias_instaladas<-rownames(installed.packages())

# Chequeo si está instalada la librería ggplot2
# Si no está instalada, la instalo
if("ggplot2" %in% librerias_instaladas == FALSE) {
  install.packages("ggplot2", dependencies = TRUE)
}

# Cargo la librería ggplot2
library(ggplot2)

# Agrupo los datos de acuerdo a la frecuencia observada para cada especie
tabla = as.data.frame(table(iris$Species))

#Gráfico de barras
ggplot(tabla, aes(x=Var1, y=Freq, fill=Var1)) +
  geom_text(aes(label=Freq), vjust=-0.3, size=3.5)+
  geom_bar(stat="identity")+
  theme_minimal()+
  xlab("Variedad Flor") + ylab("Frecuencia observada")

# Fuente: http://www.sthda.com/english/wiki/ggplot2-barplots-quick-start-guide-r-software-and-data-visualization


# Grafico de torta
ggplot(tabla, aes(x="", y=Freq, fill=Var1)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  geom_text(aes(label = Freq), position = position_stack(vjust = 0.5), color = "white")+
  labs(x = NULL, y = NULL, fill = "Variedad de Flor", title = "Planta Iris por variedad de flor")  +
  theme_void()

# Fuente: https://www.displayr.com/how-to-make-a-pie-chart-in-r/


# Histograma
ggplot(iris, aes(x=Sepal.Length)) +
  geom_histogram(aes(y=..density..), color="darkblue", fill="lightblue", binwidth=0.5) +
  geom_density(alpha=0.2, fill="#FF6666") +
  labs(y = "Frecuencia", title = "Histograma de Sepal.Length")

# Fuente: http://www.sthda.com/english/wiki/ggplot2-histogram-plot-quick-start-guide-r-software-and-data-visualization#prepare-the-data


# Boxplot
ggplot(iris, aes(y=Sepal.Length, fill=Species)) +
  stat_boxplot(geom ='errorbar') + 
  geom_boxplot() +
  labs(x = "Sepal.Length", y = "Variedad de Flor", title = "Boxplot de Sepal.Length")

# Fuente: http://www.sthda.com/english/wiki/ggplot2-box-plot-quick-start-guide-r-software-and-data-visualization


# Scatterplot o gráfico de dispersión
ggplot(iris, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(shape = Species, color = Species)) +
  geom_smooth()

# Fuente: https://www.datanovia.com/en/lessons/ggplot-scatter-plot/