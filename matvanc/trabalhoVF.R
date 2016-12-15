#####################################
## Trabalho de Matemática Avançada ##
## GRUPO:                          ##
### Bruno Vieira Costa             ##
### Lucas Ricarte Rogério Teixeira ##
#####################################

getwd()

library(XLConnect)

dados<-readWorksheet(loadWorkbook("Edu-Data.xlsx"),sheet=1)
dados

###########################
## 1. TIPOS DE VARIÁVEIS ##
###########################

 ##1. Gender-Qualitativa Nominal

 ##2. Nationality-Qualitativa Nominal

 ##3. Place of birth-Qualitativa Nominal

 ##4. Educational Stages-Qualitativa Ordinal

 ##5. Grade Levels-Qualitativa Ordinal

 ##6. Section ID-Qualitativa Nominal

 ##7. Topic-Qualitativa Nominal

 ##8. Semester-Qualitativa Ordinal

 ##9. Parent-Qualitativa Nominal

##10. Raised hand-Quantitativa Discreta

##11. Visited resources-Quantitativa Discreta

##12. Viewing announcements-Quantitativa Discreta

##13. Discussion groups-Quantitativa Discreta

##14. Parent Answering Survey-Qualitativa Nominal

##15. Parent School Satisfaction-Qualitativa Nominal

##16. Student Absence Days-Qualitativa Ordinal

##17. Class-Qualitativa Nominal


###############################
## 2. VARIÁVEIS QUALITATIVAS ##
###############################

############
## Gender ##
############

tab1<-table(dados$gender)
tab1

## a) TABELA DE DISTRIBUIÇÃO DE FREQUÊNCIA
f<-tab1
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist1<-cbind(f, F, fr, Fra)
dist1

Total<-c(sum(f), NA, sum(fr), NA)

dist1total<-rbind(dist1, Total)
dist1total

## b) GRÁFICOS DE BARRAS PARA AS FREQUÊNCIAS ABSOLUTAS

barplot(tab1,main="Gráfico de Barras\n Variável: Sexo", ylab= "Frequência", xlab="Sexo", col=c("pink", "blue"))
        
## b) GRÁFICOS DE SETORES PARA AS FREQUÊNCIAS RELATIVAS

pie(tab1, labels = c("FEMININO","MASCULINO"),col=c("pink","blue"),main="Distribuição dos elementos da amostra segundo sexo")

##Com porcentagem
p.tab1<-round(prop.table(tab1), 2)
p.tab1

rotulos = paste(c("FEMININO","MASCULINO") ," (", 100*p.tab1[],"%)", sep="")
rotulos
pie(tab1, labels = rotulos ,main="Distribuição dos elementos\n da amostra segundo sexo", col=c("pink", "blue"))

##Com legenda
rotulos1 = paste(" (", 100*p.tab1[],"%)")
rotulos1
pie(tab1, labels = rotulos1, main = "Distribuição dos elementos da amostra segundo sexo",col=c("pink", "blue"))
legend("topright", c("Feminino", "Masculino"), cex = 0.8,  fill =c("pink", "blue"))

#################
## NationalITy ##
#################

tab2<-table(dados$NationalITy)
tab2

## a) TABELA DE DISTRIBUIÇÃO DE FREQUÊNCIA
f<-tab2
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist2<-cbind(f, F, fr, Fra)
dist2

Total<-c(sum(f), NA, sum(fr), NA)

dist2total<-rbind(dist2, Total)
dist2total

## b) GRÁFICOS DE BARRAS PARA AS FREQUÊNCIAS ABSOLUTAS

barplot(tab2,main="Gráfico de Barras\n Variável: Nacionalidade", ylab= "Frequência", xlab="Nacionalidade")
        
## b) GRÁFICOS DE SETORES PARA AS FREQUÊNCIAS RELATIVAS

pie(tab2,main="Distribuição dos elementos da amostra segundo nacionalidade")

##################
## PlaceofBirth ##
##################

