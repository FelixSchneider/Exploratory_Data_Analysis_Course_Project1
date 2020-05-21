library(dplyr)
library(lubridate)

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,"household_power_consumption.zip")
unzip("household_power_consumption.zip")

Sys.setlocale("LC_ALL","English_US")
data_read <- read.table("household_power_consumption.txt",
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

par(mfrow=c(1,1))
with(data, plot(DateTime, Global_active_power,
                ylab="Global Active Power (kilowatts)",
                xlab="",
                type="n"
                )
     )

with(data, lines(DateTime, Global_active_power))
