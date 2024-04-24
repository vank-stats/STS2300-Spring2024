# Notes 13 Code

library(infer)
library(ggplot2)
library(dplyr)


# Example: population proportion of mice in NYC carrying drug resistant bacteria

# Read in data

mice <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Spring2024/main/data/mice.csv")


# Step 2: Calculate p hat

mice_phat <- mean(mice$drugresist == "Yes")


# Step 3: Create a null distribution and calculate a p-value

set.seed(4162)
mice_null <- mice %>%
  specify(formula = drugresist ~ NULL, success = "Yes") %>%
  hypothesize(null = "point", p = 1/4) %>%
  generate(reps = 1000, type = "draw") %>%
  calculate(stat = "prop")

visualize(mice_null) +
  shade_pvalue(obs_stat = mice_phat,
               direction = "left")

mice_null %>%
  get_pvalue(obs_stat = mice_phat,
               direction = "left")




# Example: Population mean adult body temperature

# Read in data

bodytemps <- data.frame(temperature = c(97.39, 97.45, 97.96, 97.35, 96.74, 99.66,
                                        98.21, 99.02, 96.78, 97.70, 96.90, 97.29,
                                        97.99, 97.73, 98.18, 97.78, 97.17, 97.34,
                                        97.56, 98.13, 97.77, 97.07, 97.13, 96.74, 
                                        99.10, 96.76, 96.19, 97.84, 96.80, 98.09))


# Step 2: Summarize data (numerically & graphically)

temps_xbar <- mean(bodytemps$temperature)

ggplot(bodytemps, aes(x = temperature)) +
  geom_histogram(color = "white", binwidth = 0.5) +
  geom_vline(xintercept = 98.6, color = "red")


# Step 3: Make null distribution and calculate a p-value

set.seed(228365)
temps_null <- bodytemps %>%
  specify(formula = temperature ~ NULL) %>%
  hypothesize(null = "point", mu = 98.6) %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "mean")

visualize(temps_null) +
  shade_pvalue(obs_stat = temps_xbar,
               direction = "both")

temps_null %>%
  get_pvalue(obs_stat = temps_xbar,
               direction = "both")




# Code for theory-based tests for both examples

# Mice in NYC test for p < 0.25

table(mice$drugresist)
prop.test(x = 95,
          n = 321 + 95,
          p = 0.25,
          alternative = "less")


# Body temperature test for mu not equal 98.6

t.test(bodytemps$temperature,
       mu = 98.6,
       alternative = "two.sided")
