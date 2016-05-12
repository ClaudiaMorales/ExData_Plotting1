## First download, unzip and read the file

downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "./exdata-data-household_power_consumption.zip"
householdFile <- "./household_power_consumption.txt"
if (!file.exists(householdFile)) {
    download.file(downloadURL, downloadFile)
    unzip(downloadFile, overwrite = T)
}
Data <- read.table(householdFile, header=T, sep=";", na.strings="?")

## set time variable
plotData <- Data[Data$Date %in% c("1/2/2007","2/2/2007"),]
SetTime <-strptime(paste(plotData$Date, plotData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
plotData <- cbind(SetTime, plotData)

## Generating Plot 4 and creating PNG

png(filename='plot4.png', width=480, height=480, units='px')

labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
columnlines <- c("black","red","blue")
par(mfrow=c(2,2))
plot(plotData$SetTime, plotData$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(plotData$SetTime, plotData$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(plotData$SetTime, plotData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(plotData$SetTime, plotData$Sub_metering_2, type="l", col="red")
lines(plotData$SetTime, plotData$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", legend=labels, lty=1, col=columnlines)
plot(plotData$SetTime, plotData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()