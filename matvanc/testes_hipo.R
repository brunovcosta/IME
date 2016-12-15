#################################################
###### Teste de Hipóteses########################
#################################################

#################################################
########Gráficos da Região de Rejeição###########
########Unilateral à Direita#####################
#################################################

 cord.x <- c(-3,seq(-3,-2,0.01),-2) 
 cord.y <- c(0,dnorm(seq(-3,-2,0.01)),0) 
 curve(dnorm(x,0,1),xlim=c(-3,3),main='Standard Normal') 
 polygon(cord.x,cord.y,col='skyblue')
 
 par(mfrow=c(1,1))
 
 stdDev <- 1;
 x <- seq(-5,5,by=0.01)
 y <- dnorm(x,sd=stdDev)
 right <- qnorm(0.95,sd=stdDev)
 right
 left <- -right
 plot(x,y,type="l",xaxt="n",ylab="", main="",
       xlab="",
       axes=FALSE,ylim=c(0,max(y)*1.05),xlim=c(min(x),max(x)),
       frame.plot=FALSE)

 axis(1,at=c(-5, right,0,5),
       pos = c(0,0),
       labels=c(expression(' '), expression(z[cr]),expression(0),expression(' ')))
title(main="Teste de Hipótese\nUnilateral à direita")

 xReject <- seq(right,5,by=0.01)
 #xReject
 yReject <- dnorm(xReject,sd=stdDev)
 #yReject
 polygon(c(xReject,xReject[length(xReject)],xReject[1]),
        c(yReject,0, 0), col='red')

text(0, 0.1, expression(paste("1 - ", alpha)))
text(0, 0.05, "Não rejeitar H0")
text(-4, 0.3, expression(paste("H1:", theta, " < ", theta[0])))
arrows(2, 0.02, 3, 0.1, length = 0.15, angle = 15)
text(3.2, 0.1, expression(alpha))
text(3.5, 0.05, "Rejeitar H0")

#################################################
########Gráficos da Região de Rejeição###########
########Bilateral################################
#################################################

cord.x <- c(-3,seq(-3,-2,0.01),-2) 
 cord.y <- c(0,dnorm(seq(-3,-2,0.01)),0) 
 curve(dnorm(x,0,1),xlim=c(-3,3),main='Standard Normal') 
 polygon(cord.x,cord.y,col='skyblue')
 
 par(mfrow=c(1,1))
 
 stdDev <- 1;
 x <- seq(-5,5,by=0.01)
 y <- dnorm(x,sd=stdDev)
 right <- qnorm(0.95,sd=stdDev)
 right
 left <- -right
 plot(x,y,type="l",xaxt="n",ylab="", main="",
       xlab="",
       axes=FALSE,ylim=c(0,max(y)*1.05),xlim=c(min(x),max(x)),
       frame.plot=FALSE)

axis(1,at=c(-5,left, right,0,5),
       pos = c(0,0),
       labels=c(expression(' '),expression(-z[cr]), expression(z[cr]),expression(0),expression(' ')))
title(main="Teste de Hipótese\nBilateral")

text(0, 0.1, expression(paste("1 - ", alpha)))
text(0, 0.05, "Não rejeitar H0")
text(-4, 0.3, expression(paste("H1:", theta !=  theta[0])))
arrows(2, 0.02, 3, 0.1, length = 0.15, angle = 15)
text(3.2, 0.1, expression(frac(alpha, 2)))
text(-3.2, 0.1, expression(frac(alpha, 2)))
arrows(-2, 0.02, -3, 0.1, length = 0.15, angle = 15)

text(3.5, 0.05, "Rejeitar H0")
text(-3.5, 0.05, "Rejeitar H0")

 xReject <- seq(right,5,by=0.01)
 #xReject
 yReject <- dnorm(xReject,sd=stdDev)
 #yReject
 polygon(c(xReject,xReject[length(xReject)],xReject[1]),
        c(yReject,0, 0), col='red')
 x2Reject <- seq(-5, left, by=0.01)
 y2Reject <- dnorm(x2Reject,sd=stdDev)
 polygon(c(x2Reject,x2Reject[length(x2Reject)],x2Reject[1]),
        c(y2Reject,0, 0), col='red')

#################################################
########Gráficos da Região de Rejeição###########
########Unilaterla à Esquerda####################
#################################################

