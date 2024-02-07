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



library(moderndive)
str(MA_schools)


# School size tables

table(MA_schools$size)
prop.table(table(MA_schools$size))
