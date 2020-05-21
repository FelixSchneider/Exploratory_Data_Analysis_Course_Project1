library(dplyr)
library(lubridate)


fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,"household_power_consumption.zip")
unzip("household_power_consumption.zip")

data_read <- read.table("household_power_consumption.txt",
                        header=TRUE,
                        sep=";",
                        nrows=2075300,
                        na.strings="?",
                        stringsAsFactors=FALSE)

data <- data_read %>%
  mutate(datetime=dmy_hms(paste(Date,Time))) %>%
  filter(datetime>=ymd_hms("2007-02-01 00:00:00",locale=Sys.getlocale("LC_TIME")) &
         datetime<=ymd_hms("2007-02-02 23:59:00",locale=Sys.getlocale("LC_TIME"))) %>%
  select(-(Date:Time))

png("plot4.png",width=480,height=480)
par(mfcol=c(2,2))
### plot upper left ###
with(data, plot(datetime, Global_active_power,
                ylab="Global Active Power (kilowatts)",
                xlab="",
                type="n"
                )
     )
with(data, lines(datetime, Global_active_power))

### plot lower left ###
with(data, plot(datetime, Sub_metering_1,
                ylab="Energy sub metering",
                xlab="",
                type="n"
                )
     )
with(data, lines(datetime, Sub_metering_1, col="black"))
with(data, lines(datetime, Sub_metering_2, col="red"))
with(data, lines(datetime, Sub_metering_3, col="blue"))
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

### plot upper right ###
with(data, plot(datetime, Voltage, type="n"))
with(data, lines(datetime, Voltage))

### plot lower right ###
with(data, plot(datetime, Global_reactive_power, type="n"))
with(data, lines(datetime, Global_reactive_power))

dev.off()