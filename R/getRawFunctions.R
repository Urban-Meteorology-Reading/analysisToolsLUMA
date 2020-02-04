##chek that n time cols == length of cols format

createDateList <- function(startDate, endDate){
  # get a vector of all dates to get data for
  dateList <- seq(startDate, endDate, by = 'day')
  return(dateList)
}

readRawData <- function(x, separator, classCols){
  # read in data
  if (file.exists(x)){
    print(paste('Reading file:', x))
    tryCatch({read.table(x, sep = separator, fill = NA,
                         colClasses = classCols,
                         stringsAsFactors = F)},
             error = function(e){
               print(paste('Error reading file:', x))
               print(e)
             })
  } else {
    print(paste('File:', x, 'doesnt exist'))
  }
}

getFileRes <- function(fileTimeRes){
  #get the file res as a number and a unit
  fileResList = list()
  fileResList[['Res']] <- readr::parse_number(fileTimeRes)
  fileResList[['Unit']] <- str_remove(fileTimeRes, as.character(fileResList[['Res']]))
  # check if it's one of the valid units
  if (fileResList$Unit != 'Min' &  fileResList$Unit != 'Sec' &
      fileResList$Unit != 'Hz'){
    stop(paste('Invalid fileTimeRes unit:', fileResList$Unit, 'valid units are: "Min", "Sec" and "Hz"'))
  }
  return(fileResList)
}

getClassCols <- function(nTimeCols){
  #time columns must be as characters to keep leading zeros
  # this is used as an argument in read.table
  timeCols <- paste0('V', seq(1:nTimeCols))
  classCols <- rep('character', nTimeCols)
  names(classCols) <- timeCols
  return(classCols)
}

formatTimeCol <- function(dayData, timeColFormat, variables, Tinfo){
  #format time column(s) of raw data to POSIXct

  #the format to put into as.POSIXct
  dtFormat <- paste('%Y', paste(timeColFormat, collapse = ' '))

  # paste all time cols together
  dtObjs <- apply(dayData[, timeColFormat] , 1 , paste, collapse=" ")
  #paste with year and convert to posixct
  dayData <- dayData %>% mutate(TIME = paste(Tinfo['tD', 'YEAR'], dtObjs)) %>%
    mutate(TIME = as.POSIXct(TIME, format = dtFormat)) %>%
    select(c('TIME', variables) )

  return(dayData)
}

padData <- function(Tinfo, fileResList, dayData){
  # all times must be present to make a decent timeseries so data must be padded

  endDate <- as.POSIXct(Tinfo['tM', 'YD'], format = '%Y%j')
  #allTimes depends on the file resolution
  if (fileResList$Unit == 'Hz') {
    startDate <- as.POSIXct(paste(Tinfo['tD', 'YD'], '00:00:00.0'), format = '%Y%j %H:%M:%OS') + (1/fileResList$Res)
    allTimes <- seq(startDate, endDate, by = 1/fileResList$Res)
  } else if (fileResList$Unit == 'Sec'){
    startDate <- as.POSIXct(Tinfo['tD', 'YD'], format = '%Y%j') + fileResList$Res
    allTimes <- seq(startDate, endDate, by = fileResList$Res)
  } else if (fileResList$Unit == 'Min'){
    startDate <- as.POSIXct(Tinfo['tD', 'YD'], format = '%Y%j') + (fileResList$Res *60)
    allTimes <- seq(startDate, endDate, by = fileResList$Res * 60)
  }

  allTimesDF <- tibble('TIME' = allTimes)

  #merge the two, filling with NA
  paddedData <- merge(allTimesDF, dayData, all = TRUE)

  return(paddedData)
}

readRawFiles <- function(dateList, instrument, fileTimeRes, sep,
                         variableColNos, variables, timeColFormat ,
                         nTimeCols, fileResList){
  rawDataList <- list()
  # for every date
  for (idate in 1:length(dateList)){
    DATE <- dateList[idate]
    # get Metadata for this date for this sensor
    Tinfo <- lf_Tinfo(as.Date(DATE))
    print(Tinfo['tD', ])
    sensorInfo <- lf_sensorINFO(instrument$site, instrument$id, Tinfo)
    rawFiles <- sensorInfo$rawFiles[[1]]

    #get columns that must be kept as characters (time columns)
    classCols <- getClassCols(nTimeCols)
    # read in all data in raw files and bind this into dataframe
    dayRawData <- lapply(rawFiles, function(x){readRawData(x, separator = sep, classCols)})
    #### what do if only 1 list entry
    dayData <- do.call(rbind, dayRawData)
    #only keep specified columns and time columns -> assuming time cols at the start
    dayData <- dayData %>% select(c(1:nTimeCols, variableColNos))
    names(dayData) <- c(timeColFormat , variables)
    # reformat time to be as posixct
    dayData <- formatTimeCol(dayData, timeColFormat, variables, Tinfo)

    #pad data
    # what happens when no data for day
    rawDataList[[idate]] <- padData(Tinfo, fileResList, dayData)
  }
  return(rawDataList)
}
