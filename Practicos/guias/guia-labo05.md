# Guía LABORATORIO V: Reglas de asociación

Vamos a trabajar con R y escribir algunas rutinas para calcular el __soporte__ y la __confianza__ de un conjunto de reglas a partir del dataset [Titanic](http://www.rdatamining.com/data/titanic.raw.rdata?attredirects=0&d=1).

# Leer el dataset Titanic

```r
load("titanic.raw.rdata")
```

# Soporte

Calcular el soporte para: 

 - Survived=Yes
 
 ```R
 # ¿Cuál es el soporte de Survived=Yes?

attach(titanic.raw)

nrow(titanic.raw[Survived=='Yes',])/nrow(titanic.raw)

 
 ```

 - Survived=Yes y Sex=Male
 
```R
# ¿Cuál es el soporte de Survived=Yes y Sex=Male?

nrow(titanic.raw[Survived=='Yes' & Sex=='Male' ,])/nrow(titanic.raw)

```

 
## ¿Cuales itemsets de los que se listan a continuación tienen mayor soporte?
  
  1. {Class=3rd, Sex=Male, Survived=Yes}
  2. {Class=3rd, Sex=Male, Survived=No}
 
Interprete el resultado.

## ¿Considera que 0.02 es un minsup adecuado para conseguir itemsets frecuentes? Justifique su respuesta con ejemplos.
 
# Confianza

Calcular la confianza para el siguiente conjunto de reglas:

 1. {Class=Crew} => {Survived=Yes}
 2. {Class=1st} => {Survived=Yes}
 3. Para 1 y 2 calcule para los __no__ sobrevivientes e interprete los resultados.
 4. ¿Cuál de las siguientes reglas tiene minconf >= 0.3?
    - {Age=Adult, Sex=Female} => {Survived=Yes}
    - {Age=Adult, Sex=Male} => {Survived=No}
  

```R

nrow(titanic.raw[Class=='Crew' & Survived=='Yes',])/nrow(titanic.raw[Class=='Crew',])

```