cord.x <- c(-3,seq(-3,-2,0.01),-2) 
 cord.y <- c(0,dnorm(seq(-3,-2,0.01)),0) 
 curve(dnorm(x,0,1),xlim=c(-3,3),main='Standard Normal') 
 polygon(cord.x,cord.y,col='skyblue')
 
 par(mfrow=c(1,1))
 
 stdDev <- 1;
 x <- seq(-5,5,by=0.01)
 y <- dnorm(x,sd=stdDev)
 right <- qnorm(0.95,sd=stdDev)
 right
 left <- -right
 plot(x,y,type="l",xaxt="n",ylab="", main="",
       xlab="",
       axes=FALSE,ylim=c(0,max(y)*1.05),xlim=c(min(x),max(x)),
       frame.plot=FALSE)


axis(1,at=c(-5,left,0,5),
       pos = c(0,0),
       labels=c(expression(' '),expression(-z[cr]),expression(0),expression(' ')))
title(main="Teste de Hipótese\nUnilateral à esquerda")

text(0, 0.1, expression(paste("1 - ", alpha)))
text(0, 0.05, "Não rejeitar H0")
text(-4, 0.3, expression(paste("H1:", theta, " > ", theta[0])))
arrows(-2, 0.02, -3, 0.1, length = 0.15, angle = 15)
text(-3.2, 0.1, expression(alpha))
text(-3.5, 0.05, "Rejeitar H0")

 x2Reject <- seq(-5, left, by=0.01)
 y2Reject <- dnorm(x2Reject,sd=stdDev)
 polygon(c(x2Reject,x2Reject[length(x2Reject)],x2Reject[1]),
        c(y2Reject,0, 0), col='red')


##########################################################
#####Teste para Média com var populacional conhecida######
##########################################################

####Sem os valores da Amostra (n >= 30)

xbar = 14.6            # sample mean 
xbar
mu = 15.4             # hypothesized value(H0)
mu
sigma = 2.5            # population standard deviation 
n = 35                 # sample size 
z = (xbar - mu)/(sigma/sqrt(n))
z                      # test statistic

alpha = .05 

