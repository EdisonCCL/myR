#创建
c(1,2,3)
seq(0,10,1)
seq(0,10,2)
1:10
0:10
sample(1:10,5)#随机抽样
sample(1:10,11,replace = T)#可重复
paste0('x_',1:10)
#factor 重新定义levels 默然按首字母顺序 ordered觉得是否为排序
b = factor(c("Hi","Med","Hi","Low"), 
           levels = c("Low","Hi","Med"), ordered = TRUE)
rep(c("b","a","c"),each=3)

#引用
x=c(1,2,1,2,1,3)
x[1]
which(x==1)#索引
which.max(x)
which.min(x)

#集合运算
x=c(1,2,1,2,1,3)
y=c(1,4,5)
intersect(x,y)#交
union(x,y)#并
setdiff(x,y)#x差y
setdiff(y,x)#y差x

#数值向量
length(x)
max(x)
min(x)
mean(x)
median(x)
quantile(x)
quantile(x,prob=seq(0,1,0.1))
sort(x)
sort(x,decreasing = T)
rank(x)#秩和检验中的秩
rank(c(1,3,4,2,1))
order(x)#排序后在原数据中的位置
x[order(x)]
match(x,c(1,3,2))#x在y中的位置，若无返回na
x1=letters[x]
match(x1,letters[1:3])
cut(x,breaks=c(0.9,1.5,2.5,3),label=c('a','b','c'))
x2=cut(x,breaks=c(1,2,2.5,3),label=c('a','b','c'))#左开右闭
class(x2)#factor,连续型变量变分类型变量

#字符向量
nchar('字符向量a')#长度
nchar('字符  向量')
nchar(c('aa','aaa','a a'))
substr('字符  向量',1,3)#切分
substr(c('aa','aaa','a a'),1,1)
substr(c('aa','aaa','a a'),1,2)
paste(c('字符','向量','串'))#粘贴
paste(c('字符','向量','串'),collapse='')
paste(c('字符','向量','串'),collapse=';')
paste('x',1:4)
paste0('x',1:4)#没间隔
paste('x','y',collapse = ', ')#collapse对向量之间不起作用
paste('x','y','z',sep = ', ')#sep对向量之间起作用
paste0('x','y',collapse = ', ')
x3=paste0('x',1:4)#粘完还是向量
paste(c('x','y','z'),1,sep = '_')
paste0(c('x','y','z'),1,sep = '_')

paste(letters[1:4],1:4)
paste(letters[1:4],1:3)
paste(letters[1:4],1:4,collapse = ';')
paste0(letters[1:4],1:4,collapse = ';')
paste(letters[1:4],1:4,collapse = ';',sep='_')

txt=c('aa','上海','sufea')
grep('a',txt)
grep('aa',txt)#查找给位置
gsub('上海','浙江',txt)#替换
salary=c('20万','30万','80万')
salary0=gsub('万','0000',salary)
mean(as.numeric(salary0))
median(as.numeric(salary0))


