# ==============================================================================
# Question 12: Text and Numerical Value Concatenation in R
# ==============================================================================

# 1. Define the given text and numerical components
text1 <- "Ram has scored"
text2 <- 89            # Numerical value
text3 <- "marks"
text4 <- "in Mathematics"

# 2. Concatenate the text and numerical values using paste()
# Note: paste() automatically adds a single space between each element by default.
full_sentence <- paste(text1, text2, text3, text4)

# 3. Print the final concatenated result
print("--- Concatenated Result ---")
print(full_sentence)

# Alternatively, using paste0() with explicit spaces added manually:
full_sentence_0 <- paste0(text1, text2, text3, text4)
print(full_sentence_0)