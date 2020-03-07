library(sf)
library(tbeptools)

fimdat <- st_read('https://opendata.arcgis.com/datasets/68fb6774b58a40a08a6f87959aaa53c4_26.geojson')

otb <- tbseg[tbseg$bay_segment %in% 'OTB',]
otbfimdat <- fimdat[otb, ]
otbfimdat <- st_set_geometry(otbfimdat, NULL)

write.csv(otbfimdat, 'data/otbfimdat.csv', row.names = F)
