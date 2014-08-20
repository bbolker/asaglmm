## finding hidden things
library(nlme)
methods("ACF")
## argh, 'Non-visible functions are asterisked'
## we can probably guess that they're living inside the nlme 'namespace'
nlme:::ACF.lme
## but we didn't know that
(gg <- getAnywhere("ACF.lme"))
cbind(gg$name,gg$where)
gg$objs[[1]]
getAnywhere("dens")
library(lme4)
lme4:::dens
getAnywhere("dens")

## there's probably a StackOverflow answer somewhere (maybe by me?)


install.packages(file.choose(),type="source",repos=NULL)
detach("package:bbmle",unload=TRUE)
library("bbmle")
