install.packages('lars')
library(lars)
n <- 100
beta <- c(1, 2, 3,-1.5,-2,-1,rep(0,4) )/5
x <- matrix(rnorm(10*n), nrow = n)
y <- x%*%beta + rnorm(n)

object=lars(x,y,type='lar')
object1=cv.lars(x,y,type='lar',mode='step')

object1$index[which.min(object1$cv)]
object$beta[9,]
predict(object,newx=x[1:5,],s=9,type='fit',mode='step') #给x值 出预测值
y[1:5] #真实值

object2=cv.lars(x,y,type='lar',mode='fraction',index=seq(from=0,to=1,length=100))
object2$index[which.min(object2$cv)]
predict(object,s=0.8484848,type='coefficients',mode='fraction') #得到系数
predict(object,s=0.8484848,newx=x[1:5,],type='fit',mode='fraction')

