## # install
## install.packages('tidyverse')

# load
library(tidyverse)

# import the data
fishdat <- read_csv('data/fishdat.csv')

# see first six rows
head(fishdat)

# dimensions
dim(fishdat)

# column names
names(fishdat)

# structure
str(fishdat)

# first, select some columns
dplyr_sel1 <- select(fishdat, Sampling_Date, Gear, Pinfish)
head(dplyr_sel1)

# select everything but ObjectId and ExDate
dplyr_sel2 <- select(fishdat, -OBJECTID, -ExDate)
head(dplyr_sel2)

# select columns that contain the letter c
dplyr_sel3 <- select(fishdat, matches('c'))
head(dplyr_sel3)

# now filter observations with more than 30 Pinfish caught
dplyr_high_catch <- filter(fishdat, Pinfish > 30)
head(dplyr_high_catch)

# now filter observations for Gear type as 20
dplyr_gear20 <- filter(fishdat, Gear == 20)
head(dplyr_gear20)

# get rows with > 30 and less than 100 Pinfish
filt1 <- filter(fishdat, Pinfish > 30 & Pinfish < 100)
head(filt1)

# get rows with gear type 20 or red drum larger than 40
filt2 <- filter(fishdat, Gear == 20 | `Red Drum` > 40)
head(filt2)

# get rows gear 20 or gear 5
filt3 <- filter(fishdat, Gear == 20 | Gear == 5)
head(filt3)

# get rows with gear 20 or gear 5 using different syntax
filt4 <- filter(fishdat, Gear %in% c(20, 5))
head(filt4)

# add a column as bluefish divided by 100
dplyr_mut <- mutate(fishdat, Bluefish_p100 = Bluefish / 100)
head(dplyr_mut)

# add a column for many/few mullet
dplyr_mut2 <- mutate(fishdat, mullet_cat = ifelse(Mullets < 20, 'few', 'many'))
head(dplyr_mut2)

# arrange by maximum size
dplyr_arr <- arrange(fishdat, `Sand Seatrout`)
head(dplyr_arr)

# rename some columns
dplyr_rnm <- rename(fishdat, snook = `Common Snook`)
head(dplyr_rnm)

## ex1 <- select(fishdat, Reference, Sampling_Date, Gear, `Sand Seatrout`)
## ex1 <- filter(ex1, Gear == 20)
## ex1 <- rename(ex1, date = Sampling_Date)
## nrow(ex1)

## cropdat <- rawdat[1:28]
## savecols <- data.frame(cropdat$Party, cropdat$`Last Inventory Year (2015)`)
## names(savecols) <- c('Party','2015')
## savecols$rank2015 <- rank(-savecols$`2015`)
## top10df <- savecols[savecols$rank2015 <= 10,]
## basedat <- cropdat[cropdat$Party %in% top10df$Party,]

# not using pipes, select a column, filter rows
bad_ex <- select(fishdat, Gear, `Common Snook`)
bad_ex2 <- filter(bad_ex, `Common Snook` > 25)

# with pipes, select a column, filter rows
good_ex <- fishdat %>% 
  select(Gear, `Common Snook`) %>%
  filter(`Common Snook` > 25)

## ex2 <- fishdat %>%
##   select(Reference, Sampling_Date, Gear, `Sand Seatrout`) %>%
##   filter(Gear == 20) %>%
##   rename(date = Sampling_Date)
## identical(ex1, ex2)
