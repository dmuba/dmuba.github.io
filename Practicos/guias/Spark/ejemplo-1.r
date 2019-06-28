library(stringr)
library(dplyr)
library(arules)
library(SparkR)

master_spark = "spark://10.2.200.43:7077"
spc = sparkR.session(master = master_spark, sparkEnvir = list(spark.driver.memory="3g"))

df.iris1 = iris
df.iris1$Sepal.Length <- discretize(iris$Sepal.Length, breaks = 3, labels = c("bajo","medio","alto")) 
df.iris1$Sepal.Width <- discretize(iris$Sepal.Width, breaks = 3, labels = c("bajo","medio","alto")) 
df.iris1$Petal.Length <- discretize(iris$Petal.Length, breaks = 3, labels = c("bajo","medio","alto")) 
df.iris1$Petal.Width <- discretize(iris$Petal.Width, breaks = 3, labels = c("bajo","medio","alto")) 

as_transaction = function(r){
  return(paste(paste(names(r),r,sep = "="), collapse = ','))
}

data.trans = as.data.frame(apply(df.iris1, 1, as_transaction))
names(data.trans) = c("items")
head(data.trans)

# Crea el Objeto SparkDataFrame
df.iris.items = createDataFrame(data.trans, schema = c("items"))

# Hace la conversión a transacciones
data <- selectExpr(df.iris.items, "split(items, ' ') as items")

# Configuración del Modelo FP-Growth
model = spark.fpGrowth(data = data, minSupport=0.1, minConfidence = 0.1)

# Búsqueda de Itemset Fecuentes
frequent_itemsets = spark.freqItemsets(model)

# Mostrar Itemsets Frecuentes
showDF(frequent_itemsets, truncate = F)

# Mostrar Reglas
association_rules = spark.associationRules(model)
showDF(association_rules, truncate=F)



