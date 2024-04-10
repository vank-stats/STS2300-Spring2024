# Notes 11 Code

# Remember to show how to a section for a second R script
#   Tools --> Global Options --> Pane Layout --> Add Column


# Read in packages we will use

library(infer)
library(dplyr)
library(ggplot2)
library(palmerpenguins)


# Difference in proportions example - COVID-sniffing dog

# Reading data

covid_dog <- data.frame(ID = c(rep("positive", 157), rep("negative", 792),
                               rep("positive", 33), rep("negative", 30)),
                        actual = c(rep("positive", 157), rep("negative", 792),
                                   rep("negative", 33), rep("positive", 30))) %>%
  mutate(correct = ifelse(ID == actual, "yes", "no"))


# Calculate a statistic from my sample (difference in sample proportions)

dog_diff_in_props <- covid_dog %>%
  specify(formula = correct ~ actual, success = "yes") %>%
  calculate(stat = "diff in props", order = c("positive", "negative"))
dog_diff_in_props


# Graph our sample to visualize it

ggplot(covid_dog) +
  geom_bar(aes(x = actual, fill = correct),
           position = "fill")


# Creating a bootstrap distribution

set.seed(24946)
dog_boot <- covid_dog %>%
  specify(formula = correct ~ actual, success = "yes") %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "diff in props", order = c("positive", "negative"))
visualize(dog_boot)


# 99% CI using percentile method

dog_boot %>%
  get_ci(level = 0.99, type = "percentile")


# 99% CI using theory-based method (and prop.test() function)

table(covid_dog$correct, covid_dog$actual)

prop.test(x = c(157, 792),
          n = c(157 + 30, 792 + 33),
          conf.level = 0.99)



#####



# Difference in means example - penguin bill lengths

adelie <- filter(penguins, species == "Adelie",
                 !is.na(sex))


# Bootstrap distribution for a difference in mean bill lengths (male vs. female)

set.seed(8395722)
adelie_boot <- adelie %>%
  specify(formula = bill_length_mm ~ sex) %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "diff in means", order = c("male", "female"))
visualize(adelie_boot)
