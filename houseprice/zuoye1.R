# Set Seed so that same sample can be reproduced in future also
set.seed(101) 
# Now Selecting 80% of data as sample from total 'n' rows of the data  
sample <- sample.int(n = nrow(df), size = floor(.80*nrow(df)), replace = F)
train <- df[sample, ]
test  <- df[-sample, ]




#Initial Model
linearModel <- lm(train$price ~ (train$sqft_living+train$sqft_above+train$sqft_basement+factor(train$view)+factor(train$condition)+factor(train$floors)+factor(train$view)+ factor(train$yr_renovated)+factor(train$bedrooms)+factor(train$floors)))
summary(linearModel)
#Residual standard error: 236000 on 17191 degrees of freedom 
#Multiple R-squared: 0.581, Adjusted R-squared: 0.5787
#F-statistic: 248.3 on 96 and 17191 DF, p-value: < 2.2e-16

#Model 2
#zipcode and view to factor
#columns grade,condition to ordered factor
df$zipcode <- as.factor(df$zipcode)
df$view <- as.factor(df$view)
df$grade <- as.ordered(df$grade)
df$condition <- as.ordered(df$condition)

# Set Seed so that same sample can be reproduced in future also
set.seed(101) 
# Now Selecting 80% of data as sample from total 'n' rows of the data  
sample <- sample.int(n = nrow(df), size = floor(.80*nrow(df)), replace = F)
train <- df[sample, ]
test  <- df[-sample, ]

linearMod2 <- lm(train$price ~ train$sqft_living + train$sqft_lot + train$grade + train$zipcode + train$sqft_living15 + train$sqft_above + train$sqft_basement + train$sqft_lot + train$sqft_lot15)
summary(linearMod2)
#Residual standard error: 169300 on 17202 degrees of freedom
#Multiple R-squared:  0.7843,	Adjusted R-squared:  0.7832 
#F-statistic: 735.7 on 85 and 17202 DF,  p-value: < 2.2e-16

#Model 3 adding train$view 

linearMod3 <- lm(train$price ~ train$sqft_living + train$sqft_lot + train$grade + train$zipcode + train$sqft_living15 + train$sqft_above + train$sqft_basement + train$sqft_lot + train$sqft_lot15+train$view)
summary(linearMod3)
#Residual standard error: 156000 on 17198 degrees of freedom
#Multiple R-squared:  0.8168,	Adjusted R-squared:  0.8159 
#F-statistic: 861.6 on 89 and 17198 DF,  p-value: < 2.2e-16