# file name      : plot4.r
#set the screen device's dimension to have consistent dimensions for legend.
#Choose the screen device based on the operating system.
#windows() for Windows, quartz() for Mac, x11() for Unix/Linux
windows(width=6.4, height=6.4)

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
#combine date and time
formatteddate <- paste(as.Date(filtereddata$Date), filtereddata$Time)
filtereddata$datetime <- as.POSIXct(formatteddate)
#set the layout
par(mfrow=c(2,2), mar=c(4,4,2,1), bg="white")
#plot the graphs
with(filtereddata, {
    plot(Global_active_power~datetime, type="l", xlab="", ylab="Global Active Power")
    plot(Voltage~datetime, type="l", ylab="Voltage")
    plot(Sub_metering_1~datetime, type="l", col="black", xlab="", ylab="Energy sub metering")
    lines(Sub_metering_2~datetime,col="red")
    lines(Sub_metering_3~datetime,col="blue")
    legend("topright", col=c("black", "red", "blue"), lty=1, bty="n",legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~datetime, type="l")
})
#copy the plot to png file (480 X 480)
dev.copy(png,"plot4.png",width=480,height=480)
dev.off()
