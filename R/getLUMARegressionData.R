#' Get LUMA data that can be used
#'
#' @param instrument1,instrument2 the first instruments to compare. These must be lists
#' containing at least id, site and level. ECpack is an optional name in the list. id
#' must be consistent with the LUMA metadata site.
#' @param startDate,endDate the time span to get data for. Must be class date
#' or POSIXct.
#' @param variable the variable to compare the instruments. Must be consistent with
#' LUMA metadata site.
#' @param fileTimeRes The file time resolution- this must be the same for each instrument.
#'
#' @return
#' @export
#'
#' @examples
getLUMARegressionData <- function(instrument1, instrument2, startDate, endDate,
                              variable, fileTimeRes){

  instrument1Lvl <- instrument1$level
  instrument1 <- instrument1[names(instrument1) != 'level']

  instrument2Lvl <- instrument2$level
  instrument2 <- instrument2[names(instrument2) != 'level']


  instrument1dat <- getLUMAdata(instrument1, instrument1Lvl, startDate, endDate,
                                variable, fileTimeRes)

  instrument2dat <- getLUMAdata(instrument2, instrument2Lvl, startDate, endDate,
                                variable, fileTimeRes)

  #create names for columns.
  # if ecpack add in to name
  names(instrument1dat$data) <- c('TIME', paste0(paste0(instrument2dat$metadata$instrument , collapse = '_'),
                                          '_', instrument2dat$metadata$level))
  names(instrument2dat$data) <- c('TIME', paste0(paste0(instrument1dat$metadata$instrument , collapse = '_'),
                                          '_', instrument1dat$metadata$level))
  #merge the two dataframes
  varData = left_join(instrument1dat$data, instrument2dat$data, by = 'TIME')

  #get rid of any NAs
  varData <- na.omit(varData)
  #add in units as list: assuming units are defo the same
  varData_units <- list(data = varData, units = instrument1dat$metadata$units)
  #do some analysis
  varData_units2 <- prepVarData(varData_units)

  return(varData_units2)
}
