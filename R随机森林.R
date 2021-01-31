#首先的首先，设置路径
#setwd("你自己的文件目录")

#首先，装包！
install.packages("pacman")
pacman::p_load(randomForest,caret,pROC)#caret数据处理，模型结果展示的包，可用于数据分割
                                        #ROC面积用于衡量模型好坏标准
#然后，导数据！
data("iris")
summary(iris)

#dat <- read.csv("./dataset.csv",header=T)

#划分训练、测试集

trainlist <- createDataPartition(iris$Species,p = 0.8, list = FALSE)#8:2或者7:3去分割
trainset <- iris[trainlist,]
testset <- iris[-trainlist,]
dim(trainset)
dim(testset)
#***********建模开始啦*************

#1. build model by traindata
set.seed(6666)#####随机性是变量选择随机，样本选择随机，，为了复现比较好的结果，要set.seed
rf.train <- randomForest(as.factor(Species) ~ .,
                         data=trainset,importance=TRUE,na.action = na.pass)

rf.train
plot(rf.train,main = "randomforest origin")#看训练效果

importance(rf.train)
varImpPlot(rf.train)
#2. predicting in testdata
set.seed(666)
rf.test<- predict(rf.train,newdata=testset,type="class")
rf.test
rf.cf <- caret::confusionMatrix(as.factor(rf.test),as.factor(testset$Species))#混淆矩阵，预测结果+测试原本结果

rf.cf
#4.ROC, AUC

rf.test2 <- predict(rf.train,newdata=testset,type="prob")##type=prob,,不能=class要的是概率不是种类
head(rf.test2)

roc.rf <- multiclass.roc(testset$Species, rf.test2)#三个种类用的multiclass
roc.rf