tab3<-table(dados$PlaceofBirth)
tab3
## a) TABELA DE DISTRIBUIÇÃO DE FREQUÊNCIA
f<-tab3
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist3<-cbind(f, F, fr, Fra)
dist3

Total<-c(sum(f), NA, sum(fr), NA)

dist3total<-rbind(dist3, Total)
dist3total

## b) GRÁFICOS DE BARRAS PARA AS FREQUÊNCIAS ABSOLUTAS

barplot(tab3,main="Gráfico de Barras\n Variável: Local de Nascimento", ylab= "Frequência", xlab="Local de Nacimento")
        
## b) GRÁFICOS DE SETORES PARA AS FREQUÊNCIAS RELATIVAS

pie(tab3,main="Distribuição dos elementos da amostra segundo Local de nascimento")

#############
## StageID ##
#############

tab4<-table(dados$StageID)
tab4
## a) TABELA DE DISTRIBUIÇÃO DE FREQUÊNCIA
f<-tab4
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist4<-cbind(f, F, fr, Fra)
dist4

Total<-c(sum(f), NA, sum(fr), NA)

dist4total<-rbind(dist4, Total)
dist4total

## b) GRÁFICOS DE BARRAS PARA AS FREQUÊNCIAS ABSOLUTAS

barplot(tab4,main="Gráfico de Barras\n Variável: StageID", ylab= "Frequência", xlab="StageID")
        
## b) GRÁFICOS DE SETORES PARA AS FREQUÊNCIAS RELATIVAS

pie(tab4,main="Distribuição dos elementos da amostra segundo sexo")

#############
## GradeID ##
#############

tab5<-table(dados$GradeID)
tab5
## a) TABELA DE DISTRIBUIÇÃO DE FREQUÊNCIA
f<-tab5
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist5<-cbind(f, F, fr, Fra)
dist5

Total<-c(sum(f), NA, sum(fr), NA)

dist5total<-rbind(dist5, Total)
dist5total

## b) GRÁFICOS DE BARRAS PARA AS FREQUÊNCIAS ABSOLUTAS

barplot(tab5,main="Gráfico de Barras\n Variável: GradeID", ylab= "Frequência", xlab="GradeID")
        
## b) GRÁFICOS DE SETORES PARA AS FREQUÊNCIAS RELATIVAS

pie(tab5,main="Distribuição dos elementos da amostra segundo GradeID")

###############
## SectionID ##
###############

tab6<-table(dados$SectionID)
tab6
## a) TABELA DE DISTRIBUIÇÃO DE FREQUÊNCIA
f<-tab6
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist6<-cbind(f, F, fr, Fra)
dist6

Total<-c(sum(f), NA, sum(fr), NA)

dist6total<-rbind(dist6, Total)
dist6total

## b) GRÁFICOS DE BARRAS PARA AS FREQUÊNCIAS ABSOLUTAS

barplot(tab6,main="Gráfico de Barras\n Variável: Section", ylab= "Frequência", xlab="Section")
        
## b) GRÁFICOS DE SETORES PARA AS FREQUÊNCIAS RELATIVAS

pie(tab6,main="Distribuição dos elementos da amostra segundo section")

###########
## Topic ##
###########

tab7<-table(dados$Topic)
tab7
## a) TABELA DE DISTRIBUIÇÃO DE FREQUÊNCIA
f<-tab7
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist7<-cbind(f, F, fr, Fra)
dist7

Total<-c(sum(f), NA, sum(fr), NA)

dist7total<-rbind(dist7, Total)
dist7total

## b) GRÁFICOS DE BARRAS PARA AS FREQUÊNCIAS ABSOLUTAS

barplot(tab7,main="Gráfico de Barras\n Variável: Tópico", ylab= "Frequência", xlab="Tópico")
        
## b) GRÁFICOS DE SETORES PARA AS FREQUÊNCIAS RELATIVAS

pie(tab7,main="Distribuição dos elementos da amostra segundo Tópico")

##############
## Semester ##
##############

tab8<-table(dados$Semester)
tab8
## a) TABELA DE DISTRIBUIÇÃO DE FREQUÊNCIA
f<-tab8
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist8<-cbind(f, F, fr, Fra)
dist8

