# Notes 1 Code

# Create an object called mynumbers

mynumbers <- c(4, 8, 15, 16, 23, 42)

# Multiply the object by 2 (but don't save it)

mynumbers * 2

# Calculate the maximum number in mynumbers

max(mynumbers)


### Writing R code section

# Question 5
mynums <- c(5, 10, 15, 20)
my_max <- max(mynums)
min(mynums)
mean(mynums)
median(mynums)

# Question 6 - Produces an error because R is case sensitive and function is max()
Max(mynumbers)

# Question 7 - Produces errors because we can't have spaces in object names

my numbers <- c(1, 2, 3)
1mynumbers <- c(1, 2, 3)


# Brings up help menus for mtcars data and for max() function

?mtcars
?max()


# displays first 5, first 10, and last 10 (respectively) rows in mtcars data

head(mtcars, n = 5)
head(mtcars, n = 10)
tail(mtcars, n = 10)


# Calculates a summary of each variable in mtcars

summary(mtcars)

# Displays mtcars data in a pop up window in scripts section

View(mtcars)


# glimpse() function is in dplyr package. First we had to use install.packages("dplyr")
# in the console to download the package. Then we use library(dplyr) to load the
# package. After that, we can use glimpse to see each variable and the first several
# observations.

library(dplyr)
glimpse(mtcars)

# skim() is in skimr package. After downloading it (like with dplyr), we can load
# the package and use the skim() function.

library(skimr)
skim(mtcars)



### Practice questions

# Print all of the car weights

mtcars$wt

# Find the minimum miles per gallon

min(mtcars$mpg)

# Find the oldest tree and the shortest tree

max(Loblolly$age)
min(Loblolly$height)
