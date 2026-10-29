# ==============================================================================
# Practical Question: Employee Data Frame Operations in R
# ==============================================================================

# ------------------------------------------------------------------------------
# (i) Create a data frame from the 4 vectors and demonstrate the output
# ------------------------------------------------------------------------------
emp_id <- c(1 , 2 ,3 ,4 ,5)                                                 # Integer sequence vector (1 to 5)
emp_name <- c("Rick", "Dan", "Michelle", "Ryan", "Gary")         # Character vector of names
start_date <- c("2012-01-01", "2013-09-23", "2014-11-15",        # Character/Date vector
                "2014-05-11", "2015-03-27")
salary <- c(60000, 45000, 75000, 84000, 20000)                  # Numeric vector of salaries

# Combine vectors into a data frame
emp_df <- data.frame(emp_id, emp_name, start_date, salary)

print("--- (i) Complete Employee Data Frame ---")
print(emp_df)

print("------------------------------------------------------------------------------")

# ------------------------------------------------------------------------------
# (ii) Display structure and summary of the above data frame
# ------------------------------------------------------------------------------
# str() shows the internal structure (data types, number of rows/columns)
print("--- Structure of Data Frame (str()) ---")
str(emp_df)

# summary() gives statistical information (mean, median, min, max, etc.)
print("--- Summary of Data Frame (summary()) ---")
summary(emp_df)

print("------------------------------------------------------------------------------")

# ------------------------------------------------------------------------------
# (iii) Extract the emp_name and salary columns from the above data frame
# ------------------------------------------------------------------------------
# Method 1: Using column names inside square brackets [ , c("col1", "col2")]
extracted_cols <- emp_df[, c("emp_name", "salary")]

print("--- (iii) Extracted Name and Salary Columns ---")
print(extracted_cols)

print("------------------------------------------------------------------------------")

# ------------------------------------------------------------------------------
# (iv) Extract the employee details whose salary is less than or equal to 60000
# ------------------------------------------------------------------------------
# Using subset() function with condition salary <= 60000
low_salary_emps <- subset(emp_df, salary <= 60000)

print("--- (iv) Employees with Salary <= 60000 ---")
print(low_salary_emps)