Total<-c(sum(f), NA, sum(fr), NA)

dist8total<-rbind(dist8, Total)
dist8total

## b) GRÁFICOS DE BARRAS PARA AS FREQUÊNCIAS ABSOLUTAS

barplot(tab8,main="Gráfico de Barras\n Variável: Semestre", ylab= "Frequência", xlab="Semestre")
        
## b) GRÁFICOS DE SETORES PARA AS FREQUÊNCIAS RELATIVAS

pie(tab8,main="Distribuição dos elementos da amostra segundo sexo")

##############
## Relation ##
##############

tab9<-table(dados$Relation)
tab9
## a) TABELA DE DISTRIBUIÇÃO DE FREQUÊNCIA
f<-tab9
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist9<-cbind(f, F, fr, Fra)
dist9

Total<-c(sum(f), NA, sum(fr), NA)

dist9total<-rbind(dist9, Total)
dist9total

## b) GRÁFICOS DE BARRAS PARA AS FREQUÊNCIAS ABSOLUTAS

barplot(tab9,main="Gráfico de Barras\n Variável: Responsável", ylab= "Frequência", xlab="Responsável")
        
## b) GRÁFICOS DE SETORES PARA AS FREQUÊNCIAS RELATIVAS

pie(tab9,main="Distribuição dos elementos da amostra segundo responsável")

###########################
## ParentAnsweringSurvey ##
###########################

tab10<-table(dados$ParentAnsweringSurvey)
tab10
## a) TABELA DE DISTRIBUIÇÃO DE FREQUÊNCIA
f<-tab10
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist10<-cbind(f, F, fr, Fra)
dist10

Total<-c(sum(f), NA, sum(fr), NA)

dist10total<-rbind(dist10, Total)
dist10total

## b) GRÁFICOS DE BARRAS PARA AS FREQUÊNCIAS ABSOLUTAS

barplot(tab10,main="Gráfico de Barras\n Variável: Pais responderam pesquisa", ylab= "Frequência", xlab="Pais responderam pesquisa")
        
## b) GRÁFICOS DE SETORES PARA AS FREQUÊNCIAS RELATIVAS

pie(tab10,main="Distribuição dos elementos da amostra segundo pais que responderam pesquisa")

##############################
## ParentschoolSatisfaction ##
##############################

tab11<-table(dados$ParentschoolSatisfaction)
tab11
## a) TABELA DE DISTRIBUIÇÃO DE FREQUÊNCIA
f<-tab11
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist11<-cbind(f, F, fr, Fra)
dist11

Total<-c(sum(f), NA, sum(fr), NA)

dist11total<-rbind(dist11, Total)
dist11total

## b) GRÁFICOS DE BARRAS PARA AS FREQUÊNCIAS ABSOLUTAS

barplot(tab11,main="Gráfico de Barras\n Variável: Satisfação dos pais", ylab= "Frequência", xlab="Satisfação dos pais")
        
## b) GRÁFICOS DE SETORES PARA AS FREQUÊNCIAS RELATIVAS

pie(tab11,main="Distribuição dos elementos da amostra segundo satisfação dos pais")


########################
## StudentAbsenceDays ##
########################

tab12<-table(dados$StudentAbsenceDays)
tab12
## a) TABELA DE DISTRIBUIÇÃO DE FREQUÊNCIA
f<-tab12
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist12<-cbind(f, F, fr, Fra)
dist12

Total<-c(sum(f), NA, sum(fr), NA)

dist12total<-rbind(dist12, Total)
dist12total

## b) GRÁFICOS DE BARRAS PARA AS FREQUÊNCIAS ABSOLUTAS

barplot(tab12,main="Gráfico de Barras\n Variável: StudentAbsenceDays", 
        ylab= "Frequência", xlab="StudentAbsenceDays")
        
## b) GRÁFICOS DE SETORES PARA AS FREQUÊNCIAS RELATIVAS

