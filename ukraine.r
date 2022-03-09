# ggplot mapping example

# Install these packages once, either with source or console
packages <- c("tidyverse","maps")
install.packages(packages, repos = "http://cran.us.r-project.org")

#Required libraries
library(tidyverse)
library(maps)

#World Map Data
world <- map_data("world")

#Isolating geometry for Ukraine
ukraine <- world[world$region == "Ukraine",]

#This is the plot for the Ukraine map
p <- ggplot(data = ukraine,
            mapping = aes(
              x = long,
              y = lat,
              group = group
            ))

#Violence Incidents in Ukraine
violence <- read_csv("https://www.dropbox.com/s/k2v5g9j6zbne1xw/violence.csv?dl=1")

#These are the scatterplot points for the incidents
points <- geom_point(
  data = violence,
  aes(
    x = longitude,
    y = latitude,
    group = 1,
    size = fatalities,
    color = sub_event_type
  )
)

#Prints to your RStudio plot tab
print(p + geom_polygon(color = "black", fill = "white", size = 0.1) + 
        coord_map(projection = "albers", lat0 = 44, lat1 = 53) + points)
