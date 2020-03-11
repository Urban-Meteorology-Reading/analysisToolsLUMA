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
rawWXTData <- analysisToolsLUMA::getLUMAdata(instrument, level, startDate, endDate, variables, sep = sep, variableColNos = variableColNos, timeColFormat = timeColFormat) 
```

```
## [1] "Getting raw file time resolution from metadata site..."
## [1] "Raw file res: 1min"
## [1] "Creating dataframe of Tair, RH, dir, WS for SWTWXSTATION at site SWT for level RAW at time resolution 1min between 2020-02-27 and 2020-02-27"
## [1] "Getting variable units from metadata site..."
```

```
## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion
```

```
## [1] "Reading file: /storage/basic/micromet/Tier_raw/RAW//2020/London/SWT/MetData/02/20200227_SWT_MetData.dat"
```


```r
lapply(rawWXTData, head)
```

```
## $data
##                  TIME  Tair    RH   dir    WS
## 1 2020-02-27 00:00:00 4.454 69.32 257.6 3.192
## 2 2020-02-27 00:01:00 4.431 69.29 253.1 3.140
## 3 2020-02-27 00:02:00 4.441 69.30 242.4 2.909
## 4 2020-02-27 00:03:00 4.452 69.35 239.9 2.136
## 5 2020-02-27 00:04:00 4.457 69.17 227.2 2.883
## 6 2020-02-27 00:05:00 4.473 69.25 234.4 2.291
## 
## $metadata
## $metadata$instrument
## $metadata$instrument$id
## [1] "SWTWXSTATION"
## 
## $metadata$instrument$site
## [1] "SWT"
## 
## 
## $metadata$level
## [1] "RAW"
## 
## $metadata$fileTimeRes
## [1] "1min"
## 
## $metadata$units
##   variables   units
## 1      Tair Celsius
## 2        RH       %
## 3       dir  degree
## 4        WS   m.s-1
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
startDate <- as.Date('2020-03-06') #start and end date must be class 'Date'
endDate <- as.Date('2020-03-09')
variables <- c('C_CO2_kg', 'Q_E') 
tickBreaks <- '7 days' # where ticks will be on the plot
dateLabelFormat <- '%d-%m %H' #how the time axis will be formatted
fileTimeRes = '30min' # for processed data the file time resolution must be manually defined as there's often several options.
lOneLicoData <- analysisToolsLUMA::getLUMAdata(instrument, level, startDate, endDate, variables, fileTimeRes) 
```

```
## $id
## [1] "LI7500A"
## 
## $site
## [1] "IMU"
## 
## $ECpack
## [1] TRUE
## 
## [1] "Creating dataframe of C_CO2_kg, Q_E for LI7500A at site IMU for level 1 at time resolution 30min between 2020-03-06 and 2020-03-09"
## [1] "Getting output definitions from metadata site..."
## [1] "More than one output definition matched the request, and one must be selected. Available output definition names are: LI7500A"      
## [2] "More than one output definition matched the request, and one must be selected. Available output definition names are: Li7500_ECpack"
## [3] "More than one output definition matched the request, and one must be selected. Available output definition names are: LI7500A_10Hz" 
## [1] "Using output definition: Li7500_ECpack"
## [1] "Getting variable units from metadata site..."
## [1] "Reading file:  /storage/basic/micromet/Tier_raw//data/2020/London/L1/IMU/DAY/066/Li7500_ECpack_IMU_2020066_30min.nc"
## [1] "Reading file:  /storage/basic/micromet/Tier_raw//data/2020/London/L1/IMU/DAY/067/Li7500_ECpack_IMU_2020067_30min.nc"
## [1] "Reading file:  /storage/basic/micromet/Tier_raw//data/2020/London/L1/IMU/DAY/068/Li7500_ECpack_IMU_2020068_30min.nc"
## [1] "Reading file:  /storage/basic/micromet/Tier_raw//data/2020/London/L1/IMU/DAY/069/Li7500_ECpack_IMU_2020069_30min.nc"
```


```r
lapply(lOneLicoData, head)
```

```
## $data
##                  TIME     C_CO2_kg       Q_E
## 1 2020-03-06 00:30:00 0.0005453699 13.327059
## 2 2020-03-06 01:00:00 0.0005455576 12.021266
## 3 2020-03-06 01:30:00 0.0005457265 10.278804
## 4 2020-03-06 02:00:00 0.0005467439  9.497451
## 5 2020-03-06 02:30:00 0.0005474362  9.080501
## 6 2020-03-06 03:00:00 0.0005484081  9.928359
## 
## $metadata
## $metadata$instrument
## $metadata$instrument$id
## [1] "LI7500A"
## 
## $metadata$instrument$site
## [1] "IMU"
## 
## $metadata$instrument$ECpack
## [1] TRUE
## 
## 
## $metadata$level
## [1] 1
## 
## $metadata$fileTimeRes
## [1] "30min"
## 
## $metadata$units
##   variables  units
## 1  C_CO2_kg kg.m-3
## 2       Q_E  W.m-2
```
plotLUMAdata() constists of 2 main functions that
1. get the data
2. plots the data

These can each be done seperately using these two functions:

```r
allData <- getLUMAdata

