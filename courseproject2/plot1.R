# Exploratory Data Analysis - Coursera / Johns Hopkins University
# Assignment 2 - Part 1
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
NEI_sample <- NEI[sample(nrow(NEI), size = 2000, replace = FALSE),]

# Aggregate the data
Emissions <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN = sum)
Emissions$PM <- round(Emissions[,2]/1000, 2)

# Have the total emissions from PM2.5 decreased in the US from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# Generate the plot in the same directory as the source code
png(filename = paste(getwd(), 'plot1.png', sep = '/'))

barplot(Emissions$PM, names.arg = Emissions$Group.1,
		main = expression('Total Emission of PM'[2.5]),
		xlab = 'Year', ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))

dev.off()