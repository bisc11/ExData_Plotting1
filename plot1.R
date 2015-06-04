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

## Open a PNG graphics device for the plot file to be written in.
## Plot a red histogram of Global active power.
## Close graphics device
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(housepower$Global_active_power, col="red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()