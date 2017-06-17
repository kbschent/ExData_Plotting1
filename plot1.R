# Author: Kyle B. Schenthal
# Created: Fri Jun 16 17:41:33 2017
# Last Updated: Sat Jun 17 15:14:26 2017
# Coursera Course: Exploratory Data Analysis by Johns Hopkins University
# Course Project: 1
# Description:  Loads UCI Machine Learning Repo Electric Power Consumption data,
#               generates a histogram of global active power consumption, 
#               and exports as PNG file.
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
    filter(Date == "1/2/2007"| Date == "2/2/2007")  # Filter dates


# Plot data -----------------------------------------------
# Histogram of Global Active Power
hist(power_tbl$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")


# Export plot ---------------------------------------------
dev.copy(png, file = "plot1.png")
dev.off()  # Close graphics device