library(magrittr)

# Read in Data only for dates between 01/02/2007 and 02/02/2007
lower_date <- as.Date("2007-01-31")
upper_date <- as.Date("2007-02-3")
data <- read.csv2("household_power_consumption.txt", 
                  stringsAsFactors = F) %>% 
    subset(as.Date(Date, "%d/%m/%Y") < format(upper_date, "%Y-%m-%d") &
               as.Date(Date, "%d/%m/%Y") > format(lower_date, "%Y-%m-%d"))

# Create plot2
as.POSIXct(paste(as.Date(data$Date, "%d/%m/%Y"), data$Time)) %>% 
    plot(., as.numeric(data$Global_active_power), 
         ylab = "Global Active Power (kilowatts)", type = "l")
dev.copy(png, file = "plot2.png") #480x480 by default
dev.off()


