# Notes 12 Code

# Load packages for this set of notes

library(infer)
library(ggplot2)


# Data for example

layoffs <- data.frame(age = c(25, 33, 35, 38, 48, 55, 55, 55, 56, 64),
                      laidoff = c("No", "No", "No", "No", "No", 
                                  "Yes", "Yes", "No", "No", "Yes"))


# Summarize data for step 2

layoffs_xbardiff <- layoffs %>%
  specify(age ~ laidoff) %>%
  calculate(stat = "diff in means", order = c("Yes", "No"))
layoffs_xbardiff

# We could also calculate a t statistic like is used in theory-based tests

obs_t <- layoffs %>%
  specify(formula = age ~ laidoff) %>%
  calculate(stat = "t", order = c("Yes", "No"))
obs_t


# Null distribution using infer package for our example

set.seed(201005)

layoff_perm <- layoffs %>%
  specify(formula = age ~ laidoff) %>%
  hypothesize(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat = "diff in means", order = c("Yes", "No"))

visualize(layoff_perm) +
  shade_pvalue(obs_stat = layoffs_xbardiff,
               direction = "right")


# Calculate p-value

get_pvalue(layoff_perm,
           obs_stat = layoffs_xbardiff,
           direction = "right")
