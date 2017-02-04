# Stanford Tree-Ant survey data analysis

# Note
# 1. More winter ants
# 2. Camponotus activity drop between summer and autumn survey
# 3.
# include libraries
library(ggplot2)

# set the working directory
setwd('~/Google Drive/Research/Stanford_Ant_Map/dataAnalysis/data/')

# import Matlab preprocessed ant data
ant.data <- read.csv('antdata_matlab.csv',stringsAsFactors = FALSE)
ant.data$SPECIES[is.na(ant.data$SPECIES)] = 'NOANT'

# color code for species
ant.colours <- c(
  "PI" = "#AED6F1","FM" = "#EC7063",
  "CS" = "#873600", "NOANT" = "#EAEDED",
  "LO" = "#229954", "TS" = "#F4D03F",
  "LH" = "#AF7AC5", "CL" = "#873600",
  "CC" = "#F39C12", "PC" = "#F39C12",
  "CV" = "#873600"
)

# create cross-tab for species CS, LO, FM and NOANT
ant.data[which(ant.data$SPECIESCOD == 'QUAG'),"TREETYPE"] <- 'quag'
ant.data[which(ant.data$SPECIESCOD != 'QUAG'),"TREETYPE"] <- 'other'
ant.data[which(ant.data$SPECIES == 'NOANT'),"ANTTYPE"] <- 'noant'
ant.data[which(ant.data$SPECIES != 'NOANT'),"ANTTYPE"] <- 'ants'

mytable <-
  table(ant.data[which(ant.data$DAY_NIGHT == 'night'), "ANTTYPE"],
        ant.data[which(ant.data$DAY_NIGHT == 'night'), "TREETYPE"])
#mytable[2,1] <- 352*2-mytable[1,1]
#mytable[2,2] <- 339*2-mytable[1,2]
mytable[2,1] <- 352 - mytable[1,1]
mytable[2,2] <- 339 - mytable[1,2]

mytable
Xsq <- chisq.test(mytable)
Xsq

# create cross-tab for species CS, LO, FM and NOANT
rownames(mytable) <- c('trail', 'notrail')
colnames(mytable) <- c('quag', 'other')

mytable[1,1] <- length(unique(ant.data[which((ant.data$T_TRAIL == 1 |
                                                ant.data$B_TRAIL == 1) &
                                               ant.data$SPECIES == 'LO' &
                                               ant.data$SPECIESCOD == 'QUAG'
), "UNIQUEID"]))
mytable[1,2] <- length(unique(ant.data[which((ant.data$T_TRAIL == 1 |
                                                ant.data$B_TRAIL == 1) &
                                               ant.data$SPECIES == 'LO' &
                                               ant.data$SPECIESCOD != 'QUAG'
), "UNIQUEID"]))
mytable[2,1] <- length(unique(ant.data[which(ant.data$SPECIESCOD == 'QUAG'),"UNIQUEID"])) * 2 - mytable[1,1]
mytable[2,2] <- length(unique(ant.data[which(ant.data$SPECIESCOD != 'QUAG'),"UNIQUEID"])) * 2 - mytable[1,2]
mytable
Xsq <- chisq.test(mytable)
Xsq

lm.db <- lm(TREE ~ DBH ,data = ant.data)

ant.data[which(ant.data$SPECIESCOD == 'QUAG'),"TREETYPE"] <- 'quag'
ant.data[which(ant.data$SPECIESCOD != 'QUAG'),"TREETYPE"] <- 'other'
ant.data[which((ant.data$T_TRAIL == 1 |
                  ant.data$B_TRAIL == 1)),"CS"] <- 'cs'
ant.data[which(!(ant.data$T_TRAIL == 1 |
                   ant.data$B_TRAIL == 1)),"CS"] <- 'noant'


mytable <- table(ant.data[, "ANTTYPE"],
                 ant.data[, "TREETYPE"])

mytable
mytable[2,1] <- 352 * 2 - mytable[1,1]
mytable[2,2] <- 339 * 2 - mytable[1,2]
mytable

length(unique(ant.data[which(ant.data$ANTTYPE == 'trail' &
                               ant.data$SPECIESCOD == 'QUAG'), "UNIQUEID"]))

