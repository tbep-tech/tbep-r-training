knitr::opts_chunk$set(echo = T, warning = F, message = F, fig.path = 'figure/')

# Learning about functions in R
# Created March  10, 2020
# FWRI R club

library(tidyverse)

dat <- tibble::tibble(
  a = rnorm(100), 
  b = rnorm(100), 
  c = rnorm(100), 
  d = rnorm(100)
)

## dat$a <- (dat$a - min(dat$a, na.rm = TRUE)) / (max(dat$a, na.rm = T) - min(dat$a, na.rm = T))
## dat$b <- (dat$b - min(dat$b, na.rm = TRUE)) / (max(dat$b, na.rm = T) - min(dat$b, na.rm = T))
## dat$c <- (dat$b - min(dat$c, na.rm = TRUE)) / (max(dat$c, na.rm = T) - min(dat$c, na.rm = T))
## dat$d <- (dat$c - min(dat$d, na.rm = TRUE)) / (max(dat$d, na.rm = T) - min(dat$d, na.rm = T))


rescale_fun <- function(x) (x - min(x, na.rm = TRUE)) / (max(x, na.rm = T) - min(x, na.rm = T))

dat$a <- rescale_fun(dat$a)
dat$b <- rescale_fun(dat$b)
dat$c <- rescale_fun(dat$c)
dat$d <- rescale_fun(dat$d)

dat <- mutate_all(dat, rescale_fun)

add_one <- function(x){
  x + 1
}

add_one(x = 2)

## a <- 1
## add_one(x = 2, a)

## add_one <- function(x){
##   x + 1 + a
## }
## add_one(2)

url <- 'https://raw.githubusercontent.com/tbep-tech/tbep-r-training/master/data/otbfimdatcmb.csv'
otbfimdat <- read.csv(url, stringsAsFactors = F)

subdat <- otbfimdat %>% 
  filter(Commonname %in% 'Red Drum') %>% 
  filter(avg_size > 18 & avg_size < 27) %>% 
  mutate(Sampling_Date = as.POSIXct(Sampling_Date, format = '%Y-%m-%d %H:%M:%S', tz = 'America/New_York'))

table(subdat$Gear)

subdat <- subdat %>% 
  filter(Gear %in% 20)

p1 <- ggplot(subdat, aes(x = Sampling_Date, y = TotalNum)) + 
  geom_point() + 
  scale_y_log10() + 
  geom_smooth(method = 'lm') + 
  labs(
    x = NULL,
    y = 'Total catch', 
    title = "Red drum catch in gear 20", 
    subtitle = "Data subset to average size between 18-27 inches"
  )
p1

subdat <- otbfimdat %>% 
  filter(Commonname %in% 'Spotted Seatrout') %>% 
  filter(avg_size > 15 & avg_size < 20) %>% 
  filter(Gear %in% 20) %>% 
  mutate(Sampling_Date = as.POSIXct(Sampling_Date, format = '%Y-%m-%d %H:%M:%S', tz = 'America/New_York'))

p2 <- ggplot(subdat, aes(x = Sampling_Date, y = TotalNum)) + 
  geom_point() + 
  scale_y_log10() + 
  geom_smooth(method = 'lm') + 
  labs(
    x = NULL,
    y = 'Total catch', 
    title = "Spotted Seatrout catch in gear 20", 
    subtitle = "Data subset to average size between 15-20 inches"
  )
p2 

plotcatch <- function(name, szrng, gearsel){}

plotcatch <- function(name, szrng, gearsel, datin){}

plotcatch <- function(name, szrng, gearsel, datin){
  
  subdat <- datin %>% 
    filter(Commonname %in% name) %>% 
    filter(avg_size > szrng[1] & avg_size < szrng[2]) %>% 
    filter(Gear %in% gearsel) %>% 
    mutate(Sampling_Date = as.POSIXct(Sampling_Date, format = '%Y-%m-%d %H:%M:%S', tz = 'America/New_York'))
  
  p <- ggplot(subdat, aes(x = Sampling_Date, y = TotalNum)) + 
    geom_point() + 
    scale_y_log10() + 
    geom_smooth(method = 'lm') + 
    labs(
      x = NULL,
      y = 'Total catch', 
      title = paste0(name, " catch in gear ", gearsel), 
      subtitle = paste0("Data subset to average size between ", szrng[1], '-', szrng[2], " inches")
    )
  
  p 
  
}

plotcatch('Red Drum', c(25, 30), 20, otbfimdat)

plotcatch <- function(name = 'Red Drum', szrng = c(18, 27), gearsel = 20, datin = otbfimdat){
  
  subdat <- datin %>% 
    filter(Commonname %in% name) %>% 
    filter(avg_size > szrng[1] & avg_size < szrng[2]) %>% 
    filter(Gear %in% gearsel) %>% 
    mutate(Sampling_Date = as.POSIXct(Sampling_Date, format = '%Y-%m-%d %H:%M:%S', tz = 'America/New_York'))
  
  p <- ggplot(subdat, aes(x = Sampling_Date, y = TotalNum)) + 
    geom_point() + 
    scale_y_log10() + 
    geom_smooth(method = 'lm') + 
    labs(
      x = NULL,
      y = 'Total catch', 
      title = paste0(name, " catch in gear ", gearsel), 
      subtitle = paste0("Data subset to average size between ", szrng[1], '-', szrng[2], " inches")
    )
  
  p
  
}

## x + 1

addone <- function(x) {
  x + 1
}

## subdat <- otbfimdat %>%
##   filter(Commonname %in% 'Spotted Seatrout') %>%
##   filter(avg_size > 15 & avg_size < 20) %>%
##   filter(Gear %in% 20) %>%
##   mutate(Sampling_Date = as.POSIXct(Sampling_Date, format = '%Y-%m-%d %H:%M:%S', tz = 'America/New_York'))
## 
## p <- ggplot(subdat, aes(x = Sampling_Date, y = TotalNum)) +
##   geom_point() +
##   scale_y_log10() +
##   geom_smooth(method = 'lm') +
##   labs(
##     x = NULL,
##     y = 'Total catch',
##     title = "Spotted Seatrout catch in gear 20",
##     subtitle = "Data subset to average size between 15-20 inches"
##   )
## p

plotcatch <- function(otbfimdat, Commonname, avg_size, Gear, Sampling_Date, TotalNum) {
  subdat <- otbfimdat %>% 
    filter(Commonname %in% 'Spotted Seatrout') %>% 
    filter(avg_size > 15 & avg_size < 20) %>% 
    filter(Gear %in% 20) %>% 
    mutate(Sampling_Date = as.POSIXct(Sampling_Date, format = '%Y-%m-%d %H:%M:%S', tz = 'America/New_York'))
  
  p <- ggplot(subdat, aes(x = Sampling_Date, y = TotalNum)) + 
    geom_point() + 
    scale_y_log10() + 
    geom_smooth(method = 'lm') + 
    labs(
      x = NULL,
      y = 'Total catch', 
      title = "Spotted Seatrout catch in gear 20", 
      subtitle = "Data subset to average size between 15-20 inches"
    )
  p 
}
