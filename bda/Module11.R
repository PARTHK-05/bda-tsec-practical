# ==============================================================================
# Question 11: Sales Data Vector Creation & Subsetting Operators in R
# ==============================================================================

# ------------------------------------------------------------------------------
# Part (i): Create five sample numeric vectors from the product sales data
# ------------------------------------------------------------------------------

# Create numeric vectors representing daily sales (Monday to Friday) for each product
bread <- c(12, 3, 5, 11, 9)
milk <- c(21, 27, 18, 20, 15)
cola_cans <- c(10, 1, 33, 6, 12)
chocolate_bars <- c(6, 7, 4, 13, 12)
detergent <- c(5, 8, 12, 20, 23)

# Combine the individual vectors into a single structured Data Frame
sales_df <- data.frame(bread, milk, cola_cans, chocolate_bars, detergent)

print("--- 1. Complete Sales Data Frame ---")
print(sales_df)

print("------------------------------------------------------------------------------")

# ------------------------------------------------------------------------------
# Part (ii): Examples of Operators Used to Form Data Subsets in R
# ------------------------------------------------------------------------------

# 1. The Dollar Sign Operator ($)
# Explanation: Extracts a single column by name from a data frame.
print("--- Subsetting Operator 1: The $ Operator ---")
print("Extracting only the 'bread' sales column:")
bread_only <- sales_df$bread
print(bread_only)

print("------------------------------------------------------------------------------")

# 2. The Square Bracket Operator ([ ])
# Explanation: Slices data using row and column positions in the format [rows, columns].
print("--- Subsetting Operator 2: The [ ] Indexing Operator ---")
print("Extracting the first 3 rows and all columns:")
first_three_days <- sales_df[1:3, ]
print(first_three_days)

print("------------------------------------------------------------------------------")

# 3. Logical Operators (<, >, ==, &, |) inside Brackets
# Explanation: Filters rows based on conditional checks.
print("--- Subsetting Operator 3: Logical Operators with [ ] ---")
print("Extracting rows where milk sales are strictly greater than 20:")
high_milk_sales <- sales_df[sales_df$milk > 20, ]
print(high_milk_sales)

print("------------------------------------------------------------------------------")

# 4. The subset() Function
# Explanation: A built-in R function that extracts rows cleanly based on conditions.
print("--- Subsetting Operator 4: The subset() Function ---")
print("Extracting rows where cola cans sales are greater than 10:")
cola_subset <- subset(sales_df, cola_cans > 10)
print(cola_subset)