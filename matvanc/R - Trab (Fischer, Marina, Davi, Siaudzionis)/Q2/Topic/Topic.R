######Topic######

##############Tabela dados qualitativos(categóricos)#################

tab7<-table(data1$Topic)
tab7

f<-tab7
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

#f - Frequência Absoluta#
#fr - Frequência Relatida#

dist7<-cbind(f, F, fr, Fra)
dist7

Total<-c(sum(f), NA, sum(fr), NA)

dist7<-rbind(dist7, Total)
dist7

##########Gráfico de Barras Simples##############

barplot(tab7,main="Gráfico de Barras\n Variável: Topic", 
        ylab= "Frequência", xlab="Topic", col=c(rainbow(length(tab7))))


##########Gráfico de Setor##############

pie(tab7, labels = c(names(tab7)),main="Distribuição dos elementos da amostra segundo Topic", col=c(rainbow(length(tab7))))

