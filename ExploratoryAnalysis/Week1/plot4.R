library(magrittr)

# Read in Data only for dates between 01/02/2007 and 02/02/2007
lower_date <- as.Date("2007-01-31")
upper_date <- as.Date("2007-02-3")
data <- read.csv2("household_power_consumption.txt", 
                  stringsAsFactors = F) %>% 
    subset(as.Date(Date, "%d/%m/%Y") < format(upper_date, "%Y-%m-%d") &
               as.Date(Date, "%d/%m/%Y") > format(lower_date, "%Y-%m-%d"))

# Create plot4
par(mfrow = c(2,2), mar = c(4,4,2,1))

# Topleft
as.POSIXct(paste(as.Date(data$Date, "%d/%m/%Y"), data$Time)) %>% 
    plot(., as.numeric(data$Global_active_power), 
         ylab = "Global Active Power (kilowatts)", type = "l")

# TopRight
as.POSIXct(paste(as.Date(data$Date, "%d/%m/%Y"), data$Time)) %>% 
    plot(., as.numeric(data$Voltage), 
         ylab = "Voltage", 
         xlab = "datetime", type = "l")

# BottomLeft
as.POSIXct(paste(as.Date(data$Date, "%d/%m/%Y"), data$Time)) %>% {
    plot(., as.numeric(data$Sub_metering_1), 
         ylab = "Energy sub metering", type = "n")
    lines(., as.numeric(data$Sub_metering_1))
    lines(., as.numeric(data$Sub_metering_2), col = "red")
    lines(., as.numeric(data$Sub_metering_3), col = "blue")#
} 
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), bty = "n",
       lty=1, cex = 0.6)

# BottomRight
as.POSIXct(paste(as.Date(data$Date, "%d/%m/%Y"), data$Time)) %>% 
    plot(., as.numeric(data$Global_reactive_power), 
         ylab = "Global_reactive_power", 
         xlab = "datetime", type = "l")

# Export
dev.copy(png, file = "plot4.png") #480x480 by default
dev.off()