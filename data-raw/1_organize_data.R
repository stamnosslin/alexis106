# ALEXIS 106 Psychoacoustic experiment with blind and sighted listeners
# This script reads data from the raw data file and calculates thresholds
# 'alexis106_data.txt'. This script imports background data and combines part of
# it with the threshold data. It also defines experimental groups.
#
# MN: 2016-12-30

# Load threshold data ----------------------------------------------------------
source('./data-raw/0_get_individual_thresholds.R')
#-------------------------------------------------------------------------------


# Import background data -------------------------------------------------------
bg <- read.table("./data-raw/alexis106_background.txt",
                  header = TRUE, sep = ',', stringsAsFactors = FALSE)
# ------------------------------------------------------------------------------


# Fixing date variables --------------------------------------------------------
bg$birthdate <- as.Date(bg$birthdate, format = "%Y-%m-%d")
bg$testdate <- as.Date(bg$testdate, format = "%Y-%m-%d")
bg$age_y <- as.numeric(difftime(bg$testdate, bg$birthdate, units = 'days')) / 365 # Age [y]

# Make factor variables
bg$sex <- factor(bg$sex, levels = c(1, 2), labels = c('female', 'male'))
bg$echolocator <- factor(bg$echolocator, levels = c(1, 2, 3, 4),
                         labels = c('never', 'sometimes', 'often', 'always'))
# ------------------------------------------------------------------------------


# Define groups in mth and bg --------------------------------------------------
# Note: 1039 lack 3D-sight! + other visual problems, excluded from young group
# (below 1039 up in the to be excuded unmatch group)
young  <- c(1002, 1003, 1004, 1006, 1007, 1008, 1009, 1011, 1012, 1014,
           1015, 1017, 1018, 1019, 1021, 1022, 1023, 1024, 1026, 1027,
           1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 1037,
           1038, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048)

matched <- c(1010, 1013, 1016, 1020, 2001, 2002, 2003, 2050, 2051, 2052,
           2053, 2054, 2055, 2056, 2057, 2058, 2059, 2060, 2061, 2062,
           2063, 2064, 2065, 2067, 2070, 2071)

blind  <- c(6001, 6002, 6003, 6010, 6013, 6016, 6020, 6050, 6051, 6052,
           6053, 6054, 6055, 6056, 6057, 6058, 6059, 6060, 6061, 6062,
           6063, 6064, 6065, 6067, 6070, 6071)

unmatched <- setdiff(unique(mth$id), c(young, matched, blind))

# Add groups to mth (threshold data)
mth$group <- 1 * is.element(mth$id, young) + 2 * is.element(mth$id, matched) +
             3 * is.element(mth$id, blind)

mth$group <- factor(mth$group, levels = c(0, 1, 2, 3),
                  labels = c('unmatched', 'young', 'matched', 'blind'))

# Add groups to bg (background data)
bg$group <- 1 * is.element(bg$id, young) + 2 * is.element(bg$id, matched) +
  3 * is.element(bg$id, blind)

bg$group <- factor(bg$group, levels = c(0, 1, 2, 3),
                    labels = c('unmatched', 'young', 'matched', 'blind'))
# ------------------------------------------------------------------------------


# Create variable with matched-pair numbers in mth -----------------------------
mth$pairs <- as.character(mth$id)
mth$pairs <- substr(mth$pairs, 3, 4)  # Keep two last digits only
mth$pairs <- as.numeric(mth$pairs)
mth$pairs[mth$group == 'young'] <- 0  # Set non-matched individuals to 0
table(mth$pairs)  # Check that it worked
# ------------------------------------------------------------------------------


# Merge mth and bg into new data frame -----------------------------------------
bg$id2 <- bg$id  # Add id-variable as a security check
# This merges mth and (part of) bg into a new data frame called d
d <- merge(mth, bg, by = 'id')
d$id - d$id2  # This is the check: Should be all zeros
d$id2 <- NULL  # Delete d$id2 (not necessary)
d$group.y <- NULL  # remove duplicate group variable
# remove birth and testdate
d$birthdate <- NULL
d$testdate <- NULL

# Rename two columns
dcols <- colnames(d)
dcols[dcols == "group.x"] <- "group"  # Rename group.x to group
dcols[dcols == "age_y"] <- "age"  # Rename age_y to age
colnames(d) <- dcols
# ------------------------------------------------------------------------------


# Exclude unmatched participants from data frame -------------------------------
d <- d[d$group != 'unmatched', ]
d$group <- droplevels(d$group)  # Drop level 'unmatched' from factor
rownames(d) <- NULL  # Drop rownames
# ------------------------------------------------------------------------------


# Remove objects from global environment ---------------------------------------
z <- ls()
z <- c(z[z != 'd'], 'z')
rm(list = z)
# ------------------------------------------------------------------------------


table(d$pairs)



