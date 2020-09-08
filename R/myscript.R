# setup -------------------------------------------------------------------

# load packages
library(tidyverse)
library(gridExtra)
library(patchwork)

# load data
tbhdat <- read.csv('TBHardbottom_WI_Length_Data_To_Use.csv', stringsAsFactors = F)

# create length frequency graph -------------------------------------------

# preprocess length data
Plot <- tbhdat %>%
  filter(Scientificname == 'Lagodon rhomboides') %>%
  ggplot() +
  geom_histogram(aes(x=sl), color = "black", fill = NA, binwidth = 10) +
  labs(x = "Standard length (mm)", y = "Frequency") +
  facet_wrap(~ Gear, ncol = 1) +
  theme_classic() +
  theme(panel.border = element_rect(color = "black", fill = NA)) +
  theme(strip.background = element_rect(fill = "gray90"))

#get length summary data
summary <- tbhdat %>%
  filter(Scientificname == 'Lagodon rhomboides') %>%
  group_by(Gear) %>%
  summarise(min_sl = min(sl),
            max_sl = max(sl),
            mean_sl = round(mean(sl), digits = 2),
            sd_sl = round(sd(sl), digits = 2),
            Num_lengths = n()) %>%
  ungroup()

# combine plot and summary table
Plot / gridExtra::tableGrob(summary, rows = NULL) +
  plot_layout(heights = c(2,0.8)) +
  plot_annotation(title = 'Lagodon rhomboides', theme= theme(plot.title = element_text(face = "italic")))
