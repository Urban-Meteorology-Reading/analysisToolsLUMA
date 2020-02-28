makeDF <- function(instrument, level, startDate, endDate, variables, fileTimeRes = NA,
                   sep = NA, variableColNos = NA, timeColFormat = NA, skipRows = 0){

  if (level == 'RAW'){
    #check all valid variables are inputted if level = RAW
    if(any(is.na(c(sep, variableColNos, timeColFormat)))){
      stop('Args sep, variableColNos, timeColFormat and nTimeCols must be
           specifed if level = RAW' )
    #get a raw dataframe
    } else { allData <- getRawDF(instrument, level, startDate, endDate,
                                 sep, variableColNos, variables,
                                 timeColFormat, skipRows)}
  # otherwise read processed data
  } else {allData <- getProcessedDF(instrument, level, startDate, endDate,
                                    fileTimeRes, variables)}

  return(allData)
}
