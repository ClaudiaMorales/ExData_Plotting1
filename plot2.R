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


## Generating Plot 2 and saving as PNG
png(filename='plot2.png', width=480, height=480, units='px')

plot(plotData$SetTime, plotData$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()