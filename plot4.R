##### filename: plot4.R
##### goal: this script is to generate plot4.png for course project #1.  The data file is assumed to be stored in the data folder in same directory as the script.

##read the entire electric date set
if (!file.exists("./data")) {dir.create("./data")}
powerdata <- read.table("./data/household_power_consumption.txt",header=TRUE,sep=";")

##subset the dataset to dates 2007-02-01 and 2007-02-02
d <- as.Date(as.character(powerdata$Date),format = "%d/%m/%Y")
subd <- d >= as.Date("2007-02-01") & d <= as.Date("2007-02-02")
subpowerdata <- powerdata[subd,]

##add new column combing Date and Time
subpowerdata$DateTime <- as.POSIXct(paste(as.Date(subpowerdata$Date,"%d/%m/%Y"),subpowerdata$Time),"%Y-%m-%d %H:%M:%S")

##convert columns into numeric
subpowerdata$Global_active_power <- as.numeric(as.character(subpowerdata$Global_active_power))
subpowerdata$Sub_metering_1 <- as.numeric(as.character(subpowerdata$Sub_metering_1))
subpowerdata$Sub_metering_2 <- as.numeric(as.character(subpowerdata$Sub_metering_2))
subpowerdata$Sub_metering_3 <- as.numeric(as.character(subpowerdata$Sub_metering_3))
subpowerdata$Voltage <- as.numeric(as.character(subpowerdata$Voltage))
subpowerdata$Global_reactive_power <- as.numeric(as.character(subpowerdata$Global_reactive_power))


##open file dervice to create png file
png(file = "plot4.png")

##plot plot4.png
par(mfrow = c(2,2))
with(subpowerdata, {
  plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power(kilowatts)", type = "l")
  plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
  plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
    lines(DateTime,Sub_metering_1,col="black")
    lines(DateTime,Sub_metering_2,col="red")
    lines(DateTime,Sub_metering_3,col="blue")
    legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1, 1, 1), col = c("black","red","blue"),bty = "n")
  plot(DateTime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
    points(DateTime, Global_reactive_power,pch = ".")
})
##close png file dervice
dev.off()
