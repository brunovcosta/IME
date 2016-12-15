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

#classificacao de curtose
Cur<-function(x){
  if(x==0)
    return("Mesokurtic")
  if(x<0)
    return("Platykurtic")
  if(x>0)
    return("Leptokurtic")
}
#classificacao de assimetria
ClassAss<-function(x){
  if(x>0)
    return("right skewed")
  if(x<0)
    return("left skewed")
  if(x==0)
    return("symmetry")
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
  titulos<-c("media","mediana","moda","variância","desvio padrao","coeficiente de variação","coeficiente de assimetria",
             "assimetria","coeficiente de curtose","curtose")
  saida<-c(media,mediana,moda,variancia,desvio_padrao,coeficiente_variacao,coeficiente_assimetria,
           ClassAss(coeficiente_assimetria),coeficiente_curtose,Cur(coeficiente_curtose))
  
  names(saida)<-titulos
  
  return(saida)
}

rbind(questao3(raisedHands),questao3(visitedResources),questao3(announcementsView),questao3(discussion))

