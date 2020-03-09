#' Plot raw or processed LUMA data for multiple variables.
#'
#' @param instrument A list containing the instrument name an site in the form
#' list(id = "INSTID", site = "SITENAME"). INSTID and SITENAME should be
#' consistent with the LUMA metadata system. 'ECpack' can also be included with
#' a boolean.
#' @param level The quality level of the data. Either "RAW" or an integer.
#' @param startDate,endDate Start and end date of plot. Should be of class date.
#' @param variables A string or vector of strings of the variables to plot.
#' These must be consisted with variables on LUMA metadata website.
#' @param tickBreaks How often ticks should appear on plots. e.g. 6 hours.
#' See https://www.rdocumentation.org/packages/ggplot2/versions/1.0.0/topics/scale_x_datetime
#' date_breaks for valid options.
#' @param dateLabelFormat The format of date labels e.g. %H:%M to have time labels
#' with Hour and Minute separated by : . See date_labels in link above for valid
#' options.
#' @param fileTimeRes Time resolution of file this should be consistent with file
#' names on the cluster e.g. 1min. Only needed when level is not RAW.
#' @param sep If data is RAW then what is data separated by e.g. ','.
#' @param variableColNos If data is RAW then a vector of the position of the variable
#' to be plotted.
#' @param timeColFormat The format of time columns. A string or vector of strings
#' if multiple time columns.
#' @param skipRows How many rows to skip when reading raw file. Default is none.
#' @param title The title of the plot. If not specified then a default will be
#' generated based on information given.
#' @param SAVEplot Boolean whether to save the plot.
#' @param SAVEname The name of the plot if SAVEplot = TRUE
#' @param SAVEpath The path to folder in which plot should be saved. Leave as null
#' to save in current working directory.
#' @param SAVEsize The size the save the image. This is a 3D vector consisting of
#' h (height), w (width) and unit. See https://ggplot2.tidyverse.org/reference/ggsave.html
#' for valid units.
#'
#' @return A plot of the of the variables for the instrument specifed between
#' startDate and endDate. Optionally, it will save this plot.
#'
#' @export
#'
#' @examples
#' #plot a from RAW data
#' # set up arguments
#' instrument <- list(id = 'SWTWXSTATION',  site = 'SWT')
#' level <- 'RAW'
#' startDate = as.Date('2020-030', format = '%Y-%j')
#' endDate = as.Date('2020-031', format = '%Y-%j')
#' fileTimeRes = '1min'
#' variables = c('Tair', 'dir', 'RH')
#' tickBreaks <- '6 hours'
#' dateLabelFormat <- '%j %H:%M'
#' sep <- ','
#' variableColNos <- c(2, 9, 10)
#' timeColFormat <- '%Y-%m-%d %H:%M:%S'
#' #create the plot
#' RAWplot <- plotData(instrument, level, startDate, endDate, fileTimeRes, variables,
#'              tickBreaks, dateLabelFormat, sep, variableColNos, timeColFormat)
#'
#' #plot processed netcdf data and save it automatically, manually specifying the title
#' level = 1
#' title = 'A plot of level 1 processed data'
#' SAVEname = 'Level1.png'
#' SAVEpath = 'imgs'
#' SAVEsize = c(h = 7.23, w = 7.56, unit = 'in'
#' #this will save plot in imgs folder with a height and width of 7.23 and 7.56 inches, repsectively
#' L1plot <- plotData(instrument, level, startDate, endDate, fileTimeRes, variables,
#'               tickBreaks, dateLabelFormat, title = title, SAVEplot = TRUE,
#'               SAVEname = SAVEname, SAVEpath = SAVEpath,
#'               SAVEsize = SAVEsize)

plotLUMAdata <- function(instrument, level, startDate, endDate, variables,
                   fileTimeRes = NA,  sep = NA, variableColNos = NA,
                   timeColFormat = NA, skipRows = 0, tickBreaks = NA,
                   dateLabelFormat = NA,title = NA, SAVEplot = FALSE,
                   SAVEname = NA, SAVEpath = NULL, SAVEsize = NA){

  #check the save parameters at start to prevent wasting time
  if (SAVEplot == TRUE){
      checkSaveParams(SAVEname, SAVEsize)
  }

  # get the data
  allData <- getLUMAdata(instrument, level, startDate, endDate, variables, fileTimeRes,
                    sep, variableColNos, timeColFormat, skipRows)

  # plot the data
  finalPlot <- plotTimeSeries(allData, tickBreaks, dateLabelFormat, title, SAVEplot, SAVEname, SAVEpath,
                          SAVEsize)

  return(finalPlot)
}
