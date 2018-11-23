#矩阵创建
zero=matrix(0,nrow=3,ncol=3)
diag=diag(rep(1,4))
diag(1:4)
x=matrix(1:4,2)
x[2]
x1=matrix(1:6,2,byrow=T)
x1[2]

#基本操作
dim(x1)
nrow(x1)
ncol(x1)
colnames(x1)=paste0('x_',1:3) #给列名赋值
rownames(x1)=1:2
x1
colnames(x1)
matrix(1:4,2,dimnames=list(1:2,paste0('x_',1:2))) #dimnames 需赋值list 第一个值是行名 第二个列

rbind(matrix(1:9,3),diag(11:13)) #按行合并
cbind(matrix(1:9,3),diag(11:13)) #按列合并

#数学操作
A=matrix(1:9,3)
B=diag(11:13)
A+B
A-B
A*B
A%*%B
A%*%A
t(A) #转置
crossprod(A,B) #A的转置与B的乘法
t(A)%*%B
tcrossprod(A,B) #A与B的转置的乘法
A%*%t(B)
solve(B) #求逆
eigen(A) #求特征值与特征向量
A%*%c$vectors
c$vectors%*%diag(c$values)

svd(A) #奇异值分解 

install.packages('rARPACK')
library(rARPACK)
T=matrix(1:1000000,1000)
system.time(svd(T))
system.time(svds(T,5))
system.time(eigen(T))
system.time(eigs(T,5))

#稀疏矩阵
c=c(1:3,rep(0,5),6:9)
m1=matrix(c,3)
library(Matrix)
m2=Matrix(c,3,4,sparse = TRUE)
class(m2)
m2
m3=Matrix(c,3,4,sparse = FALSE)
class(m3)
m3
m4=spMatrix(10,20,i=c(1,3:8),j=c(2,9,6:10),x=seq(7,49,7)) #或x=7*(1:7)
m4
summary(m4)
summary(m2)
summary(m3)
#比较存储大小与生成时间
n=100
m1=matrix(0,n,n)
m2=Matrix(0,n,n) #0超过一半，自动生成稀疏矩阵
object.size(matrix(0,n,n))
object.size(Matrix(0,n,n))
system.time(matrix(0,n,n))
system.time(Matrix(0,n,n))

n=10000
m1=matrix(0,n,n)
m2=Matrix(0,n,n) #0超过一半，自动生成稀疏矩阵
object.size(matrix(0,n,n))
object.size(Matrix(0,n,n))
system.time(matrix(0,n,n))
system.time(Matrix(0,n,n))

n=1000
dat=sample(c(0,1),n^2,replace = TRUE,prob=c(0.9,0.1))
m1=matrix(dat,n,n)
m2=Matrix(dat,n,n)
system.time(m1%*%t(m1))
system.time(m2%*%t(m2))
system.time(solve(m1))
system.time(solve(m2))
