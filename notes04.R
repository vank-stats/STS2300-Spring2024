# Code for Notes 4

library(ggplot2)

ggplot(data = mtcars) +
  geom_point(aes(x = wt,
                 y = mpg))


# Practice

ggplot(data = mtcars) +
  geom_point(aes(x = hp,
                 y = mpg))

ggplot(data = mtcars) +
  geom_bar(aes(x = am))

# We can use as.factor() to tell R to treat the am variable as categorical
# (before this it was treating it as quantitative)

ggplot(data = mtcars) +
  geom_bar(aes(x = as.factor(am)))


# Scatterplots

# Practice: Take the scatterplot we made above and see if you can 
#  - make the points purple,
#  - bigger than they were before, 
#  - slightly transparent, 
#  - and triangles instead of circles.

ggplot(data = mtcars) +
  geom_point(aes(x = wt,
                 y = mpg),
             color = "purple",
             size = 5,
             alpha = 0.5,
             shape = 17)



# Histograms

ggplot(data = airquality) +
  geom_histogram(aes(x = Temp),
                 binwidth = 5,
                 fill = "orange",
                 color = "white",
                 boundary = 80)

ggplot(data = airquality) +
  geom_histogram(aes(x = Temp),
                 bins = 9,
                 fill = "orange",
                 color = "white",
                 boundary = 80)



# Boxplots

# Example using ToothGrowth

ggplot(data = ToothGrowth) +
  geom_boxplot(aes(x = supp, 
                   y = len),
               fill = "black",
               color = "pink")



# Option 1 - Raw data

ggplot(data = dataset_name) +
  geom_bar(aes(x = cat_var))

# Option 2 - Summarized data

ggplot(data = dataset_name) +
  geom_col(aes(x = cat_var, 
               y = count_var))

# Example using diamonds data frame (raw or summarized?)

ggplot(data = diamonds) +
  geom_bar(aes(x = cut, 
               fill = cut),
           color = "black")
