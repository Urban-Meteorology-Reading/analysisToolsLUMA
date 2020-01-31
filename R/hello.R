# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'
#knglkltgregwg


startDate <- as.POSIXct('2020-01-28')
startDate <- as.POSIXct('2020-01-28')

li_mmdir <- '/storage/basic/micromet/Tier_raw/RAW/2020/London/IMU/LI7500_Hrly/01'
li_keepcols <- c(1,2,3,4,5,6, 7)
li_headers <- c('DOY', 'time', 'secs', 'CO2', 'H2O', 'CO2_absorp', 'H2O_absorp')
li_plottingVars <- c('CO2', 'H2O', 'CO2_absorp', 'H2O_absorp')

gill_mmdir <- '/storage/basic/micromet/Tier_raw/RAW/2020/London/URAO/Gill_Hrly/01'
gill_keepcols <- c(1,2,3,4,7)
gill_headers <- c('DOY', 'time', 'secs', 'U', 'T')
gill_plottingVars <- c('U', 'T')

mmLicorPlot<- getMMdata(li_mmdir, li_keepcols, li_headers, li_plottingVars, theDate)
mmGillPlot <- getMMdata(gill_mmdir, gill_keepcols, gill_headers, gill_plottingVars, theDate)

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

