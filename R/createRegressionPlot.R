#' Title
#'
#' @param varData_units
#' @param tickBreaks
#' @param dateLabelFormat
#'
#' @return
#' @export
#'
#' @examples
createRegressionPlot <- function(varData_units, tickBreaks = NA, dateLabelFormat = NA){

  require(ggplot2)
  require(cowplot)

  varNames <- setdiff(names(varData_units$data), 'TIME')
  variable <- varData_units$units[['variables']]

  ts <- createCompTS(varData_units, varNames, variable, tickBreaks, dateLabelFormat)
  scat <- scatterPlot(varData_units, varNames)

  finalRegPlot <- cowplot::plot_grid(scat, ts, nrow = 2, rel_heights = c(3,1))

  return(finalRegPlot)
}
