library(tidyverse)
library(ggmap)
library(RColorBrewer)
library(patchwork)
library(here)

options(digits = 3)
set.seed(1234)
theme_set(theme_minimal())

#Bounding Box coordinate wrapper.

chi_bb <- c(
  left = -87.936287,
  bottom = 41.679835,
  right = -87.447052,
  top = 42.000835
)

#Retrive map from Stamen maps.

chicago <- get_stamenmap(
  bbox = chi_bb,
  zoom = 11
)

#Play with zoom value!

#print(ggmap(chicago))

#Download crime dataset.

crimes <- read_csv("https://cfss.uchicago.edu/data/Crimes_-_2017.csv")

#Type glimpse(crimes) in console to preview the data.

#Longitude and Latitude columns store the exact location of each incident.

#Heat map

datamap <- ggmap(chicago) +
  stat_density2d(
    data = crimes,
    aes(
      x = Longitude,
      y = Latitude,
      fill = stat(level)
    ),
    alpha = .2,
    bins = 25,
    geom = 'polygon'
  ) +
  scale_fill_gradientn(colors = brewer.pal(7, "YlOrRd"))

print(datamap)
