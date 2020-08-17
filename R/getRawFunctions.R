checkRawArgs <- function(variables, variableColNos){
  # check raw arguments
  if (length(variables) != length(variableColNos)){
    stop('Number of variables and variableColNos doesnt match' )
  }
}

getFileResFromMeta <- function(startDate, instrument){
  # get the raw file time resolution from metadata system

  print('Getting raw file time resolution from metadata site...')
  # get Tinfo from start of time period
  startTinfo <- lf_Tinfo(startDate)
  # get sensor info
  sensorInfo <- lf_sensorINFO(instrument$site, instrument$id, startTinfo)
  #check sensor info and information given is consistent
  checkSensorInfo(instrument, sensorInfo, startDate)
  #if multiple serials at site use serial given
  if (nrow(sensorInfo) > 1){
     ftr <- sensorInfo$rawTimeResolution[sensorInfo$instSerial == instrument$serial][[1]]
    # otherwise use only file res option
  } else {ftr <- sensorInfo$rawTimeResolution[[1]]}

  # get rid of space in string
  ftr <- stringr::str_remove(ftr, ' ')
  print(paste('Raw file res:', ftr))
  # format like i want
  fileResList <- getFileRes(ftr)

  return(fileResList)
}

checkSensorInfo <- function(instrument, sensorInfo, theDate){
  #check sensor info and information given is consistent
  #if multiple sensors at site
  if (nrow(sensorInfo) > 1){
    # if the serial isn't specified
    if (!('serial' %in% names(instrument))){
      stop(paste('Multiple', instrument$id, 'at', instrument$site,
                 '. Specify serial in instrument list. Available serials:',
                 paste(sensorInfo$instSerial, collapse = ', ')))
      # if serial not in available serials
    } else if (!(instrument$serial %in% sensorInfo$instSerial)){
      stop(paste('Serial', instrument$serial, 'not found at', instrument$site,
                 'on date', as.character(theDate),
                 '. Available serials:',
                 paste(sensorInfo$instSerial, collapse = ', ')))
    }
  # if one sensor at site but the serial specified doesn't match that on sensor info
  } else if ('serial' %in% names(instrument) && instrument$serial != sensorInfo$instSerial){
      stop(paste('Sensor info has found', instrument$id,
                 'at site', instrument$site, 'on date',
                 as.character(startDate), 'to have serial number',
                 sensorInfo$instSerial, 'not the specifed', instrument$serial))
  }
}

