install.packages("randomForest")

# Carrega a biblioteca randomForest para utilizar seus recursos
library(randomForest)

# Mostra as primeiras linhas do conjunto de dados iris
head(iris)

# Define uma semente para garantir a reprodutibilidade dos resultados
set.seed(123)

# Cria um modelo de Random Forest para classificar a espécie das flores com base nas outras variáveis
modelo_rf <- randomForest(Species ~ ., data = iris, ntree = 100, importance = TRUE)

# Exibe o modelo treinado
print(modelo_rf)
