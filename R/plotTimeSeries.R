#' Create a time series from a dataframe or output equivalent to that from getLUMAdata.
#'
#' @param allData The data to plot in the form output by getLUMAdata().
#' @param tickBreaks How often ticks should appear on plots. e.g. 6 hours.
#' See https://www.rdocumentation.org/packages/ggplot2/versions/1.0.0/topics/scale_x_datetime
#' date_breaks for valid options.
#' @param dateLabelFormat The format of date labels e.g. %H:%M to have time labels
#' with Hour and Minute separated by : . See date_labels in link above for valid
#' options.
#' @param title The title of the plot. If not specified then a default will be
#' generated based on information given.
#' @param SAVEplot Boolean whether to save the plot.
#' @param SAVEname The name of the plot if SAVEplot = TRUE
#' @param SAVEpath The path to folder in which plot should be saved. Leave as null
#' to save in current working directory.
#' @param SAVEsize The size the save the image. This is a 3D vector consisting of
#' h (height), w (width) and unit. See https://ggplot2.tidyverse.org/reference/ggsave.html
#' for valid units.
#'
#' @return A time series for each variable.
#' @export
#'
#' @examples

plotTimeSeries <- function(allData, tickBreaks = NA, dateLabelFormat = NA, title = NA,
                     SAVEplot = FALSE, SAVEname = NA, SAVEpath = NULL,
                     SAVEsize = NA){

  require(ggplot2)
  require(cowplot)

  print('Plotting data...')

  if (SAVEplot == TRUE){
     checkSaveParams(SAVEname, SAVEsize)
  }

  if (class(allData) != 'list') {
    stop(paste('Invalid class:', class(allData), '. allData must be class "list"'))
  }

  plotList <- makePlotList(allData, tickBreaks, dateLabelFormat)

  # the number of columns in the grid_plot
  nc <- getNoCols(length(names(allData$data))-1)
  # get a grid plot of plotlist
  plotsGrid <- plot_grid(plotlist = plotList, ncol = nc)

  # get the start and end date from data frame
  startDate <- as.character(strftime(allData$data$TIME[[1]], '%Y-%m-%d'))
  endDate <- as.character(strftime(as.Date(allData$data$TIME[[length(allData$data$TIME)]]), '%Y-%m-%d'))

  # get the relative heights -> the title should be much smaller than the plots
  relH <- c(0.1, rep(1, nc))
  # make a title if one isn't specified
  if (is.na(title)) {
    title <- chooseTitle(allData$metadata, startDate, endDate)
  }

  # create the users specified title
  gridTitle <- ggdraw() + draw_label(title)
  # final plot includes the plot title
  finalPlot <- plot_grid(gridTitle, plotsGrid, ncol = 1, rel_heights = relH)
  #save the final plot if specified
  if (SAVEplot == TRUE){
    savePlot(SAVEpath, SAVEname, finalPlot, SAVEsize)
  }

  print('Finished')

  return(finalPlot)
}


