# ALEXIS 106 Psychoacoustic experiment with blind and sighted listeners
# This script reads data from the raw data file and calculates thresholds
# 'alexis106_data.txt'. This script loads data prepared by scripts 0_*.R and 1_*.R
# and conducts data analysis.
#
# MN: 2016-12-30


# Clear everything -------------------------------------------------------------
rm(list = ls()) # clear memory
graphics.off()  # clear all plots
cat("\014")     # clear console (same as Ctrl-L in console)
#-------------------------------------------------------------------------------

setwd("C:/Users/MATNI/Desktop/alexis106/")



# Load data --------------------------------------------------------------------
source("./data-raw/0_get_individual_thresholds.R")
source("./data-raw/1_organize_data.R")
# ------------------------------------------------------------------------------


# Save data as R object in /R (done automatically by devtools) -----------------
data106 <- d
devtools::use_data(data106, overwrite = TRUE)
# ------------------------------------------------------------------------------