z.half.alpha = qnorm(1-alpha/2) # valor crítico bilateral
z.half.alpha                       
c(-z.half.alpha, z.half.alpha) # intervalo de comparação
res<-0
if(z<(-z.half.alpha) | z>z.half.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

z.alpha = qnorm(1 - alpha)  # valor crítico unilaterla à direita
z.alpha
res<-0
if(z>z.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res  #resultado do teste

z.alpha = qnorm(1 - alpha)  # valor crítico unilaterla à esquerda
-z.alpha
res<-0
if(z<(-z.alpha)){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

####Com valores da amostra (n >= 30)

z.test = function(amos, mu0, var0){
   zeta = (mean(amos) - mu0) / (sqrt(var0 / length(amos)))
   return(zeta)
}

amos<-c(88, 55, 88, 81, 65, 95, 79, 88, 88, 78, 95, 78, 55, 79, 95,
 79, 57, 55, 81, 65, 48, 57, 57, 79, 48, 65, 66, 65, 65, 48) #amostra

mu0 = 75  #média populacional conhecida(H0)
var0 = 18 #variância populacional conhecida

z = z.test(amos, mu0, var0) # test statistic
z

alpha = .05 

z.half.alpha = qnorm(1-alpha/2) # valor crítico bilateral
z.half.alpha                       
c(-z.half.alpha, z.half.alpha) # intervalo de comparação
res<-0
if(z<(-z.half.alpha) | z>z.half.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

z.alpha = qnorm(1 - alpha)  # valor crítico unilaterla à direita
z.alpha
res<-0
if(z>z.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res  #resultado do teste

z.alpha = qnorm(1 - alpha)  # valor crítico unilaterla à esquerda
-z.alpha
res<-0
if(z<(-z.alpha)){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

#############################################################
#####Teste para Média com var populacional desconhecida######
#############################################################

####Sem os valores da Amostra (n < 30)

xbar = 14.6            # sample mean 
xbar
mu = 15.4             # hypothesized value(H0)
mu
s = 2.5            # sample standard deviation  
n = 20                 # sample size 
t = (xbar - mu)/(sigma/sqrt(n))
t                      # test statistic

alpha = .05 

t.half.alpha = qt(1 - alpha/2, df=n - 1)  # valor crítico bilateral
t.half.alpha                       
c(-t.half.alpha, t.half.alpha) # intervalo de comparação
res<-0
if(t<(-t.half.alpha) | t>t.half.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

t.alpha = qt(1 - alpha, df=n - 1)   # valor crítico unilaterla à direita
t.alpha
res<-0
if(t>t.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res  #resultado do teste

t.alpha = qt(1 - alpha, df=n - 1) # valor crítico unilaterla à esquerda
-t.alpha
res<-0
if(t<(-t.alpha)){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

####Com valores da amostra (n < 30)

amos = c(65, 78, 88, 55, 48, 95, 66, 57, 79, 81)
mu ## valor da média a ser testado (média populacional - H0)

t = t.test (amos, mu=75) #teste bilaterial
t

t$statistic ## valor t calculado
t$parameter ## graus de liberdade
t$estimate  ## média da amostra
t$p.value   ## p-valor para t calculado

alpha = .05 

t.half.alpha = qt(1 - alpha/2, df=n - 1)  # valor crítico bilateral
t.half.alpha                       
c(-t.half.alpha, t.half.alpha) # intervalo de comparação
res<-0
if(t$statistic<(-t.half.alpha) | t$statistic>t.half.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

t = t.test (amos, mu=75, alternative=c("greater")) #teste unilaterla à direita
t

t$statistic ## valor t calculado
t$parameter ## graus de liberdade
t$estimate  ## média da amostra
t$p.value   ## p-valor para t calculado

alpha = .05 

t.alpha = qt(1 - alpha, df=n - 1)   # valor crítico unilaterla à direita
t.alpha
res<-0
if(t$statistic>t.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res  #resultado do teste

t = t.test (amos, mu=75, alternative=c("less")) #teste unilaterla à esquerda
t

t$statistic ## valor t calculado
t$parameter ## graus de liberdade
t$estimate  ## média da amostra
t$p.value   ## p-valor para t calculado

alpha = .05 

t.alpha = qt(1 - alpha, df=n - 1) # valor crítico unilaterla à esquerda
-t.alpha
res<-0
if(t$statistic<(-t.alpha)){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

#############################################################
#####Teste para Média com var populacional desconhecida######
################Mas valor de n>= 30##########################
#############################################################

####Sem os valores da Amostra (n >= 30)

xbar = 14.6            # sample mean 
xbar
mu = 15.4              # hypothesized value(H0)
mu
s = 2.5                # sample standard deviation
n = 35                 # sample size 
z = (xbar - mu)/(s/sqrt(n))
z                      # test statistic

alpha = .05 

z.half.alpha = qnorm(1-alpha/2) # valor crítico bilateral
z.half.alpha                       
c(-z.half.alpha, z.half.alpha) # intervalo de comparação
res<-0
if(z<(-z.half.alpha) | z>z.half.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

z.alpha = qnorm(1 - alpha)  # valor crítico unilaterla à direita
z.alpha
res<-0
if(z>z.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res  #resultado do teste

z.alpha = qnorm(1 - alpha)  # valor crítico unilaterla à esquerda
-z.alpha
res<-0
if(z<(-z.alpha)){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

####Com valores da amostra (n >= 30)

z.test = function(amos, mu0){
   zeta = (mean(amos) - mu0) / (sqrt(var(amos) / length(amos)))
   return(zeta)
}

amos<-c(88, 55, 88, 81, 65, 95, 79, 88, 88, 78, 95, 78, 55, 79, 95,
 79, 57, 55, 81, 65, 48, 57, 57, 79, 48, 65, 66, 65, 65, 48) #amostra

mu0 = 75  #média populacional conhecida(H0)

z = z.test(amos, mu0) # test statistic
z

alpha = .05 

z.half.alpha = qnorm(1-alpha/2) # valor crítico bilateral
z.half.alpha                       
c(-z.half.alpha, z.half.alpha) # intervalo de comparação
res<-0
if(z<(-z.half.alpha) | z>z.half.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

z.alpha = qnorm(1 - alpha)  # valor crítico unilaterla à direita
z.alpha
res<-0
if(z>z.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res  #resultado do teste

z.alpha = qnorm(1 - alpha)  # valor crítico unilaterla à esquerda
-z.alpha
res<-0
if(z<(-z.alpha)){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

#############################################################
#################Teste para Proporção########################
#############################################################

####Sem os valores da Amostra

pbar = 12/20           # sample proportion 
p0 = 0.5                # hypothesized value 
n = 20                 # sample size 
z = (pbar - p0)/sqrt(p0*(1 - p0)/n) 
z                      # test statistic 

alpha = .05 

z.half.alpha = qnorm(1-alpha/2) # valor crítico bilateral
z.half.alpha                       
c(-z.half.alpha, z.half.alpha) # intervalo de comparação
res<-0
if(z<(-z.half.alpha) | z>z.half.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

z.alpha = qnorm(1 - alpha)  # valor crítico unilaterla à direita
z.alpha
res<-0
if(z>z.alpha){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res  #resultado do teste

z.alpha = qnorm(1 - alpha)  # valor crítico unilaterla à esquerda
-z.alpha
res<-0
if(z<(-z.alpha)){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

####Com valores da amostra

heads <- rbinom(1, size = 100, prob = .5)
heads

z<-prop.test(heads, 100)          # continuity correction TRUE by default
z<-prop.test(heads, 100, correct = FALSE)
names(z)

z$statistic ## valor z calculado
z$parameter ## graus de liberdade
z$estimate  ## média da amostra
z$p.value   ## p-valor para z calculado

X<-sample(1:20, 10) #X é uma amostra de 10 números quaisquer entre 1 e 20
X
par<-0
for(i in 1:length(X)){
        if((X[i]%%2==0)){par[i]<-1}else{par[i]<-0}}
par #separamos os pares na amostra X
n.total<-length(par)#quantidade de elementos na amostra
n.total

n.par<-sum(par)#quantidade de elementos pares na amostra
n.par
p<-n.par/n.total #probabilidade de números pares na amostra
p

z<-prop.test(n.par, n.total, correct = FALSE)
z
names(z)

z$statistic ## valor z calculado
z$parameter ## graus de liberdade
z$estimate  ## média da amostra
z$p.value   ## p-valor para z calculado

#############################################################
#################Teste para Variância########################
#############################################################

####Sem os valores da Amostra

sigma20=0.01           # true variance(populacional - hypothesized value)
s2=0.00003969           # sample variance 
n = 100                 # sample size 
X2 = (n - 1)*(s2/sigma20)
X2                     # test statistic 

alpha = .05 
df = n - 1
X2.lower = qchisq(alpha/2, df) # valor crítico bilateral 1
X2.upper = qchisq(1 - alpha/2, df) # valor crítico bilateral 2
                 
c(X2.lower, X2.upper) # intervalo de comparação
res<-0
if(X2<X2.lower | X2>X2.upper){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

X2.upper = qchisq(1 - alpha, df)  # valor crítico unilaterla à direita
X2.upper
res<-0
if(X2>X2.upper){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res  #resultado do teste

X2.lower = qchisq(alpha, df)  # valor crítico unilaterla à esquerda
X2.lower
res<-0
if(X2<X2.lower){res<-c("Rejeita")}else{res<-c("Não Rejeita")}
res #resultado do teste

####Com valores da amostra

rnorm(10, 10, 2)

amos<-c( 7.997426, 10.143208, 10.341558, 11.167829,  9.053713, 10.804689,
     11.117276, 13.079283,  5.874729,  7.341960)

## Create function to perform chi-square test.
var.interval = function(data,sigma0,alpha = 0.05) {
  df = length(data) - 1
  chi.lower = qchisq(alpha/2, df)
  chi.upper = qchisq(1 - alpha/2, df)
  v = var(data)
  test.chi = df*v/(sigma0^2)
  conf.level = 1-alpha

  print(paste("Standard deviation = ", round(sqrt(v),4)),quote=FALSE)
  print(paste("Test statistic = ", round(test.chi,4)),quote=FALSE)
  print(paste("Degrees of freedom = ", round(df,0)),quote=FALSE)
  print(" ",quote=FALSE)
  print("Two-tailed test critical values, alpha=0.05",quote=FALSE)
  print(paste("Lower = ", round(qchisq(alpha/2,df),4)),quote=FALSE)
  print(paste("Upper = ", round(qchisq(1-alpha/2,df),4)),quote=FALSE)
  print(" ",quote=FALSE)
  print("95% Confidence Interval for Standard Deviation",quote=FALSE)
  print(c(round(sqrt(df * v/chi.upper),4), 
         round(sqrt(df * v/chi.lower),4)),quote=FALSE)
}

## Perform chi-square test.
 var.interval(amos,2)

