#' Create a kml file displaying the locations of an instrument at a given date.
#'
#' @param instrumentID instrument id that must be consistent with LUMA metadata site.
#' @param layerName the name of the output file.
#' @param DATE the date to use. Must be class 'Date'.
#' @param outDir the directory to save the kml file.
#'
#' @return A kml file that can be viewed in google earth.
#' @export
#'
#' @examples
#' makeSitePositionKML('CL31', 'ceilometerPositions', as.Date('2020-10-03'), 'ceilkml')

makeSitePositionKML <- function(instrumentID, layerName, DATE = Sys.Date(), outDir = getwd()){
  require(rgdal)
  require(LUMA)

  #get the Tinfo
  Tinfo <- lf_Tinfo(DATE)
  #find the instruments running on that day
  print(paste('Finding locations of', instrumentID, 'for date', as.character(DATE)))
  insts <- lf_serialsRunningToday(instrumentId = instrumentID, Tinfo = Tinfo)
  # get site positions
  print(paste('Getting site locations for', paste(insts[['siteId']], collapse =' ')))
  instSitePos <- lf_getSitePositions(insts[['siteId']])
  # reorder lat and lon columns
  instSitePos <- instSitePos[,c('Longitude', 'Latitude')]
  # format site names for data
  siteNames <- data.frame(siteName = rownames(instSitePos))
  # get into spatial points class
  instSitePosSP <- SpatialPointsDataFrame(instSitePos, siteNames, proj4string = CRS('+proj=longlat +datum=WGS84'))
  #write kml file
  writeOGR(instSitePosSP,  paste0(outDir, '/', layerName, '.kml'), layerName, driver = 'KML')
}
