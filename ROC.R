
#========== method 1.ggplot2 =========
install.packages('ggplot2')
install.packages('ROCR')
library(ggplot2)
library(ROCR) 
data(ROCR.simple) 
pred <- prediction(ROCR.simple$predictions, ROCR.simple$labels)  
perf <- performance(pred,"tpr","fpr") 
perf
x <- unlist(perf@x.values)
y <- unlist(perf@y.values)
plotdata <- data.frame(x,y) 
names(plotdata) <- c("x", "y")

g <- ggplot(plotdata) + 
  geom_path(aes(x = x, y = y, colour = x), size=1) + 
  labs(x = "False positive rate", y = "True positive rate", title ="ROC Curves") +
  scale_colour_gradient(name = 'False positive rate', low = 'blue', high = 'red') +
  theme(plot.title = element_text(face = 'bold',size=15))
g

#========= method 2. pROC ========
install.packages('pROC')
library(pROC)##roc
data(aSAH)

roc1<-roc(aSAH$outcome,aSAH$age)
roc2<-roc(aSAH$outcome,aSAH$s100b)
plot(roc1,col='blue')
plot.roc(roc2,add=TRUE,col='red')
auc(roc1, partial.auc = c(1, .9))
smooth(roc1)
