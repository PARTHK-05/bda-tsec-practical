# 1. Load and Preview your CSV Dataset
Iris_data <- read.csv('Iris.csv')

print("Iris Dataset Preview:")
print(head(Iris_data))

print("--------------------------------------------------------------------------------------")

# 2. Basic Data Analysis
print("Statistical Summary:")
print(summary(Iris_data))

# Count how many flowers belong to each species
species_counts <- table(Iris_data$Species)
print("Species Frequency Counts:")
print(species_counts)

print("--------------------------------------------------------------------------------------")


# 4. Visualizations using your 'Iris_data' dataframe

# Chart 1: Box Plot (Sepal Length grouped by Species)
# (Note: Kaggle CSV columns usually have 'Cm' at the end)
boxplot(SepalLengthCm ~ Species, data = Iris_data, 
        main = "Sepal Length by Iris Species", 
        xlab = "Species", 
        ylab = "Sepal Length (cm)", 
        col = c("lightblue", "lightgreen", "pink"))

# Chart 2: Histogram (Frequency distribution of Petal Length)
hist(Iris_data$PetalLengthCm, 
     main = "Histogram of Petal Length", 
     xlab = "Petal Length (cm)", 
     col = "orange", 
     border = "black")

# Chart 3: Scatter Plot (Sepal Length vs Sepal Width)
plot(Iris_data$SepalLengthCm, Iris_data$SepalWidthCm, 
     main = "Sepal Length vs Sepal Width", 
     xlab = "Sepal Length (cm)", 
     ylab = "Sepal Width (cm)", 
     col = "blue", 
     pch = 19, 
     cex = 1.2)

# Chart 4: Bar Chart (Total counts of each species)
barplot(species_counts, 
        main = "Species Count Bar Chart", 
        xlab = "Species", 
        ylab = "Count", 
        col = c("purple", "cyan", "yellow"))