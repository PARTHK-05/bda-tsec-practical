# ==============================================================================
# Practical Question: Combining Datasets A and B into Dataset C
# ==============================================================================

# 1. Define Dataset A and Dataset B using the given values
dataset_A <- c(6, 7, 8, 9)
dataset_B <- c(1, 2, 4, 5)

# 2. Combine both datasets into Dataset C using the c() function
dataset_C <- c(dataset_A, dataset_B)

# 3. Print the input and output results
print("--- Inputs ---")
print(paste("Dataset A:", paste(dataset_A, collapse = " ")))
print(paste("Dataset B:", paste(dataset_B, collapse = " ")))

print("--- Output: Combined Dataset C ---")
print(dataset_C)