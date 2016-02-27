### Plot4 ----

###  Preparation before running the script ----
# Put yourself in your desired working directory.
# Dowload the data and unzip it into the working drectory. (See README)

# Load libraries 
# You will need to install the packages if you do not already have them
library(dplyr)

# Read raw-data into R
data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE) 

data2 <- data %>%
  filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
  mutate(Global_active_power = as.numeric(Global_active_power))

data2 <- data %>%
  filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
  mutate(Global_active_power = as.numeric(Global_active_power)) %>%
  mutate(Global_reactive_power = as.numeric(Global_reactive_power)) %>%
  mutate(Voltage = as.numeric(Voltage)) %>%
  mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
  mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
  mutate(Sub_metering_3 = as.numeric(Sub_metering_3))

# Dplyr does not support POSIX... "Error: `mutate` does not support `POSIXlt` results"
data2$datetime <- strptime(paste(data2$Date, data2$Time), "%d/%m/%Y %H:%M:%S") 

# I work on a Mac and for the weekdays to in english in the plot change the LC_TIME
# This option might need or not need to be run depending on your computer/instalation
Sys.setlocale("LC_TIME", "en_US.UTF-8")

# Create and save plot
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

plot(data2$datetime,
     data2$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power"
)

plot(data2$datetime,
     data2$Voltage,
     type = "l",
     xlab = "Datetime",
     ylab = "Voltage"
)

plot(data2$datetime,
     data2$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy Submetering")
lines(data2$datetime, data2$Sub_metering_2, type="l", col="red")
lines(data2$datetime, data2$Sub_metering_3, type="l", col="blue")
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 1, bty = "n", col=c("black", "red", "blue")
)

plot(data2$datetime,
     data2$Global_reactive_power,
     type = "l",
     xlab = "Datetime",
     ylab = "Global_reactive_power"
)

dev.off()
