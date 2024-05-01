# Notes 14 Code

library(infer)
library(ggplot2)
library(dplyr)


# Difference in Proportions Hypothesis Test

# Read in our data

library(readr)
ACA_survey <- read_delim("https://www.openintro.org/data/tab-delimited/healthcare_law_survey.txt", "\t", 
                         escape_double = FALSE, 
                         trim_ws = TRUE) %>%
  mutate(response = ifelse(response == "approve", "approve", "dont"))



# Step 2 - Summarize data numerically and graphically

ggplot(ACA_survey, aes(x = order, fill = response)) +
  geom_bar(position = "fill")

ACA_diffinphat <- ACA_survey %>%
  specify(response ~ order, success = "approve") %>%
  calculate(stat = "diff in props", order = c("cannot_afford_second",
                                              "penalty_second"))
ACA_diffinphat
  


# Step 3 - Null distribution + p-value

set.seed(15032)
ACA_null <- ACA_survey %>%
  specify(response ~ order, success = "approve") %>%
  hypothesize(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat = "diff in props", order = c("cannot_afford_second",
                                              "penalty_second"))
visualize(ACA_null) +
  shade_pvalue(obs_stat = ACA_diffinphat,
               direction = "both")

ACA_null %>%
  get_pvalue(obs_stat = ACA_diffinphat,
               direction = "both")



# Code for theory-based test

table(ACA_survey$order, ACA_survey$response)

prop.test(x = c(365, 249),
          n = c(406 + 365, 483 + 249),
          alternative = "two.sided")



# Difference in Means Hypothesis Test

# Read in our data

esp <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Spring2024/main/data/esp.csv")


# Step 2 - Summarize data numerically and graphically

esp_diffinxbar <- esp %>%
  specify(Matches ~ Group) %>%
  calculate(stat = "diff in means", order = c("believer", "skeptic"))
esp_diffinxbar

ggplot(esp, aes(x = Matches, y = Group)) +
  geom_boxplot() +
  geom_jitter(width = 0, height = 0.1)


# Step 3 - Null distribution + p-value

set.seed(512024)
esp_null <- esp %>%
  specify(Matches ~ Group) %>%
  hypothesize(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat = "diff in means", order = c("believer", "skeptic"))

visualize(esp_null) +
  shade_pvalue(obs_stat = esp_diffinxbar,
               direction = "right")

esp_null %>%
  get_pvalue(obs_stat = esp_diffinxbar,
               direction = "right")



# Code for theory-based test

prop.test(x = c(365, 249),
          n = c(365 + 406, 249 + 483),
          alternative = "two.sided")

t.test(Matches ~ Group, data = esp, alternative = "greater")
