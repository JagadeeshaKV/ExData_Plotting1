# file name      : plot1.r

#Download the file from the server if it does not exist in the local directory
filename<-"household_power_consumption.txt"
if(!file.exists(filename)){
source<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination<-"ProjectData.zip"
download.file(source,destfile=destination)

#unzip
unzip(zipfile = destination)
}
#read the data from the file. First row is the header.
filedata<-read.csv(filename, header=T, sep=';',na.strings = "?",nrows=2075259,check.names=F, stringsAsFactors=F)
#filter the data
filtereddata <- subset(filedata, filedata$Date=="1/2/2007" | filedata$Date=="2/2/2007")
#convert to date format
filtereddata$Date <- as.Date(filtereddata$Date, format="%d/%m/%Y")
#plot the histogram. 
hist(filtereddata$Global_active_power, col="red", main="Global Active Power",xlab="Global Active Power (kilowatts)")
#copy the plot to png file (480 X 480)
dev.copy(png, file = "plot1.png",height= 480, width=480)
dev.off()