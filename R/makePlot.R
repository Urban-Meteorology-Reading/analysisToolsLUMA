makePlot <- function(allData, tickBreaks, dateLabelFormat, lvl = NA,
                     inst = NA, fileTRes = NA, title = NA,
                     SAVEplot = FALSE, SAVEname = NA, SAVEpath = NULL,
                     SAVEsize = NA){

  require(ggplot2)
  require(cowplot)

  print('Plotting data...')

  #plotList is a list containing a time series for every variable
  if(class(allData) == 'data.frame'){
    #if dataframe then no units will be on plot
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
  startDate <- as.character(allData$data$TIME[[1]])
  endDate <- as.character(as.Date(allData$data$TIME[[length(allData$data$TIME)]]))

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


