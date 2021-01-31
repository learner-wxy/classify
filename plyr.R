install.packages("plyr")
library(plyr)

df <- data.frame (id=1:4,
                  weight=c(20,27,24,NA),
                  size=c("small", "large", "medium", "large"))
df

### === arrange 排序======
arrange(df, weight)       # Use arrange from plyr package
df[ order(df$weight), ]   # Use built-in R functions
#>   id weight   size
#> 1  1     20  small
#> 2  4     22  large
#> 3  3     24 medium
#> 4  2     27  large

arrange(df, size, weight)         # Use arrange from plyr package
df[ order(df$size, df$weight), ]  # Use built-in R functions

# Sort by all columns in the data frame, from left to right
df[ do.call(order, as.list(df)), ] 
# In this particular example, the order will be unchanged

# Reverse sort by weight column. These all have the same effect:
arrange(df, -weight)                      # Use arrange from plyr package
df[ order(df$weight, decreasing=TRUE), ]  # Use built-in R functions
df[ order(-df$weight), ]                  # Use built-in R functions
#>   id weight   size
#> 2  2     27  large
#> 3  3     24 medium
#> 4  4     22  large
#> 1  1     20  small


# Sort by size (increasing), then by weight (decreasing)
arrange(df, size, -weight)         # Use arrange from plyr package
df[ order(df$size, -df$weight), ]  # Use built-in R functions
#>   id weight   size
#> 2  2     27  large
#> 4  4     22  large
#> 3  3     24 medium
#> 1  1     20  small


# Sort by size (decreasing), then by weight (increasing)
# The call to xtfrm() is needed for factors
arrange(df, -xtfrm(size), weight)         # Use arrange from plyr package


###=== apply ====
library(plyr)

a <- array(data=1:500000,dim=c(100000,5))

#对每一行求均值，不显示进度条

test1 <- apply(a,1,mean,progress = 'none')

head(test1)

#加function
fun <- function(data) apply(data,1,mean)

daply(.data = iris[,1:4],.variables = .(iris$Species),.fun=fun)

ddply(.data = iris[,1:4],.variables = .(iris$Species),.fun=fun)


#plyr包中还有很多其他函数，如rename()、arrange()、join()等函数，其功能与dplyr包中的rename()、arrange()、left_join()一致
