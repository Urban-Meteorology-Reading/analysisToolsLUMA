plotData <- function(instrument, level, startDate, endDate, fileTimeRes, variables,
                   tickBreaks, dateLabelFormat, sep = NA, variableColNos = NA,
                   timeColFormat = NA, nTimeCols = NA, title = NA, SAVEplot = FALSE,
                   SAVEname = NA, SAVEpath = NULL, SAVEsize = NA){
  # get the data
  allData <- makeDF(instrument, level, startDate, endDate, fileTimeRes, variables,
                    sep, variableColNos, timeColFormat, nTimeCols)

  # plot the data
  finalPlot <- makePlot(allData, tickBreaks, dateLabelFormat, level, instrument,
                          fileTimeRes, title, SAVEplot, SAVEname, SAVEpath,
                          SAVEsize)

  return(finalPlot)
}
