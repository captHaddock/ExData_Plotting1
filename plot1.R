### Plot1 ----

##  Preparation before running the script ----
# Put yourself in your desired working directory.
# Dowload the data and unzip it into the working drectory. (See README)

# Load libraries 
# You will need to install the packages if you do not already have them
library(dplyr)

### Read raw-data into R ----
data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE) 

# Filter and fix format for variables
data2 <- data %>%
  filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
  mutate(Global_active_power = as.numeric(Global_active_power))

# Create and save plot
png("plot1.png", width = 480, height = 480)
hist(data2$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)"
)
dev.off()
