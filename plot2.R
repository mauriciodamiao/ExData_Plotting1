library(sqldf)
library(dplyr)
library(lubridate)

file <- "household_power_consumption.txt"

table <- read.csv.sql(file, sep = ";", header = TRUE, 
                      sql = "select * from file where Date in ('1/2/2007','2/2/2007')") %>%
     as.data.frame()

#Transforming variables

table$Date <- as.POSIXlt(table$Date, format = "%d/%m/%Y")

#Assign a variable which order the correct days and time

order <- ymd_hms(paste(table$Date, table$Time))


plot(order, table$Global_active_power, type = "l", xlab = c(""),
     ylab = "Global Active Power (kilowatts)")

dev.cur()
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()