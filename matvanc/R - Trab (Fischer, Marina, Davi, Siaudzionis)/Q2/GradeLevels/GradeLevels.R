######Grade Levels######

##############Tabela dados qualitativos(categóricos)#################

tab5<-table(data1$GradeID)
tab5

f<-tab5
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

#f - Frequência Absoluta#
#fr - Frequência Relatida#

dist5<-cbind(f, F, fr, Fra)
dist5

Total<-c(sum(f), NA, sum(fr), NA)

dist5<-rbind(dist5, Total)
dist5

##########Gráfico de Barras Simples##############

barplot(tab5,main="Gráfico de Barras\n Variável: Grade Levels", 
        ylab= "Frequência", xlab="Grade Levels", col=c(rainbow(length(tab5))))


##########Gráfico de Setor##############

pie(tab5, labels = c(names(tab5)),main="Distribuição dos elementos da amostra segundo Grade Levels", col=c(rainbow(length(tab5))))

