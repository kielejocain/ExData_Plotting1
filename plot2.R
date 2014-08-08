## This sequence of functions will read into memory the data to be plotted,
## then build Plot 1 and save it to a .png file.
## We assume the data is in the working directory.

## we first read the data into R
power_data <- read.table("household_power_consumption.txt", header = TRUE,
                         sep = ";", stringsAsFactors = FALSE)

## the Date column is awkwardly formatted
power_data[, 1] <- as.Date(power_data[, 1], "%d/%m/%Y")

## we can now more easily subset the data to only what we will use
pwr_data <- subset(power_data, power_data$Date == as.Date("2006-02-01") |
                         power_data$Date == as.Date("2006-02-02"))

## in order to plot with the time, we add a column that combines the date
## and time; this is more easily done as character strings
time <- paste(as.character(pwr_data[, 1]), pwr_data[, 2], sep = " ")
pwr_data[, "datetime"] <- time

## we open a png graphing device
png(filename = "plot3.png")

## we plot as desired
plot(Global_active_power ~ as.POSIXct(datetime), pwr_data, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

## close the graphing device, saving the file
dev.off()