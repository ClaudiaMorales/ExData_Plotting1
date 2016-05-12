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


## Generating Plot 3 and saving as PNG

png(filename='plot3.png', width=480, height=480, units='px')

columnlines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(plotData$SetTime, plotData$Sub_metering_1, type="l", col=columnlines[1], xlab="", ylab="Energy sub metering")
lines(plotData$SetTime, plotData$Sub_metering_2, col=columnlines[2])
lines(plotData$SetTime, plotData$Sub_metering_3, col=columnlines[3])
legend("topright", legend=labels, col=columnlines, lty="solid")
dev.off()