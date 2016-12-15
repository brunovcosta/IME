
install.packages("XLConnect")
library(XLConnect)

dados<-readWorksheet(loadWorkbook("dados_alunos1.xls"),sheet=1)
dados

head(dados, 5)
tail(dados, 5)

##############Tabeela dados qualitativos(categóricos)#################

tab1<-table(dados$SEXO)
tab1

f<-tab1
F<-cumsum(f)
fr<-f/sum(f)
Fra<-cumsum(fr)

dist1<-cbind(f, F, fr, Fra)
dist1

Total<-c(sum(f), NA, sum(fr), NA)

dist1<-rbind(dist1, Total)
dist1

###########Construção da Tabela de Distribuição de Freqüências###############


h<-hist(dados$IDADE)

names(h)

br<-h$breaks
br

k<-length(br)-1
k

f <-h$counts
f

n <- sum(f)
n

PM<-h$mids
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



####Cálculo da Média####

x.bar<-weighted.mean(PM, f)
x.bar

#####Cálculo da Moda####

for(j in 1:k){
   if(j==which(f==max(f))){
        d1<-f[j]-f[j-1]
        d2<-f[j]-f[j+1]
        Mo<-br[j]+(d1/(d1+d2))*h}}
Mo
dist

#####Cálculo da Mediana####

fac<-cumsum(f)
fac

PMd<-n/2
PMd

for (j in 1:k){
   if( j == which(fac==min(fac[which(fac>=PMd)]))){
        Md<-br[j]+((PMd-max(fac[which(fac<PMd)]))/f[j])*h}}

Md
dist

####Comparando valores####

x.bar
Md
Mo


#######Cálculo da Variância#####

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

####Cálculo Desvio-padrão####

DP = sqrt(Var)
DP

######Cálculo do Coeficiente de Variação####

CV = (DP/x.bar)*100
CV

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

########Cálculo de Assimetria e Curtose######

As = (Q3 - 2*Md + Q1)/(Q3 - Q1)
As

k = (Q3 - Q1)/(2*(P90 - P10))
k

############Estatistica Descritiva de Dados Sem Freqüência########

install.packages("pastecs")
library(pastecs)

x<-sample(1:30, 10)
x

stat.desc(x) 


############

par(las=1)
h.id<-hist(IDADE, breaks=br, axes=F, col="blue", main="Histograma com Polígono de Freqüências", xlab="Intervalos", ylab="Freqüências")
axis(1, at=br, pos=0)
axis(2, at=seq(0, max(h$counts), by=1), pos=min(br))

c<-c(0, h$counts, 0)
c
x.m<-c(min(br), h$mids, max(br))
x.m
lines(x.m, c, lwd=1, lty=2)

f<-c(0, h$counts)
f

fac<-cumsum(f)
fac

plot(br, fac, type="l", lty=2, main="Freqüências Acumuladas", xlab="Intervalos", ylab="Freqüencias")
points(br, fac, pch=16)




###########Cálculos de Média e outros###########333

mean(IDADE)

summary(IDADE)

var(IDADE)
sd(IDADE)

cv<-sd(IDADE)/mean(IDADE)
cv

quantile(IDADE, probs=0.25)

quantile(IDADE,probs=seq(0.1,0.9,0.1))

summary(IDADE[SEXO=="MASCULINO"])

summary(IDADE[SEXO=="FEMININO"])

tapply(IDADE,SEXO,summary)

tapply(IDADE,SEXO,sd)

stripchart(IDADE~SEXO,method="stack",xlab="Idade por Sexo")

boxplot(IDADE~SEXO , ylab = "Idade",main = "Boxplot de Idade por Sexo")

par(mfrow=c(2,1))

hist(IDADE[SEXO=="MASCULINO"],main="Histograma de Idade por Sexo: Masculino", xlab="Intervalos",ylab="Frequência")
hist(IDADE[SEXO=="FEMININO"],main="Histograma de Idade por Sexo: Feminino", xlab="Intervalos",ylab="Frequência")

br<-h$breaks

hist(IDADE[SEXO=="MASCULINO"],breaks=br, main="Histograma de Idade por Sexo: Masculino", xlab="Intervalos",ylab="Frequência")
hist(IDADE[SEXO=="FEMININO"],breaks=br, main="Histograma de Idade por Sexo: Feminino", xlab="Intervalos",ylab="Frequência")

head(dados, 5)

plot(IDADE, ALTURA, pch=16, main="Gráfico de Dispersão entre Idade e Altura")

mod<-lm(ALTURA~IDADE)
summary(mod)

plot(IDADE, ALTURA, pch=16, main="Gráfico de Dispersão entre Idade e Altura")
abline(lm(ALTURA~IDADE))



install.packages("Rcmdr")
library(Rcmdr)
Rcmdr()






