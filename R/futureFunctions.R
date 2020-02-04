#not needed yet
getBaseDir <- function(level){
  if(level == 'RAW'){
    dataDir <- file.path(Sys.getenv('MM_DAILYDATA'), 'RAW', '%Y', 'London',
                         '%SITE', '%INSTRUMENT', '%m')
  }
  return(dataDir)
}

createReplacementVec <- function(DATE, instrument, replacementVec){
  #the placeholders in the path need to be replaced with actual information
  replacementVec <- c(replacementVec, '%Y' = strftime(DATE, '%Y'))
  replacementVec <- c(replacementVec, '%j' = strftime(DATE, '%j'))
  replacementVec <- c(replacementVec, '%d' = strftime(DATE, '%d'))
  replacementVec <- c(replacementVec, '%m' = strftime(DATE, '%m'))

  #replacementVec <- c(replacementVec, '%INSTRUMENT' = instrument$name)
  replacementVec <- c(replacementVec, '%SITE' = instrument$site)

  return(replacementVec)
}

replaceDataDir <- function(x, instrument){
  # replce the placeholders in dataDir
  if (grepl('%INSTRUMENT', x)) {
    xSplit <- strsplit(x, '/|\\|')[[1]]
    xSplit <- xSplit[xSplit != ""]
    siteFolders <- list.files(paste0(c('/', xSplit[1:which(xSplit == '%INSTRUMENT') - 1]),
                                     collapse = '/'))
    instFolder <- siteFolders[grepl(instrument$name, siteFolders)]
    dataDir2 <- paste0(c('/', replace(xSplit, xSplit== '%INSTRUMENT', instFolder )),
                       collapse = '/')
    return(dataDir2)
  } else {return(x)}
}

#### for non standard file dir
dunno<- function(){
  replacementVec <- c()
  replacementVec <- createReplacementVec(dateList[idate], instrument, replacementVec)
  replDir[[idate]] <- stringr::str_replace_all(dataDir, replacementVec)
  # replace instrument placeholders -> in many cases the directory will be the same
  # day to day
  newDataDirs <- unique(lapply(replDir, function(x){getDataDir(x, instrument)}))
  fVec <- list.files(newDataDirs[[1]])
  grepl(strftime(dateList[1], '%j'), fVec)
}
