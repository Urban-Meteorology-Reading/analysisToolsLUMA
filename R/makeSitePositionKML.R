makeSitePositionKML <- function(instrumentID, layerName, DATE = Sys.Date(), outDir = getwd()){
  require(rgdal)
  source(Sys.getenv('MM_LUMAfun'))
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
