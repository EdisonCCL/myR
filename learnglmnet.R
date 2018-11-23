install.packages('glmnet')
library(glmnet)
set.seed(1010)
n=1000;p=100
nzc=trunc(p/10)
x=matrix(rnorm(n*p),n,p)
beta=rnorm(nzc)
fx= x[,seq(nzc)] %*% beta
eps=rnorm(n)*5
y=drop(fx+eps)
px=exp(fx)
px=px/(1+px)
ly=rbinom(n=length(px),prob=px,size=1)
set.seed(1011)
cvob1=cv.glmnet(x,y)
plot(cvob1)
coef(cvob1)


par(mfrow=c(1,1),mar=c(4.5,4.5,4,3))
cvob2=cv.glmnet(x,ly,family="binomial")
plot(cvob2)
cvob2$lambda.min



n <- 100
beta <- c(1, 2, 3,-1.5,-2,-1,rep(0,4) )/5
x <- matrix(rnorm(10*n), nrow = n)
y <- x%*%beta + rnorm(n)
fit1=glmnet(x,y)
print(fit1)
plot(fit1)



n <- 200
beta <- c(1, 2, 3,-1.5,-2,-1,rep(0,4) )/5
x <- matrix(rnorm(10*n), nrow = n)
px <- exp(x%*%beta)
px <- px/(1+px)
y <- as.numeric(px<runif(n))

fit1=glmnet(x,y,family="binomial")
print(fit1)
plot(fit1)