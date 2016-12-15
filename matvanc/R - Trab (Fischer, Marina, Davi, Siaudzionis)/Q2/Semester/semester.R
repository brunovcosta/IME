######Semester######

##############Tabela dados qualitativos(categóricos)#################

tab8<-table(data1$Semester)
tab8

f<-tab8
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

#f - Frequência Absoluta#
#fr - Frequência Relatida#

dist8<-cbind(f, F, fr, Fra)
dist8

Total<-c(sum(f), NA, sum(fr), NA)

dist8<-rbind(dist8, Total)
dist8

##########Gráfico de Barras Simples##############

barplot(tab8,main="Gráfico de Barras\n Variável: Semester", 
        ylab= "Frequência", xlab="Semester", col=c(rainbow(length(tab8))))


##########Gráfico de Setor##############

pie(tab8, labels = c(names(tab8)),main="Distribuição dos elementos da amostra segundo Semester", col=c(rainbow(length(tab8))))

