# Notes 10 Code

# Load packages for notes 10

library(infer)
library(dplyr)
library(ggplot2)
library(palmerpenguins)


# Read in data

house_of_reps <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Spring2024/main/data/house_of_reps.csv")


# Set seed and take a random sample of 30 seats

set.seed(82720)
HOR_samp <- sample_n(house_of_reps, size = 30)
table(HOR_samp$party)


# Generate a bootstrap distribution and graph it

HOR_boot <- HOR_samp %>%
  specify(formula = party ~ NULL, success = "Democratic") %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "prop")

visualize(HOR_boot)


# Make 90% Percentile Method CI

HOR_boot %>%
  get_ci(level = 0.9, 
         type = "percentile")


# Make 90% SE Method CI 

HOR_phat <- mean(HOR_samp$party == "Democratic")
  
get_ci(HOR_boot, 
       level = 0.9, 
       type = "se",
       point_estimate = HOR_phat)


# 90% Theory-based interval for the population proportion

prop.test(x = 14,
          n = 30,
          conf.level = 0.9)


# Add $conf.int to get just the confidence interval values

prop.test(x = 14,
          n = 30,
          conf.level = 0.9)$conf.int
