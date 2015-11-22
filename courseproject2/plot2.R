# Exploratory Data Analysis - Coursera / Johns Hopkins University
# Assignment 2 - Part 2
# Brandon Wolfgang - November 22, 2015

# Initialize data related variables
dataUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
dataZipped <- tempfile()
dataPath <- tempdir()
dir.create(file.path(dataPath), showWarnings = FALSE)

# Download data to tempfile() and unzip to temporary directory
download.file(dataUrl, dataZipped, method = 'curl')
unzip(zipfile = dataZipped, exdir = dataPath)

# Load datasets
NEI <- readRDS(paste(dataPath, 'summarySCC_PM25.rds', sep = '/'))

# Sample the data
NEI_sample <- NEI[sample(nrow(NEI), size = 5000, replace = FALSE),]

# Subset the data and append two years into one data frame
MD <- subset(NEI, fips=='24510')

# Have the total emissions from PM2.5 decreased in the Baltimore City, MD
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
# a plot answering this question.

# Generate the plot in the same directory as the source code
png(filename = paste(getwd(), 'plot2.png', sep = '/'))

barplot(tapply(MD$Emissions, MD$year, sum),
		main = 'Total Emissions in Baltimore City, MD',
		xlab = 'Year', ylab = expression('PM'[2.5]))

dev.off()