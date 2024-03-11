# Notes 7 Code

# Load packages for this set of notes

library(ggplot2)
library(dplyr)
library(patchwork)
library(Lock5Data)


# Create data frame called cars with 5 variables (from Lock5Data package)

cars <- Cars2015 %>%
  select(HwyMPG, Length, Height, Acc060, Weight)


# Graph relationships between each variable and HwyMPG
#   Added best-fit lines to graph (not in notes)
#   See note in Notes 7 about why we need aes() in geom_smooth()

g <- ggplot(cars, aes(y = HwyMPG))

g1 <- g + geom_point(aes(x = Length)) + theme_classic() +
  geom_smooth(aes(x = Length), method = "lm")
g2 <- g + geom_point(aes(x = Height)) + theme_classic() +
  geom_smooth(aes(x = Height), method = "lm")
g3 <- g + geom_point(aes(x = Acc060)) + theme_classic() +
  geom_smooth(aes(x = Acc060), method = "lm")
g4 <- g + geom_point(aes(x = Weight)) + theme_classic() +
  geom_smooth(aes(x = Weight), method = "lm")


# Use patchwork package to combine graphs into one image

(g1 + g2) / (g3 + g4) 


# Find estimated multiple linear regression equation in R using lm()

lm(HwyMPG ~ Length + Height + Acc060 + Weight, data = cars)


# Predictions using equation "by hand"
#   This did NOT do a good job due to excessive rounding

34.01 + .074*192 - 0.173*72 + 1.633*7.7 - 0.004*4505


# Example using predict() with piping -- This function will not round

cars %>%
  lm(HwyMPG ~ Length + Height + Acc060 + Weight, data = .) %>%
  predict(newdata = data.frame(Length = 192, 
                                      Height = 72, 
                                      Acc060 = 7.7,
                                      Weight = 4505))


# Graphing predictions vs. actual response variable values

# Create an lm() object
cars.lm <- lm(HwyMPG ~ Length + Height + Acc060 + Weight, data = cars)

# Use lm() object to add predictions to our cars data frame
cars$predictedHwyMPG <- predict(cars.lm)

ggplot(cars) +
  geom_point(aes(x = HwyMPG, y = predictedHwyMPG)) +
  geom_abline(slope = 1) +
  labs(title = "Actual vs. Predicted MPG", x = "Actual Highway MPG", 
       y = "Predicted Highway MPG")


# Use summary() to see R^2 value (more on this later)

summary(cars.lm)
