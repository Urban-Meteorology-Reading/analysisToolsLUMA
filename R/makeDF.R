makeDF <- function(instrument, level, startDate, endDate, fileTimeRes, variables,
                   sep = NA, variableColNos = NA, timeColFormat = NA,
                   nTimeCols = NA){

  if (level == 'RAW'){
    #check all valid variables are inputted if level = RAW
    if(any(is.na(c(sep, variableColNos, timeColFormat, nTimeCols)))){
      stop('Args sep, variableColNos, timeColFormat and nTimeCols must be
           specifed if level = RAW' )
    #get a raw dataframe
    } else { allData <- getRawDF(instrument, level, startDate, endDate,
                                 fileTimeRes, sep, variableColNos, variables,
                                 timeColFormat, nTimeCols)}
  # otherwise read processed data
  } else {allData <- getProcessedDF(instrument, level, startDate, endDate,
                                    fileTimeRes, variables)}

  return(allData)
}
