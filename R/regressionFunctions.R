getVarData <- function(instrument1, instrument2, startDate, endDate,
                       variable, fileTimeRes = NA, DRIVE){

  #extract the level of the instrument and remove from instrument list
  instrument1Lvl <- instrument1$level
  instrument1 <- instrument1[names(instrument1) != 'level']
  #if raw then we need sep, variableColNos ect
  if (instrument1Lvl == 'RAW'){
    checkRawFileParams(instrument1)
    instrument1Sep <- instrument1$rawFileParams$sep
    instrument1VCN <- instrument1$rawFileParams$variableColNos
    instrument1TCF <- instrument1$rawFileParams$timeColFormat
    if ('skipRows' %in% names(instrument1$rawFileParams)){
      instrument1SR <- instrument1$rawFileParams$skipRows
    } else {instrument1SR <- 0}
    instrument1 <- instrument1[names(instrument1) != 'rawFileParams']
  } else {
    #if not raw set these to NA
    instrument1Sep <- NA; instrument1VCN <- NA; instrument1TCF <- NA; instrument1SR <- 0
  }

  #do the same for second instrument
  instrument2Lvl <- instrument2$level
  instrument2 <- instrument2[names(instrument2) != 'level']

  if (instrument2Lvl == 'RAW'){
    checkRawFileParams(instrument2)
    instrument2Sep <- instrument2$rawFileParams$sep
    instrument2VCN <- instrument2$rawFileParams$variableColNos
    instrument2TCF <- instrument2$rawFileParams$timeColFormat
    if ('skipRows' %in% names(instrument2$rawFileParams)){
      instrument2SR <- instrument2$rawFileParams$skipRows
    } else {instrument2SR <- 0}
    instrument2 <- instrument2[names(instrument2) != 'rawFileParams']
  } else {
    instrument2Sep <- NA; instrument2VCN <- NA; instrument2TCF <- NA; instrument2SR <- 0
  }

  #get the data for both instruments
  instrument1dat <- getLUMAdata(instrument1, instrument1Lvl, startDate, endDate,
                                variable, fileTimeRes, instrument1Sep, instrument1VCN,
                                instrument1TCF, instrument1SR, DRIVE)

  instrument2dat <- getLUMAdata(instrument2, instrument2Lvl, startDate, endDate,
                                variable, fileTimeRes, instrument2Sep, instrument2VCN,
                                instrument2TCF, instrument2SR, DRIVE)

  #create names for columns.
  names(instrument1dat$data) <- setColNames(instrument1dat)
  names(instrument2dat$data) <- setColNames(instrument2dat)
  #merge the two dataframes
  varData = left_join(instrument1dat$data, instrument2dat$data, by = 'TIME')
  #add in units as list: assuming units are defo the same
  varData_units <- list(data = varData, units = instrument1dat$metadata$units)

  return(varData_units)
}

