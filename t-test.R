x <- c(20.99,20.41,20.10,20.00,20.91,22.60,20.99,20.42,20.90,22.99,23.12,20.89)
t.test(x, alternative = "greater", mu = 20.7 ,conf.level = 0.9)
summary(x)
var(x)#样本方差
t=1.5665;n=11
1-pt(t,n) #p值

#配对样本t检验
x1 <- c(2.41,2.90,2.75,2.23,3.67,4.49,5.16,5.45,2.06,1.64,1.06,0.77)
y1 <- c(2.80,3.04,1.88,3.43,3.81,4.00,4.44,5.41,1.24,1.83,1.45,0.92)
t.test(x1,y1,paired = T)

require(graphics)
str(sleep)
plot(extra ~ group, data = sleep)
#结论相反
t.test(extra ~ group, data = sleep)
t.test(extra ~ group, data = sleep,paired=T)
t.test(extra ~ group, data = sleep,var.equal=T)


#方差齐性检验
high <- c(134, 146, 104, 119, 124, 161, 107, 83, 113, 129, 97, 123)
low <- c(70, 118, 101, 85, 107, 132, 94)

x3 <- c(134, 146, 104, 119, 124, 161, 107, 83, 113, 129, 97, 123,70, 118, 101, 85, 107, 132, 94)
a <- factor(c(rep(1,12),rep(2,7)))
bartlett.test(x3~a)
var.test(x3~a)
install.packages('car')
library(car)
leveneTest(x3~a)
