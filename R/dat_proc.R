library(sf)
library(tbeptools)
library(lubridate)
library(tidyverse)
library(extrafont)

loadfonts(device = 'win', quiet = T)
fml <- 'Lato'

# FIM csv data ------------------------------------------------------------

# fimdat <- st_read('https://opendata.arcgis.com/datasets/68fb6774b58a40a08a6f87959aaa53c4_26.geojson')
# 
otb <- tbseg[tbseg$bay_segment %in% 'OTB',]
# otbclip <- fimdat[otb, ]
# otbfimdatcmb <- st_set_geometry(otbclip, NULL) %>%
#   select(-Scientificname, -avg_size, -min_size, -max_size) %>%
#   filter(Commonname %in% c('Sand Seatrout', 'Red Drum', 'Pinfish', 'Common Snook', 'Bluefish', 'Mullets')) %>%
#   spread(Commonname, TotalNum, fill = 0)
# 
# write_csv(otbfimdatcmb, 'data/otbfimdatcmb.csv')

otbfimdatcmb <- read_csv('data/otbfimdatcmb.csv')

fishdat <- otbfimdatcmb %>% 
  select(-Latitude, -Longitude) %>% 
  mutate(yr = year(Sampling_Date)) %>% 
  select(OBJECTID, Reference, Sampling_Date, yr, Gear, ExDate, Bluefish, `Common Snook`, Mullets, Pinfish, `Red Drum`, `Sand Seatrout`)

statloc <- otbfimdatcmb %>%
  select(Reference, Latitude, Longitude) %>%
  unique()

write.csv(fishdat, 'data/fishdat.csv', row.names = F)
write.csv(statloc, 'data/statloc.csv', row.names = F)

# seagrass spatial data ---------------------------------------------------

load(file = '../seagrass-dash/data/sgdat2016.RData')

sgdat <- sgdat2016[otb, ] %>% 
  select(OBJECTID, FLUCCS = FLUCCS_CODE)

st_write(sgdat, 'data/sgdat.shp', delete_layer = T)

# registrant counts -------------------------------------------------------

toplo <- read.csv('~/Desktop/TBEP R training RSVP.csv') %>% 
  janitor::clean_names() %>% 
  select(email = matches('^please_provide_your_email')) %>%
  mutate(
    email = tolower(email), 
    email = gsub('^.*\\@', '', email), 
    email = gsub('\\,', '.', email), 
    email = gsub('\\.com$|\\.edu$|\\.gov$|\\.org$|\\.net$|\\.con$', '', email), 
    email = gsub('\\.com\\.au$', '', email), 
    email = gsub('contractor\\.', '', email), 
    email = gsub('mail\\.', '', email)
  ) %>% 
  group_by(email) %>% 
  summarise(n = n()) %>%
  arrange(-n) %>% 
  mutate(email = factor(email, levels = email))

p <- ggplot(toplo, aes(x = email, y = n)) + 
  geom_bar(stat = 'identity') + 
  theme_minimal() +
  scale_y_continuous(expand = c(0, 0)) + 
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(), 
    panel.grid.minor.y = element_blank(), 
    axis.title.x = element_blank(), 
    axis.text.x = element_text(size = 6, angle = 40, hjust = 1), 
    text = element_text(family = fml)
  ) + 
  labs(
    y = 'Count', 
    title = 'Workshop registrants by email domain'
  )

png('~/Desktop/registrants.png', height = 3.5, width = 8, family = fml, units = 'in', res = 200)
print(p)
dev.off()

