library(sf)
library(tbeptools)

fimdat <- st_read('https://opendata.arcgis.com/datasets/68fb6774b58a40a08a6f87959aaa53c4_26.geojson')

otb <- tbseg[tbseg$bay_segment %in% 'OTB',]
otbclip <- fimdat[otb, ]
otbfimdatcmb <- st_set_geometry(otbclip, NULL) %>% 
  select(-Scientificname, -avg_size, -min_size, -max_size) %>% 
  filter(Commonname %in% c('Sand Seatrout', 'Red Drum', 'Pinfish', 'Common Snook', 'Bluefish', 'Mullets')) %>% 
  spread(Commonname, TotalNum, fill = 0)

statloc <- otbfimdatcmb %>% 
  select(Reference, Latitude, Longitude) %>% 
  unique()

write.csv(otbfimdatcmb, 'data/otbfimdatcmb.csv', row.names = F)

fishdat <- otbfimdatcmb %>% 
  select(-Latitude, -Longitude)

write.csv(fishdat, 'data/fishdat.csv', row.names = F)
write.csv(statloc, 'data/statloc.csv', row.names = F)

zip('data/datazip.zip', c('data/otbfimdat.csv', 'data/statloc.csv'))