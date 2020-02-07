getRawDF <- function(instrument, startDate, endDate, fileTimeRes, sep,
                     variableColNos, variables, timeColFormat,
                     nTimeCols){
  require(stringr)
  #create a list of dates to be run
  dateList <- createDateList(startDate, endDate)
  # separate the resolution and unit of file res
  fileResList <- getFileRes(fileTimeRes)
  #get the variable units from the metadata system
  vars <- getUnits(variables, variableColNos)
  #read and pad data
  rawDataList <- readRawFiles(dateList, instrument, fileTimeRes, sep,
                              vars, timeColFormat,
                              nTimeCols, fileResList)

  #bind list elements
  allDataDf <- do.call(rbind, rawDataList)
  allDataDf <- allDataDf[is.na(allDataDf['TIME']) == FALSE, ]

  #add units to data
  allData <- list(data = allDataDf, units = vars[c('variables', 'units'), ])
  return(allData)
}