pie(tab12,main="Distribuição dos elementos da amostra segundo StudentAbsenceDays")


###########
## Class ##
###########

tab13<-table(dados$Class)
tab13
## a) TABELA DE DISTRIBUIÇÃO DE FREQUÊNCIA
f<-tab13
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist13<-cbind(f, F, fr, Fra)
dist13

Total<-c(sum(f), NA, sum(fr), NA)

dist13total<-rbind(dist13, Total)
dist13total

## b) GRÁFICOS DE BARRAS PARA AS FREQUÊNCIAS ABSOLUTAS

barplot(tab13,main="Gráfico de Barras\n Variável: Class", ylab= "Frequência", xlab="Class")
        
## b) GRÁFICOS DE SETORES PARA AS FREQUÊNCIAS RELATIVAS

pie(tab13,main="Distribuição dos elementos da amostra segundo Class")



################################
## 3. VARIÁVEIS QUANTITATIVAS ##
################################

################
## raisehands ##
################

## a) Tabela de Distribuição de frequências para variáveis quantitativas ##

histograma<-hist(dados$raisedhands)
names(histograma)

br<-histograma$breaks
br

k<-length(br)-1
k

f <-histograma$counts
f

n <- sum(f)
n

PM<-histograma$mids
PM

h<-br[2] - br[1]
h

Intervalos<-0
for(i in 1:(k)){
      Intervalos[i]<-paste(br[i],c("|-"),br[i+1], sep="")}
Intervalos

dist<-cbind(Intervalos, PM, f)
dist

fr<-f/n
fr

F<-cumsum(f)
F

Fra<-cumsum(fr)
Fra

dist<-cbind(dist, F, fr, Fra)
dist

Total<-c("Total", NA, sum(f), NA, sum(fr), NA)

dist<-rbind(dist, Total)
dist

rownames(dist)<-seq(1, k+1, 1)
dist

dist<-data.frame(dist)
dist

## b) Histograma
histograma<-hist(dados$raisedhands)

## c) Frequência Acumulada
f<-c(0, histograma$counts)
f

fac<-cumsum(f)
fac

plot(br, fac, type="l", lty=2, main="Freqüências Acumuladas", xlab="Intervalos", ylab="Freqüencias")
points(br, fac, pch=16)

## d) Média
f <-histograma$counts
f

x.bar<-weighted.mean(PM, f)
x.bar

## d) Mediana
f <-histograma$counts
f
fac<-cumsum(f)
fac

PMd<-n/2
PMd

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PMd)]))){
        Md<-br[j]+((PMd-max(fac[which(fac<PMd)]))/f[j])*h}}
Md
dist

## d) Moda
f <-histograma$counts
f
h<-br[2] - br[1]
h
j<-which(f==max(f))
    if(j>1){
      d1<-f[j]-f[j-1]
      d2<-f[j]-f[j+1]
      Mo<-br[j]+(d1/(d1+d2))*h}
    if(j==1){
      Mo<-PM[j]}
Mo
dist

## e) Variância
Desvio = PM - x.bar
Desvio
Desvio2 = Desvio^2
Desvio2
Desvio2f = Desvio2*f
Desvio2f
sum(Desvio2f)
sum(Desvio2f)/(n-1)

dist<-cbind(dist, Desvio, Desvio2f)
dist

Var = sum(Desvio2*f)/(n-1)
Var

## 3 e) Desvio-padrão
DP = sqrt(Var)
DP

## 3 e) Coeficiente de variação
CV = (DP/x.bar)*100
CV

## 3 f) Calcular o coeficiente de assimetria, e classificar a distribuição;
###################Cálculo de Q1 e Q3##############

PQ1<-0.25*sum(f)
PQ1
fac<-cumsum(f)
fac
k
h

for (j in 1:length(fac)){
   if( j == which(fac==min(fac[which(fac>=PQ1)]))){
        Q1<-br[j]+((PQ1-max(fac[which(fac<PQ1)]))/f[j])*h}}
Q1

PQ3<-0.75*sum(f)
PQ3

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PQ3)]))){
        Q3<-br[j]+((PQ3-max(fac[which(fac<PQ3)]))/f[j])*h}}
