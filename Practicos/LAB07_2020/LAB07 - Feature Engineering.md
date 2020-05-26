# Laboratorio VII: Feature Engineering

En este laboratorio pondremos en práctica las técnicas de procesamiento de variables usando el lenguaje R. 

## Dataset
En este caso trabajaremos con un set de datos con estadísticas resúmenes a nivel países de casos de COVID-19 ([Link de descarga](https://github.com/dmuba/dmuba.github.io/blob/master/Practicos/LAB07_2020/covid19.csv)). Este dataset fue generado con los datos publicados en el sitio https://www.worldometers.info/coronavirus/.


```r
library(readr)
covid19 <- read_csv("covid19.csv")
```

## Discretización

### Binning

En este caso usaremos la función de discretize del paquete **arules** (instalación: *install.packages("arules")*).
En el siguiente ejemplo se muestra la discretización en 5 categorías usando los métodos por intervalo, frecuencia y cluster.

```r
library(arules)

# discretización de igual ancho
covid19$disc_cases_interval = arules::discretize(covid19$cases, method = "interval", breaks = 5, labels=c("muy_bajo", "bajo", "medio", "alto", "muy_alto"))

# discretización de igual frecuencia
covid19$disc_cases_frequency = arules::discretize(covid19$cases, method = "frequency", breaks = 5, labels=c("muy_bajo", "bajo", "medio", "alto", "muy_alto"))

# discretización por kmeans
covid19$disc_cases_cluster = arules::discretize(covid19$cases, method = "cluster", breaks = 5, labels=c("muy_bajo", "bajo", "medio", "alto", "muy_alto"))

```

Para más información sobre los parámetros se sugiere, como siempre, acceder a la documentación de la función:

```r
?arules::discretize
```


### Discretización por función matemática

En este ejemplo se discretiza la variable tomando la cantidad de dígitos numéricos. Este tipo de discretización puede ser muy útil en variables muy sesgadas.

```r
covid19$disc_cases_log10 = floor(log10(covid19$cases))
```

## Normalización

La función **scale** resulta muy útil para implementar las técnicas de normalización vistas en clase. Esta función tiene dos parámetros opcionales que nos permite manejar la función de normalización a aplicar.

* center: Indica la forma de centrar la variable, es decir primero va a restar por un valor central. Si se indica TRUE (valor por defecto) utilizará la media como valor central. Sino se puede especificar el nuevo valor en este parámetro. Si se indica FALSE, no realizará ningún centrado.

* scale: Luego del centrado realiza el escalado, es decir, dividir la variable por un valor definido. Si se indica TRUE (valor por defecto) usa el desvío estándar. Sino se puede especificar un valor numérico distinto. FALSE significa que no realizará ningún escalado. 

#### zscore:
```r
scale(covid19$cases, center=TRUE,  scale=TRUE)
```
#### min-max:
```r
scale(covid19$cases, center=min(covid19$cases),  scale=max(covid19$cases) - min(covid19$cases))
```
####  Escalado robusto usando la mediana:
```r
scale(covid19$cases, center=median(covid19$cases),  scale=TRUE)
```

####  Escalado robusto usando la mediana y el rango intercuartil:
```r
scale(covid19$cases, center=median(covid19$cases),  scale=IQR(covid19$cases))
```

####  Índice relativo a la media.
```r
scale(covid19$cases, center=mean(covid19$cases),  scale=mean(covid19$cases))
```

#### Decimal scaling
```r
d = floor(log10(max(covid19$cases))) + 1
covid19$cases / 10**d 
```

## Variables dummies

Este tipo de codificación también se la conoce como *"One Hot Encoding"* o variables *"Flags"*. En este caso usaremos el paquete **fastDummies**.

La función **dummy_cols** genera nuevas columnas del tipo flags (valores 1 o 0 / tiene o no tiene), a partir de columnas categóricas. Estas columnas pueden ser de tipo *factor* o *character*. Se generarán tantas columnas nuevas como categorías o niveles existan en la variable original. El nombre de estas nuevas columnas seguirá el patrón: *\<nombre columna original>_<nombre categoría>*.

El valor devuelto por esta función es una copia del dataset original con las nuevas variables creadas.

```r
library(fastDummies)

covid19_dummies = dummy_cols(covid19, select_columns=c("continent"), ignore_na=TRUE)
```
Los parámetros más relevante de esta función son:

* select_columns: Se especifica la/s columna/s categórica/s a transformar.
* remove_first_dummy: Cuando se crean variables dummies, una es redundante. Si se especifica TRUE en este valor omitirá la columna de la primera categoría.
* remove_most_frequent_dummy: Igual al caso anterior pero omitiendo a la categoría más frecuente.
* ignore_na: Si este valor es FALSE, se agrega una nueva columna de tipo flag indicando si la variable original contiene un dato NA .

Para más detalles acceder a la documentación de ayuda:

```r
?dummy_cols
```

## Consignas

Sobre la variable de cantidad de casos (columna cases):

1. Aplicar distintos métodos de normalización y analizar las distribuciones resultantes. (Gráficos hist, qqplot, density, boxplot)
2. Aplicar los ejemplos de discretización de esta guía. Documente ventajas y desventajas de cada método.
3. Aplique alguna transformación para reducir el sesgo. Calcule la métrica de sesgo: ```3*(media - mediana) / desvío```, antes y después de la transformación. Grafique las distribuciones.
4. Volver aplicar binnings por frecuencia, ancho y kmeans sobre la transformación realizada en 3. ¿Cuáles métodos resultaron más y menos sensibles al sesgo?
5. Qué transformaciones considera más adecuadas para comparar la dispersión entre las variables de cantidad de casos, y cantidad de casos cada 1 millón de habitantes (*cases_1Mpop*).


