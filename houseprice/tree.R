#用CV方法的预测精度来评价模型好坏
house_dat=read.csv('C:\\Users\\ccl\\Downloads\\housesalesprediction\\kc_house_data.csv')
house1=house_dat[,c(-1,-2,-18,-19)]
#决策树
install.packages('rpart.plot')
library(rpart.plot)
fit_tree1=rpart(price~.,house1)
rpart.plot(fit_tree1,type=4,extra=1,digits = 4)
summary(fit_tree1,type=8)
resfit_tree1=house1[,1]-predict(fit_tree1,house1)
SST=sum((house1[,1]-mean(house1[,1]))^2)
SSE=sum(resfit_tree1^2)
R2_1=1-SSE/SST
fit2=lm(price~.,house1)
SSEb=sum(fit2$residuals^2)
R2b=1-SSEb/SST
qqnorm(fit2$residuals)
qqline(fit2$residuals)
plot(fit2$residuals~fit2$fitted.values)
abline(h=0,lty=2)

house2=house1
house2$floors=as.factor((house2$floors))
house2$waterfront=as.factor(house2$waterfront)
house2$view=as.factor(house2$view)
house2$bathrooms=as.factor((house2$bathrooms))
house2$bedrooms=as.factor(house2$bedrooms)
house2$condition=as.factor(house2$condition)
house2$grade=as.factor(house2$grade)
fit_tree2=rpart(price~.,house2)
rpart.plot(fit_tree1,type=4,extra=1,digits = 4)
resfit_tree2=house2[,1]-predict(fit_tree2,house2)
SST2=sum((house2[,1]-mean(house2[,1]))^2)
SSE2=sum(resfit_tree2^2)
R2_2=1-SSE2/SST2 #结果一样，说明没必要化为因子

#bagging
install.packages('ipred')
library(ipred)
fit_bagging1=bagging(price~.,house1,coob=T)

#比较bagging、决策树、线性回归的准度
CV=function(n,Z=10,seed=888){
  z=rep(1:Z,ceiling(n/Z))[1:n]
  set.seed(seed)
  z=sample(z,n)
  mm=list()
  for (i in 1:Z) mm[[i]]=(1:n)[z==i]
  return(mm)
}
K=10
mm=CV(nrow(house1),K,1111)
gg=price~.
MSE=matrix(99,K,3)->NMSE
J=1
for(i in 1:K){m=mm[[i]];M=mean((house1[m,1]-mean(house1[m,1]))^2)
             a=bagging(gg,house1[-m,])
             MSE[i,J]=mean((house1[m,1]-predict(a,house1[m,]))^2)
             NMSE[i,J]=MSE[i,J]/M}
J=J+1
for(i in 1:K){m=mm[[i]];M=mean((house1[m,1]-mean(house1[m,1]))^2)
a=rpart(gg,house1[-m,])
MSE[i,J]=mean((house1[m,1]-predict(a,house1[m,]))^2)
NMSE[i,J]=MSE[i,J]/M}
J=J+1
for(i in 1:K){m=mm[[i]];M=mean((house1[m,1]-mean(house1[m,1]))^2)
a=lm(gg,house1[-m,])
MSE[i,J]=mean((house1[m,1]-predict(a,house1[m,]))^2)
NMSE[i,J]=MSE[i,J]/M}

#随机森林
install.packages('randomForest')
library(randomForest)
fit_rf1=randomForest(price~.,house1,mtry=7)#mtry根据tuneRF得出
partialPlot(fit_rf1,pred.data=house1,bathrooms)#部分依赖图
plot(fit_rf1)
tuneRF(house1[,-1],house1[,1],stepFactor = 1.5)#搜寻最优mtry

#神经网络
install.packages('nnet')
library(nnet)
fit_net1=nnet(price/max(price)~.,data=house1,maxit=1000,size=10,decay=0.1,trace=F)
SSE_net=sum((house1[,1]-fit_net1$fitted.values*max(house1$price))^2)
1-SSE_net/SST
