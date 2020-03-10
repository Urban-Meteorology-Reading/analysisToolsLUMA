#' Get LUMA data of a variable for two instruments or processing level, with some
#' parameters calculated. This can be used to create a regression plot.
#'
#' @param instrument1,instrument2 the first instruments to compare. These must be lists
#' containing at least id, site and level. id must be consistent with the LUMA metadata site.
#' ECpack is an optional name in the list. If level is RAW than rawFileParams must be included.
#' rawFileParams is a list containing the elements: sep, variableColNos, timeColFormat
#' and optionally skipRows. use ?getLUMAdata for more information on these.
#' @param startDate,endDate the time span to get data for. Must be class date
#' or POSIXct.
#' @param variable the variable to compare between instruments. Must be consistent with
#' LUMA metadata site.
#' @param fileTimeRes The file time resolution- this must be the same for each instrument.
#'
#' @return A list with three elements: $data containing a dataframe of variable from
#' each instrument between start and endDate, $units containing the variable units
#' as diplayed on the metadata website and $anaylsis which is where several regression
#' statistics are stored.
#' @export
#'
#' @examples
#' #for processed data
#' instrument1 <- list(id = 'DAVIS', site = 'IMU', level = 1)
#' #for raw data
#' inst2rawFileParams <- list(sep = ',', variableColNos = 2, timeColFormat = '%Y-%m-%d %H:%M:%S')
#' instrument2 <- list(id = 'SWTWXSTATION', site = 'SWT', level = 'RAW',
#'                     rawFileParams = inst2rawFileParams)
#' startDate <- as.Date('2020-01-20')
#' endDate <- as.Date('2020-01-28')
#' variable <- 'Tair'
#' fileTimeRes <- '1min'
#' regData <- getLUMARegressionData(instrument1, instrument2, startDate, endDate,
#'                                  variable, fileTimeRes)

getLUMARegressionData <- function(instrument1, instrument2, startDate, endDate,
                              variable, fileTimeRes = NA){

  #varData is a list containing a dataframe with the data for both instruments
  # and the units of the variable
  varData_units <- getVarData(instrument1, instrument2, startDate, endDate,
                        variable, fileTimeRes = NA)

  #do some analysis
  varData_units2 <- prepVarData(varData_units)

  return(varData_units2)
}
