makePlotListDF <- function(allData, tickBreaks, dateLabelFormat){
  plotList = list()
  for (i in 1:length(names(allData))){
    plotList[[i]] <- ggplot(data = allData) +
      geom_line(aes_string('TIME', names(allData)[i])) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))  +
      scale_x_datetime(date_breaks = tickBreaks, date_labels = dateLabelFormat) +
      xlab(paste('Time (', dateLabelFormat , ')'))
  }
  return(plotList)
}

makePlotListL <- function(allData, tickBreaks, dateLabelFormat){

  df <- allData[['data']]
  units <- allData[['units']]

  plotList = list()
  for (i in 1:length(names(df))){
    plotList[[i]] <- ggplot(data = df) +
      geom_line(aes_string('TIME', names(df)[i])) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))  +
      scale_x_datetime(date_breaks = tickBreaks, date_labels = dateLabelFormat) +
      xlab(paste('Time (', dateLabelFormat , ')')) +
      ylab(paste())
  }
  return(plotList)
}

getNoCols <- function(variables){
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
