getRawDF <- function(instrument, level, startDate, endDate, sep,
                     variableColNos, variables, timeColFormat, skipRows){
  require(stringr)
  require(dplyr)
  require(tidyr)
  require(lubridate)

  source(Sys.getenv('MM_LUMAfun'))

  #if only a serial number is supplied then get site and id
  instrument <- checkSerialInfo(instrument, startDate)
  #create a list of dates to be run
  dateList <- createDateList(startDate, endDate)
  # get file time res from metadata and separate the resolution and unit of file res
  fileResList <- getFileResFromMeta(startDate, instrument)

  print(paste('Creating dataframe of', paste(variables, collapse = ', '),
              'for', instrument$id, 'at site', instrument$site, 'for level',
              level, 'at time resolution', paste0(fileResList$Res, fileResList$Unit),
              'between', as.character(startDate), 'and', as.character(endDate)))

  #get the variable units from the metadata system
  vars <- getUnits(variables, variableColNos)
  #read and pad data
  rawDataList <- readRawFiles(dateList, instrument, fileTimeRes, sep,
                              vars, timeColFormat, fileResList, skipRows)

  #bind list elements
  allDataDf <- do.call(rbind, rawDataList)
  allDataDf <- allDataDf[is.na(allDataDf['TIME']) == FALSE, ]

  #add units to data
  allData <- list(data = allDataDf, units = vars[c('variables', 'units')])
  return(allData)
}

