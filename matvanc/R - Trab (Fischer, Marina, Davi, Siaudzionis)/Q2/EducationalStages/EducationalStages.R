######Educational Stages######

##############Tabela dados qualitativos(categóricos)#################

tab4<-table(data1$StageID)
tab4

f<-tab4
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

#f - Frequência Absoluta#
#fr - Frequência Relatida#

dist4<-cbind(f, F, fr, Fra)
dist4

Total<-c(sum(f), NA, sum(fr), NA)

dist4<-rbind(dist4, Total)
dist4

##########Gráfico de Barras Simples##############

barplot(tab4,main="Gráfico de Barras\n Variável: Educational Stages", 
        ylab= "Frequência", xlab="Educational Stages", col=c(rainbow(length(tab4))))


##########Gráfico de Setor##############

pie(tab4, labels = c(names(tab4)),main="Distribuição dos elementos da amostra segundo Educatinal Stages", col=c(rainbow(length(tab4))))
