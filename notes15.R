# Notes 15 Code

library(infer)
library(ggplot2)
library(dplyr)


### Chi-squared Test

# Read in data

college <- data.frame(worthit = factor(c(rep("def_yes", 263), rep("prob_yes", 197),
                                         rep("prob_no", 90), rep("def_no", 47),
                                         rep("def_yes", 527), rep("prob_yes", 331),
                                         rep("prob_no", 88), rep("def_no", 29)),
                                       levels = c("def_yes", "prob_yes",
                                                  "prob_no", "def_no")),
                      firstgen = c(rep("yes", 263 + 197 + 90 + 47),
                                   rep("no", 527 + 331 + 88 + 29)))

table(college$worthit, college$firstgen)


# Visualize the sample

ggplot(college, aes(x = firstgen, fill = worthit)) +
  geom_bar(position = "fill")


# Calculate a chi-squared statistic

# Using infer
college_chisq <- college %>%
  specify(worthit ~ firstgen) %>%
  calculate(stat = "Chisq")

# Using chisq.test()
chisq.test(college$firstgen, college$worthit)



# Generate a null distribution

set.seed(15722)
college_null <- college %>%
  specify(worthit ~ firstgen) %>%
  hypothesize(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat = "Chisq")

visualize(college_null) +
  shade_pvalue(obs_stat = college_chisq,
               direction = "right")

college_null %>%
  get_pvalue(obs_stat = college_chisq,
             direction = "right")



### ANOVA Example

# Read in the data

cereal <- data.frame(design = c(rep("A", 5), rep("B", 5), 
                                rep("C", 5), rep("D", 5)),
                     sales = c(19, 17, 16, 19, 15, 12, 18, 15, 19, 11,
                               23, 20, 18, 17, 24, 27, 33, 22, 26, 20))

# Visualize the sample

ggplot(cereal, aes(x = design, y = sales)) +
  geom_boxplot() +
  geom_jitter(height = 0, width = 0.1, size = 3)


# Calculate an F statistic

cereal_F <- cereal %>%
  specify(sales ~ design) %>%
  calculate(stat = "F")

aov(sales ~ design, data = cereal) %>%
  summary()


# Generate a null distribution

set.seed(562024)
cereal_null <- cereal %>%
  specify(formula = sales ~ design) %>%
  hypothesize(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat = "F")

visualize(cereal_null) +
  shade_pvalue(obs_stat = cereal_F,
               direction = "right")


# Calculate a p-value

cereal_null %>%
  get_pvalue(obs_stat = cereal_F,
               direction = "right")
