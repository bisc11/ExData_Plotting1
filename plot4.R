## Before running this script, check that the datafile "household_power_consumption.txt"
## is unzipped and in your working directory.
if (!file.exists("household_power_consumption.txt")){
    print("Download and unzip household_power_consumption.txt in your working directory")
}
## Read the datafile. Since we will only be using data from the dates 2007-02-01
## and 2007-02-02, only this data is read. (Makes the script run much faster also.)
housepower<-read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                       skip = 66636, nrows = 2880)
names(housepower)<-c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                     "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                     "Sub_metering_3")

## Combine the Date and Time into 1 object, so this can be used as the x axis of the plot.
## Also convert this to class POSIXlt
housepower$DateTime<-as.POSIXlt(paste(housepower$Date,housepower$Time),format = "%d/%m/%Y %H:%M:%S",)

## Open a PNG graphics device for the plot file to be written in.
## Set graphic device to contain 4 plots.
## Create the plots rowwise.
## Close graphics device.
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))

## plot 1, upper left
plot(housepower$DateTime, housepower$Global_active_power, type = "n", xlab = "",
     ylab = "Global Active Power")
lines(housepower$DateTime, housepower$Global_active_power)

## plot 2, upper right
plot(housepower$DateTime, housepower$Voltage, type = "n", xlab = "datetime", 
     ylab = "Voltage")
lines(housepower$DateTime, housepower$Voltage)

## plot 3, lower left
plot(housepower$DateTime, housepower$Sub_metering_1, type = "n", xlab = "",
     ylab = "Energy sub metering")
lines(housepower$DateTime, housepower$Sub_metering_1, col = "black")
lines(housepower$DateTime, housepower$Sub_metering_2, col = "red")
lines(housepower$DateTime, housepower$Sub_metering_3, col = "blue")
legend("topright", lty = 1, legend = c("Sub_metering_1","Sub_metering_2",
        "Sub_metering_3"),col = c("black", "red", "blue"), bty = "n")

## plot 4, lower left
plot(housepower$DateTime, housepower$Global_reactive_power, type = "n", xlab = "datetime", 
     ylab = "Global_reactive_power")
lines(housepower$DateTime, housepower$Global_reactive_power)

dev.off()