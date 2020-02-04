# read in raw data and get a data frame/ plots
library(stringr)
library(dplyr)
library(readr)
library(stringr)
library(ggplot2)
library(cowplot)

source(Sys.getenv('MM_LUMAfun'))
# initial settings
standardFileDir <- TRUE
sep <- ','

startDate = as.POSIXct('2020-032', format = '%Y-%j')
endDate = as.POSIXct('2020-033', format = '%Y-%j')

fileTimeRes = '10Hz'
variables = c('u', 'v')
variableColNos <- c(4, 5)
nTimeCols <- 3
timeColFormat <- c('%j', '%H%M', '%OS')
# instrument -> name, level, site
instrument <- list(id = 'GILL121R03',  site = 'URAO', level = 'RAW')