checkRawFileParams <- function(instrument){
  #check the rawFileParams look okay
  if(!('rawFileParams' %in% names(instrument))){
    stop('rawFileParams must be specified in instrument if level is raw')
  }

  if (any(!(c('sep', 'variableColNos', 'timeColFormat') %in% names(instrument$rawFileParams)))){
    stop('sep, variableColNos and timeColFormat must be specifed in instrument
         rawFileParams if level is RAW')
  }
}


setColNames <- function(instDat){
  # set column names so they can be identified when merged
  if ('ECpack' %in% names(instDat$metadata$instrument)){
    colName <- c('TIME', paste0(instDat$metadata$instrument$id , '_',
                                instDat$metadata$instrument$site ,
                                '_ECpack_', instDat$metadata$level))
  } else {
    colName <- c('TIME', paste0(paste0(instDat$metadata$instrument , collapse = '_'),
                                '_', instDat$metadata$level))
  }
  return(colName)
}

prepVarData <- function(varData_units){

  dataOnly <- na.omit(varData_units$data)
  # get maximum of var for both instrument for plotting purposes
  maxInst1 <- ceiling(max(dataOnly[2]))
  maxInst2 <- ceiling(max(dataOnly[3]))
  minInst1 <- floor(min(dataOnly[2]))
  minInst2 <- floor(min(dataOnly[3]))
  extremes <- matrix(c(maxInst1, maxInst2, minInst1, minInst2), nrow = 2, ncol = 2,
                     dimnames = list(c('inst1', 'inst2'), c('max', 'min')))
  # linear model
  linearMod <- lm(dataOnly[, 3] ~ dataOnly[, 2])
  names(linearMod$coefficients) <- c('Intercept', 'Gradient')
  intercept <- round(linearMod$coefficients[['Intercept']], 2)
  grad <- round(linearMod$coefficients[['Gradient']], 2)
  #get the correlation coeffient
  correlationCoef <- round(cor(dataOnly[, 2], dataOnly[, 3]), 2)
  # get number of points
  numb <- nrow(dataOnly)
  #get first and last date
  firstdate <- as.character(strftime(dataOnly$TIME[1], '%d-%m-%Y'))
  lastdate <- as.character(strftime(dataOnly$TIME[length(dataOnly$TIME)],
                                    '%d-%m-%Y'))
  dSpan <- paste(firstdate, '-', lastdate)
  #create the final product
  varData_units$analysis <- list(int = intercept, grad = grad, cor = correlationCoef,
                                 n = numb, max_min_rounded = extremes,
                                 dateSpan = dSpan)
  return(varData_units)
}

createCompTS <- function(varData_units, varNames, variable, tickBreaks, dateLabelFormat){
  #create time series of variable from two instruments
  # if altered xscale then create this
  xSca <- getXScale(tickBreaks, dateLabelFormat)
  # display dateLabelFormate on x axis if it's specified
  if(is.na(dateLabelFormat)){
    Xlabel <- 'Time'
  } else {
    Xlabel <- paste('Time (', dateLabelFormat , ')')
  }

  timeSeries <- ggplot(data = varData_units$data) +
    geom_line(aes_string('TIME', varNames[1], color = shQuote(varNames[1])), alpha = 0.75)+
    geom_line(aes_string('TIME', varNames[2], color = shQuote(varNames[2])), alpha = 0.75)+
    ylab(paste0(variable, ' (', varData_units$units[['units']], ')')) +
    xlab(Xlabel) + xSca +
    scale_colour_manual(name = 'Instrument', values = c('black', 'blue'))

  return(timeSeries)
}

getAxLims <- function(varData_units, inst){
  # if the minimum value is positive then set the axis limit to be zero, otherwise use min val
  if (varData_units$analysis$max_min_rounded[inst, 'min'] > 0){
    Xlimit <- c(0, varData_units$analysis$max_min_rounded[inst, 'max'] +
                  (varData_units$analysis$max_min_rounded[inst, 'max']*0.1))
  } else {
    Xlimit <- c(varData_units$analysis$max_min_rounded[inst, 'min'] -
                  (0.1 * varData_units$analysis$max_min_rounded[inst, 'min']),
                varData_units$analysis$max_min_rounded[inst, 'max'] +
                  (0.1*varData_units$analysis$max_min_rounded[inst, 'max']))
  }
}

scatterPlot <- function(varData_units, varNames){

  dataOnly <- na.omit(varData_units$data)
  #set the x and y limits of scatter plot as 10% above max val
  Xlimit <- getAxLims(varData_units, 'inst1')
  Ylimit <- getAxLims(varData_units, 'inst2')

  scat <- ggplot(data = dataOnly, aes_string(varNames[1], varNames[2])) +
    geom_point(alpha = 0.3, colour = 'black') +
    geom_abline(aes(colour = '1:1', slope = 1, intercept = 0)) +
    geom_abline(aes(colour = 'best fit', slope = varData_units$analysis$grad,
                    intercept = varData_units$analysis$int),
                linetype = 'dashed')+
    geom_smooth(method = 'lm', colour = 'darkred')+
    scale_colour_manual(values = c('darkgreen', 'darkred'), name = 'Lines') +
    xlim(Xlimit) + ylim(Ylimit) +
    ylab(varNames[2]) + xlab(varNames[1]) +
    labs(title = paste(variable, '(', varData_units$units[['units']], ')  ',
                       varData_units$analysis$dateSpan),
         subtitle = paste('corr:', round(varData_units$analysis$cor, 2),
                          'intercept:', varData_units$analysis$int,
                          'gradient:', varData_units$analysis$grad,
                          'n:', varData_units$analysis$n))
  return(scat)
}




