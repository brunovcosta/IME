###############Intervalos de Confiança###############

####Para a média com dp conhecido##############

data<- c(84, 93, 100, 86, 82, 86, 88, 94, 89, 94, 93, 83, 95, 86, 94, 87, 
91, 96, 89, 79, 99, 98, 81, 80, 88, 100, 90, 100, 81, 98, 87, 95, 94)

x.min<-min(data)
x.min
x.max<-max(data)
x.max
AT<-x.max - x.min
AT
k<-ceiling(1+3.322*log(length(data), 10))
k

h.x<-AT/k
h.x
h.x<-round(h.x, 2)
h.x

AT < k*h.x

k<-round(1+3.322*log(length(data), 10), 0)
k

h.x<-AT/k
h.x
h.x<-ceiling(h.x)
h.x

AT < k*h.x

#calculando os limites dos intervalos
ini<-x.min-h.x
x.br<-0
for (i in 1:(k+1)){
   x.br[i]<-ini
   ini<-ini+h.x
   }
x.br

x.br<-c(75, 80, 85, 90, 95, 100, 105)

h<-hist(data, breaks=x.br, right=FALSE, axes=T, col="red", main="Histograma das Notas", xlab="Notas", ylab="Freqüências", ylim=c(0, 10))

h$breaks
h$counts

install.packages("fdth")
require(fdth)

x.dist=fdt(data, start=75, end=105, h=5 )
x.dist
str(x.dist)
x.dist$table[1]

PM<-h$mids
PM

x.dist<-cbind(x.dist$table[1], PM,x.dist$table[2], x.dist$table[3], x.dist$table[4], x.dist$table[5], x.dist$table[6]) 
x.dist

x.dist<-data.frame(x.dist)

mydoc = docx()
mydoc = addFlexTable( mydoc, FlexTable(print(x.dist)) )
writeDoc( mydoc, file = "x_dist.docx")

f<-h$counts
f

prod<-sum(PM*f)
prod
prod/n

x.bar<-weighted.mean(PM, f)
x.bar

n<-length(data)
n
sd(data)
dp.p<-7

se = dp.p/sqrt(n)
se

IC.média<-x.bar + c(-qnorm(.975)*se,qnorm(.975)*se) 
IC.média

install.packages("BSDA")
library(BSDA)

z.test(data, sigma.x=7)

z.test(data, sigma.x=7)$conf.int

############para a média com dp desconhecido###############################

x<-c(341, 345, 338, 339, 340, 343, 341, 343, 341, 328, 343, 347, 337, 348, 339)
n<-length(x)
n
sum(x)
sum(x)/n
x.bar<-mean(x)
x.bar

desvio<-x - x.bar
desvio^2
sqrt(sum(desvio^2)/(n-1))

dp<-sd(x)
dp

se = dp/sqrt(n)
se

qt(.975, n-1)

IC.média<-x.bar + c(-qt(.975, n-1)*se,qt(.975, n-1)*se) 
IC.média

t.test(x, conf.level = 0.95)$conf.int

############para variância################################

var.x<-var(x)
var.x

qui.i<-qchisq(0.025, n-1)
qui.i

qui.s<-qchisq(0.975, n-1)
qui.s

IC.Var<-c(var.x*(n-1)/qui.s, var.x*(n-1)/qui.i)
IC.Var

############para o desvio-padrão####################

IC.dp<-c(sqrt(var.x*(n-1)/qui.s), sqrt(var.x*(n-1)/qui.i))
IC.dp



###########para proporção##################################

x<-c(341, 345, 338, 339, 340, 343, 341, 343, 341, 328, 343, 347, 337, 348, 339)
n<-length(x)
n

sort(x)

p.x<-subset(x, x<340)
p.x
n.p.x<-length(p.x)
n.p.x

p<-n.p.x/n
p

for(i in 1:n){
 if(x[i]<340){x[i]<-1}else{x[i]<-0}
 }

x
p<-mean(x)
p

conf.level=0.95
z <- qnorm((1+conf.level)/2)
z
# intervalo otimista
LI.p<-p-z*sqrt((p)*(1-p)/n)
LS.p<-p+z*sqrt((p)*(1-p)/n)

IC.p<-c(p-z*sqrt((p)*(1-p)/n), p+z*sqrt((p)*(1-p)/n))
IC.p

# Uma função para calcular intervalo de confiança para proporção

ic.proporcao <-function(x,conf.level=0.95){

# tamanho de amostra
n <- length(x)

# quantil da normal padrão
z <- qnorm((1+conf.level)/2)

# estimador pontual da proporção
pchapeu<-mean(x)

# intervalo conservador 

LI.c<-pchapeu-z*sqrt(0.25/n)
LS.c<-pchapeu+z*sqrt(0.25/n)

# intervalo otimista
LI.o<-pchapeu-z*sqrt((pchapeu)*(1-pchapeu)/n)
LS.o<-pchapeu+z*sqrt((pchapeu)*(1-pchapeu)/n)

return(lista=list(pchapeu=pchapeu, otimista=c(LI.c,LS.c),conservador=c(LI.o,LS.o)))

}

ic.proporção(x)

# Leitura de dados sobre hipertensao
d<-read.csv2('http://www.professores.uff.br/joel/dados/hipertensao.csv')
d
d$tabag

# eliminando valores inconsistentes
d$tabag[which(d$tabag>1)]<-NA
d$tabag
# eliminando linhas com valores faltantes(NA)
d<-na.omit(d)
d$tabag
# estimando a proporção de tabagistas
ic.proporcao(d$tabag)
d$tabag
# estimando a proporção de pessoas com doenças cardiovasculares
ic.proporcao(d$dcv)

##############################################
# Intervalos de Confiança supondo a populacao d
###############################################

# Parametro na populacao
p<- mean(d$dcv)
p

# Intervalo de 95% de confianca para uma amostra de tamanho n=50
# Tamanho da populacao
N<-length(d$dcv)
N

# Objeto para armazenar os resultados 

Resultado<-NULL

for ( i in 1:1000){
# amostra de tamanho n=50
amostra<-d$dcv[sample(N,50)]

print(ic.proporcao(amostra)$otimista)

LI<-ic.proporcao(amostra)$otimista[1]
LS<-ic.proporcao(amostra)$otimista[2]

if (p>LS | p<LI){print('ERRO');Resultado[i]<-'ERRO'}
if (p<LS & p>LI){print('ACERTO');Resultado[i]<-'ACERTO'}
}

table(Resultado)



