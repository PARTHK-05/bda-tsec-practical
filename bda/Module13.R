# ==============================================================================
# Question: Data Frame Creation and Subsetting using [ ] and subset()
# ==============================================================================

# 1. Create the Data Frame using the given data values
course <- c(1, 2, 3, 4, 5, 6)
id <- c(11, 12, 13, 14, 15, 16)
class <- c(1, 2, 1, 2, 1, 2)
marks <- c(56, 75, 48, 69, 84, 53)

df <- data.frame(id , course , class, marks)

print("--- Original Data Frame ---")
print(df)

print("------------------------------------------------------------------------------")

# ------------------------------------------------------------------------------
# (i) Create a subset of course less than 3 by using [ ] brackets
# ------------------------------------------------------------------------------
# Note: df$course < 3 filters the rows, and the blank space after the comma 
# ensures we keep all columns.

sub1 <- df[df$course < 3, ]

print("--- (i) Subset where course < 3 (using [ ] brackets) ---")
print(sub1)

print("------------------------------------------------------------------------------")

# ------------------------------------------------------------------------------
# (ii) Create a subset where course < 3 OR class == 2 using subset() function
# ------------------------------------------------------------------------------
# Note: '|' represents the logical OR operator in R.

sub2 <- subset(df, course < 3 | class == 2)

print("--- (ii) Subset where course < 3 OR class == 2 (using subset() function) ---")
print(sub2)

sub3 <- df[df$course<3 | df$class==2 , ]
print("--- (ii) Subset where course < 3 OR class == 2 (using subset() function) method2 ---")
print(sub3)