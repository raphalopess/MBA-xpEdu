
rm(list=ls(all=TRUE)) #Remove objetos da memória do R

#Armazena o conjunto de dados iris em um data frame com o nome dados
dados <- iris

#visualiza a media (mean) e outras estatisticas descritivas das variaveis
summary(dados)

#Visualiza desvio padrao (standard deviation) das variaveis
sd(dados$Sepal.Length)
sd(dados$Sepal.Width)
sd(dados$Petal.Length)
sd(dados$Petal.Width)

#Visualiza atraves de um histograma a distribuicao da variavel Sepal Length
hist(dados$Sepal.Length)

# Customizando o histograma
hist(dados$Sepal.Length,
col = 'blue',main = 'Distribuicao dos valores da variavel Sepal.Length')

#Visualiza o histograma das quatro variaveis numericas na mesma pagina
par(mfrow=c(2,2)) #Configura layout para posicionar os graficos em duas linhas e duas colunas
hist(dados$Sepal.Length,
 col = 'blue',
 main = 'Distribuicao dos valores da variavel Sepal.Length')
hist(dados$Sepal.Width,
 col = 'blue',
 main = 'Distribuicao dos valores da variavel Sepal.Width')
hist(dados$Petal.Length,
 col = 'blue',
 main = 'Distribuicao dos valores da variavel Petal.Length')
hist(dados$Petal.Width,
 col = 'blue',
 main = 'Distribuicao dos valores da variavel Petal.Width')
dev.off() #limpa os graficos e volta o layout para configuracao normal

#Visualiza relacao entre as variaveis sepal length e sepal width
plot(y = dados$Sepal.Length,
 x = dados$Petal.Length)
#Customiza o grafico
plot(y = dados$Sepal.Length,
 x = dados$Petal.Length,
 pch = 16,
 col = 'blue',
 xlab = 'Petal Length',
 ylab = 'Sepal Length',
 main = 'Relacao entre comprimento da sepala e comprimento da petala')
grid() #este comando adiciona linhas de grade ao grafico

#Colore o grafico por tipo de flor com o argumento col =
plot(col = dados$Species,
 y = dados$Sepal.Length,
 x = dados$Petal.Length,
 pch = 16,
 xlab = 'Petal Length',
 ylab = 'Sepal Length',
 main = 'Relacao entre comprimento da sepala e comprimento da petala')
 
 #adiciona legenda
legend(x=1,y=8,
 c("Virginica","Versicolor","Setora"),
 col=c("green","red",'black'),pch=c(16,16,16))
grid()

#calcula a correlacao entre Sepal.Length e Petal.Length
cor(dados$Sepal.Length, dados$Petal.Length)

#Gera matriz de correlacoes para visualizar a correlacao entre todas as variaveis
cor(dados[,-5]) #remove a coluna 5 pois corresponde a variavel resposta que e categorica

#Visualiza matriz de dispersoes
plot(dados[,-5])

#Cria uma nova variavel informando se a observacao esta acima ou abaixo da media da variavel Sepal.Length
	media <- mean(dados$Sepal.Length) #armazena a media em uma variavel
	variavel <- ifelse(dados$Sepal.Length > media,
		'Acima_da_media',
			'Abaixo_da_media')
	variavel <- factor(variavel) #converte nova variavel para factor
	plot(variavel) #grafico com a qtde abaixo e acima da media
	table(variavel) #visualiza a qtde abaixo e acima da media
