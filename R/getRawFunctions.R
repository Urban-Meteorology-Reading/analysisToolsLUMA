##chek that n time cols == length of cols format

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
    return(NA)
  }
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
  #browser()
  dtObjs <- apply(array(dayData[, timeColFormat]) , 1 , paste, collapse=" ")
  #paste with year and convert to posixct
  dayData <- dayData %>% dplyr::mutate(TIME = paste(Tinfo['tD', 'YEAR'], dtObjs)) %>%
    dplyr::mutate(TIME = as.POSIXct(TIME, format = dtFormat)) %>%
    dplyr::select(c('TIME', variables) )

  return(dayData)
}

padData <- function(Tinfo, fileResList, dayData){
  # all times must be present to make a decent timeseries so data must be padded

  endDate <- as.POSIXct(Tinfo['tM', 'YD'], format = '%Y%j')
  #allTimes depends on the file resolution
  if (fileResList$Unit == 'Hz') {
    startDate <- as.POSIXct(paste(Tinfo['tD', 'YD'], '00:00:00.0'), format = '%Y%j %H:%M:%OS') + (1/fileResList$Res)
    allTimes <- seq(startDate, endDate, by = 1/fileResList$Res)
  } else if (fileResList$Unit == 'sec'){
    startDate <- as.POSIXct(Tinfo['tD', 'YD'], format = '%Y%j') + fileResList$Res
    allTimes <- seq(startDate, endDate, by = fileResList$Res)
  } else if (fileResList$Unit == 'min'){
    startDate <- as.POSIXct(Tinfo['tD', 'YD'], format = '%Y%j') + (fileResList$Res *60)
    allTimes <- seq(startDate, endDate, by = fileResList$Res * 60)
  }

  allTimesDF <- tibble('TIME' = allTimes)

  #merge the two, filling with NA
  paddedData <- merge(allTimesDF, dayData, all = TRUE)

  return(paddedData)
}

getUnits <- function(variables, variableColNos){
  # get the units for the variable from the metadata system
  print('Getting variable units from metadata site...')
  varInfo <- lf_getVariables()

  ### add chech here ###


  units <- unlist(lapply(variables, function(x){
    return(varInfo[varInfo$id == x, ]$unit)
  }))
  vars <- as.data.frame(cbind(variables, units, variableColNos),
                        stringsAsFactors = FALSE)

  return(vars)
}

readRawFiles <- function(dateList, instrument, fileTimeRes, sep,
                         vars, timeColFormat, fileResList){
  rawDataList <- list()
  #find the number of time columns
  nTimeCols <- length(timeColFormat)
  # for every date
  for (idate in 1:length(dateList)){
    DATE <- dateList[idate]
    # get Metadata for this date for this sensor
    Tinfo <- lf_Tinfo(as.Date(DATE))
    sensorInfo <- lf_sensorINFO(instrument$site, instrument$id, Tinfo)
    rawFiles <- sensorInfo$rawFiles[[1]]

    #get columns that must be kept as characters (time columns)
    classCols <- getClassCols(nTimeCols)
    # read in all data in raw files and bind this into dataframe
    dayRawData <- lapply(rawFiles, function(x){readRawData(x, separator = sep, classCols)})
    #### what do if only 1 list entry
    dayData <- do.call(rbind, dayRawData)
    #only keep specified columns and time columns -> assuming time cols at the start
    dayData <- dayData %>% dplyr::select(c(1:nTimeCols, as.numeric(vars[, 'variableColNos'])))
    names(dayData) <- c(timeColFormat , vars[, 'variables'])
    # reformat time to be as posixct
    dayData <- formatTimeCol(dayData, timeColFormat, vars[, 'variables'], Tinfo)

    #pad data
    # what happens when no data for day
    rawDataList[[idate]] <- padData(Tinfo, fileResList, dayData)
  }
  return(rawDataList)
}


