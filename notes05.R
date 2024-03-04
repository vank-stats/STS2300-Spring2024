# Notes 05 Code

# Load packages for this set of notes

library(ggplot2)
library(palmerpenguins)


# Customizing titles, labels, etc.

# Example using penguins data from palmerpenguins package

graphA <- ggplot(penguins, aes(x = bill_length_mm, 
                               y = body_mass_g,
                               color = species, 
                               shape = island)) +
  geom_point(size = 3, 
             alpha = 0.5) +
  labs(title = "Comparing penguin bill lengths to body mass",
       subtitle = "Across species and island",
       caption = "Created for STS 2300 Notes 05",
       x = "Bill Length (in mm)",
       y = "Body Mass (in grams)",
       shape = "Islands",
       color = "Penguin \nSpecies")

graphA



# Editing scales

# Shape scale example - picking new shapes

graphA +
  scale_shape_manual(values = c(8, 18, 25))


# Practice: Add scale_color_manual() and pick three new colors

graphA +
  scale_color_manual(values = c("blue", "darkgreen", "red"))


# Customizing x and y scales

library(patchwork) # allows us to combine graphs in the same image

left <- ggplot(diamonds, aes(x = price)) +
  geom_histogram(color = "white", bins = 20, boundary = 0)
right <- left +
  scale_x_log10() +
  labs(x = "Price on log scale")
left + right


# Customizing how numbers show up on axes

left +
  scale_x_continuous(labels = scales::label_dollar()) +
  scale_y_continuous(labels = scales::label_comma(),
                     breaks = seq(0, 15000, 2500))



# Reordering categories in categorical data

majors <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Spring2024/main/data/MTH_STS_Majors_Long.csv")

ggplot(majors, aes(y = Major, x = Count)) +
  geom_boxplot(fill = "gold", color = "maroon", alpha = .5) +
  geom_point() +
  scale_y_discrete(limits = c("Math", "Applied_Math", "Data_Analytics", "Stats"))


# Using viridis color schemes

# Practice: Add scale_color_viridis_d() to scatterplot at top.
#   Choose an option you like.

graphA +
  scale_color_viridis_d(option = "C") +
  theme_bw()


# Practice: Add function to choose continuous color option to below graph.

ggplot(penguins, aes(x = bill_length_mm, 
                     y = body_mass_g, 
                     color = flipper_length_mm)) +
  geom_point(size = 3, alpha = 0.5) +
  scale_color_viridis_c(option = "G")


# Bonus to previous question: Edit x/y labels, add commas to y-axis scale,
#   change values in legend

ggplot(penguins, aes(x = bill_length_mm, 
                     y = body_mass_g, 
                     color = flipper_length_mm)) +
  geom_point(size = 3, alpha = 0.5) +
  scale_color_viridis_c(option = "G",
                        breaks = seq(170, 230, 15)) +
  labs(x = "Bill length (in mm)",
       y = "Body mass (in g)") +
  scale_y_continuous(labels = scales::label_comma())



# Example of a custom theme

ggplot(majors, aes(x = Year, y = Count, color = Major)) +
  geom_line(linewidth = 2) +
  geom_point() +
  labs(title = "Elon MTH/STS Department Majors", 
       x = "Year (Fall Semester)",
       y = "Number of Majors") +
  scale_x_continuous(breaks = seq(2007, 2023, 3)) +
  theme(plot.background = element_rect(fill = "firebrick4"),
        panel.background = element_rect(fill = "white"),
        panel.grid = element_line(color = "lightgray"),
        plot.title = element_text(color = "goldenrod1", 
                                  size = 18, 
                                  face = "bold", 
                                  family = "Courier"),
        axis.title = element_text(color = "goldenrod1", 
                                  size = 14),
        axis.text = element_text(color = "goldenrod1"),
        axis.ticks = element_line(color = "goldenrod1"),
        legend.background = element_rect(fill = "darkgray"),
        plot.margin = margin(20, 20, 20, 20))



# Using patchwork to combine graphs in a single image

A <- ggplot(penguins, aes(x = bill_length_mm)) +
  geom_histogram(binwidth = 5, color = "white")
B <- ggplot(penguins, aes(x = bill_depth_mm)) +
  geom_histogram(binwidth = 2, color = "white")
C <- ggplot(penguins, aes(x = body_mass_g, y = species)) +
  geom_boxplot(aes(fill = species), 
               show.legend = FALSE)

(A + B) / C +
  plot_annotation(title = "My Three Penguin Graphs",
                  subtitle = "Two histograms and side-by-side boxplots",
                  caption = "Made with the patchwork package")

