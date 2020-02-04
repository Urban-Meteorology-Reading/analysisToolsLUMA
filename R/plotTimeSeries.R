makeTSGrid <- function(allData, variables, tickBreaks, dateLabelFormat,
                       title){
  plotList = list()
  for (i in 1:length(variables)){
    plotList[[i]] <- ggplot(data = allData) +
      geom_line(aes_string('TIME', variables[i])) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))  +
      scale_x_datetime(date_breaks = tickBreaks, date_labels = dateLabelFormat) +
      xlab(paste('Time (', dateLabelFormat , ')'))
  }

  if (length(variables) <= 2 ){
    nc <- 1
  } else if (length(variables) > 2 &  length(variables) <= 6){
    nc <- 2
  } else if (length(variables) > 6){
    nc <- 3
  }

  plotsGrid <- plot_grid(plotlist = plotList, ncol = nc)

  relH <- c(0.1, rep(1, nc))

  gridTitle <- ggdraw() + draw_label(title)
  finalPlot <- plot_grid(gridTitle, plotsGrid, ncol = 1, rel_heights = relH)

  if (SAVEplot == TRUE){
    ggsave(SAVEname, finalPlot)
  }
}


