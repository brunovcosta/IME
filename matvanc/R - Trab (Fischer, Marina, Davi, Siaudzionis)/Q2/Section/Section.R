######Section######

##############Tabela dados qualitativos(categóricos)#################

tab6<-table(data1$SectionID)
tab6

f<-tab6
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

#f - Frequência Absoluta#
#fr - Frequência Relatida#

dist6<-cbind(f, F, fr, Fra)
dist6

Total<-c(sum(f), NA, sum(fr), NA)

dist6<-rbind(dist6, Total)
dist6

##########Gráfico de Barras Simples##############

barplot(tab6,main="Gráfico de Barras\n Variável: Section", 
        ylab= "Frequência", xlab="Section", col=c(rainbow(length(tab6))))


##########Gráfico de Setor##############

pie(tab6, labels = c(names(tab6)),main="Distribuição dos elementos da amostra segundo Section", col=c(rainbow(length(tab6))))

