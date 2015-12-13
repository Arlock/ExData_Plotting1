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

#Creating a single variable wiht date and time: full_date
data<-data.frame(data, paste(as.character(data$Date), as.character(data$Time)))
names(data)[10]<-"full_date"
data$full_date<-strptime(data$full_date,"%Y-%m-%d %H:%M:%S")
data$full_date<-as.POSIXct(data$full_date)

#Plotting Global Active Power vs time
plot(x=data$full_date,y=data$Global_active_power,type="l",xlab="", ylab="Global Active Power (kilowatts)")

#saving to PNG
dev.copy(png,file="plot2.png", width=480, height=480)
dev.off()
