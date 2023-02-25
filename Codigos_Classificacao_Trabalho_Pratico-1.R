#################################################################################
####                      Mineração de Dados - IGTI                          ####
####                      Trabalho Prático                                   ####
####                                                                         ####
#################################################################################

rm(list=ls(all=TRUE)) #Remove objetos da memória do R


#################### Instala as bibliotecas necessarias ##############################################3

# A instalacao da biblioteca é realizada apenas uma vez,
#caso já tenha sido realizada anteriormente, basta desconsiderar essa parte do código


# A biblioteca readxl serve para manipular arquivos em Excel
install.packages("readxl", dependencies = TRUE,
                 repos = "http://cran.us.r-project.org")

# A biblioteca caret possui uma quantidade enorme de ferramentas e algoritmos para aprendizado de maquina
install.packages("caret", dependencies = TRUE,
                 repos = "http://cran.us.r-project.org")

# Biblioteca para trabalhar com o algoritmo rpart que gera a arvore de decisao
install.packages("rpart", dependencies = TRUE,
                 repos = "http://cran.us.r-project.org")

# A biblioteca rpart.plot serve para gerar visualizacao da arvore de decisao construida
install.packages("rpart.plot", dependencies = TRUE,
                 repos = "http://cran.us.r-project.org")

# A biblioteca dplyr serve para manipular dados semelhante ao SQL
install.packages("dplyr", dependencies = TRUE,
                 repos = "http://cran.us.r-project.org")


#Carrega bibliotecas
library(dplyr)
library(caret)
library(rpart.plot)

