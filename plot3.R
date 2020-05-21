library(dplyr)
library(lubridate)

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,"./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip",exdir="./data")

Sys.setlocale("LC_ALL","English_US")
data_read <- read.table("./data/household_power_consumption.txt",
                   header=TRUE,
                   sep=";",
                   nrows=2075300,
                   na.strings="?",
                   stringsAsFactors=FALSE)

data <- data_read %>%
  mutate(DateTime=dmy_hms(paste(Date,Time))) %>%
  filter(DateTime>=ymd_hms("2007-02-01 00:00:00",locale=Sys.getlocale("LC_TIME")) &
         DateTime<=ymd_hms("2007-02-02 23:59:00",locale=Sys.getlocale("LC_TIME"))) %>%
  select(-(Date:Time))

with(data, plot(DateTime, Sub_metering_1,
                ylab="Energy sub metering",
                xlab="",
                type="n"
                )
     )

with(data, lines(DateTime, Sub_metering_1, col="black"))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
