library(dplyr)

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
  mutate(Date=as.Date(Date,format="%d/%m/%Y")) %>%
  filter(Date=="2007-02-01" | Date=="2007-02-02")

par(mfrow=c(1,1))
hist(data$Global_active_power,
     col="red",
     main="Global Active Power (kilowatts)",
     xlab="Global Active Power (kilowatts)")
