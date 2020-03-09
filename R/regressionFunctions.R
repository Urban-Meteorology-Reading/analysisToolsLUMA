createCompTS <- function(varData_units, varNames, variable, tickBreaks, dateLabelFormat){
  # if altered xscale then create this
  xSca <- getXScale(tickBreaks, dateLabelFormat)
  # display dateLabelFormate on x axis if it's specified
  if(is.na(dateLabelFormat)){
    Xlabel <- 'Time'
  } else {
    Xlabel <- paste('Time (', dateLabelFormat , ')')
  }

  timeSeries <- ggplot(data = varData_units$data) +
    geom_line(aes_string('TIME', varNames[1], color = shQuote(varNames[1])))+
    geom_line(aes_string('TIME', varNames[2], color = shQuote(varNames[2])))+
    ylab(paste0(variable, ' (', varData_units$units[['units']], ')')) +
    xlab(Xlabel) + xSca +
    scale_colour_manual(name = 'Instrument', values = c('red', 'blue'))

  return(timeSeries)
}

scatterPlot <- function(varData_units, varNames){

  #set the x and y limits of scatter plot as 10% above max val
  Xlimit <- c(0, varData_units$analysis$max_min_rounded['inst1', 'max'] +
                (varData_units$analysis$max_min_rounded['inst1', 'max']*0.1))

  Ylimit <- c(0, varData_units$analysis$max_min_rounded['inst2', 'max'] +
                (varData_units$analysis$max_min_rounded['inst2', 'max']*0.1))

  scat <- ggplot(data = varData_units$data, aes_string(varNames[1], varNames[2])) +
    geom_point(alpha = 0.3, colour = 'black') +
    geom_abline(aes(colour = '1:1', slope = 1, intercept = 0)) +
    geom_abline(aes(colour = 'best fit', slope = varData_units$analysis$grad,
                    intercept = varData_units$analysis$int),
                linetype = 'dashed')+
    geom_smooth(method = 'lm', colour = 'black')+
    scale_colour_manual(values = c('green', 'black'), name = 'Lines') +
    xlim(Xlimit) + ylim(Ylimit) +
    ylab(varNames[1]) + xlab(varNames[2]) +
    labs(title = paste(variable, '   ', varData_units$analysis$dateSpan),
         subtitle = paste('corr:', round(varData_units$analysis$cor, 2),
                          'intercept:', varData_units$analysis$int,
                          'gradient:', varData_units$analysis$grad,
                          'n:', varData_units$analysis$n))
  return(scat)
}

prepVarData <- function(varData_units){

  # get maximum of var for both instrument for plotting purposes
  maxInst1 <- ceiling(max(varData_units$data[2]))
  maxInst2 <- ceiling(max(varData_units$data[3]))
  minInst1 <- floor(min(varData_units$data[2]))
  minInst2 <- floor(min(varData_units$data[3]))
  extremes <- matrix(c(maxInst1, maxInst2, minInst1, minInst2), nrow = 2, ncol = 2,
                     dimnames = list(c('inst1', 'inst2'), c('max', 'min')))
  # linear model
  linearMod <- lm(varData_units$data[, 3] ~ varData_units$data[, 2])
  names(linearMod$coefficients) <- c('Intercept', 'Gradient')
  intercept <- round(linearMod$coefficients[['Intercept']], 2)
  grad <- round(linearMod$coefficients[['Gradient']], 2)
  #get the correlation coeffient
  correlationCoef <- round(cor(varData_units$data[, 2], varData_units$data[, 3]), 2)
  # get number of points
  numb <- nrow(varData_units$data)
  #get first and last date
  firstdate <- as.character(strftime(varData_units$data$TIME[1], '%d-%m-%Y'))
  lastdate <- as.character(strftime(varData_units$data$TIME[length(varData_units$data$TIME)],
                                    '%d-%m-%Y'))
  dSpan <- paste(firstdate, '-', lastdate)
  #create the final product
  varData_units$analysis <- list(int = intercept, grad = grad, cor = correlationCoef,
                                 n = numb, max_min_rounded = extremes,
                                 dateSpan = dSpan)

  return(varData_units)
}


