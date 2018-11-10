#基本数据类型
#1.numeric
#2.character
#3.logical
#4.factor
#5.Date/POSIXCT/POSIXIt

a=c('A','A','C','B','E')
#字符转因子
b=as.factor(a)
#因子转数字
as.numeric(b)
#因子排序
c=factor(a,ordered=T)
c1=factor(a,ordered=T,levels=c('B','E','A','C'))
as.numeric(c1)
class(c1)

#Date
class(Sys.Date())
as.Date('2018/01/01')
as.Date('2018-02-28 22:45:12')
as.Date('02,28,18',format='%m,%d,%y')
as.Date('二月,28,18',format='%B,%d,%y')
as.Date('2月,28,2018',format='%b,%d,%Y')

#POSIXct
Sys.time()
class(Sys.time())
as.POSIXct('2018-02-28 22:45:12')
as.POSIXct('2018-02-2822:45:12')
as.POSIXct('2018-02-28,22:45:12')
as.POSIXct('2018/02/28 22:45:12')
as.POSIXlt('2018/02/28 22:45:12')
as.POSIXct('20180228 22:45:12',format='%Y%m%d')
a=as.POSIXct('20180228 224512',format='%Y%m%d %H%M%S')
#输出想要的时间
format(a,format='%A')
format(a,format='%a')

#lubridate
install.packages('lubridate')
library(lubridate)
ymd(c('20090102','2009 1 2','2001 dss 02 1'))
mday(as.Date('2009-01-02'))
wday(as.Date('2009-01-02'))
hour(as.POSIXlt('2018/02/28 22:45:12'))
minute(as.POSIXlt('2018/02/28 22:45:12'))
second(as.POSIXct('2018/02/28 22:45:12'))

#算术
difftime(as.Date('2018/2/2'),as.Date('2018/1/2'),'auto')
as.Date('2018/2/2')-as.Date('2018/1/2')
difftime(as.POSIXct('2018/2/2'),as.POSIXct('2018/1/2'),units='weeks')
difftime(as.POSIXct('2018/2/2'),as.POSIXct('2018/1/2'),units='hours')
difftime(as.POSIXct('2018/2/2 12:21:30'),as.POSIXct('2018/1/2 11:20:11'),units= "secs")
difftime(as.POSIXct('2018/2/2 12:21:30'),as.POSIXct('2018/1/2 11:20:11'),units= "mins")
x1=difftime(as.POSIXct('2018/2/2 12:21:30'),as.POSIXct('2018/1/2 11:20:11'),units= "days")
as.numeric(x1)
as.POSIXlt(Sys.time(),'GMT')
as.POSIXct(Sys.time(),'GMT')

