## ------|---------|---------|---------|---------|---------|---------|---------|---------|
##
## plot2.R
##
## Course assignment 1.2 for Exploratory Data Analysis (exdata-013) - April 2015
##
## This script takes raw data from one file, "household_power_consumption.txt" and
## produces an output graph stored in "plot2.png"
##
## Author: Wayne Carriker
## Date:   April 8, 2015
##

## Inputs
## Script assumes starting in a directory which contains
##  README.Rmd                                      - describes the assignment
##  plot2.R                                         - this script
##  exdata-data-household_power_consumption.zip     - zipped filed
##    or
##  household_power_consumption.txt                 - unzipped data file

## Outputs
##  plot2.png                                       - output plot matching example

## First step is to uncompress the data if only the zip file exists
if (!file.exists("./household_power_consumption.txt")) {
    unzip("exdata-data-household_power_consumption.zip")
}

## Second step is to read in the data for the desired date range (Feb 1st & 2nd 2007)
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt", sep = ";", 
                sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"')

## Third step is to create the desired plot
png("plot2.png")
## This plot is relatively simple except for the x-axis labeling, so many parameters are
## left to their default values and the rest (except for the x-axis) are defined within
## the plot function:
##  the data are in data$Global_active_power
##  the data are plotted as a continuous line rather than discrete points
##  the graph title is blank
##  the x-axis label is blank
##  the y-axis label is "Global Active Power (kilowatts)"
##  no x-axis text is displayed across the data points so that a simplified axis can be
##  applied after the fact
plot(data$Global_active_power, 
     type = "l", 
     main = "", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)", 
     xaxt = "n")
## Three points are identified for the x-axis: beginning, middle, and end of the data
## Three labels are identified for the x-axis: day of the week for each point
## This logic could be generalized to handle cases with more than 2 days worth of data
## or it could have simply been hard-coded as 'C(1,1441,1881) & c("Thu", "Fri", "Sat")'
ticks <- c(1, nrow(data)/2+1, nrow(data)+1)
days <- weekdays(sapply(c("1/2/2007", "2/2/2007", "3/2/2007"), as.Date, 
                        format = "%d/%m/%Y"))
axis(1, at = ticks, labels = days)
dev.off()
