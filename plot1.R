## ------|---------|---------|---------|---------|---------|---------|---------|---------|
##
## plot1.R
##
## Course assignment 1.1 for Exploratory Data Analysis (exdata-013) - April 2015
##
## This script takes raw data from one file, "household_power_consumption.txt" and
## produces an output graph stored in "plot1.png"
##
## Author: Wayne Carriker
## Date:   April 8, 2015
##

## Inputs
## Script assumes starting in a directory which contains
##  README.Rmd                                      - describes the assignment
##  plot1.R                                         - this script
##  exdata-data-household_power_consumption.zip     - zipped filed
##    or
##  household_power_consumption.txt                 - unzipped data file

## Outputs
##  plot1.png                                       - output plot matching example

## First step is to uncompress the data if only the zip file exists
if (!file.exists("./household_power_consumption.txt")) {
    unzip("exdata-data-household_power_consumption.zip")
}

## Second step is to read in the data for the desired date range (Feb 1st & 2nd 2007)
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt", sep = ";", 
                sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"')

## Third step is to create the desired plot
png("plot1.png")
## Since this is a simple histogram, most of the parameters can be left as default values
## and the rest can be defined within the hist function:
##  the data are in data$Global_active_power
##  the data color is red
##  the graph title is "Global Active Power"
##  the x-axis label is "Global Active Power (kilowatts)"
hist(data$Global_active_power,
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
