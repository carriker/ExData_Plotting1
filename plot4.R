## ------|---------|---------|---------|---------|---------|---------|---------|---------|
##
## plot4.R
##
## Course assignment 1.4 for Exploratory Data Analysis (exdata-013) - April 2015
##
## This script takes raw data from one file, "household_power_consumption.txt" and
## produces an output graph stored in "plot4.png"
##
## Author: Wayne Carriker
## Date:   April 8, 2015
##

## Inputs
## Script assumes starting in a directory which contains
##  README.Rmd                                      - describes the assignment
##  plot4.R                                         - this script
##  exdata-data-household_power_consumption.zip     - zipped filed
##    or
##  household_power_consumption.txt                 - unzipped data file

## Outputs
##  plot4.png                                       - output plot matching example

## First step is to uncompress the data if only the zip file exists
if (!file.exists("./household_power_consumption.txt")) {
    unzip("exdata-data-household_power_consumption.zip")
}

## Second step is to read in the data for the desired date range (Feb 1st & 2nd 2007)
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt", sep = ";", 
                     sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"')

## Third step is to find the limits of all three data sets in order to define the chart
## limits. The number of rows defines the limits of the x-axis, while the min and max
## values of all three data sets defines the limits of the y-axis.
tlines <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
sub <- data[tlines]
xrng <- c(1, nrow(sub))
yrng <- c(min(sub), max(sub))

## Fourth step is to create the values needed for all of the charts
## Three points are identified for the x-axis: beginning, middle, and end of the data
## Three labels are identified for the x-axis: day of the week for each point
## This logic could be generalized to handle cases with more than 2 days worth of data
## or it could have simply been hard-coded as 'C(1,1441,1881) & c("Thu", "Fri", "Sat")'
ticks <- c(1, nrow(data)/2+1, nrow(data)+1)
days <- weekdays(sapply(c("1/2/2007", "2/2/2007", "3/2/2007"), as.Date, 
                        format = "%d/%m/%Y"))

## Fifth step is to create the desired plot (which is actually four charts)
png("plot4.png")
par(mfrow = c(2,2))
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
     xaxt = "n",
     ylab = "Global Active Power")
## Then the x-axis text is applied using the previously calculated values
axis(1, at = ticks, labels = days)

## This plot is relatively simple except for the x-axis labeling, so many parameters are
## left to their default values and the rest (except for the x-axis) are defined within
## the plot function:
##  the data are in data$Voltage
##  the data are plotted as a continuous line rather than discrete points
##  the graph title is blank
##  the x-axis label is "datetime"
##  the y-axis label is "Voltage"
##  no x-axis text is displayed across the data points so that a simplified axis can be
##  applied after the fact
plot(data$Voltage, 
     type = "l", 
     main = "", 
     xlab = "datetime", 
     ylab = "Voltage",
     xaxt = "n")
## Then the x-axis text is applied using the previously calculated values
axis(1, at = ticks, labels = days)

## This plot is somewhat complex with three different data sets and a little bit tricky
## x-axis labeling, but many parameters are still left to their default values, some are
## are defined within the plot function, and then the data and x-axis text are added
## after the fact:
##  there is no data in the initial plot
##  the data are plotted as continuous lines rather than discrete points
##  the graph title is blank
##  the x-axis label is blank
##  the y-axis label is "Energy sub metering"
##  no x-axis text is displayed across the data points so that a simplified axis can be
##  applied after the fact
##  the x-axis limits are defined by the previously calculated range
##  the y-axis limits are defined by the previously calculated range
plot(1, 
     type = "l", 
     main = "", 
     xlab = "", 
     ylab = "Energy sub metering", 
     xaxt = "n", 
     xlim = xrng, 
     ylim = yrng)
## The three lines are then plotted independently in each of the three colors
lines(data$Sub_metering_1, col = "black")
lines(data$Sub_metering_2, col = "red")
lines(data$Sub_metering_3, col = "blue")
## The legend is applied:
##  in the upper right corner
##  using the labels defined previously to subset the data
##  with solid lines for each data set
##  in matching colors for what is in the plot
##  with no bounding box
legend("topright", tlines, lty = c(1,1,1), col = c("black", "red", "blue"), bty = "n")
## Then the x-axis text is applied using the previously calculated values
axis(1, at = ticks, labels = days)

## This plot is relatively simple except for the x-axis labeling, so many parameters are
## left to their default values and the rest (except for the x-axis) are defined within
## the plot function:
##  the data are in data$Global_reactive_power
##  the data are plotted as a continuous line rather than discrete points
##  the graph title is blank
##  the x-axis label is "datetime"
##  the y-axis label is "Global_reactive_power"
##  no x-axis text is displayed across the data points so that a simplified axis can be
##  applied after the fact
plot(data$Global_reactive_power, 
     type = "l", 
     main = "", 
     xlab = "datetime",  
     ylab = "Global_reactive_power",
     xaxt = "n")
## Then the x-axis text is applied using the previously calculated values
axis(1, at = ticks, labels = days)
dev.off()
