
# Dataset: Electric power consumption [20Mb]
# Description: Measurements of electric power consumption in one household 
# with a one-minute sampling rate over a period of almost 4 years. 
# Different electrical quantities and some sub-metering values are available.


# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#Date: Date in format dd/mm/yyyy
#Time: time in format hh:mm:ss
#Global_active_power: household global minute-averaged active power (in kilowatt)
#Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#Voltage: minute-averaged voltage (in volt)
#Global_intensity: household global minute-averaged current intensity (in ampere)
#Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.


dh <- unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip", exdir = getwd())

dh2007 <- read.table(text = grep("^[1,2]/2/2007", readLines(dh), value = TRUE), 
                     col.names = c("Date", "Time", "Global_active_power", 
                                   "Global_reactive_power", "Voltage", 
                                   "Global_intensity", "Sub_metering_1", 
                                   "Sub_metering_2", "Sub_metering_3"), 
                     sep = ";", na.strings = "?", header = TRUE)


## Remove incomplete observation
dh2007 <- dh2007[complete.cases(dh2007),]

# Check the output of dh2007
dim(dh2007)

## Format date to Type Date
dh2007$Date <- as.Date(dh2007$Date, "%d/%m/%Y")

## Combine Date and Time column
dateTime <- paste(dh2007$Date, dh2007$Time)
## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Add DateTime column
dh2007 <- cbind(dateTime, dh2007)

## Format dateTime Column
dh2007$dateTime <- as.POSIXct(dateTime)


## Create Plot 3
with(dh2007, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Copy to PNG file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

