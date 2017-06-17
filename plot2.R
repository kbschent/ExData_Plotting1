# Author: Kyle B. Schenthal
# Created: Sat Jun 17 02:31:08 2017
# Last Updated: Sat Jun 17 15:17:50 2017
# Coursera Course: Exploratory Data Analysis by Johns Hopkins University
# Course Project: 1
# Description:  Loads UCI Machine Learning Repo Electric Power Consumption data, 
#               generates a line graph of global active power vs time, and 
#               exports as PNG file.
# ---------------------------------------------------------
library(tidyverse)


# Download zip file and extract ---------------------------
kFileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
kZipFile = "household_power_consumption.zip"
download.file(kFileUrl, destfile = kZipFile, method = "curl")
unzip(kZipFile)


# Load Data -----------------------------------------------
# Read in data as tibble
power_tbl <- read_delim("household_power_consumption.txt", delim = ";", 
                    quote = "", na = "?", n_max = 2075260) %>%
    filter(Date == "1/2/2007"| Date == "2/2/2007") %>%  # Filter dates
        # Add datetime col
        mutate(datetime = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %T"))
    

# Plot data -----------------------------------------------
# Global_active_power v. datetime.
with(power_tbl, plot(Global_active_power ~ datetime, type = "l", xlab = "", 
                 ylab = "Global Active Power (kilowatts)"))


# Export Plot ---------------------------------------------
dev.copy(png, file = "plot2.png")
dev.off()  # Close graphics device