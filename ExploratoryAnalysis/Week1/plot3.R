library(magrittr)

# Read in Data only for dates between 01/02/2007 and 02/02/2007
lower_date <- as.Date("2007-01-31")
upper_date <- as.Date("2007-02-3")
data <- read.csv2("household_power_consumption.txt", 
                  stringsAsFactors = F) %>% 
    subset(as.Date(Date, "%d/%m/%Y") < format(upper_date, "%Y-%m-%d") &
               as.Date(Date, "%d/%m/%Y") > format(lower_date, "%Y-%m-%d"))

# Create plot3
as.POSIXct(paste(as.Date(data$Date, "%d/%m/%Y"), data$Time)) %>% {
    plot(., as.numeric(data$Sub_metering_1), 
         ylab = "Energy sub metering", type = "n")
    lines(., as.numeric(data$Sub_metering_1))
    lines(., as.numeric(data$Sub_metering_2), col = "red")
    lines(., as.numeric(data$Sub_metering_3), col = "blue")
} 
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty=1, cex = 0.8)
dev.copy(png, file = "plot3.png") #480x480 by default
dev.off()