finalPlot <- plotTimeSeries
```

Use ?getLUMAdata() and ?plotTimeSeries for more details.

Notes
* doesn't deal with changes in site and time res
* instrument can just be a serial number, or can be site, id and serial. I is faster to define site and ID.
* for level RAW fileTimeRes can either be defined manually or it will be obtained from the metadata system


```r
 regData <- getLUMARegressionData(instrument1, instrument2, startDate, endDate,variable, fileTimeRes)
```

```
## $id
## [1] "DAVIS"
## 
## $site
## [1] "IMU"
## 
## [1] "Creating dataframe of Tair for DAVIS at site IMU for level 1 at time resolution 30min between 2020-03-06 and 2020-03-09"
## [1] "Getting output definitions from metadata site..."
## [1] "Using output definition: Davis"
## [1] "Getting variable units from metadata site..."
## [1] "File for 2020-03-06 doesnt exist"
## [1] "File for 2020-03-07 doesnt exist"
## [1] "File for 2020-03-08 doesnt exist"
## [1] "File for 2020-03-09 doesnt exist"
## [1] "Creating dataframe of Tair for SWTWXSTATION at site SWT for level RAW at time resolution 30min between 2020-03-06 and 2020-03-09"
## [1] "Getting variable units from metadata site..."
```

```
## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion

## Warning in lf_getVariables(): NAs introduced by coercion
```

```
## [1] "Reading file: /storage/basic/micromet/Tier_raw/RAW//2020/London/SWT/MetData/03/20200306_SWT_MetData.dat"
## [1] "Reading file: /storage/basic/micromet/Tier_raw/RAW//2020/London/SWT/MetData/03/20200307_SWT_MetData.dat"
## [1] "Reading file: /storage/basic/micromet/Tier_raw/RAW//2020/London/SWT/MetData/03/20200308_SWT_MetData.dat"
## [1] "Reading file: /storage/basic/micromet/Tier_raw/RAW//2020/London/SWT/MetData/03/20200309_SWT_MetData.dat"
```

```
## Error in FUN(X[[i]], ...): only defined on a data frame with all numeric variables
```


```r
 lapply(regData, head)
```

```
## $data
##                  TIME DAVIS_IMU_1 SWTWXSTATION_SWT_RAW
## 1 2020-01-20 00:01:00    4.700000                3.039
## 2 2020-01-20 00:02:00    4.700000                3.090
## 3 2020-01-20 00:03:00    4.700000                3.076
## 4 2020-01-20 00:04:00    4.700000                3.060
## 5 2020-01-20 00:05:00    4.753333                3.063
## 6 2020-01-20 00:06:00    4.770000                3.049
## 
## $units
##   variables   units
## 1      Tair Celsius
## 
## $analysis
## $analysis$int
## [1] -1.7
## 
## $analysis$grad
## [1] 1.22
## 
## $analysis$cor
## [1] 0.95
## 
## $analysis$n
## [1] 12959
## 
## $analysis$max_min_rounded
##       max min
## inst1  10   2
## inst2  11   0
## 
## $analysis$dateSpan
## [1] "20-01-2020 - 28-01-2020"
```
