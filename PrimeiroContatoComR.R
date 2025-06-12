# 🔹 Importar pacotes necessários para manipulação e modelagem de dados
library(tidyverse)  # Pacote para manipulação e visualização de dados
library(caret)      # Pacote para treinamento de modelos de machine learning

# 🔹 Criar um conjunto de dados fictícios
dados <- data.frame(
  ID = 1:10,  # Identificador único para cada cliente
  Nome = c("Ana", "Bruno", "Carla", "Daniel", "Eduarda", "Felipe", "Gabriela", "Henrique", "Isabela", "João"),  # Nomes fictícios
  Idade = sample(18:60, 10, replace=TRUE),  # Gera idades aleatórias entre 18 e 60 anos
  Renda = round(runif(10, 2000, 10000), 2),  # Gera valores aleatórios de renda entre 2000 e 10000 reais
  Comprou = sample(c("Sim", "Não"), 10, replace=TRUE)  # Indica se o cliente comprou ou não
)

# 🔹 Salvar os dados como um arquivo CSV para futura análise
write.csv(dados, "dados_ficticios.csv", row.names=FALSE)

# 🔹 Definir uma semente aleatória para garantir que os resultados sejam reprodutíveis
set.seed(123)  

# 🔹 Criar uma partição dos dados (80% para treino, 20% para teste)
indice <- createDataPartition(dados$Comprou, p=0.8, list=FALSE)  
# 'createDataPartition' divide os dados de forma estratificada, garantindo balanceamento

# 🔹 Separar os dados em treino e teste
treino <- dados[indice, ]  # Conjunto de treino com 80% dos dados
teste <- dados[-indice, ]  # Conjunto de teste com os 20% restantes

# 🔹 Transformar a variável categórica 'comprou' em fator para ser usada no modelo preditivo
treino$Comprou <- as.factor(treino$Comprou)
teste$Comprou <- as.factor(teste$Comprou)

# 🔹 Normalizar as variáveis numéricas para garantir que tenham a mesma escala
treino$Idade <- scale(treino$Idade)
treino$Renda <- scale(treino$Renda)
teste$Idade <- scale(teste$Idade)
teste$Renda <- scale(teste$Renda)

# 🔹 Treinar um modelo de regressão logística para prever se um cliente comprará ou não
modelo <- train(Comprou ~ Idade + Renda, data=treino, method="glm", family="binomial")

# 🔹 Fazer previsões no conjunto de teste
predicoes <- predict(modelo, teste)

# 🔹 Avaliar a qualidade das previsões com uma matriz de confusão
confusionMatrix(predicoes, teste$Comprou)  
# Exibe métricas como acurácia, precisão e sensibilidade para avaliar o desempenho do modelo

print(confusionMatrix(predicoes, teste$Comprou))

print(predicoes)

#MOTIVOS DO ERRO NO CODIGO:
#O erro ocorre porque a regressão logística não conseguiu aprender padrões nos dados, 
#resultando em previsões fixas para uma única categoria ("Sim"). 
#Isso pode acontecer devido ao tamanho pequeno do conjunto de treino, 
#ao desbalanceamento da variável alvo ou à falta de variáveis preditoras mais informativas. 
#Além disso, as probabilidades ajustadas podem ter ficado presas em valores extremos (0 ou 1),
#impossibilitando a convergência do modelo. 


