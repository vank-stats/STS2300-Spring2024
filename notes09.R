# Notes 9 Code

library(infer)
library(dplyr)
library(ggplot2)


# Read in House of Representatives data

house_of_reps <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Spring2024/main/data/house_of_reps.csv")


# Draw our sample of 30 seats from the House of Reps

set.seed(82720)
mysamp <- sample_n(house_of_reps, size = 30)
table(mysamp$party)


# Generic Bootstrap Distribution Code (for population proportion)

bootstrap_dist <- data %>%
  specify(response ~ explanatory, success = "___") %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "ourstat")

visualize(bootstrap_dist)


# Bootstrap Distribution for House of Reps example

HOR_boot <- mysamp %>%
  specify(party ~ NULL, success = "Democratic") %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "prop")

visualize(HOR_boot) +
  geom_vline(xintercept = 14 / 30,
             color = "green",
             linewidth = 3)



# Calculate sample proportion

phat <- mean(mysamp$party == "Democratic")
phat

# Calculate a theory-based CI using our formula
# You will not need to calculate CIs in this way. We have functions for this.

ci_theory <- c(phat - 1.645 * sqrt(phat * (1 - phat) / 30),
               phat + 1.645 * sqrt(phat * (1 - phat) / 30))
ci_theory