#Cria o dataset
dados <- data.frame(Estado_Civil = c("Solteiro", "Solteiro", "Solteiro", 
                  "Solteiro", "Casado", "Casado", "Solteiro", "Solteiro", "Casado", 
                  "Solteiro", "Casado", "Solteiro", "Solteiro", "Solteiro", "Solteiro", 
                  "Solteiro", "Solteiro", "Casado", "Solteiro", "Casado", "Casado", 
                  "Casado", "Casado", "Solteiro", "Casado", "Casado", "Casado", 
                  "Solteiro", "Casado", "Casado", "Solteiro", "Casado", "Solteiro", 
                  "Casado", "Solteiro", "Solteiro", "Solteiro", "Solteiro", "Solteiro", 
                  "Solteiro", "Solteiro", "Casado", "Solteiro", "Casado", "Solteiro", 
                  "Casado", "Casado", "Casado", "Casado", "Solteiro", "Casado", 
                  "Solteiro", "Casado", "Casado", "Solteiro", "Casado", "Solteiro", 
                  "Casado", "Solteiro", "Solteiro", "Solteiro", "Casado", "Casado", 
                  "Solteiro", "Solteiro", "Casado", "Solteiro", "Solteiro", "Casado", 
                  "Solteiro", "Casado", "Casado", "Solteiro", "Solteiro", "Casado", 
                  "Casado", "Solteiro", "Solteiro", "Casado", "Solteiro", "Casado", 
                  "Casado", "Casado", "Solteiro", "Solteiro", "Casado", "Solteiro", 
                  "Solteiro", "Solteiro", "Casado", "Solteiro", "Casado", "Solteiro", 
                  "Solteiro", "Casado", "Casado", "Casado", "Casado", "Casado", 
                  "Solteiro", "Solteiro", "Casado", "Casado", "Solteiro", "Solteiro", 
                  "Solteiro", "Solteiro", "Casado", "Solteiro", "Solteiro", "Solteiro", 
                  "Solteiro", "Solteiro", "Solteiro", "Solteiro", "Casado", "Solteiro", 
                  "Casado", "Casado", "Casado", "Solteiro", "Casado", "Solteiro", 
                  "Solteiro", "Casado", "Solteiro", "Solteiro", "Solteiro", "Solteiro", 
                  "Solteiro", "Solteiro", "Casado", "Casado", "Solteiro", "Casado", 
                  "Solteiro", "Casado", "Solteiro", "Casado", "Solteiro", "Solteiro", 
                  "Solteiro", "Casado", "Casado", "Solteiro", "Solteiro", "Casado", 
                  "Solteiro", "Casado", "Solteiro", "Casado", "Solteiro", "Casado", 
                  "Solteiro", "Solteiro", "Solteiro", "Solteiro", "Casado", "Casado", 
                  "Solteiro", "Casado", "Solteiro", "Solteiro", "Solteiro", "Solteiro", 
                  "Casado", "Casado", "Solteiro", "Casado", "Solteiro"), Escolaridade = c("Superior", 
                  "Pos_Graduacao", "Pos_Graduacao", "Pos_Graduacao", "Tecnico_Profissionalizante", 
                  "Tecnico_Profissionalizante", "Superior", "Segundo_Grau", "Superior", 
                  "Segundo_Grau", "Tecnico_Profissionalizante", "Segundo_Grau", 
                  "Tecnico_Profissionalizante", "Pos_Graduacao", "Tecnico_Profissionalizante", 
                  "Tecnico_Profissionalizante", "Segundo_Grau", "Tecnico_Profissionalizante", 
                  "Segundo_Grau", "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", 
                  "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", "Superior", 
                  "Superior", "Superior", "Superior", "Segundo_Grau", "Tecnico_Profissionalizante", 
                  "Segundo_Grau", "Tecnico_Profissionalizante", "Segundo_Grau", 
                  "Tecnico_Profissionalizante", "Segundo_Grau", "Tecnico_Profissionalizante", 
                  "Segundo_Grau", "Tecnico_Profissionalizante", "Segundo_Grau", 
                  "Segundo_Grau", "Pos_Graduacao", "Tecnico_Profissionalizante", 
                  "Superior", "Tecnico_Profissionalizante", "Segundo_Grau", "Tecnico_Profissionalizante", 
                  "Tecnico_Profissionalizante", "Superior", "Segundo_Grau", "Pos_Graduacao", 
                  "Superior", "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", 
                  "Superior", "Segundo_Grau", "Pos_Graduacao", "Segundo_Grau", 
                  "Superior", "Segundo_Grau", "Segundo_Grau", "Tecnico_Profissionalizante", 
                  "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", 
                  "Tecnico_Profissionalizante", "Superior", "Pos_Graduacao", "Segundo_Grau", 
                  "Tecnico_Profissionalizante", "Segundo_Grau", "Tecnico_Profissionalizante", 
                  "Pos_Graduacao", "Tecnico_Profissionalizante", "Superior", "Segundo_Grau", 
                  "Tecnico_Profissionalizante", "Pos_Graduacao", "Tecnico_Profissionalizante", 
                  "Superior", "Segundo_Grau", "Superior", "Tecnico_Profissionalizante", 
                  "Superior", "Tecnico_Profissionalizante", "Pos_Graduacao", "Tecnico_Profissionalizante", 
                  "Tecnico_Profissionalizante", "Superior", "Superior", "Pos_Graduacao", 
                  "Pos_Graduacao", "Segundo_Grau", "Pos_Graduacao", "Pos_Graduacao", 
                  "Segundo_Grau", "Pos_Graduacao", "Superior", "Tecnico_Profissionalizante", 
                  "Segundo_Grau", "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", 
                  "Segundo_Grau", "Segundo_Grau", "Pos_Graduacao", "Superior", 
                  "Segundo_Grau", "Tecnico_Profissionalizante", "Pos_Graduacao", 
                  "Pos_Graduacao", "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", 
                  "Tecnico_Profissionalizante", "Superior", "Superior", "Segundo_Grau", 
                  "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", "Segundo_Grau", 
                  "Superior", "Pos_Graduacao", "Superior", "Tecnico_Profissionalizante", 
                  "Superior", "Tecnico_Profissionalizante", "Superior", "Tecnico_Profissionalizante", 
                  "Tecnico_Profissionalizante", "Segundo_Grau", "Superior", "Tecnico_Profissionalizante", 
                  "Pos_Graduacao", "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", 
                  "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", 
                  "Pos_Graduacao", "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", 
                  "Pos_Graduacao", "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", 
                  "Segundo_Grau", "Pos_Graduacao", "Tecnico_Profissionalizante", 
                  "Tecnico_Profissionalizante", "Segundo_Grau", "Segundo_Grau", 
                  "Superior", "Pos_Graduacao", "Segundo_Grau", "Superior", "Tecnico_Profissionalizante", 
                  "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", "Pos_Graduacao", 
                  "Tecnico_Profissionalizante", "Segundo_Grau", "Tecnico_Profissionalizante", 
                  "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", "Pos_Graduacao", 
                  "Tecnico_Profissionalizante", "Tecnico_Profissionalizante", "Pos_Graduacao", 
                  "Segundo_Grau", "Pos_Graduacao", "Tecnico_Profissionalizante", 
                  "Segundo_Grau", "Tecnico_Profissionalizante", "Superior"),
Idade = c(25, 25, 23, 25, 21, 25, 22, 24, 23, 23, 23, 24, 24, 22, 23, 22, 24, 
25, 23, 23, 23, 25, 24, 25, 24, 22, 24, 25, 23, 23, 25, 24, 24, 
25, 24, 24, 24, 23, 23, 24, 24, 23, 24, 23, 24, 23, 23, 24, 23, 
23, 23, 25, 24, 23, 23, 24, 22, 23, 22, 24, 23, 25, 24, 25, 22, 
24, 23, 25, 24, 25, 23, 25, 25, 22, 24, 23, 22, 25, 23, 24, 24, 
23, 22, 24, 23, 21, 24, 23, 24, 24, 24, 23, 26, 23, 24, 24, 24, 
22, 25, 25, 23, 22, 22, 23, 25, 22, 23, 24, 22, 23, 24, 23, 25, 
23, 24, 25, 24, 24, 24, 24, 23, 24, 25, 23, 23, 25, 23, 23, 23, 
22, 22, 26, 26, 23, 24, 25, 23, 23, 23, 25, 22, 24, 26, 25, 25, 
23, 28, 25, 23, 24, 27, 23, 25, 24, 24, 25, 25, 24, 23, 23, 23, 
23, 26, 23, 25, 21, 21, 25, 23, 23), Renda_Mensal = c(2.9, 4, 
3.1, 2.7, 3, 3.4, 4, 3.3, 3, 3.5, 3.4, 4, 3.1, 2.1, 3.3, 2.9, 
3.2, 3.7, 3.2, 3.4, 2.7, 3.8, 2.9, 3.1, 3, 3.3, 4, 3.3, 2.9, 
2.7, 3.3, 3.8, 3.6, 4, 3.5, 3, 3.7, 3.4, 2.5, 3.5, 3.4, 3.4, 
3.6, 3.7, 2.6, 2.6, 3, 2.2, 2.8, 3, 3.3, 3.2, 2.7, 3.5, 4, 2.4, 
3.8, 3.6, 3, 3.5, 2.7, 2.9, 3.6, 2.8, 3.3, 3.5, 2.9, 3.1, 3.9, 
3.7, 3.9, 2.9, 3.4, 2.8, 3.3, 3.6, 2.8, 3.5, 3.4, 2.2, 3.5, 2.9, 
3.4, 3.9, 3.7, 2.9, 2.5, 2.9, 2.8, 3, 2.5, 2.6, 3.1, 2.4, 2.8, 
3.3, 3.1, 3, 2.8, 3.4, 3.1, 3.3, 3.4, 3.8, 3.5, 2.7, 3.7, 2.9, 
2.3, 2.3, 3.1, 2.3, 2.3, 3.6, 3.6, 3.1, 2.3, 3.7, 3.1, 2.5, 2.4, 
2.9, 3.7, 2.1, 3.2, 2.3, 3.7, 3.3, 4, 3.2, 3.6, 2.7, 3.4, 3.1, 
3.9, 3.2, 3, 2.5, 2.9, 3, 3.3, 3.7, 2.2, 2.8, 3.7, 2.9, 3.3, 
3.5, 2.9, 2.6, 2.4, 3.2, 2.8, 3.5, 3.3, 4, 3.5, 2.9, 3.6, 2.7, 
3.9, 3, 3.1, 3.8, 2.5, 3.2, 2.1, 2.4, 3.6, 3.7), Metodo_Pagamento = c("Boleto", 
             "Credito", "Credito_Conjuge", "Boleto", "Debito_Automatico", 
             "Credito_Conjuge", "Credito", "Carne", "Debito_Automatico", "Credito", 
             "Credito", "Credito", "Credito", "Boleto", "Carne", "Debito_Automatico", 
             "Debito_Automatico", "Credito_Conjuge", "Credito_Conjuge", "Carne", 
             "Credito", "Boleto", "Boleto", "Debito_Automatico", "Credito_Conjuge", 
             "Credito", "Debito_Automatico", "Credito_Conjuge", "Credito", 
             "Debito_Automatico", "Debito_Automatico", "Debito_Automatico", 
             "Credito_Conjuge", "Debito_Automatico", "Credito_Conjuge", "Debito_Automatico", 
             "Debito_Automatico", "Credito_Conjuge", "Credito", "Carne", "Credito_Conjuge", 
             "Credito_Conjuge", "Boleto", "Debito_Automatico", "Debito_Automatico", 
             "Boleto", "Credito_Conjuge", "Credito", "Credito_Conjuge", "Boleto", 
             "Credito_Conjuge", "Debito_Automatico", "Boleto", "Debito_Automatico", 
             "Credito", "Credito", "Carne", "Boleto", "Carne", "Credito_Conjuge", 
             "Boleto", "Debito_Automatico", "Carne", "Credito", "Debito_Automatico", 
             "Boleto", "Debito_Automatico", "Carne", "Carne", "Boleto", "Debito_Automatico", 
             "Boleto", "Credito", "Credito_Conjuge", "Credito", "Debito_Automatico", 
             "Debito_Automatico", "Debito_Automatico", "Debito_Automatico", 
             "Carne", "Debito_Automatico", "Credito", "Carne", "Credito_Conjuge", 
             "Boleto", "Carne", "Boleto", "Debito_Automatico", "Credito", 
             "Credito_Conjuge", "Debito_Automatico", "Carne", "Carne", "Boleto", 
             "Debito_Automatico", "Debito_Automatico", "Debito_Automatico", 
             "Carne", "Credito_Conjuge", "Debito_Automatico", "Credito", "Credito_Conjuge", 
             "Carne", "Debito_Automatico", "Credito_Conjuge", "Credito", "Carne", 
             "Credito_Conjuge", "Debito_Automatico", "Credito", "Debito_Automatico", 
             "Credito_Conjuge", "Credito_Conjuge", "Boleto", "Debito_Automatico", 
             "Boleto", "Debito_Automatico", "Carne", "Credito", "Boleto", 
             "Credito_Conjuge", "Debito_Automatico", "Credito_Conjuge", "Debito_Automatico", 
             "Credito_Conjuge", "Debito_Automatico", "Credito_Conjuge", "Debito_Automatico", 
             "Debito_Automatico", "Credito", "Credito_Conjuge", "Credito_Conjuge", 
             "Carne", "Credito", "Credito", "Credito", "Carne", "Boleto", 
             "Carne", "Carne", "Boleto", "Credito_Conjuge", "Debito_Automatico", 
             "Debito_Automatico", "Credito_Conjuge", "Boleto", "Credito", 
             "Credito_Conjuge", "Credito_Conjuge", "Boleto", "Credito", "Carne", 
             "Credito_Conjuge", "Boleto", "Credito", "Carne", "Credito", "Credito_Conjuge", 
             "Credito_Conjuge", "Carne", "Debito_Automatico", "Carne", "Carne", 
             "Debito_Automatico", "Debito_Automatico", "Debito_Automatico", 
             "Credito_Conjuge", "Debito_Automatico", "Credito", "Credito"), 
  Classe = c("Alto_Risco", "Alto_Risco", "Alto_Risco", "Alto_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Alto_Risco", "Alto_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Alto_Risco", "Alto_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Alto_Risco", "Alto_Risco", "Alto_Risco", 
             "Baixo_Risco", "Alto_Risco", "Alto_Risco", "Baixo_Risco", 
             "Alto_Risco", "Baixo_Risco", "Baixo_Risco", "Alto_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Alto_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", "Alto_Risco", 
             "Alto_Risco", "Alto_Risco", "Alto_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Alto_Risco", "Alto_Risco", "Baixo_Risco", 
             "Alto_Risco", "Alto_Risco", "Alto_Risco", "Baixo_Risco", 
             "Alto_Risco", "Baixo_Risco", "Alto_Risco", "Baixo_Risco", 
             "Alto_Risco", "Alto_Risco", "Alto_Risco", "Alto_Risco", "Alto_Risco", 
             "Baixo_Risco", "Alto_Risco", "Baixo_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Alto_Risco", "Alto_Risco", 
             "Alto_Risco", "Baixo_Risco", "Baixo_Risco", "Alto_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Alto_Risco", "Alto_Risco", "Alto_Risco", 
             "Alto_Risco", "Alto_Risco", "Baixo_Risco", "Baixo_Risco", 
             "Alto_Risco", "Baixo_Risco", "Alto_Risco", "Alto_Risco", 
             "Alto_Risco", "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", 
             "Alto_Risco", "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Alto_Risco", "Baixo_Risco", "Alto_Risco", 
             "Baixo_Risco", "Alto_Risco", "Alto_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Alto_Risco", "Baixo_Risco", 
             "Alto_Risco", "Baixo_Risco", "Alto_Risco", "Baixo_Risco", 
             "Alto_Risco", "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Alto_Risco", "Baixo_Risco", "Alto_Risco", 
             "Baixo_Risco", "Alto_Risco", "Baixo_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Alto_Risco", "Alto_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", "Alto_Risco", 
             "Alto_Risco", "Alto_Risco", "Alto_Risco", "Alto_Risco", "Alto_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Alto_Risco", "Alto_Risco", 
             "Baixo_Risco", "Alto_Risco", "Alto_Risco", "Alto_Risco", 
             "Baixo_Risco", "Alto_Risco", "Alto_Risco", "Alto_Risco", 
             "Baixo_Risco", "Alto_Risco", "Baixo_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Alto_Risco", "Baixo_Risco", "Alto_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", 
             "Baixo_Risco", "Baixo_Risco", "Baixo_Risco", "Baixo_Risco"
  ))

