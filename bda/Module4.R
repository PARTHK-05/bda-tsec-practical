# 1. Create five sample numeric vectors from the product sales data
bread <- c(12, 3, 5, 11, 9)
milk <- c(21, 27, 18, 20, 15)
cola_cans <- c(10, 1, 33, 6, 12)
choco_bars <- c(6, 7, 4, 13, 12)
detergent <- c(5, 8, 12, 20, 23)

# 2. Combine vectors into a single Data Frame
sales_df <- data.frame(bread, milk, cola_cans, choco_bars, detergent)

print("Sales Data Frame:")
print(sales_df)

print("--------------------------------------------------------------------------------------")

# 3. Enable prompt so R pauses between each chart
par(ask = TRUE)

# 4. Visualize the data using different types of charts

# Chart 1: Bar Chart
product_totals <- colSums(sales_df)        # Calculates the total sum of each product column
barplot(product_totals,                    # Input data values for the bar heights
        main = "Total Sales by Product",   # Main title at the top of the chart
        xlab = "Products",                 # Label for the horizontal X-axis
        ylab = "Units Sold",               # Label for the vertical Y-axis
        col = "skyblue")                   # Fill color of the bars

# Chart 2: Line Plot / Scatter Plot
plot(bread,                                # Data points to plot
     type = "b",                           # "b" plots both lines and dots
     main = "Bread Sales Trend",           # Main title at the top of the chart
     xlab = "Days (Mon-Fri)",              # Label for the X-axis
     ylab = "Units Sold",                  # Label for the Y-axis
     col = "blue",                         # Color of the lines and dots
     pch = 19,                             # Point character type (19 = solid circle)
     lwd = 2)                              # Line width (thickness)

# Chart 3: Box Plot
boxplot(sales_df,                          # Data frame input to show distributions
        main = "Product Sales Distribution", # Main title at the top of the chart
        xlab = "Products",                 # Label for the X-axis
        ylab = "Units Sold",               # Label for the Y-axis
        col = "orange")                    # Fill color of the boxes

# Chart 4: Histogram
hist(milk,                                 # Numeric vector to show frequency distribution
     main = "Histogram of Milk Sales",     # Main title at the top of the chart
     xlab = "Units Sold",                  # Label for the X-axis
     col = "lightgreen",                   # Fill color of the frequency bins
     border = "black")                     # Border outline color of the bins