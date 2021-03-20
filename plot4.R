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



par(mfrow = c(2,2), mar = c(2.9,2.7,0,3), oma = c(1,2,1,1), cex.lab = 0.8)

### First

plot(order, table$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power")


### Second

plot(order, table$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")


### Third

plot(order, table$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")

lines(order, table$Sub_metering_2, type = "l", col = "red")

lines(order, table$Sub_metering_3, type = "l", col = "blue")

legend("topright", legend = names, col = cols, lty = rep(1, 3), cex = 0.7, bty="n", lwd = 2.5)


### Fourth

plot(order, table$Global_reactive_power, type = "l", xlab = "datetime",
     ylab = "Global_reactive_power")


dev.cur()
dev.copy(png, filename = "plot4.png", width = 480, height = 480)
dev.off()