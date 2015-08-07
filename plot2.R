##This script file is for the Coursera Course 4, Exploratory Data Analysis, first course project
## plot 2

## The assignment actually begins with reading the data.  Code to unzip the file and set the
## working directory is for reference only.

##unzip the file and set the working directory to new directory created when unzipping (to where the data file is found).
##  unzip ("exdata_data_household_power_consumption.zip")
##  if(!file.exists("./exdata_data_household_power_consumption")){dir.create("./exdata_data_household_power_consumption")}
##  setwd( "./exdata_data_household_power_consumption")
##  getwd()

##read the file in.  This assumes the unzipped text file is in the working directory.

ed1 <-read.table(file="household_power_consumption.txt", header = TRUE, sep = ";",stringsAsFactors=FALSE,na.strings="?")

## Just using dates 2007-02-01 and 2007-02-02.
## Use dplyr to filter down to the rows needed, and lubridate to convert the date column and time column.  
## Add a step to create a new combined Date/time column.
library(dplyr)
library(lubridate)
ed2 <- filter(ed1, Date=="1/2/2007" | Date=="2/2/2007")
ed2 <- mutate(ed2,Date=dmy(Date), Time=hms(Time))
ed3 <- mutate(ed2,datetime=Date+Time)

##get rid of the big file to save memory space
rm(ed1)

## create the chart.  Note that there is no main label on this one, and no x axis label.
with(ed3, plot(datetime,Global_active_power,
     type="l",ylab="Global Active Power (kilowatts)",xlab=""))

##copy to a png device

dev.copy(png,file="plot2.png", width=480, height=480, unit="px")
dev.off()
