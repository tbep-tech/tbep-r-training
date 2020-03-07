library(sf)
library(tbeptools)

fimdat <- st_read('https://opendata.arcgis.com/datasets/68fb6774b58a40a08a6f87959aaa53c4_26.geojson')

tbfimdat <- fimdat[tbseg, ]
tbfimdat <- st_set_geometry(tbfimdat, NULL)

write.csv(tbfimdat, 'data/tbfimdat.csv', row.names = F)