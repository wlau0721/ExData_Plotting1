##### filename: plot2.R
##### goal: this script is to generate plot2.png for course project #1.  The data file is assumed to be stored in the data folder in same directory as the script.

##read the entire electric date set
if (!file.exists("./data")) {dir.create("./data")}
powerdata <- read.table("./data/household_power_consumption.txt",header=TRUE,sep=";")

##subset the dataset to dates 2007-02-01 and 2007-02-02
d <- as.Date(as.character(powerdata$Date),format = "%d/%m/%Y")
subd <- d >= as.Date("2007-02-01") & d <= as.Date("2007-02-02")
subpowerdata <- powerdata[subd,]

##add new column combing Date and Time
subpowerdata$DateTime <- as.POSIXct(paste(as.Date(subpowerdata$Date,"%d/%m/%Y"),subpowerdata$Time),"%Y-%m-%d %H:%M:%S")

##convert global active power column into numeric
subpowerdata$Global_active_power <- as.numeric(as.character(subpowerdata$Global_active_power))

##open file dervice to create png file
png(file = "plot2.png")

##plot plot2.png
with(subpowerdata, plot(DateTime, Global_active_power, xlab = "", ylab = "Global Active Power(kilowatts)", type = "l"))

##close png file dervice
dev.off()

