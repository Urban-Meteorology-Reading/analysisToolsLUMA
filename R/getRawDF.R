getRawDF <- function(instrument, level, startDate, endDate, fileTimeRes, sep,
                     variableColNos, variables, timeColFormat){
  require(stringr)
  require(dplyr)
  require(tidyr)

  source(Sys.getenv('MM_LUMAfun'))

  print(paste('Creating dataframe of', paste(variables, collapse = ', '),
              'for', instrument$id, 'at site', instrument$site, 'for level',
              level, 'at time resolution', fileTimeRes, 'between',
              as.character(startDate), 'and', as.character(endDate)))

  #create a list of dates to be run
  dateList <- createDateList(startDate, endDate)
  # separate the resolution and unit of file res
  fileResList <- getFileRes(fileTimeRes)
  #get the variable units from the metadata system
  vars <- getUnits(variables, variableColNos)
  #read and pad data
  rawDataList <- readRawFiles(dateList, instrument, fileTimeRes, sep,
                              vars, timeColFormat, fileResList)

  #bind list elements
  allDataDf <- do.call(rbind, rawDataList)
  allDataDf <- allDataDf[is.na(allDataDf['TIME']) == FALSE, ]

  #add units to data
  allData <- list(data = allDataDf, units = vars[c('variables', 'units')])
  return(allData)
}

