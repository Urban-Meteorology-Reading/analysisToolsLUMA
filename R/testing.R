# initial settings
sep <- ','

startDate = as.Date('2020-030', format = '%Y-%j')
endDate = as.Date('2020-031', format = '%Y-%j')

fileTimeRes = '1min'
variables = c('Tair', 'dir', 'RH')
variableColNos <- c(2, 9, 10)
nTimeCols <- 1
timeColFormat <- '%Y-%m-%d %H:%M:%S'
level = 1

tickBreaks <- '6 hours'
dateLabelFormat <- '%j %H:%M'

# instrument -> name, level, site
instrument <- list(id = 'SWTWXSTATION',  site = 'SWT')

#l1 <- plotData(instrument, 1, startDate, endDate, fileTimeRes, variables,
#               tickBreaks, dateLabelFormat, title = 'L1', SAVEplot = TRUE,
#               SAVEname = 'L1.png', SAVEpath = 'imgs',
#               SAVEsize = c(h = 7.23, w = 7.56, unit = 'in'))

#RAW <- plotData(instrument, 'RAW', startDate, endDate, fileTimeRes, variables,
#              tickBreaks, dateLabelFormat, sep, variableColNos, timeColFormat,
#              nTimeCols)



