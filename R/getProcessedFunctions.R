checkThermocoupleOutDef <- function(instrument){
  #thermocouple has two outdef options - user must choose 1
  
  if (!('outdef' %in% names(instrument))){
    stop('THERMOCOUPLE instrument must have one of "Omega_T" or "Thermocouple" (
         see metadata site for what these mean) as an outdef in the instrument list
         e.g. instrument <- list(id = "THERMOCOUPLE", site = "IMU", oudef = "Omega_T")')
  }
}

getInstOutDef <- function(instrument, level, startDate, fileTimeRes, variables, calibrated){
  #get the output definitions for the instrument specified
  print('Getting output definitions from metadata site...')
  # we are assuming the out def doesn't change throughout the period
  startTinfo <- lf_Tinfo(as.Date(startDate))

  if ('serial' %in% names(instrument)){
    instSerial <- instrument$serial
  } else {
    #get the serial numbers for the instrument
    serials <- lf_serialsRunningToday(instrumentId = instrument$id, startTinfo)
    if (purrr::is_empty(serials)){
      stop(paste(instrument$id, 'not found running for date', as.character(startDate)))
    }
    #get the correct site
    instSerial <- serials[serials[['siteId']] == instrument$site, ]$instSerial
    #check for any issues with serial
    checkInstSerial(instSerial)
  }

  #get the output definitions for this serial
  instOutDef <- lf_getOutputDef(instSerial, startTinfo, level)
  
  #stop if instrument site doesn't match output def
  if (instrument$site != instOutDef[[1]]$header['Site', 2][[1]]){
    stop(paste('Output definition has found serial', instSerial,
               'to be at site', instOutDef[[1]]$header['Site', 2][[1]],
               'on date', as.character(startDate),
               'not the specified site,', instrument$site))
  }
  
  # if ceilometer then different variables stored in different output defs
  if (instrument$id == 'CL31' | instrument$id == 'CT25K'){
    instOutDef <- checkCorrectCeilOutDef(instOutDef, variables)
  }
  
  # decide which output def to use based on the file time res and if is ECpack
  instOutDefVals <- selectOutDef(fileTimeRes, instrument, instOutDef)
  
  #check if using the calibrated ceilometer data
  if (calibrated == TRUE){
    # calibrated can only be appplied to ceilometers (as things stand)
    if (instrument$id == 'CL31' | instrument$id == 'CT25K'){
      #get new file prefix  
      fpCal <- getCalibratedFilePre(instOutDefVals)
      instOutDefVals[['filePrefix']] <- fpCal
    } else {
      warning('calibrated not a valid argument for this instrument... ignoring')
    }
  }

  return(instOutDefVals)
}

checkInstSerial <- function(instSerial){
  #error if no inst at site
  if (purrr::is_empty(instSerial)){
    stop(paste('No serials found for', instrument$id, 'at', instrument$site ))
  }

  # error if multiple serials at site
  if (length(instSerial) > 1) {
    stop(paste('Multiple serials for', instrument$id, 'at', instrument$site,
               '. Specify serial manually. Available serials:',
               paste0(instSerial, collapse = ',')))
  }
}

checkCorrectCeilOutDef <- function(instOutDef, variables){
  # ceilometers have multiple output definitions 
  correctOutDef <- vector(mode = 'list')
  n = 1
  if (length(instOutDef) > 1){
    for (i in 1:length(instOutDef)){
      if (any(variables %in% instOutDef[[i]][['variables']][,'ID'])){
        correctOutDef[[n]] <- instOutDef[[i]]
        n = n + 1
      } 
    }
  }
  #check all variables correct
  if (length(correctOutDef) == 0) stop('none of the variables found for any output definition')
  if (length(correctOutDef) > 1) stop('variables found in multiple output definitions')
  
  return(correctOutDef)
}

getCalibratedFilePre <- function(instOutDefVals){
  #add calibrated into ceilometer file prefix
  fpSplit <- strsplit(instOutDefVals[['filePrefix']], '_')[[1]]
  fpCal <- paste0(c(fpSplit[1:2], 'calibrated', 'SWT'), collapse = '_')
  return(fpCal)
}

selectOutDef <- function(fileTimeRes, instrument, instOutDef){
  #select the output definition based on the file time res
  # if only one name available use this
  if (length(instOutDef) == 1) {
    odInd <- 1
  } else if ('ECpack' %in% names(instrument) && instrument$ECpack == TRUE) {
    # if more than 1 check for EC pack output defs
    odInd <- grep('ECpack', names(instOutDef))
  } else if (any(grepl(fileTimeRes, names(instOutDef)))){
    # if theres an ouput def for the file time res
    odInd <- grep(fileTimeRes,names(instOutDef))
  } else if (instrument$id == 'THERMOCOUPLE'){
    #thermocouple needs outdef manually defined
    odInd <- grep(instrument$outdef, names(instOutDef))
  }  else {
    #otherwise try to use the instrument id
    odInd <- which(names(instOutDef) == instrument$id)
  }

  print(paste('Using output definition:', names(instOutDef)[[odInd]]))
  instOutDefVals <- instOutDef[[odInd]]

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
    if (!is.na(fileTimeRes)){
        dayFile <- dayFile[grepl(fileTimeRes, dayFile)]
    } else {
      stop(paste('Multiple time resolutions available. fileTimeRes must be specified
                 Available files:', paste(dayFile, collapse = ',')))
    }
  }
  return(dayFile)
}

format2Ddata <- function(var, varName){
  # assume each column represents time and row profile reading e.g. temperature tower
  varT <- t(data.frame(var))
  colnames(varT) <- 1:ncol(varT)
  rownames(varT) <- 1:nrow(varT)
  return(varT)
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
    #check if 2d or 1d 
    if (ncol(var) > 1){
      var <- format2Ddata(var, variables[i])
    }
    varDayData[[variables[i]]] <- var
  }
  
  nc_close(instIn)
  
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
  print('Reading data')
  varDayList <- vector(mode = 'list', length = length(dateList))
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
      #print(paste('File for', DATE, 'doesnt exist'))
      #fill dataframes for missing files with NA
      varDayData <- missingDay(DATE, variables, fileResList)
    }
    varDayList[[idate]] <- varDayData
  }
  return(varDayList)
}
