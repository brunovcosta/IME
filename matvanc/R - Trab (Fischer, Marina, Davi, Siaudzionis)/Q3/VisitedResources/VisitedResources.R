######VisitedResources######

###########Construção da Tabela de Distribuição de Freqüências###############

h<-hist(data1$VisITedResources)

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

dist11<-cbind(Intervalos, PM, f)
dist11


fr<-f/n
fr

F<-cumsum(f)
F

Fra<-cumsum(fr)
Fra

dist11<-cbind(dist11, F, fr, Fra)
dist11

Total<-c("Total", NA, sum(f), NA, sum(fr), NA)


dist11<-rbind(dist11, Total)
dist11

rownames(dist11)<-seq(1, k+1, 1)
dist11

dist11<-data.frame(dist11)
dist11

###################Histograma#################

hist(data1$VisITedResources, main="Histograma para variável VisitedResources", 
     xlab="Visited Resources", ylab="Freqüências", col="Blue")

###############Freqüências Acumuladas############
f2<-c(0, f)
f2

fac<-cumsum(f)
fac

plot(br, fac, type="l", lty=2, main="Freqüências Acumuladas", xlab="Intervalos", ylab="Freqüencias")
points(br, fac, pch=16)

####Cálculo da Média para dados da Tabela de Freqüências####

x.bar<-weighted.mean(PM, f)
x.bar

#####Cálculo da Moda####
j<-which(f==max(f))
if(j>1){
  d1<-f[j]-f[j-1]
  d2<-f[j]-f[j+1]
  Mo<-br[j]+(d1/(d1+d2))*h}

if(j==1){
  Mo<-PM[j]}

Mo
dist11

#####Cálculo da Mediana####

fac2<-cumsum(f)
fac2

PMd<-n/2
PMd

for (j in 1:k){
  if( j == which(fac2==min(fac2[which(fac2>=PMd)]))){
    Md<-br[j]+((PMd-max(fac2[which(fac2<PMd)]))/f[j])*h}}

Md
dist11

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
fac3<-cumsum(f)
fac3
k
h

for (j in 1:length(fac3)){
  if( j == which(fac3==min(fac3[which(fac3>=PQ1)]))){
    Q1<-br[j]+((PQ1-max(fac3[which(fac3<PQ1)]))/f[j])*h}}

Q1



PQ3<-0.75*sum(f)
PQ3

for (j in 1:k){
  if( j == which(fac3==min(fac3[which(fac3>=PQ3)]))){
    Q3<-br[j]+((PQ3-max(fac3[which(fac3<PQ3)]))/f[j])*h}}

Q3

###################Cálculo de P10 e P90##############


PP10<-(0.10*sum(f))
PP10


for (j in 1:k){
  if( j == which(fac3==min(fac3[which(fac3>=PP10)]))){
    fant=max(fac3[which(fac3<PP10)])
    if(fant==-Inf){fant=0}
    P10<-br[j]+((PP10-fant)/f[j])*h}}

P10


PP90<-(0.90*sum(f))
PP90

for (j in 1:k){
  if( j == which(fac3==min(fac3[which(fac3>=PP90)]))){
    fant2=max(fac3[which(fac3<PP90)])
    if(fant2==-Inf){fant2=0}
    P90<-br[j]+((PP90-fant2)/f[j])*h}}

P90

########Cálculo de Assimetria#####

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

#######Cálculo de Curtose######

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

