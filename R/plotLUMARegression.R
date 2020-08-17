#' Plot a scatter graph and time series, along with a few statistics, of a variable
#' for two instruments or processing levels.
#'
#' @param instrument1,instrument2 the first instruments to compare. These must be lists
#' containing at least id, site and level. id must be consistent with the LUMA metadata site.
#' ECpack is an optional name in the list. If level is RAW than rawFileParams must be included.
#' rawFileParams is a list containing the elements: sep, variableColNos, timeColFormat
#' and optionally skipRows. use ?getLUMAdata for more information on these.
#' @param startDate,endDate the time span to get data for. Must be class date
#' or POSIXct.
#' @param variable the variable to compare between instruments. Must be consistent with
#' LUMA metadata site.
#' @param fileTimeRes The file time resolution- this must be the same for each instrument.
#' @param DRIVE If running on windows which drive is /storage/basic/micromet mapped to e.g. Z
#' @param tickBreaks How often ticks should appear on time series plots. e.g. 6 hours.
#' See https://www.rdocumentation.org/packages/ggplot2/versions/1.0.0/topics/scale_x_datetime
#' date_breaks for valid options.
#' @param dateLabelFormat The format of date labels on time series plot
#' e.g. with Hour and Minute separated by : . See date_labels in link above for valid options.
#'
#' @return
#' @export
#'
#' @examples
#' #for processed data
#' instrument1 <- list(id = 'DAVIS', site = 'IMU', level = 1)
#' #for raw data
#' inst2rawFileParams <- list(sep = ',', variableColNos = 2, timeColFormat = '%Y-%m-%d %H:%M:%S')
#' instrument2 <- list(id = 'SWTWXSTATION', site = 'SWT', level = 'RAW',
#'                     rawFileParams = inst2rawFileParams)
#' startDate <- as.Date('2020-01-20')
#' endDate <- as.Date('2020-01-28')
#' variable <- 'Tair'
#' fileTimeRes <- '1min'
#' tickBreaks <- '1day'
#' dateLabelFormat <- '%j'
#' regData <- plotLUMARegressionData(instrument1, instrument2, startDate, endDate,
#'                                  variable, fileTimeRes, tickBreaks, dateLabelFormat)

plotLUMARegression <- function(instrument1, instrument2, startDate, endDate,
                               variable, fileTimeRes, DRIVE = NULL, tickBreaks = NA,
                               dateLabelFormat = NA){

  #get the required data and analysis
  varData <- getLUMARegressionData(instrument1, instrument2, startDate, endDate,
                               variable, fileTimeRes, DRIVE)
  #plot the data
  regressionPlot <- createRegressionPlot(varData, tickBreaks, dateLabelFormat)

  return(regressionPlot)
}