Q3

###################Cálculo de P10 e P90##############

PP10<-(0.10*sum(f))
PP10

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PP10)]))){
        fant=max(fac[which(fac<PP10)])
        if(fant==-Inf){fant=0}
        P10<-br[j]+((PP10-fant)/f[j])*h}}
P10

PP90<-(0.90*sum(f))
PP90

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PP90)]))){
        fant=max(fac[which(fac<PP90)])
        if(fant==-Inf){fant=0}
        P90<-br[j]+((PP90-fant)/f[j])*h}}
P90

######## Cálculo de Assimetria ######
As = (Q3 - 2*Md + Q1)/(Q3 - Q1)
As

ClassAss <- function(x)
{
  if( x > 0 )
    return ("Assimetria Positiva")
  if( x < 0 )
    return ("Assimetria Negativa")
  if( x == 0 )
    return ("Simetrica")
}

ClassAss(As)

## 3 g) Calcular o coeficiente de curtose, e classificar a distribuição.
Cur = (Q3 - Q1)/(2*(P90 - P10))
Cur

ClassCur <- function(x)
{
  if( x > 0.263 )
    return ("Distribuição Platicúrtica")
  if( x < 0.263 )
    return ("Distribuição leptocúrtica")
  if( x == 0.263 )
    return ("Distribuição mesocúrtica")
}

ClassCur(Cur)


######################
## VisITedResources ##
######################

## a) Tabela de Distribuição de frequências para variáveis quantitativas ##

histograma<-hist(dados$VisITedResources)
names(histograma)

br<-histograma$breaks
br

k<-length(br)-1
k

f <-histograma$counts
f

n <- sum(f)
n

PM<-histograma$mids
PM

h<-br[2] - br[1]
h

Intervalos<-0
for(i in 1:(k)){
      Intervalos[i]<-paste(br[i],c("|-"),br[i+1], sep="")}
Intervalos

dist<-cbind(Intervalos, PM, f)
dist

fr<-f/n
fr

F<-cumsum(f)
F

Fra<-cumsum(fr)
Fra

dist<-cbind(dist, F, fr, Fra)
dist

Total<-c("Total", NA, sum(f), NA, sum(fr), NA)

dist<-rbind(dist, Total)
dist

rownames(dist)<-seq(1, k+1, 1)
dist

dist<-data.frame(dist)
dist

## b) Histograma
histograma<-hist(dados$VisITedResources)

## c) Frequência Acumulada
f<-c(0, histograma$counts)
f

fac<-cumsum(f)
fac

plot(br, fac, type="l", lty=2, main="Freqüências Acumuladas", xlab="Intervalos", ylab="Freqüencias")
points(br, fac, pch=16)

## d) Média
f <-histograma$counts
f

x.bar<-weighted.mean(PM, f)
x.bar

## d) Mediana
f <-histograma$counts
f
fac<-cumsum(f)
fac

PMd<-n/2
PMd

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PMd)]))){
        Md<-br[j]+((PMd-max(fac[which(fac<PMd)]))/f[j])*h}}
Md
dist

## d) Moda
f <-histograma$counts
f
h<-br[2] - br[1]
h
j<-which(f==max(f))
    if(j>1){
      d1<-f[j]-f[j-1]
      d2<-f[j]-f[j+1]
      Mo<-br[j]+(d1/(d1+d2))*h}
    if(j==1){
      Mo<-PM[j]}
Mo
dist

## e) Variância
Desvio = PM - x.bar
Desvio
Desvio2 = Desvio^2
Desvio2
Desvio2f = Desvio2*f
Desvio2f
sum(Desvio2f)
sum(Desvio2f)/(n-1)

dist<-cbind(dist, Desvio, Desvio2f)
dist

Var = sum(Desvio2*f)/(n-1)
Var

## 3 e) Desvio-padrão
DP = sqrt(Var)
DP

## 3 e) Coeficiente de variação
CV = (DP/x.bar)*100
CV

