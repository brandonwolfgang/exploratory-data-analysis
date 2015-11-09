setwd('/Users/Brandon/dev/coursera/data-science/courses/04 - Exploratory Data Analysis/workspace')
downloadUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
downloadFile <- './data/household_power_consumption.zip'
downloadFile
householdFile <- './data/household_power_consumption.txt'
householdFile

download.file(downloadUrl, downloadFile, method = 'curl')
unzip(downloadFile, overwrite = T, exdir = tempdir())

plotData <- read.table(householdFile, header = T, sep = ';', na.strings = '?')

finalData <- plotData[plotData$Date %in% c('1/2/2007', '2/2/2007'),]
setTime <- strptime(paste(finalData$Date, finalData$Time, sep = ' '), '%d/%m/%Y %H:%M:%S')
finalData <- cbind(setTime, finalData)

# Generating plot 1
hist(finalData$Global_active_power, col = 'red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')

# Generating plot 2
plot(finalData$setTime, finalData$Global_active_power, type = '1', col = 'black', xlab = '', ylab = 'Global Active Power (kilowatts)')

# Generating plot 3
columnLines <- c('black', 'red', 'blue')
labels <- c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
plot(finalData$setTime, finalData$Sub_metering_1, type = '1', col = columnLines[1], xlab = '', ylab = 'Energy sub metering')
lines(finalData$setTime, finalData$Sub_metering_2, col = columnLines[2])
lines(finalData$setTime, finalData$Sub_metering_3, col = columnLines[3])
legend('topright', legend = labels, col = columnLines, lty = 'solid')

# Generating plot 4
labels <- c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
columnLines <- c('black', 'red', 'blue')
par(mfrow = c(2, 2))
plot(finalData$setTime, finalData$Global_active_power, type = '1', col = 'green', xlab = '', ylab = 'Global Active Power')
plot(finalData$setTime, finalData$Voltage, type = '1', col = 'orange', xlab = 'datetime', ylab = 'Voltage')
plot(finalData$setTime, finalData$Sub_metering_1, type = '1', xlab = '', ylab = 'Energy sub metering')
lines(finalData$setTime, finalData$Sub_metering_2, type = '1', col = 'red')
lines(finalData$setTime, finalData$Sub_metering_3, type = '1', col = 'blue')
legend('topright', bty = 'n', legend = labels, lty = 1, col = columnLines)
plot(finalData$setTime, finalData$Global_reactive_power, type = '1', col = 'blue', xlab = 'datetime', ylab = 'Global_reactive_power')

