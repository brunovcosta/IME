######StudentAbsenceDays######

##############Tabela dados qualitativos(categóricos)#################

tab16<-table(data1$StudentAbsenceDays)
tab16

f<-tab16
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

#f - Frequência Absoluta#
#fr - Frequência Relatida#

dist16<-cbind(f, F, fr, Fra)
dist16

Total<-c(sum(f), NA, sum(fr), NA)

dist16<-rbind(dist16, Total)
dist16

##########Gráfico de Barras Simples##############

barplot(tab16,main="Gráfico de Barras\n Variável: SchoolAbsentDays", 
        ylab= "School Absent Days", xlab="Section", col=c(rainbow(length(tab6))))


##########Gráfico de Setor##############

pie(tab16, labels = c(names(tab16)),main="Distribuição dos elementos da amostra segundo School Absent Days", col=c(rainbow(length(tab16))))