## 3 f) Calcular o coeficiente de assimetria, e classificar a distribuição;
###################Cálculo de Q1 e Q3##############

PQ1<-0.25*sum(f)
PQ1
fac<-cumsum(f)
fac
k
h

for (j in 1:length(fac)){
   if( j == which(fac==min(fac[which(fac>=PQ1)]))){
        Q1<-br[j]+((PQ1-max(fac[which(fac<PQ1)]))/f[j])*h}}
Q1

PQ3<-0.75*sum(f)
PQ3

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PQ3)]))){
        Q3<-br[j]+((PQ3-max(fac[which(fac<PQ3)]))/f[j])*h}}
Q3

###################Cálculo de P10 e P90##############

PP10<-(0.10*sum(f))
PP10

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PP10)]))){
        fant=max(fac[which(fac<PP10)])
        if(fant==-Inf){fant=0}
        P10<-br[j]+((PP10-fant)/f[j])*h}}
P10

PP90<-(0.90*sum(f))
PP90

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PP90)]))){
        fant=max(fac[which(fac<PP90)])
        if(fant==-Inf){fant=0}
        P90<-br[j]+((PP90-fant)/f[j])*h}}
P90

######## Cálculo de Assimetria ######
As = (Q3 - 2*Md + Q1)/(Q3 - Q1)
As

ClassAss <- function(x)
{
  if( x > 0 )
    return ("Assimetria Positiva")
  if( x < 0 )
    return ("Assimetria Negativa")
  if( x == 0 )
    return ("Simetrica")
}

ClassAss(As)

## 3 g) Calcular o coeficiente de curtose, e classificar a distribuição.
Cur = (Q3 - Q1)/(2*(P90 - P10))
Cur

ClassCur <- function(x)
{
  if( x > 0.263 )
    return ("Distribuição Platicúrtica")
  if( x < 0.263 )
    return ("Distribuição leptocúrtica")
  if( x == 0.263 )
    return ("Distribuição mesocúrtica")
}

ClassCur(Cur)



#######################
## AnnouncementsView ##
#######################

## a) Tabela de Distribuição de frequências para variáveis quantitativas ##

histograma<-hist(dados$AnnouncementsView)
names(histograma)

br<-histograma$breaks
br

k<-length(br)-1
k

f <-histograma$counts
f

n <- sum(f)
n

PM<-histograma$mids
PM

h<-br[2] - br[1]
h

Intervalos<-0
for(i in 1:(k)){
      Intervalos[i]<-paste(br[i],c("|-"),br[i+1], sep="")}
Intervalos

dist<-cbind(Intervalos, PM, f)
dist

fr<-f/n
fr

F<-cumsum(f)
F

Fra<-cumsum(fr)
Fra

dist<-cbind(dist, F, fr, Fra)
dist

Total<-c("Total", NA, sum(f), NA, sum(fr), NA)

dist<-rbind(dist, Total)
dist

rownames(dist)<-seq(1, k+1, 1)
dist

dist<-data.frame(dist)
dist

## b) Histograma
histograma<-hist(dados$AnnouncementsView)

## c) Frequência Acumulada
f<-c(0, histograma$counts)
f

fac<-cumsum(f)
fac

plot(br, fac, type="l", lty=2, main="Freqüências Acumuladas", xlab="Intervalos", ylab="Freqüencias")
points(br, fac, pch=16)

## d) Média
f <-histograma$counts
f

x.bar<-weighted.mean(PM, f)
x.bar

## d) Mediana
f <-histograma$counts
f
fac<-cumsum(f)
fac

PMd<-n/2
PMd

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PMd)]))){
        Md<-br[j]+((PMd-max(fac[which(fac<PMd)]))/f[j])*h}}
Md
dist

## d) Moda
f <-histograma$counts
f
h<-br[2] - br[1]
h
j<-which(f==max(f))
    if(j>1){
      d1<-f[j]-f[j-1]
      d2<-f[j]-f[j+1]
      Mo<-br[j]+(d1/(d1+d2))*h}
    if(j==1){
      Mo<-PM[j]}
