# Exploratory Data Analysis - Coursera / Johns Hopkins University
# Assignment 2 - Part 5
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
SCC <- readRDS(paste(dataPath, 'Source_Classification_Code.rds', sep = '/'))

NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland == fips
MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregate the data
MD.df <- aggregate(MD.onroad[,'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Generate the plot in the same directory as the source code
png(filename = paste(getwd(), 'plot5.png', sep = '/'))

ggplot(data=MD.df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=FALSE)
	+ ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland')
	+ ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none')
	+ geom_text(aes(label=round(Emissions, 0), size=1, hjust=0.5, vjust=2))

dev.off()