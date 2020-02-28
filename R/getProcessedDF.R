getProcessedDF <- function(instrument, level, startDate, endDate, fileTimeRes,
                           variables){
  require(ncdf4)
  require(stringr)
  require(dplyr)
  source(Sys.getenv('MM_LUMAfun'))

  # check file Time res is specified
  if (is.na(fileTimeRes)){
    stop('Please specify fileTimeRes')
  }

  #if only a serial number is supplied then get site and id
  instrument <- checkSerialInfo(instrument, startDate)

  print(paste('Creating dataframe of', paste(variables, collapse = ', '),
              'for', instrument$id, 'at site', instrument$site, 'for level',
              level, 'at time resolution', fileTimeRes, 'between',
              as.character(startDate), 'and', as.character(endDate)))

  #create a list of dates to be run
  dateList <- createDateList(startDate, endDate)
  # separate the resolution and unit of file res
  fileResList <- getFileRes(fileTimeRes)
  #get the output definitions ( assume start and end have same out defs to save
  # putting in a loop)
  instOutDef <- getInstOutDef(instrument, level, startDate, fileTimeRes)
  # get the variable units as a data frame
  varUnits <- getVarUnits(instOutDef, variables)
  #get the file prefix
  filePre <- instOutDef$filePrefix
  # define the base dir
  dataDirForm <- file.path(Sys.getenv('MM_DAILYDATA'), 'data', '%Y', '%CITY',
                           '%LEVEL', '%SITE', 'DAY', '%j')
  # read in the data and put into a list
  varDataList <- getNCDFData(dateList, instrument, level, dataDirForm,
                          instOutDef, filePre, fileTimeRes, fileResList,
                          variables)
  #bind list elements
  allDataDf <- do.call(rbind, varDataList)
  allDataDf <- allDataDf[is.na(allDataDf['TIME']) == FALSE, ]

  #add units to data
  allData <- list(data = allDataDf, units = varUnits)

  return(allData)
}







