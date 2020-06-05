library(sf)
library(tbeptools)

# FIM csv data ------------------------------------------------------------

# fimdat <- st_read('https://opendata.arcgis.com/datasets/68fb6774b58a40a08a6f87959aaa53c4_26.geojson')

otb <- tbseg[tbseg$bay_segment %in% 'OTB',]
# otbclip <- fimdat[otb, ]
# otbfimdatcmb <- st_set_geometry(otbclip, NULL) %>% 
#   select(-Scientificname, -avg_size, -min_size, -max_size) %>% 
#   filter(Commonname %in% c('Sand Seatrout', 'Red Drum', 'Pinfish', 'Common Snook', 'Bluefish', 'Mullets')) %>% 
#   spread(Commonname, TotalNum, fill = 0)
# 
# write.csv(otbfimdatcmb, 'data/otbfimdatcmb.csv', row.names = F)

otbfimdatcmb <- read.csv('data/otbfimdatcmb.csv')

fishdat <- otbfimdatcmb %>% 
  select(-Latitude, -Longitude)

statloc <- otbfimdatcmb %>%
  select(Reference, Latitude, Longitude) %>%
  unique()

write.csv(fishdat, 'data/fishdat.csv', row.names = F)
write.csv(statloc, 'data/statloc.csv', row.names = F)

# seagrass spatial data ---------------------------------------------------

load(file = '../seagrass-dash/data/sgdat2016.RData')

sgdat <- sgdat2016[otb, ] %>% 
  select(OBJECTID, FLUCCS_CODE)

st_write(sgdat, 'data/sgdat.shp', delete_layer = T)

# zip all data ------------------------------------------------------------

fls <- list.files('.', pattern = '^sgdat|^fishdat\\.csv$|^statloc\\.csv$', recursive = T)

zip('data/data.zip', fls)
