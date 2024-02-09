# Notes 02 Code

# Checking the structure of the mtcars data frame
# ? is used to see what variable names mean

str(mtcars)
?mtcars


# Practice summarizing quant. data

mean(mtcars$mpg)
min(mtcars$hp)
quantile(mtcars$wt, probs = 0.8)
sd(mtcars$disp)

# Bonus: What if I wanted 20th and 80th percentile?

quantile(mtcars$wt, probs = c(0.2, 0.8))


# Load dplyr package to use summarize() function
# Calculate multiple statistics that will be outputted as a data frame

library(dplyr)
summarize(mtcars,
          min_mpg = min(mpg),
          max_mpg = max(mpg),
          avg_hp = mean(hp),
          sd_hp = sd(hp))


# Practice: Store above output in car_sum. Then reference avg_hp from object.

car_sum <- summarize(mtcars,
          min_mpg = min(mpg),
          max_mpg = max(mpg),
          avg_hp = mean(hp),
          sd_hp = sd(hp))
car_sum$avg_hp



# Load moderndive package to access MA_schools data frame
# Use str() to see the structure of MA_schools

library(moderndive)
str(MA_schools)


# School size tables (counts and then proportions)

table(MA_schools$size)
prop.table(table(MA_schools$size))



# Summaries by groups (use .by argument in summarize())

summarize(MA_schools,
          count = n(),
          .by = size)


# Practice: Update earlier code to get separate summary for each transmission type

car_sum <- summarize(mtcars,
                     min_mpg = min(mpg),
                     max_mpg = max(mpg),
                     avg_hp = mean(hp),
                     sd_hp = sd(hp),
                     .by = am)
car_sum



# Practice: Group previous output by am and cyl

car_sum <- summarize(mtcars,
                     min_mpg = min(mpg),
                     max_mpg = max(mpg),
                     avg_hp = mean(hp),
                     sd_hp = sd(hp),
                     .by = c(am, cyl))
car_sum

# Bonus: Add count variable too

car_sum <- summarize(mtcars,
                     count = n(),
                     min_mpg = min(mpg),
                     max_mpg = max(mpg),
                     avg_hp = mean(hp),
                     sd_hp = sd(hp),
                     .by = c(am, cyl))
car_sum
