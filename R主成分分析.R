data("USArrests")
str(USArrests)
summary(USArrests)
### === 方法1.prcomp stats=============
#prcomp(formula, data = NULL, subset, na.action, ...)
prcomp(USArrests)  #没有scale

prcomp(USArrests, scale = TRUE) #直接数据矩阵

p <- prcomp(~ Murder + Assault + Rape, data = USArrests, scale = TRUE) #直接方程
plot(p)
plot(prcomp(USArrests))

summary(prcomp(USArrests, scale = TRUE))

biplot(prcomp(USArrests, scale = TRUE))

### === 方法2.princomp ===========
#princomp(formula, data = NULL, subset, na.action, ...) #继续完全一样
princomp(USArrests, cor = TRUE) 
summary(pc.cr <- princomp(USArrests, cor = TRUE))

loadings(pc.cr)  #rotation


plot(pc.cr) # screeplot

biplot(pc.cr)

### === 方法3.psych包 ====
install.packages("psych")
library(psych) # 载入psych包

df <- USArrests
df.cor<-cor(df) # 计算相关矩阵

####判断主成分的个数
fa.parallel(df, fa = "pc", n.iter = 100,
            show.legend = F, main = "Scree plot with parallel analysis")

pc<-principal(df, nfactors = 2, score = T, rotate = "varimax")
summary(pc)

pc$loadings

round(unclass(pc$weights),2)

