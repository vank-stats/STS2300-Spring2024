# Notes 10 Code

# Load packages for notes 10

library(infer)
library(dplyr)
library(ggplot2)
library(palmerpenguins)


# Part 1 -- Confidence intervals for p


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



# Part 2 -- Confidence intervals for mu


# Calculate a sample mean

bill_xbar <- mean(penguins$bill_length_mm, na.rm = TRUE)
bill_xbar


# Generate bootstrap distribution of sample means and graph it 

set.seed(2448945)
bill_boot <- penguins %>%
  specify(formula = bill_length_mm ~ NULL) %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "mean")

visualize(bill_boot) +
  geom_vline(xintercept = bill_xbar,
             color = "lightblue",
             linewidth = 3)


# 95% CI (SE method and percentile method)

get_ci(bill_boot,
       level = 0.95,
       type = "se",
       point_estimate = bill_xbar)

bill_boot %>%
  get_ci(level = 0.95,
         type = "percentile")


# 95% Theory-Based Confidence Interval

t.test(x = penguins$bill_length_mm, 
       conf.level = 0.95)

t.test(x = penguins$bill_length_mm, 
       conf.level = 0.95)$conf.int