Mo
dist

## e) Variância
Desvio = PM - x.bar
Desvio
Desvio2 = Desvio^2
Desvio2
Desvio2f = Desvio2*f
Desvio2f
sum(Desvio2f)
sum(Desvio2f)/(n-1)

dist<-cbind(dist, Desvio, Desvio2f)
dist

Var = sum(Desvio2*f)/(n-1)
Var

## 3 e) Desvio-padrão
DP = sqrt(Var)
DP

## 3 e) Coeficiente de variação
CV = (DP/x.bar)*100
CV

## 3 f) Calcular o coeficiente de assimetria, e classificar a distribuição;
###################Cálculo de Q1 e Q3##############

PQ1<-0.25*sum(f)
PQ1
fac<-cumsum(f)
fac
k
h

for (j in 1:length(fac)){
   if( j == which(fac==min(fac[which(fac>=PQ1)]))){
        Q1<-br[j]+((PQ1-max(fac[which(fac<PQ1)]))/f[j])*h}}
Q1

PQ3<-0.75*sum(f)
PQ3

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PQ3)]))){
        Q3<-br[j]+((PQ3-max(fac[which(fac<PQ3)]))/f[j])*h}}
Q3

###################Cálculo de P10 e P90##############

PP10<-(0.10*sum(f))
PP10

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PP10)]))){
        fant=max(fac[which(fac<PP10)])
        if(fant==-Inf){fant=0}
        P10<-br[j]+((PP10-fant)/f[j])*h}}
P10

PP90<-(0.90*sum(f))
PP90

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PP90)]))){
        fant=max(fac[which(fac<PP90)])
        if(fant==-Inf){fant=0}
        P90<-br[j]+((PP90-fant)/f[j])*h}}
P90

######## Cálculo de Assimetria ######
As = (Q3 - 2*Md + Q1)/(Q3 - Q1)
As

ClassAss <- function(x)
{
  if( x > 0 )
    return ("Assimetria Positiva")
  if( x < 0 )
    return ("Assimetria Negativa")
  if( x == 0 )
    return ("Simetrica")
}

ClassAss(As)

## 3 g) Calcular o coeficiente de curtose, e classificar a distribuição.
Cur = (Q3 - Q1)/(2*(P90 - P10))
Cur

ClassCur <- function(x)
{
  if( x > 0.263 )
    return ("Distribuição Platicúrtica")
  if( x < 0.263 )
    return ("Distribuição leptocúrtica")
  if( x == 0.263 )
    return ("Distribuição mesocúrtica")
}

ClassCur(Cur)

################
## Discussion ##
################

## a) Tabela de Distribuição de frequências para variáveis quantitativas ##

histograma<-hist(dados$Discussion)
names(histograma)

br<-histograma$breaks
br

k<-length(br)-1
k

f <-histograma$counts
f

n <- sum(f)
n

PM<-histograma$mids
PM

h<-br[2] - br[1]
h

Intervalos<-0
for(i in 1:(k)){
      Intervalos[i]<-paste(br[i],c("|-"),br[i+1], sep="")}
Intervalos

dist<-cbind(Intervalos, PM, f)
dist

fr<-f/n
fr

F<-cumsum(f)
F

Fra<-cumsum(fr)
Fra

dist<-cbind(dist, F, fr, Fra)
dist

Total<-c("Total", NA, sum(f), NA, sum(fr), NA)

dist<-rbind(dist, Total)
dist

rownames(dist)<-seq(1, k+1, 1)
dist

dist<-data.frame(dist)
dist

## b) Histograma
histograma<-hist(dados$Discussion)

## c) Frequência Acumulada
f<-c(0, histograma$counts)
f

fac<-cumsum(f)
fac

plot(br, fac, type="l", lty=2, main="Freqüências Acumuladas", xlab="Intervalos", ylab="Freqüencias")
points(br, fac, pch=16)

## d) Média
f <-histograma$counts
f

x.bar<-weighted.mean(PM, f)
x.bar

## d) Mediana
f <-histograma$counts
f
fac<-cumsum(f)
fac

