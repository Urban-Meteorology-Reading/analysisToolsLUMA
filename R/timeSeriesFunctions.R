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

getNoCols <- function(nVariables){
  # get the number of columns in grid plot just via the number of variables
  if (nVariables <= 3 ){
    nc <- 1
  } else if (nVariables > 3 &  nVariables <= 6){
    nc <- 2
  } else if (nVariables > 6){
    nc <- 3
  }
  return(nc)
}

makeTitle <- function(level, instrument, fileTimeRes, startDate, endDate){
  # paste L with level number
  if (level == 'RAW'){
    lev <- level
  } else { lev <- paste0('L', level)}

  # construct a default title
  title <- paste(instrument$id, '|', instrument$site, '|', lev,
                 '|', fileTimeRes, '|', as.character(startDate),
                 '-', as.character(endDate))
  return(title)
}

savePlot <- function(SAVEpath, SAVEname, finalPlot, SAVEsize){
  #save a plot
  print(paste('Saving plot as', SAVEname))

  #create the directory in save path i
  if (!is.null(SAVEpath) & !dir.exists(SAVEpath)){
    dir.create(SAVEpath, recursive = TRUE)
  }
  #if size not specified use the default
  if (all(is.na(SAVEsize))){
    ggsave(SAVEname, finalPlot)
  #otherwise make it savesize
  } else {
    ggsave(SAVEname, finalPlot, path = SAVEpath,
           width = as.numeric(SAVEsize[['w']]),
           height = as.numeric(SAVEsize[['h']]),
           units = SAVEsize[['unit']])}
}
