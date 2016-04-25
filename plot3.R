#load datafile 
tempdata <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",tempdata)
file <- unzip(tempdata)
unlink(tempdata)

#and store it in a data.table
powerdata <- read.table(file, header=T, sep=";")
#convert Date to Date/Time classes
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
#subset the required dates
df <- powerdata[(powerdata$Date=="2007-02-01") | (powerdata$Date=="2007-02-02"),]
#and build a new column with the date and time for each record as a Date/Time class
df <- transform(df, timerecord=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

#built the plot
plot(df$timerecord,as.numeric(as.character(df$Sub_metering_1)), type="l", xlab="", ylab="Energy sub metering")
lines(df$timerecord,as.numeric(as.character(df$Sub_metering_2)), col ="red")
lines(df$timerecord,as.numeric(as.character(df$Sub_metering_3)), col ="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

#copy to device
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
