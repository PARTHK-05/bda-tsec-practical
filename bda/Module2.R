# 1. Create a simple dataset for all charts (Run this first!)
hours <- c(1, 2, 3, 4, 5)
marks <- c(35, 50, 65, 80, 95)
attendance <- c(20, 40, 60, 80, 100)
grade <- c("Fail", "Pass", "Pass", "Good", "Top")
student_df <- data.frame(hours, marks, attendance, grade)

# Print the dataset to verify
print("Student Dataset:")
print(student_df)

# 2. Draw the Scatter Plot
plot(student_df$hours, student_df$marks,             # Specifies x and y values
     main = "Study vs Marks",  # Main title of the graph
     xlab = "Hours Studied",   # Label for the X-axis
     ylab = "Marks Obtained",  # Label for the Y-axis
     col = "blue",             # Color of the points (blue)
     pch = 20,                 # Point character type (19 = solid circle)
     cex = 1                   # Character expansion (makes dots 1.5x bigger)
  )                

print("--------------------------------------------------------------------------------------")

# 3. Bubble Chart
symbols(student_df$hours, student_df$marks,  # X and Y coordinates for the points
        circles = student_df$attendance / 30, # Controls bubble size using a 3rd variable
        inches = 0.3,                        # Scales the maximum bubble size
        bg = "purple",                       # Background/fill color inside bubbles
        main = "Bubble Chart",               # Main title of the graph
        xlab = "Hours",                      # Label for the X-axis
        ylab = "Marks")                      # Label for the Y-axis

print("--------------------------------------------------------------------------------------")

# 4. Bar Chart
grade_counts <- table(student_df$grade)       # Counts frequencies of each category
barplot(grade_counts,                        # Frequency data input for bar heights
        main = "Bar Chart",                  # Main title of the graph
        xlab = "Grade",                      # Label for the X-axis
        ylab = "Count",                      # Label for the Y-axis
        col = "green")                       # Color of the vertical bars

print("--------------------------------------------------------------------------------------")

# 5. Dot Plot
dotchart(student_df$marks,                   # Numeric values to plot horizontally
         labels = student_df$grade,          # Row labels assigned to each dot
         main = "Dot Plot",                  # Main title of the graph
         xlab = "Marks",                     # Label for the X-axis
         col = "red")                        # Color of the dots

print("--------------------------------------------------------------------------------------")

# 6. Histogram
hist(student_df$marks,                       # Numeric vector to show frequency distribution
     main = "Histogram",                     # Main title of the graph
     xlab = "Marks",                         # Label for the X-axis
     col = "orange",                         # Fill color of the frequency bins
     border = "black")                       # Border outline color of the bins

print("--------------------------------------------------------------------------------------")

# 7. Box Plot
boxplot(student_df$marks,                    # Numeric data to summarize distribution
        main = "Box Plot",                   # Main title of the graph
        ylab = "Marks",                      # Label for the Y-axis
        col = "pink")                        # Fill color of the box

print("--------------------------------------------------------------------------------------")

# 8. Pie Chart
pie(grade_counts,                            # Categorical frequency table input
    main = "Pie Chart",                      # Main title of the graph
    col = c("red", "yellow", "blue", "green")) # Vector of colors for each slice

print("--------------------------------------------------------------------------------------")

