######NATIONALITY######

##############Tabela dados qualitativos(categóricos)#################

tab2<-table(data1$NationalITy)
tab2

f<-tab2
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

#f - Frequência Absoluta#
#fr - Frequência Relatida#

dist2<-cbind(f, F, fr, Fra)
dist2

Total<-c(sum(f), NA, sum(fr), NA)

dist2<-rbind(dist2, Total)
dist2

##########Gráfico de Barras Simples##############

barplot(tab2,main="Gráfico de Barras\n Variável: Nationality", 
        ylab= "Frequência", xlab="Nationality", col=c(rainbow(length(tab2))))


##########Gráfico de Setor##############

pie(tab2, labels = c(names(tab2)),main="Distribuição dos elementos da amostra segundo nacionalidade", col=c(rainbow(length(tab2))))
