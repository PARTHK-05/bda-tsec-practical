# 1. Create vectors for the given table data
Subject <- c(1, 2, 3, 4, 5, 6)
Class <- c(1, 2, 1, 2, 1, 2)
Marks <- c(56, 75, 48, 69, 84, 53)

# 2. Combine vectors into a Data Frame
df <- data.frame(Subject, Class, Marks)

print("Original Data Frame:")
print(df)

print("--------------------------------------------------------------------------------------")

# (i) Create a subset of Subject less than 4 by using the subset() function
sub1 <- subset(df , Subject<4)
print("Subset where Subject < 4 (using subset() function):")
print(sub1)

print("--------------------------------------------------------------------------------------")

# (ii) Create a subset where Subject < 3 AND Class equals 2 using [] brackets
# Note: '&' represents the logical AND operator

sub2 <- df[df$Subject < 3 & df$Class == 2, ]
print("Subset where Subject < 3 and Class == 2 (using [] brackets):")
print(sub2)
print("--------------------------------------------------------------------------------------")

# (iii) Visualize the data using charts

# Chart 1: Bar Chart of Marks per Subject
barplot(df$Marks, 
        names.arg = df$Subject,              # Labels for each bar
        main = "Marks per Subject",          # Main title
        xlab = "Subject",                    # X-axis label
        ylab = "Marks",                      # Y-axis label
        col = "skyblue")                     # Bar color

# Chart 2: Box Plot of Marks grouped by Class
boxplot(Marks ~ Class, data = df,            # Groups marks by class using the ~ operator
        main = "Marks Distribution by Class", # Main title
        xlab = "Class",                      # X-axis label
        ylab = "Marks",                      # Y-axis label
        col = c("lightgreen", "orange"))     # Box colors