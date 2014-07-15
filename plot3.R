## Fetches full dataset
base_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ';', na.strings = "?", check.names = FALSE, stringsAsFactors = FALSE, comment.char="", quote='\"')
base_data$Date <- as.Date(base_data$Date, format="%d/%m/%Y")

## Subsets the data
data <- subset(base_data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(base_data)

## Converts dates
date_time <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(date_time)

## Plot 3
with(data, {
    plot(Sub_metering_1~Datetime, type = "l",
         ylab = "Global Active Power (kilowatts)", xlab = "")
    lines(Sub_metering_2~Datetime, col = 'Red')
    lines(Sub_metering_3~Datetime, col = 'Blue')
})
legend("topright", col=c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saves data to file
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()