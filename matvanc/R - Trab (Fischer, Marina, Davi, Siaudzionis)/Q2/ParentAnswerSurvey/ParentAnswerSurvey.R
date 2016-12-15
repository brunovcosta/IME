######ParentAnswerSurvey######

##############Tabela dados qualitativos(categóricos)#################

tab14<-table(data1$ParentAnsweringSurvey)
tab14

f<-tab14
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

#f - Frequência Absoluta#
#fr - Frequência Relatida#

dist14<-cbind(f, F, fr, Fra)
dist14

Total<-c(sum(f), NA, sum(fr), NA)

dist14<-rbind(dist14, Total)
dist14

##########Gráfico de Barras Simples##############

barplot(tab14,main="Gráfico de Barras\n Variável: ParentingAnsweringSurvey", 
        ylab= "Frequência", xlab="Answers", col=c("Red","Green"))


##########Gráfico de Setor##############


pie(tab14, labels = c(names(tab14)),main="Distribuição dos elementos da amostra segundo ParentAnswerSurvey", col=c("Red","Green"))

