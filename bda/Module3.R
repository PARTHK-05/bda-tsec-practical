# (B) Write the script in R to sort the values contained in the following vector 
# in ascending order and descending order: (23, 45, 10, 34, 89, 20, 67, 99). Demonstrate the output using graph. 

# 1. Define the vector with the given values
vec <- c(23, 45, 10, 34, 89, 20, 67, 99)

# Print the original vector
print("Original Vector:")
print(vec)

# 2. Sort the vector in Ascending order (lowest to highest)
asc_vec <- sort(vec)
print("Ascending Order:")
print(asc_vec)

# 3. Sort the vector in Descending order (highest to lowest)
# decreasing = TRUE reverses the default sort direction
desc_vec <- sort(vec, decreasing = TRUE)
print("Descending Order:")
print(desc_vec)



# 4. Demonstrate the output using a graph (Line Plot)
plot(asc_vec, 
     type = "b",                   # "b" plots both points and connecting lines
     col = "blue",                 # Sets the line/point color to blue
     lwd = 2,                      # Sets the line width (thickness)
     pch = 19,                     # Sets the point character type (solid dot)
     main = "Sorted Vector Graph", # Main title of the graph
     xlab = "Index Position",      # Label for the X-axis
     ylab = "Values")              # Label for the Y-axis