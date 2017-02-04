library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(plyr)

# set the working directory
setwd('~/Google Drive/Research/Stanford_Ant_Map/dataAnalysis/data/')

# import Stanford tree data
region.data <- read.csv('survey_region_definition.csv', stringsAsFactors = FALSE)
region.mean <- ddply(region.data, .(region), summarize,  longitude=mean(longitude), latitude=mean(latitude))
qmap('37.436723, -122.167152', zoom = 16) +
  geom_polygon(data = region.data, aes(x=longitude, y = latitude, group = group, fill = factor(region))) +
  geom_text(data = region.mean, aes(x=longitude, y = latitude, label = region))
