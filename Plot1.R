
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

# Plot 1
hist(dh2007$Global_active_power, col = "red", 
     main = paste("Global Active Power"), 
     xlab = "Global Active Power (kilowatts)")

## Copy to PNG file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

