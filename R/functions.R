createDateList <- function(startDate, endDate){
  # get a vector of all dates to get data for
  dateList <- seq(startDate, endDate, by = 'day')
  return(dateList)
}

getFileRes <- function(fileTimeRes){
  #get the file res as a number and a unit
  if (!is.na(fileTimeRes)) {
    fileResList = list()
    fileResList[['Res']] <- readr::parse_number(fileTimeRes)
    fileResList[['Unit']] <- str_remove(fileTimeRes, as.character(fileResList[['Res']]))
    # check if it's one of the valid units
    if (fileResList$Unit != 'min' &  fileResList$Unit != 'sec' &
        fileResList$Unit != 'Hz'){
      stop(paste('Invalid fileTimeRes unit:', fileResList$Unit, 'valid units are: "min", "sec" and "Hz"'))
    }
  }
  return(fileResList)
}

checkSaveParams <- function(SAVEname, SAVEsize){
  # check device
  checkSaveDevice(SAVEname)
  #check save size
  checkSaveSize(SAVEsize)
}

checkSaveDevice <- function(SAVEname){
  #check if a device is specified for savename
  if (!is.na(SAVEname)){
    if (!str_detect(SAVEname, '[.]')){
      stop('No device detected in SAVEname. Please specify (e.g. .png)')
    }
  }
}

checkSaveSize <- function(SAVEsize){
  # check save size has everything we need
  if (any(!(c('h', 'w', 'unit') %in% names(SAVEsize)))){
      stop('h, w and unit must be specified in SAVEize')
  }
}

checkInputs <- function(instrument, startDate, endDate){
  checkInstrument(instrument)
  checkDate(startDate)
  checkDate(endDate)
}

checkInstrument <- function(instrument){
  #check that the instrument is valid

  if(!is.list(instrument)){
    stop('Instrument arg must be a list')
  }

  if (any(!(names(instrument) %in% c('id', 'site', 'serial', 'ECpack')))){
    stop('Invalid instrument input. Valid inputs are: id, site, serial, ECpack')
  }
}

checkDate <- function(DATE){

  if(!lubridate::is.Date(DATE) && !lubridate::is.POSIXct(DATE)){
    stop('startDate and endDate must be class POSIXct or Date')
  }
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