readRawData <- function(x, separator, classCols, skipRows){
  # read in data
  if (file.exists(x)){
    print(paste('Reading file:', x))
    tryCatch({read.table(x, sep = separator, fill = NA,
                         skip = skipRows,
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

checkTimeColFormat <- function(dtObjsOne, dtFormat, Tinfo){
  #try and format first time into timecol format and give error if doesnt work
  firstTryDate <- paste(Tinfo['tD', 'YEAR'], dtObjsOne)

  tryCatch({as.POSIXct(firstTryDate, format = dtFormat)}, error = function(e){
    stop(paste('Error with timeColFormat. Attempting to convert', firstTryDate,
               'to format', dtFormat))
  })

  if( is.na(as.POSIXct(firstTryDate, format = dtFormat))){
    stop(paste('Error with timeColFormat. Attempting to convert', firstTryDate,
               'to format', dtFormat))
  }
}

formatTimeCol <- function(dayData, timeColFormat, variables, Tinfo, fileResList){
  #format time column(s) of raw data to POSIXct

  #the format to put into as.POSIXct
  dtFormat <- paste('%Y', paste(timeColFormat, collapse = ' '))

  # paste all time cols together
  dtObjs <- apply(array(dayData[, timeColFormat]) , 1 , paste, collapse=" ")
  #check that time columns will format
  checkTimeColFormat(dtObjs[1], dtFormat, Tinfo)

  #paste with year and convert to posixct
  dayData <- dayData %>% dplyr::mutate(TIME = paste(Tinfo['tD', 'YEAR'], dtObjs)) %>%
    dplyr::mutate(TIME = as.POSIXct(TIME, format = dtFormat)) %>%
    dplyr::select(c('TIME', variables))

  # round to the nearest fileTimeRes (so that padding doesn't make it go funny)
  if (fileResList$Unit != 'Hz') {
      dayData$TIME <- lubridate::ceiling_date(dayData$TIME, paste(fileResList, collapse = ' '))
  }

  return(dayData)
}

getAllTimes <- function(Tinfo, fileResList){
  # get every interval in day

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

  return(allTimes)
}

padData <- function(Tinfo, fileResList, dayData){
  # all times must be present to make a decent timeseries so data must be padded
  allTimes <- getAllTimes(Tinfo, fileResList)

  allTimesDF <- tibble('TIME' = allTimes)

  #merge the two, filling with NA
  paddedData <- merge(allTimesDF, dayData, all = TRUE)

  return(paddedData)
}

padWholeDate <- function(Tinfo, fileResList, vars){
  # get all interval times in day
  allTimes <- getAllTimes(Tinfo, fileResList)
  # create dataframe with NAs for all times
  wholeDay <- data.frame(matrix(NA, nrow = length(allTimes),
                                ncol = length(vars[, 'variables']) + 1))
  names(wholeDay) <- c( 'TIME' , vars[, 'variables'])
  wholeDay$TIME <- allTimes

  return(wholeDay)
}

selectRawFiles <- function(sensorInfo, instrument, DRIVE){
  #if there's multiple instruments at a site
  if (nrow(sensorInfo) > 1){
      # if more than 1 serial at site
      rawFiles <- sensorInfo$rawFiles[sensorInfo$instSerial == instrument$serial][[1]]
    # otherwise use only raw files option
  } else {rawFiles <- sensorInfo$rawFiles[[1]]}
  
  #Check if working on windows
  if (!is.null(DRIVE)){
    rawFilesSplit <- strsplit(rawFiles, '/|//')[[1]]
    # find tier_raw index 
    tierRawInd <- which(rawFilesSplit == 'Tier_raw')
    # alter path to include DRIVE 
    tierRawDir <- paste0(rawFilesSplit[tierRawInd:length(rawFilesSplit)], collapse = .Platform$file.sep)
    rawFiles <- file.path(DRIVE, tierRawDir)
  }
  return( rawFiles )
}

getUnits <- function(variables, variableColNos){
  # get the units for the variable from the metadata system
  print('Getting variable units from metadata site...')
  varInfo <- lf_getVariables()

  #check all the varibles are on the metadata system
  if (any(!(variables %in% varInfo$id))){
    invalidVar <- variables[!(variables %in% varInfo$id)]
    stop(paste('Variable:', invalidVar, 'not found on metadata system.'))
  }

  units <- unlist(lapply(variables, function(x){
    return(varInfo[varInfo$id == x, ]$unit)
  }))
  vars <- as.data.frame(cbind(variables, units, variableColNos),
                        stringsAsFactors = FALSE)

  return(vars)
}

readRawFiles <- function(dateList, instrument, sep, vars, timeColFormat,
                         fileResList, skipRows, DRIVE){
  rawDataList <- list()
  #find the number of time columns
  nTimeCols <- length(timeColFormat)
  # for every date
  for (idate in 1:length(dateList)){
    DATE <- dateList[idate]
    # get Metadata for this date for this sensor
    Tinfo <- lf_Tinfo(as.Date(DATE))
    sensorInfo <- lf_sensorINFO(instrument$site, instrument$id, Tinfo)

    #check sensor info and information given is consistent
    checkSensorInfo(instrument, sensorInfo, DATE)
    #select raw files for this serial
    browser()
    rawFiles <- selectRawFiles(sensorInfo, instrument, DRIVE)
    #get columns that must be kept as characters (time columns)
    classCols <- getClassCols(nTimeCols)
    # read in all data in raw files and bind this into dataframe
    dayRawData <- lapply(rawFiles, function(x){readRawData(x, separator = sep, classCols, skipRows)})
    #### what do if only 1 list entry
    dayData <- do.call(rbind, dayRawData)

    if (!all(is.na(dayData))){
      #only keep specified columns and time columns -> assuming time cols at the start
      #davis data was pasting \032 in front so get rid of this
      dayData <- dayData %>% dplyr::select(c(1:nTimeCols, as.numeric(vars[, 'variableColNos']))) %>%
        dplyr::mutate(V1 = stringr::str_replace_all(V1, '\032', ''))

      names(dayData) <- c(timeColFormat , vars[, 'variables'])
      # reformat time to be as posixct
      dayData <- formatTimeCol(dayData, timeColFormat, vars[, 'variables'],
                               Tinfo, fileResList)

      #pad data
      rawDataList[[idate]] <- padData(Tinfo, fileResList, dayData)
    } else{
      # what happens when no data for day
      rawDataList[[idate]] <- padWholeDate(Tinfo, fileResList, vars)
    }
  }
  return(rawDataList)
}


