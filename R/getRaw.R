# read in raw data and get a data frame/ plots
library(stringr)

# initial settings
standardFileDir <- TRUE

dataDir <- file.path(Sys.getenv('MM_DAILYDATA'), 'RAW', '%Y', 'London',
                     '%SITE', '%INSTRUMENT', '%m')

startDate = as.POSIXct('2020-025', format = '%Y-%j')
endDate = as.POSIXct('2020-026', format = '%Y-%j')


fileTimeRes = '10Hz'
fileSpan <- 'Hourly'
variables = c('u', 'v')
variableColNos <- c(4, 5)
nTimeCols <- 3
timeColFormat <- c('%j', '%H%M', '%OS')
# instrument -> name, level, site
instrument <- list(name = 'Gill', site = 'URAO')


createDateList <- function(startDate, endDate){
  # get a vector of all dates to be gotten
  dateList <- seq(startDate, endDate, by = 'day')
  return(dateList)
}

dateList <- createDateList(startDate, endDate)

createReplacementVec <- function(DATE, instrument){
  #the placeholders in the path need to be replaced with actual information
  replacementVec <- c()
  replacementVec <- c(replacementList, '%Y' = strftime(DATE, '%Y'))
  replacementVec <- c(replacementVec, '%j' = strftime(DATE, '%j'))
  replacementVec <- c(replacementVec, '%d' = strftime(DATE, '%d'))
  replacementVec <- c(replacementVec, '%m' = strftime(DATE, '%m'))

  replacementVec <- c(replacementVec, '%INSTRUMENT' = instrument$name)
  replacementVec <- c(replacementVec, '%SITE' = instrument$site)

  return(replacementVec)
}

createReplacedPath <- function(dateList, instrument, dataDir){

  for (idate in 1:length(dateList)){
    replacementList <- c()
    replacementList <- c(replacementList, '%Y' = strftime(dateList[idate], '%Y'))
    replacementList <- c(replacementList, '%j' = strftime(dateList[idate], '%j'))
    replacementList <- c(replacementList, '%d' = strftime(dateList[idate], '%d'))
    replacementList <- c(replacementList, '%m' = strftime(dateList[idate], '%m'))

    replacementList <- c(replacementList, '%INSTRUMENT' = instrument$name)
    replacementList <- c(replacementList, '%SITE' = instrument$site)


    stringr::str_replace_all(dataDir, replacementList)

   }
}
getMMdata <- function(mmdir, keepcols, headers, plottingVars, theDate){
  mmRawFiles <- list.files(mmdir)
  todaysMMfiles <- mmRawFiles[grepl(strftime(theDate, '%y%j'), mmRawFiles)]
  mmdata <- vector(mode = 'list', length= length(todaysMMfiles))

  for (i in 1:length(todaysMMfiles)){
    mmdata[[i]] <- read.table(file.path(mmdir, todaysMMfiles[i]), sep = ',', fill = NA,
                              stringsAsFactors = F)
  }

  mmDayData <- do.call(rbind, mmdata)

  mmDayData <- mmDayData %>% select(keepcols)

  names(mmDayData) <- headers

  mmDayData[, 'DOY'] <- stringr::str_pad(mmDayData[, 'DOY'], 3, pad = '0')
  mmDayData[, 'time'] <- stringr::str_pad(mmDayData[, 'time'], 4, pad = '0')
  mmDayData[, 'h'] <- substr(mmDayData[, 'time'], 1, 2)
  mmDayData[, 'm'] <- substr(mmDayData[, 'time'], 3, 4)
  mmDayData[, 'datetime'] <- paste0('2020-', mmDayData[, 'DOY'],
                                    ' ', mmDayData[, 'h'], ':',mmDayData[, 'm']
                                    , ':', mmDayData[, 'secs'])

  mmDayData[, 'DATETIME'] <- as.POSIXct(mmDayData[, 'datetime'], format = '%Y-%j %H:%M:%OS')

  ##posixct method
  startDate <- theDate
  endDate <- theDate+ (60 * 60 * 24)

  allTimes <- seq(startDate, endDate, by = 0.1)
  allTimesDF <- tibble('DATETIME' = allTimes)

  #pad out the data
  mmPaddedData <- merge(allTimesDF, mmDayData, all = TRUE)
  mmPaddedData <- as_tibble(mmPaddedData)

  mmplotList <-vector(mode='list', length = length(plottingVars))

  for (i in 1:length(plottingVars)){
    mmplotList[[i]] <- ggplot(data = mmPaddedData) +
      geom_line(aes_string('DATETIME', plottingVars[i])) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))  +
      scale_x_datetime(date_breaks = '6 hours', date_labels = '%H:%M') +
      xlab(paste('Time (', unique(strftime(mmPaddedData$DATETIME, '%Y-%m-%d')[1]), ')'))
  }

  mmPlots <- plot_grid(plotlist = mmplotList, ncol = 2)
  return(mmPlots)
}

title <- ggdraw() + draw_label('URAO EC vars in micromet storage at
                               level raw after changing processing script')
finalPlot <- plot_grid(title, mmGillPlot,mmLicorPlot, ncol = 1, rel_heights = c(0.2, 1, 1))
ggsave(file.path('kitMiniTemp', 'images', 'mmPlot_18_afterChange.png'), finalPlot)

