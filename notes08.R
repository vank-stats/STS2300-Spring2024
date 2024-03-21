# Notes 8 Code

# Load required packages

library(ggplot2)
library(dplyr)
library(moderndive)
library(patchwork)


# Read in example data (house of representatives)

house_of_reps <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Spring2024/main/data/house_of_reps.csv")



# Graph of the population

pop_dist <- ggplot(house_of_reps) +
  geom_bar(aes(x = party, 
               fill = party), 
           show.legend = FALSE) +
  theme_classic() +
  scale_fill_manual(values = c("blue", "red", "black")) 

pop_dist + labs(title = "House of Representatives Seats (Our Population)",
                subtitle = "As of March 2024")



# Sample of 30 seats - view outcome with table()

set.seed(82720) # added after we ran this code the first time

mysamp <- rep_sample_n(house_of_reps, size = 30)
table(mysamp$party)



# Graph of the sample

sample_dist <- ggplot(mysamp) +
  geom_bar(aes(x = party, 
               fill = party), 
           show.legend = FALSE) +
  theme_classic() +
  scale_fill_manual(values = c("blue", "red", "black"))

sample_dist + labs(title = "Sample of 30 House of Representatives Seats",
                   subtitle = "As of September 2023")



# Creating a sampling distribution

# Calculating population proportion
#   house_of_reps$party -- gives us the vector of party values
#   house_of_reps$party == "Democratic" -- gives a vector of TRUE/FALSE
#   mean(__) gives us the proportion of values that are TRUE

true_p <- mean(house_of_reps$party == "Democratic")


# Taking 1000 samples of 30 seats from the house of representatives

my_samples_n30 <- house_of_reps %>%
  rep_sample_n(size = 30,
               reps = 1000)


# Calculating a sample proportion for each of the 1000 samples

my_phats_n30 <- my_samples_n30 %>%
  summarize(prop_dem = mean(party == "Democratic"))


# Graphing the sampling distribution (sample proportions)

sampling_dist <- ggplot(my_phats_n30) +
  geom_histogram(aes(x = prop_dem),
                 binwidth = 1/30,
                 color = "white") +
  theme_classic() +
  scale_fill_manual(values = c("blue", "red", "black"))

sampling_dist + 
  labs(title = "Sampling Distribution for Proportion of Dems in 30 HoR Seats",
       subtitle = "Estimated from 1,000 random samples",
       caption = "Blue line is the population proportion of Democratic seats") +
  geom_vline(xintercept = true_p,
             color = "blue")


# Standard error of my sampling distribution (samples of size n = 30)

sd(my_phats_n30$prop_dem)



# Bootstrap distributions

# Calculate the proportion of Democratic seats in my original sample

phat <- mean(mysamp$party == "Democratic")


# Take 1000 samples of size 30 WITH REPLACEMENT from my original sample
# Calculate the sample proportion (p hat) for each "new" sample
# These 1000 sample proportions are my bootstrap distribution

myboot <- mysamp %>%
  rep_sample_n(size = 30,
               reps = 1000,
               replace = TRUE) %>%
  summarize(prop_dem = mean(party == "Democratic"))



# Graph the bootstrap distribution
# I placed the true proportion (p) and the sample proportion (p hat) on the graph
#   for reference

boot_dist <- ggplot(myboot) +
  geom_histogram(aes(x = prop_dem),
                 binwidth = 1/30,
                 color = "white") +
  theme_classic() +
  scale_fill_manual(values = c("blue", "red", "black")) +
  geom_vline(xintercept = true_p,
             color = "blue") +
  geom_vline(xintercept = phat,
             color = "orange")

boot_dist +
  labs(title = "Bootstrap Distribution for Proportion of Dems in 30 HoR Seats",
       subtitle = "Estimated from 1,000 bootstrap re-samples",
       caption = "Blue line is the pop. proportion, Orange line is samp. prop.")


