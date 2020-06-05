# clean
torm <- list.files(pattern = '\\.R$', recursive = F)
torm <- torm[!torm %in% c('index.R', 'buildfile.R')]
file.remove(torm)
file.remove('data/data.zip')
rmarkdown::clean_site()

# build
rmarkdown::render_site()
source('R/dat_proc.R')
tobld <- list.files(pattern = '\\.Rmd$', recursive = F)
tobld <- tobld[!tobld %in% c('Resources.Rmd', 'index.Rmd')]
sapply(tobld, knitr::purl, documentation = 0L)
