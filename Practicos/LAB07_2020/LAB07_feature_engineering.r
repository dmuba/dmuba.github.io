library(arules)
library(readr)
library(fastDummies)
library(ggplot2)

# lectura de dataset
covid19 <- read_csv("covid19.csv")

# Evaluación de métodos de binnigs
#----------------------------------
# Se obtienen cortes con los tres métodos
interval_cuts = arules::discretize(covid19$cases, method = "interval", breaks = 5, onlycuts = TRUE)
frequency_cuts = arules::discretize(covid19$cases, method = "frequency", breaks = 5, onlycuts = TRUE)
cluster_cuts = arules::discretize(covid19$cases, method = "cluster", breaks = 5, onlycuts = TRUE)
log10_cuts =  10**unique(floor(log10(covid19$cases)))

# histograma
hist(covid19$cases, main="Cantidad de casos de COVID-19 confirmados por país", xlab="número de casos", ylab="Frecuencia")

# método interval
p <- ggplot(covid19, aes(x = cases)) +
     geom_dotplot(dotsize = .6) + 
     ggtitle("Cortes en binning por igual ancho") +
     xlab("cantidad de casos") + 
     theme_bw()
for(cut in interval_cuts){
 # agrega cada corte al gráfico
 p <- p + geom_vline(xintercept= cut, col="red", linetype="dashed")
}
p

# método frequency
p <- ggplot(covid19, aes(x = cases)) +
  geom_dotplot(dotsize = .6) + 
  ggtitle("Cortes en binning por igual frecuencia") +
  xlab("cantidad de casos") + 
  theme_bw()
for(cut in frequency_cuts){
  p <- p + geom_vline(xintercept= cut, col="red", linetype="dashed")
}
p


# método clusters
p <- ggplot(covid19, aes(x = cases)) +
  geom_dotplot(dotsize = .6) + 
  ggtitle("Cortes en binning por clusters") +
  xlab("cantidad de casos") + 
  theme_bw()
for(cut in cluster_cuts){
  p <- p + geom_vline(xintercept= cut, col="red", linetype="dashed")
}
p


# método función
p <- ggplot(covid19, aes(x = cases)) +
  geom_dotplot(dotsize = .6) + 
  ggtitle("Cortes por función floor(log10(x))") +
  xlab("cantidad de casos") + 
  theme_bw()
for(cut in log10_cuts){
  p <- p + geom_vline(xintercept= cut, col="red", linetype="dashed")
}
p

# crea variables nuevas discretizaciones
covid19$disc_cases_cluster = arules::discretize(covid19$cases, method = "cluster", breaks = 5, labels=c("muy_bajo", "bajo", "medio", "alto", "muy_alto"))
covid19$disc_cases_frequency = arules::discretize(covid19$cases, method = "frequency", breaks = 5, labels=c("muy_bajo", "bajo", "medio", "alto", "muy_alto"))
covid19$disc_cases_interval = arules::discretize(covid19$cases, method = "interval", breaks = 5, labels=c("muy_bajo", "bajo", "medio", "alto", "muy_alto"))
covid19$disc_cases_log10 = floor(log10(covid19$cases))

# Normalización
#----------------------------------

# zscore
covid19$cases_z = scale(covid19$cases, center=TRUE,  scale=TRUE)

# min-max
covid19$cases_minmax = scale(covid19$cases, center=min(covid19$cases),  scale=max(covid19$cases) - min(covid19$cases))
# o también
covid19$cases_minmax = (covid19$cases - min(covid19$cases)) / (max(covid19$cases) - min(covid19$cases))

# escalado robusto
covid19$cases_median = scale(covid19$cases, center=median(covid19$cases),  scale=TRUE)
covid19$cases_median_iqr = scale(covid19$cases, center=median(covid19$cases),  scale=IQR(covid19$cases))

# relativos
covid19$cases_rel_mean =scale(covid19$cases, center=mean(covid19$cases),  scale=mean(covid19$cases))

# decimal scaling
d = floor(log10(max(covid19$cases))) + 1
covid19$cases_decimal_scaling = covid19$cases / 10**d 

# Generación de variables dummies
# -------------------------------
covid19_dummies = dummy_cols(covid19, select_columns=c("continent"), ignore_na=TRUE)
