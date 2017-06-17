# Author: Kyle B. Schenthal
# Created: Sat Jun 17 11:14:31 2017
# Last Updated: Sat Jun 17 15:21:08 2017
# Coursera Course: Exploratory Data Analysis by Johns Hopkins University
# Course Project: 1
# Description:  Loads UCI ML Repo Electric Power Consumption data, 4 graphs in 
#               a 2 x 2 matrix and outputs the graphs as a PNG file.
# ---------------------------------------------------------
library(tidyverse)


# Download zip file and extract ---------------------------
kFileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
kZipFile = "household_power_consumption.zip"  # URL and zip file name constants
download.file(kFileUrl, destfile = kZipFile, method = "curl")
unzip(kZipFile)


# Load data -----------------------------------------------
# Read in data as tibble 
power_tbl <- read_delim("household_power_consumption.txt", delim = ";", 
                    quote = "", na = "?", n_max = 2075260) %>%
    filter(Date == "1/2/2007"| Date == "2/2/2007") %>% # Filter dates
        # Add datetime col
        mutate(datetime = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %T"))


# Graphics parameters -------------------------------------
par(mfcol = c(2, 2))  # Arrange plots in a 2 x 2 grid

# Collate col names to be plotted and corresponding colors
kMetering <- names(power_tbl)[7:9]
kColors <- c("black", "red", "blue")


# Plot data -----------------------------------------------
# Plot 1
with(power_tbl, plot(Global_active_power ~ datetime, type = "l", xlab = "", 
                 ylab = "Global Active Power"))

# Plot 2
# Plot Submetering_1 data
with(power_tbl, plot(get(kMetering[1]) ~ datetime, type = "l", col = kColors[1],
                     xlab = "", ylab = "Energy sub metering")) 
with(power_tbl, points(get(kMetering[2]) ~ datetime, type = "l", 
                       col = kColors[2]))  # Add Sub_metering_2 data
with(power_tbl, points(get(kMetering[3]) ~ datetime, type = "l", 
                       col = kColors[3]))  # Add Sub_metering_3 data
legend("topright", lty = 1, col = kColors, box.lwd = 0, legend = kMetering)

# Plot 3
with(power_tbl, plot(Voltage ~ datetime, type = "l"))

# Plot 4
with(power_tbl, plot(Global_reactive_power ~ datetime, type = "l"))


# Export plots --------------------------------------------
dev.copy(png, file = "plot4.png")
dev.off()   # Close graphics device