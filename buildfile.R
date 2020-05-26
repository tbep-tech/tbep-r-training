# clean
torm <- list.files(pattern = '\\.R$', recursive = F)
torm <- torm[!torm %in% c('index.R', 'buildfile.R')]
file.remove(torm)
rmarkdown::clean_site()

# build
rmarkdown::render_site()
tobld <- list.files(pattern = '\\.Rmd$', recursive = F)
tobld <- tobld[!tobld %in% c('Resources.Rmd', 'index.Rmd')]
sapply(tobld, knitr::purl, documentation = 0L)
