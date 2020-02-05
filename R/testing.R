# read in raw data and get a data frame/ plots
library(dplyr)
library(readr)
library(stringr)
library(ggplot2)
library(cowplot)


source(Sys.getenv('MM_LUMAfun'))
# initial settings
sep <- ','

startDate = as.POSIXct('2019-245', format = '%Y-%j')
endDate = as.POSIXct('2019-246', format = '%Y-%j')

fileTimeRes = '10Hz'
variables = c('u', 'v', 'Tsonic')
variableColNos <- c(4, 5, 7)
nTimeCols <- 3
timeColFormat <- c('%j', '%H%M', '%OS')
# instrument -> name, level, site
instrument <- list(id = 'GILL121R03',  site = 'URAO', level = 'RAW')

allData <- getRawDF(startDate, endDate, fileTimeRes, sep,
         variableColNos, variables, timeColFormat,
         nTimeCols)

tickBreaks <- '6 hours'
dateLabelFormat <- '%j %H:%M'

finalPlot <- makeTSGrid(allData, variables, tickBreaks, dateLabelFormat)
