getInstOutDef <- function(instrument, level, startDate, fileTimeRes){
  #get the output definitions for the instrument specified
  print('Getting output definitions from metadata site...')

  # we are assuming the out def doesn't change throughout the period
  startTinfo <- lf_Tinfo(as.Date(startDate))
  #get the serial numbers for the instrument
  serials <- lf_serialsRunningToday(instrumentId = instrument$id, startTinfo)
  #get the correct site
  instSerial <- serials[serials[['siteId']] == instrument$site, ]$instSerial

  #### check for multiple serials at site

  #get the output definitions for this serial
  instOutDef <- lf_getOutputDef(instSerial, startTinfo, level)

  # decide which output def to use based on the file time res and if is ECpack
  instOutDefVals <- selectOutDef(fileTimeRes, instrument, instOutDef)

  return(instOutDefVals)
}

selectOutDef <- function(fileTimeRes, instrument, instOutDef){
  #select the output definition based on the file time res
  # if only one name available use this
  if (length(instOutDef) == 1) {
    instOutDefVals <- instOutDef[[1]]
  } else if ('ECpack' %in% names(instrument) & instrument$ECpack == TRUE) {
    # if more than 1 check for EC pack output defs
    instOutDefVals <- instOutDef[[names(instOutDef)[grepl('ECpack',
                                                          names(instOutDef))]]]
  } else if (any(grepl(fileTimeRes, names(instOutDef)))){
    # if theres an ouput def for the file time res
    instOutDefVals <- instOutDef[[names(instOutDef)[grepl(fileTimeRes,
                                                          names(instOutDef))]]]
  } else {
    #otherwise try to use the instrument id
    instOutDefVals <- instOutDef[[instrument$id]]
  }

  #give error if none are satisfied
  if (is.null(instOutDefVals)){
    stop(paste('Could not select suitable output definition from the available
                options:', paste(names(instOutDef), collapse = ',')))
  }

  return(instOutDefVals)
}

getVarUnits <- function(instOutDef, variables){
  # get variable units from the instrument output definitions
  print('Getting variable units from metadata site...')

  varUnits <- data.frame(instOutDef$variables, stringsAsFactors = FALSE) %>%
    dplyr::filter(ID %in% variables) %>% dplyr::select(ID, Unit)

  names(varUnits) <- c('variables', 'units')

  return(varUnits)
}

createReplacementVec <- function(DATE, instrument, level, replacementVec, instOutDef){
  #the placeholders in the path need to be replaced with actual information from here
  replacementVec <- c(replacementVec, '%Y' = strftime(DATE, '%Y'))
  replacementVec <- c(replacementVec, '%j' = strftime(DATE, '%j'))
  replacementVec <- c(replacementVec, '%d' = strftime(DATE, '%d'))
  replacementVec <- c(replacementVec, '%m' = strftime(DATE, '%m'))

  replacementVec <- c(replacementVec, '%LEVEL' = paste0('L',level))
  replacementVec <- c(replacementVec, '%CITY' = instOutDef$header[['City', 2]])
  replacementVec <- c(replacementVec, '%SITE' = instrument$site)

  return(replacementVec)
}

chooseFiles <- function(dataDir, filePre, fileTimeRes){
  # list all the files in the datadir where file prefix is present
  dayFile <- list.files(dataDir, pattern = c(filePre))
  # if there's multiple find the one with time res in it (e.g. 10Hz)
  if(length(dayFile) > 1){
    dayFile <- dayFile[grepl(fileTimeRes, dayFile)]
  }
  return(dayFile)
}

readNCDF <- function(dataDir, dayFile, variables, DATE){
  #open file
  instIn <- nc_open(file.path(dataDir, dayFile))
  #find the time from ncdf
  TIME <- instIn$dim$time$vals
  #add the date to the time (time is minutes since date)
  dt <- as.POSIXct(DATE) + (TIME * 60)
  varDayData <- data.frame('TIME' = dt)
  #add every variable to dataframe
  for(i in 1:length(variables)){
    var <- ncvar_get(instIn, variables[i])
    varDayData[[variables[i]]] <- var
  }
  return(varDayData)
}

missingDay <- function(DATE, variables, fileResList){
  #get the start and end of the day
  daystart <- as.POSIXct(DATE)
  # create a list of all times in the day at file resolution filled with na
  if ( fileResList$Unit == 'Hz' ){
    dayend <- daystart + (60*60*24) - (1/fileResList$Res)
    timesInDay <- seq(daystart, dayend, by= 1/fileResList$Res)
  # assume it must be mins
  } else {
    dayend <- daystart + (60*60*24) - (fileResList$Res*60)
    timesInDay <- seq(daystart, dayend, by= fileResList$Res*60)
  }

  # fill the dataframe with NAs
  varDayData <- data.frame('TIME' = timesInDay)
  for (i in 1:length(variables)){
    varDayData[[variables[i]]] <- NA
  }
  return(varDayData)
}

getNCDFData <- function(dateList, instrument, level, dataDirForm, instOutDef,
                        filePre, fileTimeRes, fileResList, variables){
  varDayList <- list()
  #for every date
  for (idate in 1:length(dateList)){
    DATE <- dateList[idate]

    #replace the basedir placeholders with actual information
    replacementVec <- c()
    replacementVec <- createReplacementVec(DATE, instrument, level,
                                           replacementVec, instOutDef)
    dataDir <- stringr::str_replace_all(dataDirForm, replacementVec)
    #get the files we want to read
    dayFile <- chooseFiles(dataDir, filePre, fileTimeRes)

    if (length(dayFile) > 0 ){
      print(paste('Reading file: ', file.path(dataDir, dayFile)))
      #open the file and get the variables into a dataframe
      varDayData <- readNCDF(dataDir, dayFile, variables, DATE)
    } else {
      print(paste('File for', DATE, 'doesnt exist'))
      #fill dataframes for missing files with NA
      varDayData <- missingDay(DATE, variables, fileResList)
    }
    varDayList[[idate]] <- varDayData
  }
  return(varDayList)
}
