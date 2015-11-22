# Exploratory Data Analysis - Coursera / Johns Hopkins University
# Assignment 2 - Part 6
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

# Baltimore City, MD and Los Angeles County, CA
MD.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
CA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregate the data
MD.df <- aggregate(MD.onroad[,'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')
MD.df$City <- paste(rep('MD', 4))

CA.df <- aggregate(CA.onroad[, 'Emissions'], by=list(CA.onroad$year), sum)
colnames(CA.df) <- c('year', 'Emissions')
CA.df$City <- paste(rep('CA', 4))

DF <- as.data.frame(rbind(MD.df, CA.df))

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time 
# in motor vehicle emissions?

# Generate the plot in the same directory as the source code
png(filename = paste(getwd(), 'plot6.png', sep = '/'))

ggplot(data=DF, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
	ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
	ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
	geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))

dev.off()