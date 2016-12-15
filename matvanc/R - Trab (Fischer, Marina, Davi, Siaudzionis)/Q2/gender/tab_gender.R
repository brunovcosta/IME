######GENDER######

##############Tabela dados qualitativos(categóricos)#################

tab1<-table(data1$gender)
tab1

f<-tab1
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

#f - Frequência Absoluta#
#fr - Frequência Relatida#

dist1<-cbind(f, F, fr, Fra)
dist1

Total<-c(sum(f), NA, sum(fr), NA)

dist1<-rbind(dist1, Total)
dist1

##########Gráfico de Barras Simples##############

barplot(tab1,main="Gráfico de Barras\n Variável: Sexo", 
        ylab= "Frequência", xlab="Sexo", col=c("pink", "blue"))


##########Gráfico de Setor##############

pie(tab1, labels = c("FEMININO","MASCULINO"),main="Distribuição dos elementos da amostra segundo sexo", col=c("pink", "blue"))
