makePlotListDF <- function(allData, tickBreaks, dateLabelFormat){
  #get the vars to plot
  plotVars <- names(allData)[names(allData) != 'TIME']
  #add plots of every variable to a plot list
  plotList = list()
  for (i in 1:length(plotVars)){
    plotList[[i]] <- ggplot(data = allData) +
      geom_line(aes_string('TIME', plotVars[i])) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))  +
      scale_x_datetime(date_breaks = tickBreaks, date_labels = dateLabelFormat) +
      xlab(paste('Time (', dateLabelFormat , ')'))
  }
  return(plotList)
}

makePlotListL <- function(allData, tickBreaks, dateLabelFormat){
  #separate data and units
  df <- allData[['data']]
  units <- allData[['units']]
  # get the variables that are going to be plot
  plotVars <- names(df)[names(df) != 'TIME']
  #add plots of every variable to a plot list
  plotList = list()
  for (i in 1:length(plotVars)){
    varUnit <- units[units[, 'variables'] == plotVars[i], 'units']
    plotList[[i]] <- ggplot(data = df) +
      geom_line(aes_string('TIME', plotVars[i])) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))  +
      scale_x_datetime(date_breaks = tickBreaks, date_labels = dateLabelFormat) +
      xlab(paste('Time (', dateLabelFormat , ')')) +
      ylab(paste(plotVars[i], '(', varUnit, ')'))
  }
  return(plotList)
}

getNoCols <- function(variables){
  # get the number of columns in grid plot just via the number of variables
  if (length(variables) <= 2 ){
    nc <- 1
  } else if (length(variables) > 2 &  length(variables) <= 6){
    nc <- 2
  } else if (length(variables) > 6){
    nc <- 3
  }
  return(nc)
}

makeTitle <- function(instrument, fileTimeRes, startDate, endDate){
  # construct a default title
  title <- paste(instrument$id, '|', instrument$site, '|', instrument$level,
                 '|', fileTimeRes, '|', as.character(startDate),
                 '-', as.character(endDate))
  return(title)
}
