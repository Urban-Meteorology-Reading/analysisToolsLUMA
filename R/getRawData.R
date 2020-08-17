getRawData <- function(instrument, level, startDate, endDate, fileTimeRes, sep,
                     variableColNos, variables, timeColFormat, skipRows, DRIVE){

  #check inputs
  checkRawArgs(variables, variableColNos)
  #if only a serial number is supplied then get site and id
  instrument <- checkSerialInfo(instrument, startDate)
  #create a list of dates to be run
  dateList <- createDateList(startDate, endDate)
  # get file time res from metadata and separate the resolution and unit of file res
  if (is.na(fileTimeRes)){
    fileResList <- getFileResFromMeta(startDate, instrument)
  } else {fileResList <- getFileRes(fileTimeRes)}

  print(paste('Creating dataframe of', paste(variables, collapse = ', '),
              'for', instrument$id, 'at site', instrument$site, 'for level',
              level, 'at time resolution', paste0(fileResList$Res, fileResList$Unit),
              'between', as.character(startDate), 'and', as.character(endDate)))

  #get the variable units from the metadata system
  vars <- getUnits(variables, variableColNos)
  #read and pad data
  rawDataList <- readRawFiles(dateList, instrument, sep, vars, timeColFormat,
                              fileResList, skipRows, DRIVE)

  #bind list elements
  allDataDf <- do.call(rbind, rawDataList)
  allDataDf <- allDataDf[is.na(allDataDf['TIME']) == FALSE, ]

  #create a dataframe of meta data
  metadata <- list(instrument = instrument, level = level,
                         fileTimeRes = paste0(fileResList, collapse = ''),
                         units = vars[c('variables', 'units')])
  #add units to data
  allData <- list(data = allDataDf, metadata = metadata)
  return(allData)
}

