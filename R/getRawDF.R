getRawDF <- function(startDate, endDate, fileTimeRes, sep,
                     variableColNos, variables, timeColFormat,
                     nTimeCols){
  #create a list of dates to be run
  dateList <- createDateList(startDate, endDate)
  # separate the resolution and unit of file res
  fileResList <- getFileRes(fileTimeRes)
  #read and pad data
  rawDataList <- readRawFiles(dateList, instrument, fileTimeRes, sep,
                              variableColNos, variables, timeColFormat ,
                              nTimeCols, fileResList)
  #bind list elements
  allData <- do.call(rbind, rawDataList)
  return(allData)
}

