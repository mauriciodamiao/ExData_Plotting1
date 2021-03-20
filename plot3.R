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



plot(order, table$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")

lines(order, table$Sub_metering_2, type = "l", col = "red")

lines(order, table$Sub_metering_3, type = "l", col = "blue")

names <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
cols <- c("black", "red", "blue")

legend("topright", legend = names, col = cols, rep(1, 3), cex = 0.6, lwd = 2.5)

dev.cur()
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()

