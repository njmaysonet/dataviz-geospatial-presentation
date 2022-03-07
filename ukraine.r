# ggplot mapping example

library(gapminder)
library(here)
library(tidyverse)
library(ggrepel)
library(maps)

world <- map_data("world")

#World Map Data

ukraine <- world[world$region == "Ukraine",]

#Violence Incidents in Ukraine

violence <- read_csv("https://www.dropbox.com/s/k2v5g9j6zbne1xw/violence.csv?dl=1")

p <- ggplot(data = ukraine,
            mapping = aes(
              x = long,
              y = lat,
              group = group
            ))

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

print(p + geom_polygon(color = "black", fill = "white", size = 0.1) + 
        coord_map(projection = "albers", lat0 = 44, lat1 = 53) + points)
