# Exploratory Data Analysis - Coursera / Johns Hopkins University
# Assignment 2 - Part 3
# Brandon Wolfgang - November 22, 2015

# Load ggplot2 library
require(ggplot2)

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
MD$year <- factor(MD$year, levels = c('1999', '2002', '2005', '2008'))

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from 1999-2008
# for Baltimore City? Which have seen increases in emissions from 1999-2008?
# Use the ggplot2 plotting system to make a plot answering this question.

# Generate the plot in the same directory as the source code
png(filename = paste(getwd(), 'plot3.png', sep = '/'), width = 800, height = 500, units = 'px')

ggplot(data = MD, aes(x = year, y = log(Emissions))) + facet_grid(.~type) + guides(fill = FALSE)
	+ geom_boxplot(aes(fill=type)) + stat_boxplot(geom = 'errorbar')
	+ ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year')
	+ ggtitle('Emissions per Type in Baltimore City, MD') + geom_jitter(alpha = 0.10)

dev.off()