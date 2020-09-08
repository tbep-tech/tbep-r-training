sumplot <- function(tbhdat, Scientificname) {
  # preprocess length data
  Plot <- tbhdat %>%
    filter(Scientificname == !!Scientificname) %>%
    ggplot() +
    geom_histogram(aes(x=sl), color = "black", fill = NA, binwidth = 10) +
    labs(x = "Standard length (mm)", y = "Frequency") +
    facet_wrap(~ Gear, ncol = 1) +
    theme_classic() +
    theme(panel.border = element_rect(color = "black", fill = NA)) +
    theme(strip.background = element_rect(fill = "gray90"))
  
  #get length summary data
  summary <- tbhdat %>%
    filter(Scientificname == !!Scientificname) %>%
    group_by(Gear) %>%
    summarise(min_sl = min(sl),
              max_sl = max(sl),
              mean_sl = round(mean(sl), digits = 2),
              sd_sl = round(sd(sl), digits = 2),
              Num_lengths = n()) %>%
    ungroup()
  
  # combine plot and summary table
  p <- Plot / gridExtra::tableGrob(summary, rows = NULL) +
    plot_layout(heights = c(2,0.8)) +
    plot_annotation(title = Scientificname, theme= theme(plot.title = element_text(face = "italic")))
  
  return(p)
  
}