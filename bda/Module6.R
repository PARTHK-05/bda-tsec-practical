# 1. (i) Enter the initial 10 employee salaries into a Data Frame
# We use data.frame() to create a structured table with Sr. No, Name, and Salary
emp_df <- data.frame(
  Sr_No = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
  Name = c("Vivek", "Karan", "James", "Soham", "Renu", "Farah", "Hetal", "Mary", "Ganesh", "Krish"),
  Salary = c(21000, 55000, 67000, 50000, 54000, 40000, 30000, 70000, 20000, 15000)
)
print("Original Employee Dataset:")
print(emp_df)

print("--------------------------------------------------------------------------------------")

# 2. (ii) Add the salaries of 5 new employees using rbind()
# rbind() stands for "row bind". It is used to join/combine datasets by adding new rows.
new_employees <- data.frame(
  Sr_No = c(11, 12, 13, 14, 15),
  Name = c("Amit", "Priya", "Rahul", "Sneha", "Kunal"),
  Salary = c(45000, 60000, 35000, 48000, 52000)
)

# Combine the existing dataset with the new rows
updated_emp_df <- rbind(emp_df, new_employees)

# Combine the existing dataset with the new rows
updated_emp_df <- rbind(emp_df, new_employees)

print("Updated Employee Dataset after adding new rows:")
print(updated_emp_df)

print("--------------------------------------------------------------------------------------")

# 3. (iii) Visualize the data using charts

# Enable prompt so R pauses between each chart
par(ask = TRUE)

# Chart 1: Bar Chart showing employee salaries
# names.arg sets the employee names as labels under each vertical bar
barplot(updated_emp_df$Salary, 
        names.arg = updated_emp_df$Name,     # Name labels for X-axis
        main = "Employee Salaries Bar Chart", # Main title
        xlab = "Employee Name",              # X-axis label
        ylab = "Salary (INR)",               # Y-axis label
        col = "skyblue",                     # Bar color
        las = 2)                             # Rotates X-axis names vertically so they don't overlap

# Chart 2: Histogram showing the distribution/frequency of salary ranges
hist(updated_emp_df$Salary, 
     main = "Salary Distribution Histogram",   # Main title
     xlab = "Salary Range",                  # X-axis label
     col = "orange",                         # Fill color of bins
     border = "black")                       # Border outline color