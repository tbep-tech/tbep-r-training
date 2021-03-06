## # install
## install.packages('tidyverse')

library(tidyverse)

# load the fish data
fishdat <- read_csv('data/fishdat.csv')

# load the station data
statloc <- read_csv('data/statloc.csv')

# join the two 
joindat <- left_join(fishdat, statloc, by = 'Reference')
head(joindat)

# load the fish data
fishdat <- read_csv('data/fishdat.csv')

# load the station data
statloc <- read_csv('data/statloc.csv')

# wrangle before join
joindat <- fishdat %>% 
  select(Reference, Sampling_Date, Gear, `Common Snook`) %>% 
  filter(Gear == 20) 

dim(joindat)

# full join
joindat <- joindat %>% 
  full_join(statloc, by = 'Reference')

dim(joindat)

table1
table2
table3

# Spread across two tibbles
table4a  # cases
table4b  # population

table4a

table4a %>%
  gather(`1999`, `2000`, key = "year", value = "cases")

table2

spread(table2, key = type, value = count)

# check dimensions, structure
dim(fishdat)
str(fishdat)

# gather the fishdat
gatherdat <- fishdat %>%
  gather(key = 'Species', value = 'Count', Bluefish, `Common Snook`, Mullets, Pinfish, `Red Drum`, `Sand Seatrout`)

# check dimensions, structure
dim(gatherdat)
str(gatherdat)

head(gatherdat)

by_spp <- group_by(gatherdat, Species)
by_spp

by_spp <- summarize(by_spp, totals = sum(Count))
by_spp

by_spp <- gatherdat %>%
  group_by(Species) %>%
  summarize(totals = sum(Count))
by_spp

by_spp_gear <- gatherdat %>%
  group_by(Species, Gear) %>%
  summarize(totals = sum(Count))
by_spp_gear

more_sums <-gatherdat %>%
  group_by(Species) %>%
  summarize(
    n = n(),
    min_count = min(Count),
    max_count = max(Count),
    total = sum(Count)
  )
more_sums

x <- c(1, 2, NA, 4)
mean(x)
mean(x, na.rm = T)

anyNA(x)

sumdat <- gatherdat %>%
  filter(Gear == 20 & Species == 'Pinfish') %>% 
  group_by(Reference) %>% 
  summarize(
    ave = mean(Count)
  ) %>% 
  arrange(-ave)
sumdat