PMd<-n/2
PMd

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PMd)]))){
        Md<-br[j]+((PMd-max(fac[which(fac<PMd)]))/f[j])*h}}
Md
dist

## d) Moda
f <-histograma$counts
f
h<-br[2] - br[1]
h
j<-which(f==max(f))
    if(j>1){
      d1<-f[j]-f[j-1]
      d2<-f[j]-f[j+1]
      Mo<-br[j]+(d1/(d1+d2))*h}
    if(j==1){
      Mo<-PM[j]}
Mo
dist

## e) Variância
Desvio = PM - x.bar
Desvio
Desvio2 = Desvio^2
Desvio2
Desvio2f = Desvio2*f
Desvio2f
sum(Desvio2f)
sum(Desvio2f)/(n-1)

dist<-cbind(dist, Desvio, Desvio2f)
dist

Var = sum(Desvio2*f)/(n-1)
Var

## 3 e) Desvio-padrão
DP = sqrt(Var)
DP

## 3 e) Coeficiente de variação
CV = (DP/x.bar)*100
CV

## 3 f) Calcular o coeficiente de assimetria, e classificar a distribuição;
###################Cálculo de Q1 e Q3##############

PQ1<-0.25*sum(f)
PQ1
fac<-cumsum(f)
fac
k
h

for (j in 1:length(fac)){
   if( j == which(fac==min(fac[which(fac>=PQ1)]))){
        Q1<-br[j]+((PQ1-max(fac[which(fac<PQ1)]))/f[j])*h}}
Q1

PQ3<-0.75*sum(f)
PQ3

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PQ3)]))){
        Q3<-br[j]+((PQ3-max(fac[which(fac<PQ3)]))/f[j])*h}}
Q3

###################Cálculo de P10 e P90##############

PP10<-(0.10*sum(f))
PP10

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PP10)]))){
        fant=max(fac[which(fac<PP10)])
        if(fant==-Inf){fant=0}
        P10<-br[j]+((PP10-fant)/f[j])*h}}
P10

PP90<-(0.90*sum(f))
PP90

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PP90)]))){
        fant=max(fac[which(fac<PP90)])
        if(fant==-Inf){fant=0}
        P90<-br[j]+((PP90-fant)/f[j])*h}}
P90

######## Cálculo de Assimetria ######
As = (Q3 - 2*Md + Q1)/(Q3 - Q1)
As

ClassAss <- function(x)
{
  if( x > 0 )
    return ("Assimetria Positiva")
  if( x < 0 )
    return ("Assimetria Negativa")
  if( x == 0 )
    return ("Simetrica")
}

ClassAss(As)

## 3 g) Calcular o coeficiente de curtose, e classificar a distribuição.
Cur = (Q3 - Q1)/(2*(P90 - P10))
Cur

ClassCur <- function(x)
{
  if( x > 0.263 )
    return ("Distribuição Platicúrtica")
  if( x < 0.263 )
    return ("Distribuição leptocúrtica")
  if( x == 0.263 )
    return ("Distribuição mesocúrtica")
}

ClassCur(Cur)

################################################
## 4 - Variáveis escolhidas: gender e StageID ##
################################################

## 4 a) Tabela de dupla entrada
tabdupla<-table(dados$gender,dados$StageID)
tabdupla

## 4 b) Gráfico de barras duplas
barplot(tabdupla, beside=T, col=c("pink", "blue"), main="Gráfico de Barras Duplas")
legend("top", legend=c("Feminino", "Masculino"), fill=c("pink", "blue"))

## 4 c) Gráfico de barras empilhadas
barplot(tabdupla, legend = T, col=c("pink", "blue"), main="Gráfico de Barras Empilhadas")

## 4 d) Gráfico de barras complementares
p.tabdupla<-prop.table(tabdupla,2)
p.tabdupla

barplot(p.tabdupla)
barplot(p.tabdupla, legend = T)
barplot(p.tabdupla, legend = T,col=c("pink", "blue"), main="Gráfico de Barras Complementares")

