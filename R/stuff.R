## finding hidden things

## this is a very useful, recent post of R navigational tools:
##  http://www.burns-stat.com/r-navigation-tools/

library(nlme)
methods("ACF")
## argh, 'Non-visible functions are asterisked'
## we can probably guess that they're living inside the nlme 'namespace'
nlme:::ACF.lme
## but we didn't know that
(gg <- getAnywhere("ACF.lme"))
cbind(gg$name,gg$where)
gg$objs[[1]]

## another example:
library(lme4)
lme4:::dens
getAnywhere("dens")


## incantation for installing and replacing the bbmle package
## with a newer version:
install.packages(file.choose(),type="source",repos=NULL)
detach("package:bbmle",unload=TRUE)
library("bbmle")
