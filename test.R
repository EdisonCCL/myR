x='name'
class(x)
is.character(x)
y=factor('name')
y
is.factor(y)
class(y)
x=1:10
y=10:1
z=data.frame(x,y)
z
dim(z)
str(z)
s=names(z)
s
class(s)
str(s)
class(x)
str(x)
mode(x)
mode(s)
z[2,]
z[,2]
z[1]
z[2]
z[,1]
class(z[2])
class(z[,2])
names(z)=c('ccl','zc')
z
a=list(1,2,3)
class(a)
a[1]
a
a[[1]]
b=a[[1]]
class(b)
b+1
a=matrix(1:9,nrow=3,byrow=T)
b=matrix(10:18,nrow=3)
rbind(a,b)
cbind(a,b)
c=matrix(a,byrow=T)
c
a%*%a
theUrl='http://www.jaredlander.com/data/Tomato%20First.csv'
tomato = read.csv(file = theUrl) 
head(tomato)
str(tomato)
library('igraph')
dat=c(1,2,2,3,2,4,1,4,5,5,3,6,1,7)
gd=graph(dat)
plot(gd)
gu<-graph(dat, directed=F)
plot(gu)
m<- madmen[1:nrow(madmen)%%2 == 1, ]
g<- graph.data.frame(m, directed=FALSE)
V(g)$name
plot(g, layout = layout.fruchterman.reingold,
      vertex.size = 4,
      vertex.label = V(g)$name,
      vertex.label.cex = 0.8,
      vertex.label.dist = 0.4,
      vertex.label.color = "black")

if (MyCheck == 1)
{ print('hello')}else
{print('goodbye')}
ifelse(MyCheck == 1,'hello','goodbye')
library(igraph)
data(madmen)
install.packages('ggplot2')
library(ggplot2)
data("diamonds")
str(diamonds)
diamonds$price
aggregate(cbind(price, carat)~cut, diamonds, mean)
aggregate(price ~ cut + color, diamonds, mean)
paste(c('Hello', 'Hey', 'Howby'), c('Jared', 'Bob', 'David'))
paste('Hello', c('Jared', 'Bob', 'David'), c('Goodbye', 'Seeya'))
