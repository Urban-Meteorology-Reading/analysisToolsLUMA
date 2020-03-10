#' Extract raw or processed LUMA data from the RACC.
#'
#' @param instrument A list containing the instrument name an site in the form
#' list(id = "INSTID", site = "SITENAME"). INSTID and SITENAME should be
#' consistent with the LUMA metadata system. Alternitavely you can use the serial
#' number by list(serial = "serialNo").
#' @param level The quality level of the data. Either "RAW" or an integer.
#' @param startDate,endDate Start and end date to extract. Should be of class date.
#' @param variables A string or vector of strings of the variables to plot.
#' These must be consisted with variables on LUMA metadata website.
#' @param tickBreaks How often ticks should appear on plots. e.g. 6 hours.
#' See https://www.rdocumentation.org/packages/ggplot2/versions/1.0.0/topics/scale_x_datetime
#' date_breaks for valid options.
#' @param dateLabelFormat The format of date labels e.g. %H:%M to have time labels
#' with Hour and Minute separated by : . See date_labels in link above for valid
#' options.
#' @param fileTimeRes Time resolution of file. This should be consistent with file
#' names on the cluster e.g. 1min. Only needed when level is not RAW.
#' @param sep If data is RAW then what is data separated by e.g. ','.
#' @param variableColNos If data is RAW then a vector of the position of the variable
#' to be plotted.
#' @param timeColFormat The format of time columns. A string or vector of strings
#' if multiple time columns.
#' @param skipRows How many rows to skip when reading raw file. Default is none.
#'
#' @return A list of containing the requested data and the variable units.
#' @export
#'
#' @examples
#' #get a RAW data
#' # set up arguments
#' instrument <- list(id = 'SWTWXSTATION',  site = 'SWT')
#' level <- 'RAW'
#' startDate = as.Date('2020-030', format = '%Y-%j')
#' endDate = as.Date('2020-031', format = '%Y-%j')
#' variables = c('Tair', 'dir', 'RH')
#' sep <- ','
#' variableColNos <- c(2, 9, 10)
#' timeColFormat <- '%Y-%m-%d %H:%M:%S'
#' #create the plot
#' RAWdata <- getLUMAdata(instrument, level, startDate, endDate, variables,
#'                    sep = sep, variableColNos = variableColNos, dateLabelFormat = dateLabelFormat)
#'
#' #processed data requires a fileTimeRes
#' level <- 1
#' fileTimeRes <- '15min'
#' L1data <- getLUMAdata(instrument, level, startDate, endDate, variables, fileTimeRes)

getLUMAdata <- function(instrument, level, startDate, endDate, variables, fileTimeRes = NA,
                   sep = NA, variableColNos = NA, timeColFormat = NA, skipRows = 0){

  require(stringr)
  require(dplyr)
  require(tidyr)
  require(lubridate)
  require(purrr)
  source(Sys.getenv('MM_LUMAfun'))

  # check instrument and dates are valid
  checkInputs(instrument, startDate, endDate)

  if (level == 'RAW'){
    #check all valid variables are inputted if level = RAW
    if(any(is.na(c(sep, variableColNos, timeColFormat)))){
      stop('Args sep, variableColNos and timeColFormat must be
           specifed if level = RAW' )
    #get a raw dataframe
    } else { allData <- getRawData(instrument, level, startDate, endDate, fileTimeRes,
                                 sep, variableColNos, variables,
                                 timeColFormat, skipRows)}
  # otherwise read processed data
  } else {allData <- getProcessedData(instrument, level, startDate, endDate,
                                    fileTimeRes, variables)}

  return(allData)
}
