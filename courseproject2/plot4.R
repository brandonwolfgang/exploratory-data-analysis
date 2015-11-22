# Exploratory Data Analysis - Coursera / Johns Hopkins University
# Assignment 2 - Part 4
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

# Coal combustion related sources
SCC.coal <- SCC[grepl('coal', SCC$Short.Name, ignore.case = TRUE),]

# Merge the two data sets
dataMerged <- merge(x = NEI, y = SCC.coal, by = 'SCC')
dataMerged.sum <- aggregate(dataMerged[, 'Emissions'], by = list(dataMerged$year), sum)
colnames(dataMerged.sum) <- c('Year', 'Emissions')

# Across the United States, how have emissions from coal combustion related sources
# changed from 1999-2008?

# Generate the plot in the same directory as the source code
png(filename = paste(getwd(), 'plot4.png', sep = '/'))

ggplot(data = dataMerged.sum, aes(x = Year, y = Emissions/1000))
	+ geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions))
	+ ggtitle(expression('Total Emissions of PM'[2.5]))
	+ ylab(expression(paste('PM', ''[2.5], ' in kilotons')))
	+ geom_text(aes(label=round(Emissions/1000, digits = 2), size=2, hjust=1.5, vjust=1.5))
	+ theme(legend.position='none') + scale_color_gradient(low='black', high='red')

dev.off()