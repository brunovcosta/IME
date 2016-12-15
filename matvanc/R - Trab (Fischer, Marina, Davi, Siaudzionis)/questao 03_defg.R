#esses pacotes instalam o coeficiente de curtose
install.packages("e1071")
library("e1071")

getwd()
setwd("/Users/pedrosiau/Desktop")
alunos<-read.csv("Edu-Data.csv")
summary(alunos)

raisedHands<-alunos$raisedhands
visitedResources<-alunos$VisITedResources
announcementsView<-alunos$AnnouncementsView
discussion<-alunos$Discussion

#funcao que calcula moda
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}


#criar tabela para a questao 3
questao3<-function(data){
  media<-mean(data)
  mediana<-median(data)
  moda<-getmode(data)
  variancia<-var(data)
  desvio_padrao<-sd(data)
  coeficiente_variacao<-desvio_padrao/media
  coeficiente_assimetria<-skewness(data)
  coeficiente_curtose<-kurtosis(data)
  titulos<-c("media","mediana","moda","variância","desvio padrao","coeficiente de variação","coeficiente de assimetria","coeficiente de curtose")
  saida<-c(media,mediana,moda,variancia,desvio_padrao,coeficiente_variacao,coeficiente_assimetria,coeficiente_curtose)
  
  names(saida)<-titulos
  
  return(saida)
}
skewness(raisedHands)
questao3(raisedHands)
questao3(visitedResources)
questao3(announcementsView)
questao3(discussion)

rbind(questao3(raisedHands),questao3(visitedResources),questao3(announcementsView),questao3(discussion))

