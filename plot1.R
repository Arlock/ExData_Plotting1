#Loading Data & Unzip
fileUrl<-("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
download.file(fileUrl,destfile="power_consumption.zip")
unzip("power_consumption.zip")
data<-read.csv2("household_power_consumption.txt",na.strings = "?")

#Setting Dates
data$Date<-strptime(data$Date,"%d/%m/%Y")
fromDate<-strptime("2007-02-01","%Y-%m-%d")
toDate<-strptime("2007-02-02","%Y-%m-%d")

#Subsetting & formating data
data<-subset(data,as.Date(data$Date)>=as.Date(fromDate) & as.Date(data$Date)<=as.Date(toDate))
data$Global_active_power<-as.numeric(paste(data$Global_active_power))

#Making the Histogram of Global Active Power
hist(data$Global_active_power,col="red",main ="Global Active Power", xlab="Global Active Power (Kilowatts)",ylab="Frequency")

#saving to PNG
dev.copy(png,file="plot1.png", width=480, height=480)
dev.off()
