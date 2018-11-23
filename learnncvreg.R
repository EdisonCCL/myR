library(ncvreg)
n <- 100
beta <- c(1, 2, 3,-1.5,-2,-1,rep(0,200) )/5
x <- matrix(rnorm(206*n), nrow = n)
y <- x%*%beta + rnorm(n)
fit <- ncvreg(x,y,penalty="SCAD")
fit1=cv.ncvreg(x,y,penalty="SCAD")
ind.selected=fit1$min
ind12=which(abs(fit$beta[,ind.selected])>0)
ind12
fit$beta[ind12,ind.selected]
