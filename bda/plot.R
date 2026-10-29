data(iris)
print(head(iris))
plot(iris$Sepal.Length , iris$Sepal.Width , xlab='sepal.length' , ylab='sepal.width' , col='red' , pch=19)
hist(iris$Sepal.Length)
barplot(table(iris$Species))
boxplot(data=iris ,Sepal.Length ~ Sepal.Width )
pie(table(iris$Sepal.Length))
dotchart(iris$Sepal.Length[1:30])



