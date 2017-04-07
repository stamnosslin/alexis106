# ALEXIS 106 Psychoacoustic experiment with blind and sighted listeners
# This script reads data from the raw data file and calculates thresholds
# 'alexis106_data.txt'. This script returns a data frame called mth with
# mean thresholds for each participant and condition.
#
# MN: 2016-12-30


# Load function ----------------------------------------------------------------
source('./data-raw/staircase_functions.R')  # reversals() to generate threshold data
# ------------------------------------------------------------------------------


# Read data ---------------------------------------------------------------------
# NB: first setwd() to be in package directory alexis 106
d <- read.delim("./data-raw/alexis106_data_cleaned.txt",
                 sep = ",", header = TRUE)
# ------------------------------------------------------------------------------


# Preliminary checks of data ---------------------------------------------------
summary(d)
table(d$id) # number of trials per id
#-------------------------------------------------------------------------------


# Add reversals to data frame, using mntools::reversals() ----------------------
revs <- aggregate(increment ~ session + condition + id, d, reversals)
d <- d[order(d$session, d$condition, d$id),]  # sort as output of aggregate()
d$reversals <- unlist(revs$increment)
rm(revs)
table(d$reversals)  # Check this output carefully!!!
# ------------------------------------------------------------------------------


# Adding threshold variable ----------------------------------------------------
# Definitions:
# th = vrms / srms  # cond1
# th = rrms / srms  # cond2
# th = rtau - 400   # cond3
# th = rrms / srms  # cond4 (same as cond2)

d$th <- ifelse (d$condition == 1, d$vrms / d$srms,
        ifelse(d$condition == 3, d$rtau - 400, d$rrms / d$srms))
# ------------------------------------------------------------------------------


# Calculate thresholds as fun(reversals) after excluding first k reversals -----
# Function for geometric mean
gmean = function(x, na.rm = FALSE, zero.rm = FALSE) {
  tol = 1e-08
  # Remove outliers if requested
  if (na.rm) x <- na.omit(x)
  # Remove zeros if requested
  if (zero.rm) x <- x[abs(x - 0) >= tol]

  gmean <- exp(mean(log(x)))
  gmean
}

fun <- gmean  # averaging function
k <- 4
d2 <- d[d$reversals > k, ]  # Keep only reversals > k
th <- aggregate(th ~ session + condition + id, d2, fun)
table(th$id, th$condition)  # Why some with only 4 ths in a condition?
# ------------------------------------------------------------------------------


# Calculate mean threshold per participant and condition -----------------------
mfun <- gmean  # averaging function
mth <- aggregate(th ~ condition + id, th, mfun)

# Convert to dB for conditions 1, 2, and 4
mth$th <- ifelse(mth$condition == 3, mth$th, 20 * log10(mth$th))
summary(mth)
# ------------------------------------------------------------------------------

# From long to wide format -----------------------------------------------------
mth <- reshape(mth, v.names = 'th', timevar = "condition",
                   idvar = "id", direction = "wide")
# ------------------------------------------------------------------------------


# Remove objects from global environment ---------------------------------------
z <- ls()
z <- c(z[z != 'mth'], 'z')
rm(list = z)
# ------------------------------------------------------------------------------


# OLD STUFF BELOW HERE ---------------------------------------------------------
# Calculating th for each stimulus variable
# th <- aggregate(cbind(increment, srms, vrms, rrms, rtau) ~
# session + condition + id, d2, fun)
