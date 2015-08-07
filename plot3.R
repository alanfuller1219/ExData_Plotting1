##This script file is for the Coursera Course 4, Exploratory Data Analysis, first course project
## plot 3

## The assignment actually begins with reading the data.  Code to unzip the file and set the
## working directory is for reference only.

##unzip the file and set the working directory to new directory created when unzipping (to where the data file is found).
##  unzip ("exdata_data_household_power_consumption.zip")
##  if(!file.exists("./exdata_data_household_power_consumption")){dir.create("./exdata_data_household_power_consumption")}
##  setwd( "./exdata_data_household_power_consumption")
##  getwd()

##read the file in.  This assumes the unzipped text file is in the working directory.

ed1 <-read.table(file="household_power_consumption.txt", header = TRUE, sep = ";",stringsAsFactors=FALSE,na.strings="?")

## Use dplyr to filter down to the rows needed, and lubridate to convert the date column and time column.  
## Add a step to create a new combined Date/time column.
library(dplyr)
library(lubridate)
ed2 <- filter(ed1, Date=="1/2/2007" | Date=="2/2/2007")
ed2 <- mutate(ed2,Date=dmy(Date), Time=hms(Time))
ed3 <- mutate(ed2,datetime=Date+Time)

##get rid of the big file to save memory space
rm(ed1)

##Individual plot creation, just for reference
## with(ed3,plot(datetime,Sub_metering_1,type="l",col="black",ylab="Energy sub metering",xlab=""))
## with(ed3,plot(datetime,Sub_metering_2,type="l",col="red",ylab="Energy sub metering",xlab=""))
## with(ed3,plot(datetime,Sub_metering_3,type="l",col="blue",ylab="Energy sub metering",xlab=""))


## create the chart.  Note that there is no main label on this one, and no x axis label. Thanks to
## Patrick Schatz on the discussion forum for the suggestion of doing the PNG first in order to make
## the text in the legend fit correctly.

png(file="plot3.png", width=480, height=480, unit="px")
with(ed3, {
     plot(datetime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
     lines(datetime,Sub_metering_2, col="red")
     lines(datetime,Sub_metering_3, col="blue")
})
legend("topright",col=c("black","red","blue"), lty=1,
          legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##turn off the device
dev.off()

