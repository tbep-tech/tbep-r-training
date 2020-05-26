# print
print('hello world!')

# sequence
seq(1, 10)

# random numbers
rnorm(100, mean = 10, sd = 2)

# average 
mean(rnorm(100))

# sum
sum(rnorm(100))

my_random_sum <- sum(rnorm(100))

my_random_sum

## # install packages from CRAN
## install.packages("tidyverse")
## install.packages("sf")
## install.packages("mapview")
## install.packages("viridis")
## install.packages("USAboundaries")

## library("tidyverse")
## library("sf")
## library("mapview")
## library("viridis")
## library("USAboundaries")

## # Using the help command/shortcut
## # When you know the name of a function
## help("print") # Help on the print command
## ?print # Help on the print command using the `?` shortcut
## 
## # When you know the name of the package
## help(package = "sf") # Help on the package `dplyr`
## 
## # Don't know the exact name or just part of it
## apropos("print") # Returns all available functions with "print" in the name
## ??print # shortcut, but also searches demos and vignettes in a formatted page

dbl_var <- c(1, 2.5, 4.5)
int_var <- c(1L, 6L, 10L)
log_var <- c(TRUE, FALSE, T, F)
chr_var <- c("a", "b", "c")

class(dbl_var)
length(log_var)

## # taking the mean of a character vector
## mean(chr_var)
## 
## # adding two numeric vectors of different lengths
## vec1 <- c(1, 2, 3, 4)
## vec2 <- c(2, 3, 5)
## vec1 + vec2

ltrs <- c('a', 'b', 'c')
nums <- c(1, 2, 3)
logs <- c(T, F, T)
mydf <- data.frame(ltrs, nums, logs)
mydf

fishdat <- read.csv('data/fishdat.csv', stringsAsFactors = F)
statloc <- read.csv('data/statloc.csv', stringsAsFactors = F)

# get the dimensions
dim(fishdat)
dim(statloc)

# get the column names
names(fishdat)
names(statloc)

# see the first six rows
head(fishdat)
head(statloc)

# get the overall structure
str(fishdat)
str(statloc)

## View(fishdat)
## View(statloc)

## library(readxl)
## dat <- read_excel('location/of/excel/file.xlsx')
