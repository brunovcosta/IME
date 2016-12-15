######Relation######

##############Tabela dados qualitativos(categóricos)#################

tab9<-table(data1$Relation)
tab9

f<-tab9
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

#f - Frequência Absoluta#
#fr - Frequência Relatida#

dist9<-cbind(f, F, fr, Fra)
dist9

Total<-c(sum(f), NA, sum(fr), NA)

dist9<-rbind(dist9, Total)
dist9

##########Gráfico de Barras Simples##############

barplot(tab9,main="Gráfico de Barras\n Variável: Relation", 
        ylab= "Frequência", xlab="Parant Responsible", col=c("Blue","Pink"))


##########Gráfico de Setor##############


pie(tab9, labels = c(names(tab9)),main="Distribuição dos elementos da amostra segundo Relation -Parent Responsible-", col=c("Blue","Pink"))

