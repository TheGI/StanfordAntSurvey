# Stanford Tree-Ant survey data analysis

# Note
# 1. More winter ants
# 2. Camponotus activity drop between summer and autumn survey
# 3. 
# include libraries
library(GGally)
library(ggplot2)
library(reshape)
library(rgdal)

# set the working directory
setwd('~/Google Drive/Research/Stanford_Ant_Map/dataAnalysis/data/')

# import Stanford tree data
tree.data <- read.csv('stanford_tree_LONLAT.csv', stringsAsFactors = FALSE)

# read all raw survey data into a variable called ant.data
filelist.temp <- list.files(pattern="TAS.*.csv")
ant.data = NULL
for (i in 1:length(filelist.temp)) {
  temp <- read.csv(filelist.temp[i], stringsAsFactors = FALSE)
  ant.data <- rbind(ant.data, temp)
}

# find from tree.data the matching UNIQUEID and add tree.data information
# to ant.data
ant.data <- merge(ant.data, tree.data, by = "UNIQUEID")

# convert longitude and latitude values to UTM coordinates
# survey location is UTM zone 10
xy.temp.lonlat <- cbind(ant.data$LON, ant.data$LAT) 
xy.temp.utm <- project(xy.temp.lonlat, "+proj=utm +zone=10 ellps=WGS84")
ant.data[,c("UTMX","UTMY")] <- xy.temp.utm

# convert all NA's to NOANT
ant.data$SPECIES[is.na(ant.data$SPECIES)] = 'NOANT'

# get rid of all dead trees
ant.data <- ant.data[!(ant.data$SPECIES == 'DEAD'),]

# color code for species
ant.colours <- c(
  "PI" = "#AED6F1","FM" = "#EC7063",
  "CS" = "#873600", "NOANT" = "#EAEDED",
  "LO" = "#229954", "TS" = "#F4D03F",
  "LH" = "#AF7AC5", "CL" = "#873600",
  "CC" = "#F39C12", "PC" = "#F39C12",
  "CV" = "#873600"
)

# unique species of ants
ant.species <- table(ant.data$SPECIES)

# unique species of trees
tree.species <- table(ant.data$SPECIESCOD)

# set save directory
setwd('~/Google Drive/Research/Stanford_Ant_Map/dataAnalysis/output/')

# attach ant.data for convenience
attach(ant.data)

# number of digits to print out
options(digits = 5)

rm(filelist.temp,i,temp,tree.data,xy.temp.utm,xy.temp.lonlat)