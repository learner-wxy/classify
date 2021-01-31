#SVM 
#install.packages("e1071")
library(e1071)

#dataset
redwine <- read.csv("C:\\Users\\cindy\\Desktop\\winequality-red.csv",header = T,sep = ";")
summary(redwine)
redwine$quality <- as.factor(redwine$quality)
summary(redwine$quality)

#train test split
s <- sample(nrow(redwine),nrow(redwine)*0.7,replace = F)
length(s)
trainset <- redwine[s,]
testset <- redwine[-s,]
dim(testset)

#training
fit1 <- svm(quality ~.,data = trainset,kernel = "linear")
summary(fit1)
fit2 <- svm(quality ~.,data = trainset,kernel = "sigmoid")
summary(fit2)
#plot svm
plot(fit2,trainset,sulphates~density)

#predict
p1 <- predict(fit1,testset)
p1
p2 <- predict(fit2,testset)
p2

t1 <- table(p1,testset$quality)
acc1 <- sum(diag(t1))/nrow(testset)
acc1

t2 <- table(p2,testset$quality)
acc2 <- sum(diag(t2))/nrow(testset)
acc2
