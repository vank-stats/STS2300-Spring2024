# Notes 3 Code

# Example reading in csv data
# Import Dataset --> From text (readr)

library(readr)
bridges <- read_csv("NC Bridges.csv")


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