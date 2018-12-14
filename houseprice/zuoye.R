house=read.csv('C:\\Users\\ccl\\Downloads\\housesalesprediction\\kc_house_data.csv')
install.packages('ggplot2')
install.packages('dplyr')
library(ggplot2)
library(dplyr)
house_df=tbl_df(house)
class(house_df)
str(house_df)
#1.根据经纬度画个房价热点图 
ggplot(house, aes(x=lat, y=long, size=price_avg)) +
  geom_point(shape=21, colour="black",fill="cornsilk") +
  scale_size_area(max_size=15)
install.packages('maps')
install.packages('mapproj')
library(maps)
library(mapproj)
states_map<-map_data("state")
ggplot(states_map, aes(x=long, y=lat, group=group)) +
  geom_polygon(fill="white", colour="black")
#2.画个相关系数图 算了相关系数
#3.房价应该化成均价 没用
#4.sqft_above+sqft_basement=sqft_living
#对其他变量进行聚类，把房价分成段
install.packages('GGally')
library(GGally)
ggpairs(house[,c(21,22)])
cor(house[,c(4:14,3)])
house$price_avg=round(house$price/house$sqft_living,1)
fit1=glm(log(price)~bedrooms+bathrooms+floors+grade+sqft_above+sqft_basement-1,house,family = gaussian('identity'))    
fit2=glm(price~bedrooms+floors+grade+sqft_above+sqft_basement-1,house,family = gaussian('identity')) 
fit3=glm(price~bedrooms*floors+grade+sqft_above+sqft_basement-1,house,family = gaussian('identity')) 

summary(fit1)
AIC(fit2)

install.packages('boot')
library(boot)
cvfit1=cv.glm(house,fit1,K=5)    
cvfit1$delta
cvfit2=cv.glm(house,fit2,K=5)    
cvfit2$delta
cvfit3=cv.glm(house,fit3,K=5)    
cvfit3$delta

install.packages('useful')
library(useful)
install.packages('glmnet')
library(glmnet)
house_x=build.x(log(price)~bedrooms+bathrooms+sqft_living+sqft_lot+floors+waterfront+view+grade+sqft_above
                +sqft_basement+yr_built+yr_renovated+zipcode+lat+long+sqft_living15+sqft_lot15-1,house)
house_y=build.y(log(price)~bedrooms+bathrooms+sqft_living+sqft_lot+floors+waterfront+view+grade+sqft_above
                +sqft_basement+yr_built+yr_renovated+zipcode+lat+long+sqft_living15+sqft_lot15-1,house)
fit4=glmnet(x=house_x,y=house_y,alpha = 0)
cvfit4=cv.glmnet(x=house_x,y=house_y,nfolds=5,alpha=0)
which.min(cvfit4$lambda)
cvfit4$cvm[4]
coef(cvfit4,s=cvfit4$lambda.min)

coef(fit4,s=cvfit4$lambda.1se)
fit5=glm(log(price)~bedrooms+bathrooms+sqft_living+waterfront+view+grade+
           sqft_above+yr_built+yr_renovated+zipcode+lat+long+sqft_living15,house,family = gaussian('identity'))
cvfit5=cv.glm(house,fit5,K=5)
cvfit5$delta
head(fit5$fitted.values)

fit6=glmnet(x=house_x,y=house_y,alpha = 1)
cvfit6=cv.glmnet(x=house_x,y=house_y,nfolds=10,alpha=1)
coef(cvfit6,s=cvfit6$lambda.min)
plot(cvfit6)
which.min(cvfit6$cvm)
cvfit6$cvm[68]

fit7=glm(price~bedrooms+bathrooms+sqft_living+sqft_lot+floors+waterfront
         +view+grade+sqft_above+yr_built+yr_renovated+zipcode+lat+long+sqft_living15+sqft_lot15,house,family = gaussian('identity'))
cvfit7=cv.glm(house,fit7,K=5)
cvfit7$delta
  
fit8=glm(log(price)~bedrooms+bathrooms+sqft_living+sqft_lot+floors+waterfront+view+grade+sqft_above
         +sqft_basement+yr_built+yr_renovated+zipcode+lat+long+sqft_living15+sqft_lot15,house,family = gaussian('identity'))
cvfit8=cv.glm(house,fit8,K=5)
cvfit8$delta




corH <- cor(df1)
corrplot(corH, type="full", method = "circle", main="Correlation")
print(round(corH, digits=2))
#Residual standard error: 149500 on 17204 degrees of freedom 与mse的关系 即cv方法评判准则
#用log以后残差是怎么算的

mod1 <- lm(log(price) ~ log(sqft_living) +grade + waterfront + view + condition +zipcode+bathrooms, data = train)
summary(mod1)

par(mfrow=c(3,3))
for(i in 2:19){
  plot(df1[,i], df1$price, main=names(df1[i]), ylab=names(df1$price), xlab="", col='steelblue')
}

par(mfrow=c(1,1))
for(i in c(2,3,6,7,8,9,10,15)){
  boxplot(df1[,1]~df1[,i], xlab='', main=names(df1[i]), col=c("blue","red"))
}

# converting to factors
df1$zipcode <- as.factor(df1$zipcode)
df1$grade <- as.factor(df1$grade)
df1$waterfront <- as.factor(df1$waterfront)
df1$floors <- as.factor(df1$floors)
df1$bedrooms <- as.factor(df1$bedrooms)

# Now Selecting 80% of data as sample from total 'n' rows of the data  
set.seed(100)
sample <- sample.int(n=nrow(df1), size = floor(0.80*nrow(df1)), replace = F)

# Splitting train and test data
train <- df1[sample, ]
test  <- df1[-sample, ]

# Creating linear model
mod <- lm(price ~ sqft_living + grade + waterfront + view + condition +zipcode+bathrooms+bedrooms, data = train)
summary(mod)
mod1 <- lm(price ~ sqft_living +grade + waterfront + view + condition +zipcode+bathrooms, data = train)
summary(mod1)
