# analysisToolsLUMA

Functions that can be used to analyse and check LUMA observation data.

## Installation


```r
devtools::install_github('kitbenjamin/analysisToolsLUMA') 

library(analysisToolsLUMA)
```
## dependencies


## Plotting time series of instrument variables

Checking time series of data can be useful in diagnosing when, and at what stage of processing, something has gone wrong. *plotData()* will plot raw and processed data.

### Example 1: plotting raw data

Take the simple example of plotting one day of SWT metdata data from /storage/basic/micromet/Tier_raw/RAW/2020/London/SWT/MetData/02


```r
readLines('man/data/20200227_SWT_MetData.dat', n = 5)
```

```
## [1] "\"2020-02-27 00:00:00\",4.454,4.452,0.005,3.192,3.215,0.279,257.6,240.9,69.32,0"
## [2] "\"2020-02-27 00:01:00\",4.431,4.443,0.006,3.14,2.985,0.319,253.1,238.1,69.29,0" 
## [3] "\"2020-02-27 00:02:00\",4.441,4.435,0.004,2.909,3.046,0.562,242.4,230.3,69.3,0" 
## [4] "\"2020-02-27 00:03:00\",4.452,4.45,0.007,2.136,2.057,0.23,239.9,234.1,69.35,0"  
## [5] "\"2020-02-27 00:04:00\",4.457,4.448,0.004,2.883,3.177,0.511,227.2,231.5,69.17,0"
```
To plot this we need to define several variables


```r
instrument <- list(id = 'SWTWXSTATION', site = 'SWT') #define the id and site as it's listed on the metadata site
level <- 'RAW' 
startDate <- as.Date('2020-02-27') #start and end date must be class 'Date'
endDate <- as.Date('2020-02-27')
variables <- c('Tair', 'RH', 'dir', 'WS') # these must also be consistent with the metadata system
tickBreaks <- '2 hours' # where ticks will be on the plot
dateLabelFormat <- '%H:%M' #how the time axis will be formatted
sep <- ',' #the separator in the file
variableColNos = c(2, 10, 8, 5) # what column is each variable represented by
timeColFormat = '%Y-%m-%d %H:%M:%S' # format of the time column
```
Now plot the data


```r
rawWXTPlot <- analysisToolsLUMA::plotLUMAdata(instrument, level, startDate, endDate, variables, tickBreaks, dateLabelFormat, sep = sep, variableColNos = variableColNos, timeColFormat = timeColFormat) 
```


### Example 2: plotting raw data

This time take the slightly more difficult example of this Microlite data from /storage/basic/micromet/Tier_raw/RAW/2020/London/microlite/02


```r
readLines('man/data/9178815_2020-02-27.txt', n = 20)
```

```
##  [1] "Comment,,510MJ3mWin.5mH,,510MJ3mWin.5mH,,,,"                                                  
##  [2] "S/N,,9178815,,9178815,,,,"                                                                    
##  [3] "Sensor,,Internal Digital Temperature,,Internal RH,,,,"                                        
##  [4] "Low,,,,,,,,"                                                                                  
##  [5] "Pre-low,,,,,,,,"                                                                              
##  [6] "Pre-high,,,,,,,,"                                                                             
##  [7] "High,,,,,,,,"                                                                                 
##  [8] ",,,,,,,,"                                                                                     
##  [9] "Date,Time,Internal Digital Temperature,Alarm Type,Internal RH,Alarm Type,Time Stamp Comment,,"
## [10] "27/02/2020,00:00:51,22.81,,26.20,,,,"                                                         
## [11] "27/02/2020,00:01:51,22.81,,26.20,,,,"                                                         
## [12] "27/02/2020,00:02:51,22.81,,26.20,,,,"                                                         
## [13] "27/02/2020,00:03:51,22.81,,26.20,,,,"                                                         
## [14] "27/02/2020,00:04:51,22.81,,26.16,,,,"                                                         
## [15] "27/02/2020,00:05:51,22.81,,26.16,,,,"                                                         
## [16] "27/02/2020,00:06:51,22.81,,26.16,,,,"                                                         
## [17] "27/02/2020,00:07:51,22.81,,26.16,,,,"                                                         
## [18] "27/02/2020,00:08:51,22.81,,26.16,,,,"                                                         
## [19] "27/02/2020,00:09:51,22.81,,26.16,,,,"                                                         
## [20] "27/02/2020,00:10:51,22.81,,26.16,,,,"
```

Also, save the output to a plots directory


```r
instrument <- list(serial = '9178815') # use the serial number as there's multiple microlites at its site. Equally valid is instrument <- list(id = 'MICROLITE', site = 'BMH', serial = '9178815')
level <- 'RAW' 
startDate <- as.Date('2020-02-20') # plot a few days 
endDate <- as.Date('2020-02-27')
variables <- c('Tair_indoor', 'RH_indoor') 
tickBreaks <- '12 hours' 
dateLabelFormat <- '%j %H:%M' 
sep <- ',' 
variableColNos = c(3, 5) 
timeColFormat = c('%d/%m/%Y', '%H:%M:%S') #time is now over 2 columns so timeColFormat must be a vector
skipRows <- 9 # the first 9 rows are headers
title <- 'My microlite plot' # manually define title this time
SAVEplot <- TRUE
SAVEname <- 'MicroliteTS.png' # dont forget toadd the device (.png)
SAVEpath <- 'man/plots'
SAVEsize <- c(h = 8, w = 5, unit = 'in') # vector for height, width and unit. 
```


```r
rawMicroPlot <- analysisToolsLUMA::plotLUMAdata(instrument, level, startDate, endDate, variables, tickBreaks, dateLabelFormat, sep = sep, variableColNos = variableColNos, timeColFormat = timeColFormat, skipRows = skipRows, title = title, SAVEplot = SAVEplot, SAVEname = SAVEname, SAVEpath = SAVEpath, SAVEsize = SAVEsize) 
```

### Example 3: plotting processed EC data

Plotting processed data is even easier.
Here we plot IMU eddy covariance data:


```r
instrument <- list(id = 'LI7500A', site = 'IMU', ECpack = TRUE) #omit EC pack to plot non-ECpack data 
level <- 1 # as an integer
startDate <- as.Date('2020-01-01') 
endDate <- as.Date('2020-02-27')
variables <- c('C_CO2', 'Q_E') 
tickBreaks <- '7 days' # where ticks will be on the plot
dateLabelFormat <- '%d-%m %H' #how the time axis will be formatted
fileTimeRes = '30min' # for processed data the file time resolution must be manually defined as there's often several options.
lOneLicorPlot <- analysisToolsLUMA::plotLUMAdata(instrument, level, startDate, endDate, variables, tickBreaks, dateLabelFormat, fileTimeRes) 
```

plotLUMAdata() constists of 2 main functions that
1. get the data
2. plots the data

These can each be done seperately using these two functions:

```r
allData <- getLUMAdata

finalPlot <- plotTimeSeries
```

Use ?getLUMAdata() and ?plotTimeSeries() for more details.

Notes
* doesn't deal with changes in site and time res
* instrument can just be a serial number, or can be site, id and serial. I is faster to define site and ID.
* for level RAW fileTimeRes can either be defined manually or it will be obtained from the metadata system
