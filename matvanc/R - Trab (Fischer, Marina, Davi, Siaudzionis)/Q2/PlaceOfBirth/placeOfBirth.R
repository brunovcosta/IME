######Place Of Birth######

##############Tabela dados qualitativos(categóricos)#################

tab3<-table(data1$PlaceofBirth)
tab3

f<-tab3
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

#f - Frequência Absoluta#
#fr - Frequência Relatida#

dist3<-cbind(f, F, fr, Fra)
dist3

Total<-c(sum(f), NA, sum(fr), NA)

dist3<-rbind(dist3, Total)
dist3

##########Gráfico de Barras Simples##############

barplot(tab3,main="Gráfico de Barras\n Variável: Place Of Birth", 
        ylab= "Frequência", xlab="Place of Birth", col=c(rainbow(length(tab3))))


##########Gráfico de Setor##############

pie(tab3, labels = c(names(tab3)),main="Distribuição dos elementos da amostra segundo place of birth", col=c(rainbow(length(tab3))))
