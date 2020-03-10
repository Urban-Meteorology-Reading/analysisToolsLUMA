#' Plot data as a time series and scatter plot comparing a variable from
#' two instruments or processing level.
#'
#' @param varData_units list obtained using getLUMARegressionData(). see ?getLUMARegressionData
#' @param tickBreaks How often ticks should appear on time series plots. e.g. 6 hours.
#' See https://www.rdocumentation.org/packages/ggplot2/versions/1.0.0/topics/scale_x_datetime
#' date_breaks for valid options.
#' @param dateLabelFormat The format of date labels on time series plot
#' e.g. with Hour and Minute separated by : . See date_labels in link above for valid options.
#'
#' @return a scatter plot and time series of the variable.
#' @export
#'
#' @examples
createRegressionPlot <- function(varData_units, tickBreaks = NA, dateLabelFormat = NA){

  require(ggplot2)
  require(cowplot)
  #select variable names and units
  varNames <- setdiff(names(varData_units$data), 'TIME')
  variable <- varData_units$units[['variables']]
  # make a time series comparing the two instruments
  ts <- createCompTS(varData_units, varNames, variable, tickBreaks, dateLabelFormat)
  #make a scatter plot
  scat <- scatterPlot(varData_units, varNames)
  # merge two plots
  finalRegPlot <- cowplot::plot_grid(scat, ts, nrow = 2, rel_heights = c(3,1))

  return(finalRegPlot)
}
