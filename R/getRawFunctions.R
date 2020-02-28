getFileResFromMeta <- function(startDate, instrument){
  # get the raw file time resolution from metadata system

  print('Getting raw file time resolution from metadata site...')
  # get Tinfo from start of time period
  startTinfo <- lf_Tinfo(startDate)
  # get sensor info
  sensorInfo <- lf_sensorINFO(instrument$site, instrument$id, startTinfo)

  #check if multiple serials at site
  if (nrow(sensorInfo) > 1){
    if (!('serial' %in% names(instrument))){
      stop(paste('Multiple', instrument$id, 'at', instrument$site,
                 '. Specify serial in instrument list. Available serials:',
                 paste(sensorInfo$instSerial, collapse = ', ')))
      # if serial not in available serials
    } else if (!(instrument$serial %in% sensorInfo$instSerial)){
      stop(paste('Serial', instrument$serial, 'not found at', instrument$site,
                 '. Available serials:',
                 paste(sensorInfo$instSerial, collapse = ', ')))
    } else { ftr <- sensorInfo$rawTimeResolution[sensorInfo$instSerial == instrument$serial][[1]]}
    # otherwise use only file res option
  } else {ftr <- sensorInfo$rawTimeResolution[[1]]}

  # get rid of space in string
  ftr <- stringr::str_remove(ftr, ' ')
  print(paste('Raw file res:', ftr))
  # format like i want
  fileResList <- getFileRes(ftr)

  return(fileResList)
}

checkSerialInfo <- function(instrument, startDate){
  # get a modified instrument list if only the serial number is supplied
  startTinfo <- lf_Tinfo(startDate)
  # check if only serial number supplied
  if ('serial' %in% names(instrument) && any(!(c('id', 'site') %in% names(instrument)))){
    print('Getting more metadata for instrument.')
    # get site and id from metadata site
    deployInfo <- lf_findDeploymentInfo(instrument$serial, startTinfo)
    SITE <- as.character(deployInfo[[1]]$deploymentInfo$siteId)
    ID <- as.character(deployInfo[[1]]$position$instrument)
    instrument <- list(id = ID, site = SITE, serial = instrument$serial)
  }

  return(instrument)
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

formatTimeCol <- function(dayData, timeColFormat, variables, Tinfo, fileResList){
  #format time column(s) of raw data to POSIXct

  #the format to put into as.POSIXct
  dtFormat <- paste('%Y', paste(timeColFormat, collapse = ' '))

  # paste all time cols together
  #browser()
  dtObjs <- apply(array(dayData[, timeColFormat]) , 1 , paste, collapse=" ")
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

selectRawFiles <- function(sensorInfo, instrument){
  #if there's multiple instruments at a site
  if (nrow(sensorInfo) > 1){
      # if more than 1 serial at site
      rawFiles <- sensorInfo$rawFiles[sensorInfo$instSerial == instrument$serial][[1]]
    # otherwise use only raw files option
  } else {rawFiles <- sensorInfo$rawFiles[[1]]}

  return( rawFiles )
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
                         vars, timeColFormat, fileResList, skipRows){
  rawDataList <- list()
  #find the number of time columns
  nTimeCols <- length(timeColFormat)
  # for every date
  for (idate in 1:length(dateList)){
    DATE <- dateList[idate]
    # get Metadata for this date for this sensor
    Tinfo <- lf_Tinfo(as.Date(DATE))
    sensorInfo <- lf_sensorINFO(instrument$site, instrument$id, Tinfo)

    #select raw files for this serial
    rawFiles <- selectRawFiles(sensorInfo, instrument)

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


