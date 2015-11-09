# Initialize data related variables
dataUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
dataZipped <- tempfile()
dataPath <- paste(getwd(), 'data', sep = '/')
dir.create(file.path(dataPath), showWarnings = FALSE)

# Download data to tempfile() and unzip to working directory
download.file(dataUrl, dataZipped, method = 'curl')
unzip(zipfile = dataZipped, exdir = dataPath)
householdFile <- paste(dataPath, 'household_power_consumption.txt', sep = '/')

# Get data from file into plottable structure 
plotData <- read.table(householdFile, header = T, sep = ';', na.strings = '?')
finalData <- plotData[plotData$Date %in% c('1/2/2007', '2/2/2007'),]
setTime <- strptime(paste(finalData$Date, finalData$Time, sep = ' '), '%d/%m/%Y %H:%M:%S')
finalData <- cbind(setTime, finalData)

# Generating plot 1
hist(finalData$Global_active_power, col = 'red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')

# Generating plot 2
plot(finalData$setTime, finalData$Global_active_power, type = 'l', col = 'black', xlab = '', ylab = 'Global Active Power (kilowatts)')

# Generating plot 3
columnLines <- c('black', 'red', 'blue')
labels <- c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
plot(finalData$setTime, finalData$Sub_metering_1, type = 'l', col = columnLines[1], xlab = '', ylab = 'Energy sub metering')
lines(finalData$setTime, finalData$Sub_metering_2, col = columnLines[2])
lines(finalData$setTime, finalData$Sub_metering_3, col = columnLines[3])
legend('topright', legend = labels, col = columnLines, lty = 'solid')

# Generating plot 4
labels <- c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
columnLines <- c('black', 'red', 'blue')
par(mfrow = c(2, 2))
plot(finalData$setTime, finalData$Global_active_power, type = 'l', col = 'green', xlab = '', ylab = 'Global Active Power')
plot(finalData$setTime, finalData$Voltage, type = 'l', col = 'orange', xlab = 'datetime', ylab = 'Voltage')
plot(finalData$setTime, finalData$Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering')
lines(finalData$setTime, finalData$Sub_metering_2, type = 'l', col = 'red')
lines(finalData$setTime, finalData$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', bty = 'n', legend = labels, lty = 1, col = columnLines)
plot(finalData$setTime, finalData$Global_reactive_power, type = 'l', col = 'blue', xlab = 'datetime', ylab = 'Global_reactive_power')
