
# (B) Write a R program to create a Data Frame which contain details of 5 employees and display summary of the data using R. 


# 1. Create vectors for employee details
emp_id <- c(1 , 2, 3 ,4 ,5)
emp_name <- c("Rick", "Dan", "Michelle", "Ryan", "Gary")
start_date <- c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11", "2015-03-27")
salary <- c(60000, 45000, 75000, 84000, 20000)

# 2. Combine vectors into a Data Frame
emp_df <- data.frame(emp_id , emp_name , start_date , salary)
print("Employee Data Frame:")
print(emp_df)

# 3. Display structure and summary
print("Structure of Data Frame:")
str(emp_df)

print("Summary of Data Frame:")
summary(emp_df)

# 4. Extract specific columns (emp_name and salary)
print("Extracted Names and Salaries:")
print(emp_df[, c("emp_name", "salary")])

# 5. Extract employee details whose salary is <= 60000
print("Employees with Salary <= 60000:")
print(emp_df[emp_df$salary <= 60000, ])