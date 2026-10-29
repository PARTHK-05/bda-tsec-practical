# 1. Create a Sample Churn Dataset 
# (Exam tip: If using a CSV file, replace this with: churn_df <- read.csv("Churn_Modelling.csv"))
CustomerID <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
CreditScore <- c(619, 608, 502, 699, 850, 645, 822, 376, 501, 852)
Age <- c(42, 41, 42, 39, 43, 44, 50, 29, 44, 27)
Balance <- c(0, 83807, 159660, 0, 125510, 113755, 0, 115046, 142051, 134603)
Exited <- c(1, 0, 1, 0, 0, 1, 0, 1, 0, 0) # 1 = Customer Churned (left), 0 = Retained (stayed)

churn_df <- data.frame(CustomerID, CreditScore, Age, Balance, Exited)

print("Churn Dataset Preview:")
print(head(churn_df))

print("--------------------------------------------------------------------------------------")

# 2. Basic Data Analysis
# summary() gives statistics (mean, median, min, max) for all columns
print("Statistical Summary:")
print(summary(churn_df))

# table() counts how many customers stayed (0) versus left (1)
churn_counts <- table(churn_df$Exited)
print("Churn Frequency Counts:")
print(churn_counts)

print("--------------------------------------------------------------------------------------")

# 3. Enable prompt so R pauses between each chart
par(ask = TRUE)

# 4. Visualizations

# Chart 1: Bar Chart of Churn Status (Retained vs Churned)
barplot(churn_counts, 
        main = "Customer Churn Status", 
        xlab = "Exited (0 = Retained, 1 = Churned)", 
        ylab = "Number of Customers", 
        col = c("skyblue", "salmon"))

# Chart 2: Histogram of Customer Ages
hist(churn_df$Age, 
     main = "Customer Age Distribution", 
     xlab = "Age", 
     col = "orange", 
     border = "black")

# Chart 3: Box Plot comparing Credit Score by Churn Status 
# (Using the 'Y ~ X' formula notation: Credit Score grouped by Churn Status!)
boxplot(CreditScore ~ Exited, data = churn_df, 
        main = "Credit Score vs Churn Status", 
        xlab = "Exited (0 = Retained, 1 = Churned)", 
        ylab = "Credit Score", 
        col = c("lightgreen", "pink"))