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
## Create plot. First create an empty for the plot with correct labels.
## Then add lines for the 3 sub metering measurements. Finally add a legend.
## Close graphics device
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(housepower$DateTime, housepower$Sub_metering_1, type = "n", xlab = "",
     ylab = "Energy sub metering")
lines(housepower$DateTime, housepower$Sub_metering_1, col = "black")
lines(housepower$DateTime, housepower$Sub_metering_2, col = "red")
lines(housepower$DateTime, housepower$Sub_metering_3, col = "blue")
legend("topright", lty = 1, legend = c("Sub_metering_1","Sub_metering_2", 
        "Sub_metering_3"),col = c("black", "red", "blue"))
dev.off()