createDateList <- function(startDate, endDate){
  # get a vector of all dates to get data for
  dateList <- seq(startDate, endDate, by = 'day')
  return(dateList)
}

getFileRes <- function(fileTimeRes){
  #get the file res as a number and a unit
  fileResList = list()
  fileResList[['Res']] <- readr::parse_number(fileTimeRes)
  fileResList[['Unit']] <- str_remove(fileTimeRes, as.character(fileResList[['Res']]))
  # check if it's one of the valid units
  if (fileResList$Unit != 'Min' &  fileResList$Unit != 'Sec' &
      fileResList$Unit != 'Hz'){
    stop(paste('Invalid fileTimeRes unit:', fileResList$Unit, 'valid units are: "Min", "Sec" and "Hz"'))
  }
  return(fileResList)
}
