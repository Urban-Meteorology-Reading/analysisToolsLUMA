makePlotList <- function(allData, tickBreaks, dateLabelFormat){
  #separate data and units
  df <- allData[['data']]
  units <- allData[['metadata']][['units']]
  # get the variables that are going to be plot
  plotVars <- names(df)[names(df) != 'TIME']
  #make x scale
  xSca <- getXScale(tickBreaks, dateLabelFormat)
  # display dateLabelFormate on x axis if it's specified
  if(is.na(dateLabelFormat)){
    Xlabel <- 'Time'
  } else {
    Xlabel <- paste('Time (', dateLabelFormat , ')')
  }

  #add plots of every variable to a plot list
  plotList = list()
  for (i in 1:length(plotVars)){
    varUnit <- units[units[, 'variables'] == plotVars[i], 'units']
    plotList[[i]] <- ggplot(data = df) +
      geom_line(aes_string('TIME', plotVars[i])) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))  +
      xlab(Xlabel) +
      ylab(paste(plotVars[i], '(', varUnit, ')')) + xSca
  }
  return(plotList)
}

getXScale <- function(tickBreaks, dateLabelFormat){
  #depending on the info provided, make a scale for x axis
  if (all(!is.na(c(tickBreaks, dateLabelFormat)))){
    xSca <- scale_x_datetime(date_breaks = tickBreaks, date_labels = dateLabelFormat)
  } else if (is.na(tickBreaks) && !is.na(dateLabelFormat)){
    xSca <- scale_x_datetime(date_labels = dateLabelFormat)
  } else if (!is.na(tickBreaks) && is.na(dateLabelFormat)){
    xSca <- scale_x_datetime(date_breaks = tickBreaks)
  } else { xSca <- NULL }

  return(xSca)
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

chooseTitle <- function(meta, startDate, endDate){
  lvl <- meta$level
  inst <- meta$instrument
  fileTRes <- meta$fileTimeRes

  if (any(is.na(c(lvl, inst, fileTRes)))){
    title <- paste(startDate, '-', endDate)
  } else {title <- makeTitle(lvl, inst, fileTRes, startDate, endDate)}

  return(title)
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

  # create a default name
  if (is.na(SAVEname)){
    SAVEname <- 'variableTimeSeries.png'
  }

  #if size not specified use the default
  if (all(is.na(SAVEsize))){
    ggsave(SAVEname, finalPlot, path = SAVEpath)
  #otherwise make it savesize
  } else {
    ggsave(SAVEname, finalPlot, path = SAVEpath,
           width = as.numeric(SAVEsize[['w']]),
           height = as.numeric(SAVEsize[['h']]),
           units = SAVEsize[['unit']])}
}


