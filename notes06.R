# Notes 06 Code

library(ggplot2)
library(dplyr)


# Fast food data for examples

fastfood <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Spring2024/main/data/fast_food_accuracy.csv")


# Scatterplot of order time (x) vs. error percentage (y)

ggplot(fastfood, aes(x = SecPerOrder, 
                     y = PctWithErrors)) +
  geom_point() +
  labs(x = "Average Seconds Per Drive-Thru Order",
       y = "Percentage of Orders with Errors",
       title = "Fast Food Drive Thru Accuracy") +
  theme_classic()


# Simple linear regression (predicting errors using seconds per order)

lm(PctWithErrors ~ SecPerOrder, 
   data = fastfood)

# This will produce an error because the first argument of lm() isn't the data

fastfood %>%
  lm(PctWithErrors ~ SecPerOrder)

# Alternative version using piping (notice we use . to pipe into other arguments)

fastfood %>%
  lm(PctWithErrors ~ SecPerOrder, 
     data = .)


# Making predictions

fastfood.lm <- lm(PctWithErrors ~ SecPerOrder, 
                  data = fastfood)

# For 300 and 500 seconds per order

predict(fastfood.lm, 
        newdata = data.frame(SecPerOrder = c(300, 500)))

# For 0, 100, 200, 300, ..., 1000 seconds per order

predict(fastfood.lm, 
        newdata = data.frame(SecPerOrder = seq(0, 1000, 100)))

# For every x value in your data

predict(fastfood.lm)
fastfood$SecPerOrder


# Example graph to illustrate R^2

ggplot(fastfood, aes(x = SecPerOrder, 
                     y = PctWithErrors)) +
  geom_point() +
  labs(x = "Average Seconds Per Drive-Thru Order",
       y = "Percentage of Orders with Errors",
       title = "Fast Food Drive Thru Accuracy") +
  theme_classic() +
  geom_smooth(method = "lm",
              se = FALSE) +
  geom_hline(yintercept = mean(fastfood$PctWithErrors),
             color = "red")
