# load libraries
library(tidyverse)
library(sf)
library(mapview)

# load the fish data
fishdat <- read_csv('data/fishdat.csv')

# load the station data
statloc <- read_csv('data/statloc.csv')

# load the sgdat shapefile
sgdat <- st_read('data/sgdat.shp')

methods(class = 'sf')

sgdat <- st_read('data/sgdat.shp', quiet = T)
sgdat

str(fishdat)
str(statloc)

# Join the data
alldat <- left_join(fishdat, statloc, by = 'Reference')

# check row counts
nrow(fishdat)
nrow(statloc)
nrow(alldat)

# create spatial data object
alldat <- st_as_sf(alldat, coords = c('Longitude', 'Latitude'), crs = 4326)

# examine the sf objec
alldat
str(alldat)

# check crs
st_crs(alldat)

# verify the polygon and point data have the same crs
st_crs(sgdat)
st_crs(alldat)

alldatutm <- alldat %>% 
  st_transform(crs = '+proj=utm +zone=17 +datum=NAD83 +units=m +no_defs')
st_crs(alldatutm)

plot(alldat)
plot(sgdat)

plot(alldat$geometry)
plot(sgdat$geometry)

filt_dat <- alldat %>% 
  filter(yr == 2016)
plot(filt_dat$geometry)

fish_sub <- filt_dat[sgdat, ]
plot(fish_sub$geometry)
fish_sub

fish_sub <- st_intersection(alldat, sgdat)
plot(fish_sub$geometry)
fish_sub

fish_cnt <- fish_sub %>% 
  group_by(FLUCCS) %>% 
  summarise(
    cnt = sum(Pinfish)
  ) 
fish_cnt

ggplot(fish_cnt, aes(x = FLUCCS, y = cnt)) + 
  geom_bar(stat = 'identity')

# use ggplot with sf objects
ggplot() + 
  geom_sf(data = sgdat, fill = 'green') + 
  geom_sf(data = alldat, aes(fill = 'Gear')) 

mapview(sgdat, col.regions = 'green') +
  mapview(alldat, zcol = 'Gear')

# filter alldat 
tomap <- alldat %>% 
  filter(FLUCCS == 9116) %>% 
  filter(yr == 2016)

# make map
mapview(tomap, zcol = 'Pinfish')
mapview(tomap, zcol = 'Bluefish')

# join maps
mapview(sgdat) + mapvew(tomap, zcol = 'Pinfish')
