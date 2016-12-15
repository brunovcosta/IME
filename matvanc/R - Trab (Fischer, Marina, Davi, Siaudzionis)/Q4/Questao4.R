########2 variaveis -> Relation & parentSchoolSatisfaction#######

####Tabela de dupla Entrada#######

tabDupla<-table(data1$Relation, data1$ParentschoolSatisfaction)
tabDupla


#########Gráfico de Barras Duplas#####

barplot(tabDupla, col=c("blue", "pink"),beside=T, legend = T, main="Gráfico de Barras Duplas")


############Barras Empilhadas#########

barplot(tabDupla, legend = T, col=c("blue", "pink"), main="Gráfico de Barras Empilhadas")


###########Barras complementares###########33333

p.tabDupla<-prop.table(tabDupla,2)
p.tabDupla

barplot(p.tabDupla, legend = T,col=c("blue", "pink"), main="Gráfico de Barras Complementares")
