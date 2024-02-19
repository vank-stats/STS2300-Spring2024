# Notes 3 Code

# Set our working directory to the source file location
### Session --> Set Working Directory --> To Source File Location

# Example reading in csv data
# Import Dataset --> From text (readr)

library(readr)
NC_Bridges <- read_csv("NC Bridges.csv")

# Example where we add missing values for the last two columns

library(readr)
NC_Bridges <- read_csv("NC Bridges.csv", na = "Not Posted")


# Example reading in Excel data
# Import Dataset --> From Excel

library(readxl)
majors <- read_excel("MTH_STS_Majors.xlsx")



# Functions in this set of notes are in dplyr package

library(dplyr)

auto <- filter(mtcars, am == 0)

# Version using piping (does the same thing as above)

auto <- mtcars %>%
  filter(am == 0)


# Create a subset of our NC Bridges data that only includes bridges 
# from Alamance County (call it alam_bridges)

alam_bridges <- filter(NC_Bridges, COUNTY == "ALAMANCE")

# Piping version

alam_bridges <- NC_Bridges %>%
  filter(COUNTY == "ALAMANCE")


# Create a subset that includes bridges that are structurally deficient (“SD”) 
# and functionally obsolete (“SO”).

bad_bridges <- NC_Bridges %>%
  filter(STRUCTURALLYDEFICIENT == "SD" & FUNCTIONALLYOBSOLETE == "FO")

# For "and" conditions we can use & or separate conditions by commas

bad_bridges <- NC_Bridges %>%
  filter(STRUCTURALLYDEFICIENT == "SD",
         FUNCTIONALLYOBSOLETE == "FO")


# Create a subset that includes bridges in Alamance County that are 
# either structurally deficient OR functionally obsolete.

bad_alam_bridges <- alam_bridges %>%
  filter(STRUCTURALLYDEFICIENT == "SD" | FUNCTIONALLYOBSOLETE == "FO")

# Equivalent code
bad_alam_bridges <- NC_Bridges %>%
  filter(COUNTY == "ALAMANCE") %>%
  filter(STRUCTURALLYDEFICIENT == "SD" | FUNCTIONALLYOBSOLETE == "FO")

# Equivalent code
bad_alam_bridges <- NC_Bridges %>%
  filter(COUNTY == "ALAMANCE", 
         STRUCTURALLYDEFICIENT == "SD" | FUNCTIONALLYOBSOLETE == "FO")


# Use select() to update alam_bridges to only include ROUTE, ACROSS, YEARBUILT,
#   and SR

alam_bridges <- select(alam_bridges, ROUTE, ACROSS, YEARBUILT, SR)

# Or with piping...

alam_bridges <- alam_bridges %>% 
  select(ROUTE, ACROSS, YEARBUILT, SR)


# mutate() example

mycars <- mutate(mtcars, wt_lbs = wt * 1000)

select(mycars, wt, wt_lbs)


# Practice: Using the NC Bridges data, create a new variable called AGE 
#   that takes 2024 minus YEARBUILT. 
#   Then print the year built and age for the last 10 bridges in the data.

NC_Bridges <- mutate(NC_Bridges, AGE = 2024 - YEARBUILT)

select(NC_Bridges, YEARBUILT, AGE) %>%
  tail(n = 10)




# Long vs. wide data

# Bird nests

birds_wide <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Spring2024/main/data/nestbox_lands_wide.csv")
birds_long <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Spring2024/main/data/nestbox_lands_long.csv")

birds_wide


library(tidyr)

new_birds_long <- birds_wide %>%
  pivot_longer(cols = X2012:X2023, 
               names_to = "Year", 
               values_to = "Fledged") 



new_birds_wide <- birds_long %>%
  pivot_wider(names_from = Year, 
              values_from = Fledged)

