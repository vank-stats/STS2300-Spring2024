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


# I added our sample proportion to the bootstrap distribution as a reminder
#  that bootstrap distributions are centered on a statistic of interest

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


# Calculate a standard error method CI using the formula
# You will not need to calculate CIs in this way. We have functions for this.

c(phat - 1.645 * sd(HOR_boot$stat), 
  phat + 1.645 * sd(HOR_boot$stat))

# Calculating SE method CI using get_ci()

ci_se <- HOR_boot %>%
  get_ci(level = 0.9, type = "se", point_estimate = phat)
ci_se


# Calculating percentile method CI using get_ci()

ci_perc <- HOR_boot %>%
  get_ci(level = 0.9, type = "percentile")
ci_perc


# Displaying CIs on bootstrap distribution graphs

library(patchwork)

se <- visualize(HOR_boot) +
  shade_ci(ci_se)
perc <- visualize(HOR_boot) +
  shade_ci(ci_perc, fill = "violet", color = "lightpink")

se + perc