#Visualiza tipos atuais das variaveis
str(dados)

#Converte as variaveis de character pra factor
dados$Estado_Civil <- as.factor(dados$Estado_Civil)
dados$Escolaridade <- as.factor(dados$Escolaridade)
dados$Metodo_Pagamento <- as.factor(dados$Metodo_Pagamento)
dados$Classe <- as.factor(dados$Classe)

#Visualiza a renda Media, renda mínima e renda máxima, por Classe
dados %>% group_by(Classe) %>% summarise(Renda_Media = mean(Renda_Mensal),
                                         Renda_Desvio_Padrao = sd(Renda_Mensal),
                                         Renda_Coeficiente_de_Variacao = Renda_Desvio_Padrao / Renda_Media)

#Visualiza o primeiro, segundo e terceiro quartil da Idade, por classe
dados %>% group_by(Classe) %>% summarise(Primeiro_Quartil = quantile(Idade, 0.25),
                                               Segundo_Quartil = quantile(Idade, 0.5),
                                               Terceiro_Quartil = quantile(Idade,0.75))


#Relacao entre Renda Mensal e a Classe
boxplot(dados$Renda_Mensal ~  dados$Classe)



# Cria a funcao que sera utilizada, identificando a variavel resposta e as preditoras
# Neste caso a variável resposta é a Classe e as preditoras são Escolaridade, Idade, Renda_Mensal e Metodo de Pagamento
funcao <- as.formula(Classe ~
                       Escolaridade+
                       Idade+
                       Renda_Mensal+
                       Metodo_Pagamento)


