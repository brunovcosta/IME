######ParentSchoolSatisfaction######

##############Tabela dados qualitativos(categóricos)#################

tab15<-table(data1$ParentschoolSatisfaction)
tab15

f<-tab15
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

#f - Frequência Absoluta#
#fr - Frequência Relatida#

dist15<-cbind(f, F, fr, Fra)
dist15

Total<-c(sum(f), NA, sum(fr), NA)

dist15<-rbind(dist15, Total)
dist15

##########Gráfico de Barras Simples##############

barplot(tab15,main="Gráfico de Barras\n Variável: ParentSchoolSatisfaction", 
        ylab= "Frequência", xlab="Result", col=c("Black","Pink"))


##########Gráfico de Setor##############


pie(tab15, labels = c(names(tab15)),main="Distribuição dos elementos da amostra segundo ParentSchoolSatisfaction", col=c("Black","Pink"))

