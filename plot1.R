##### filename: plot1.R
##### goal: this script is to generate plot1.png for course project #1.  The data file is assumed to be stored in the data folder in same directory as the script.

##read the entire electric date set
if (!file.exists("./data")) {dir.create("./data")}
powerdata <- read.table("./data/household_power_consumption.txt",header=TRUE,sep=";")

##convert Date column into Date object
d <- as.character(powerdata$Date)
powerdata$Date <- as.Date(d,format = "%d/%m/%Y")

##subset the dataset to dates 2007-02-01 and 2007-02-02
subd <- powerdata$Date >= as.Date("2007-02-01") & powerdata$Date <= as.Date("2007-02-02")
subpowerdata <- powerdata[subd,]

##convert global active power column into numeric
subpowerdata$Global_active_power <- as.numeric(as.character(subpowerdata$Global_active_power))


##open file dervice to create png file
png(file = "plot1.png")

##plot plot1.png
with(subpowerdata, hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power(kilowatts)", col = "RED"))

##close png file dervice
dev.off()