#Separa ao dataset em treino e teste
set.seed(1) #Fixa semente para sempre obter a mesma base de treino e teste

index <- createDataPartition(dados$Classe,
                             p = 0.8, #Definir percentual para treino
                             list = F #Manter list = F
)

treino <- dados[index,]
teste <- dados[-index,]




# Treina Arvore de decisao
arvore_model <- train(funcao, 
                      data = treino,
                      method = "rpart",
                      control = rpart.control(
                        minsplit = 5, #Qtde minima de linhas em cada nó   
                        minbucket = 5))


#Visualiza arvore
rpart.plot(arvore_model$finalModel,cex = 0.5)

#Faz a predicao na base de teste
predicao_arvore <- predict(arvore_model,newdata = teste)

#Gera matriz de confusao
confusionMatrix(predicao_arvore,teste$Classe)


# KNN com normalizacao min max
knn <- train(funcao, 
             data = treino,
             method = "knn", 
             preProcess = c("range")) # O argumento 'range' do parâmetro preProcess() realiza transformação min max nas variáveis


#Visualiza resumo do treinamento e o melhor valor de k encontrado
knn


#Faz a predicao na base de teste
predicao_knn <- predict(knn, newdata = teste)

#Gera matriz de confusao
confusionMatrix(predicao_knn,  teste$Classe) 
