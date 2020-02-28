#' Create a time series from a dataframe or output equivalent to that from getLUMAdata.
#'
#' @param allData
#' @param tickBreaks
#' @param dateLabelFormat
#' @param lvl
#' @param inst
#' @param fileTRes
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
#' @return
#' @export
#'
#' @examples
plotTimeSeries <- function(allData, tickBreaks, dateLabelFormat, lvl = NA,
                     inst = NA, fileTRes = NA, title = NA,
                     SAVEplot = FALSE, SAVEname = NA, SAVEpath = NULL,
                     SAVEsize = NA){

  require(ggplot2)
  require(cowplot)

  print('Plotting data...')

  #plotList is a list containing a time series for every variable
  if(class(allData) == 'data.frame'){
    #if dataframe: then no units will be on plot
    plotList <- makePlotListDF(allData, tickBreaks, dateLabelFormat)
  } else if (class(allData) == 'list'){
    plotList <- makePlotListL(allData, tickBreaks, dateLabelFormat)
  } else {
    stop(paste('Invalid class:', class(allData), '. allData must be either class "list" or "data.frame"'))
  }

  # the number of columns in the grid_plot
  nc <- getNoCols(length(names(allData$data))-1)
  # get a grid plot of plotlist
  plotsGrid <- plot_grid(plotlist = plotList, ncol = nc)

  # get the start and end date from data frame
  startDate <- as.character(strftime(allData$data$TIME[[1]], '%Y-%m-%d'))
  endDate <- as.character(strftime(as.Date(allData$data$TIME[[length(allData$data$TIME)]]), '%Y-%m-%d'))

  # get the relative heights -> the title should be much smaller than the plots
  relH <- c(0.1, rep(1, nc))
  if (is.na(title)) {
    if (any(is.na(c(lvl, inst, fileTRes)))){
        title <- paste(startDate, '-', endDate)
    } else {title <- makeTitle(lvl, inst, fileTRes, startDate, endDate)}
  }

  # create the users specified title
  gridTitle <- ggdraw() + draw_label(title)
  # final plot includes the plot title
  finalPlot <- plot_grid(gridTitle, plotsGrid, ncol = 1, rel_heights = relH)
  #save the final plot if specified
  if (SAVEplot == TRUE){
    savePlot(SAVEpath, SAVEname, finalPlot, SAVEsize)
  }

  return(finalPlot)
}


