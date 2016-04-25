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

#built the histogram
hist(as.numeric(as.character(df$Global_active_power)), main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)",yaxt='n')
#specify y-axis ticks locations and labels to avoid machine dependent rendering
axis(side=2, at=seq(0,1200, 200), labels=seq(0,1200,200))

#copy to device
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

