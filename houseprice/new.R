house_dat=read.csv('C:\\Users\\ccl\\Downloads\\housesalesprediction\\kc_house_data.csv')
install.packages('corrplot')
#install.packages('ggplot2')
library(corrplot)

house_dat[1:2]=NULL
house_dat1=house_dat[-19]
corH <- cor(house_dat)
corrplot(corH, type="full", method = "circle", main="Correlation")
print(round(corH, digits=2))

corrplot(corH, method = "color", outline = T, cl.pos = 'n', rect.col = "black",  tl.col = "indianred4", 
         addCoef.col = "black", number.digits = 2, number.cex = 0.60, tl.cex = 0.7, cl.cex = 1, 
         col = colorRampPalette(c("green4","white","red"))(10000))

par(mfrow=c(3,3))
for(i in 2:19){
  plot(house_dat[,i], house_dat$price, main=names(house_dat[i]), ylab=names(house_dat$price), xlab="", col='steelblue')
}

par(mfrow=c(1,1))
for(i in c(2,3,6,7,8,9,10,15)){
  boxplot(house_dat[,1]~house_dat[,i], xlab='', main=names(house_dat[i]), col=c("blue","red"))
}

floor(12.1)


#自变量与因变量标准化的影响？
#岭回归能否使误差变小？
#对奇异点进行筛选