install.packages("rpart")
install.packages("rpart.plot")
library(rpart)#决策树
library(rpart.plot)

#dataset loading
dat = read.csv("C:/Users/cindy/Desktop/data.csv",header = T)

#iris
data("iris")
attach(iris)
summary(iris)

#data split
s = sample(c(1:nrow(iris)),120,replace = F)
trainset = iris[s,]#取这些行，iris[，s]取这些列
testset = iris[-s,]

#train
fit1 = rpart(Species ~ .,data = trainset)
summary(fit1)

rpart.plot(fit1,type = 2)

#predict
pre = predict(fit1,testset,type = "class")
pre
t = table(pre,testset$Species)
t
acc = sum(diag(t))/nrow(testset) *100#对角线求和除以行数，转为%
print(acc)######这么多的概率预测准确
