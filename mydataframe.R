#创建data.frame
col1=c('叶问3','美人鱼','女汉子真爱公式','西游记之孙悟空三打白骨精','澳门风云三','功夫熊猫3','北京遇上西雅图之不二情书','谁的青春不迷茫','谁在我上铺的兄弟')
col3=as.Date(c('2016/3/4','2016/2/8','2016/3/18','2016/2/8','2016/2/8','2016/1/29','2016/4/29','2016/4/22','2016/4/1'))
col2=as.factor(c('动作','喜剧','喜剧','喜剧','喜剧','喜剧','喜剧','爱情','爱情'))
col4=c(6.4,6.9,4.5,5.7,4.0,7.7,6.5,6.4,5.0)
col5=c(77060.44,338583.26,6184.45,119956.51,111693.89,99832.53,78341.38,17798.89,12561.55)
movie=data.frame(col1,col2,col3,col4,col5,stringsAsFactors = FALSE)

#更改列名
names(movie)=c('name','type','showtime','doubanscore','boxoffice')
#更改行名
row.names(movie)=(1:9)*2
movie

#汇总
summary(movie)
str(movie)

#增列、合并
col6=rnorm(9)
movie$rnorm=col6
str(movie)

movie1=data.frame('name'=col1,'type'=col2,stringsAsFactors = F)
movie2=data.frame('name'=col1,'showtime'=col3,stringsAsFactors = F)
movies=merge(movie1,movie2,by='name')
movie3=data.frame('name1'=col1,'type'=col2,stringsAsFactors = F)
movies1=merge(movie2,movie3,by.x='name',by.y = 'name1') #合并列的列名不一样时，分别说明，最后取前一个的名
movies2=merge(movie3,movie2,by.x='name1',by.y = 'name')
movie4=movie2[1:7,]
movies3=merge(movie1,movie4,by='name')#合并列的值域不一样，即长短不一，默认以短的为准，当设置all.x后以x为准
movies4=merge(movie1,movie4,by='name',all.x =T) 

#选择列
movies$name
movies[,1:2]
#选择行
movies[movies$type=='喜剧',]
movies[movies$type=='喜剧'& movies$showtime=='2016-02-08',]

#变序
movie
movie11=movie[order(movie$boxoffice,decreasing = F),]
movie12=movie[order(movie$type,-movie$boxoffice),] #当为numeric时，可在前面加‘-’表示降序，从而实现一升一降

#reshape2
library(reshape2)
mWide=data.frame(Name=c('熊大','水妈'),Type=c('帅哥','美女'),GF2013=c(300,100),GF2014=c(500,350),GF2015=c(1000,886))
(mLong=melt(mWide,id.vars = c('Name','Type'),variable.name = 'Year'))#以id.vars为基准，其他所有原始变量都排成一个新列，即GF2013,GF2014,GF2015排成一列
mLong$Year=gsub('GF','',mLong$Year)
mLong$Year=as.numeric(mLong$Year)
str(mLong)
names(mLong)=c('Name','Type','Year','v')

dcast(mLong,Name+Type~Year)
acast(mLong,Type~Year~Name)

#分割
str(iris)
(iris.split=split(iris,iris$Species))
class(iris.split)#数据库变list

(iris.apply <- lapply(iris.split, function(x)colMeans(x[-5]))) #x[-5]代表去掉第5列

(iris.combine <- do.call(cbind, iris.apply))
(iris.combine <- do.call(rbind, iris.apply))

#plyr
install.packages('plyr')
library(plyr)
ddply(iris,.(Species), function(x) colMeans(x[-5]))
dlply(iris,.(Species), function(x) colMeans(x[-5])) #输入是data.frame,输出是list
daply(iris,.(Species), function(x) colMeans(x[-5]))

#dplyr
install.packages('dplyr')
library(dplyr)
install.packages('hflights')
library(hflights)
str(hflights)
summary(hflights)
dim(hflights)
hf=tbl_df(hflights)
str(hf)
class(hf)
slice(hf,1:10)                                           #选行
hf[1:10,1:5]
filter(hf,Month==1,DayofMonth==1,UniqueCarrier=='AA')    #选行
hf[hf$Month==1&hf$DayofMonth==1&hf$UniqueCarrier=='AA',] #等价
select(hf,Month,UniqueCarrier,DayofMonth)                #选列
hf[-3:-1]
data.frame(hf$Month,hf$DayofMonth,hf$UniqueCarrier)
select(hf,Month:UniqueCarrier)
select(hf,-(Month:UniqueCarrier))
select(hf,-(Month:UniqueCarrier),-Year)
arrange(hf,DayofMonth,Month,Year)
arrange(hf,desc(DayofMonth),Month)

a=select(hf,Month:UniqueCarrier)   #先选后排
arrange(a,desc(DayofMonth),Month)
mutate(hf,gain = ArrDelay - DepDelay, speed = Distance / AirTime * 60)
a1=mutate(hf,gain = ArrDelay - DepDelay, speed = Distance / AirTime * 60)
a1$speed
mutate(hf,gain = ArrDelay - DepDelay, gain_per_hour = gain / (AirTime / 60)) #允许使用刚定义的变量

(planes <- group_by(hf, TailNum))
dim(planes)
dim(hf)
str(planes)
delay <- summarise(planes, 
                   count = n(), 
                   dist = mean(Distance, na.rm = TRUE), 
                   delay = mean(ArrDelay, na.rm = TRUE))
str(delay)
sum(delay$count)
delay <- filter(delay, count > 20, dist < 2000)
install.packages('ggplot2')
library(ggplot2)
ggplot(delay, aes(dist, delay)) + 
  geom_point(aes(size = count), alpha = 0.5) + 
  geom_smooth() + 
  scale_size_area()
