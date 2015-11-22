# Initialize data related variables
dataUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
dataZipped <- tempfile()
dataPath <- paste(getwd(), 'data', sep = '/')
dir.create(file.path(dataPath), showWarnings = FALSE)

# Download data to tempfile() and unzip to working directory
download.file(dataUrl, dataZipped, method = 'curl')
unzip(zipfile = dataZipped, exdir = dataPath)
emissionsFile <- paste(dataPath, 'summarySCC_PM25.rds', sep = '/')
classificationsFile <- paste(dataPath, 'Source_Classification_Code.rds', sep='/')

