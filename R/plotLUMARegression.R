#' Title
#'
#' @param instrument1
#' @param instrument2
#' @param startDate
#' @param endDate
#' @param variable
#' @param fileTimeRes
#' @param tickBreaks
#' @param dateLabelFormat
#'
#' @return
#' @export
#'
#' @examples
plotLUMARegression <- function(instrument1, instrument2, startDate, endDate,
                               variable, fileTimeRes, tickBreaks = NA,
                               dateLabelFormat = NA){

  #get the required data and analysis
  varData <- getRegressionData(instrument1, instrument2, startDate, endDate,
                               variable, fileTimeRes)
  #plot the data
  regressionPlot <- createRegressionPlot(varData, tickBreaks, dateLabelFormat)

  return(regressionPlot)
}
