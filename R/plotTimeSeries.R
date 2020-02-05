makeTSGrid <- function(allData, tickBreaks, dateLabelFormat,
                       title = NA, SAVEplot = FALSE, SAVEname = NA){

  if(is.list(allData)){
    #plotList is a list containing a time series for every variable
    plotList <- makePlotListL(allData, tickBreaks, dateLabelFormat)
  } else {
    #plotList is a list containing a time series for every variable
    plotList <- makePlotListDF(allData, tickBreaks, dateLabelFormat)
  }


  # the number of columns in the grid_plot
  nc <- getNoCols(variables)
  # get a grid plot of plotlist
  plotsGrid <- plot_grid(plotlist = plotList, ncol = nc)
  # get the relative heights -> the title should be much smaller than the plots
  relH <- c(0.1, rep(1, nc))
  if (is.na(title) ){
    title <- makeTitle(instrument, fileTimeRes, startDate, endDate)
  }
  # create the users specified title
  gridTitle <- ggdraw() + draw_label(title)
  # final plot includes the plot title
  finalPlot <- plot_grid(gridTitle, plotsGrid, ncol = 1, rel_heights = relH)
  #save the final plot if specified
  if (SAVEplot == TRUE){
    ggsave(SAVEname, finalPlot)
  }

  return(finalPlot)
}


