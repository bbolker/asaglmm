## load("../DATA/Owls.rda")

dropdev <- function(x) {
  ## FIXME: doesn't change last.values ?
  if (inherits(x,"bugs")) {
    w <- which(x$root.short=="deviance")
    for (i in grep("\\.short$",names(x))) {
      x[[i]] <- x[[i]][-w]
    }
    x <- lapply(x,dropdev)
    class(x) <- "bugs"
    return(x)
  }
  if (!is.null(dim(x))) {
    dn <- dimnames(x)
    for (i in seq_along(dn)) {
      if ("deviance" %in% dn[[i]]) {
        w <- which(dn[[i]]=="deviance")
        x2 <- x[slice.index(x,i)!=w]
        dx <- dim(x)
        dx[i] <- dx[i]-1
        dn[[i]] <- dn[[i]][-w]
        return(array(x2,dim=dx,dimnames=dn))
      }
    }
  } else if ("deviance" %in% names(x)) {
    return(x[names(x)!="deviance"])
  }
  x
}

simfun <- function(beta_count=c(int=3,-0.5,-0.1,-0.05,0.2,-0.02),
                   logitzi=-1.5,
                   nest_sd_count=1) {
  m <- model.matrix(~(FoodTreatment+ArrivalTime)*SexParent,data=Owls)
  re_vec <- rnorm(length(Owls$Nest),sd=nest_sd_count)
  logcount <- m %*% beta_count + Owls$logBroodSize + re_vec[Owls$Nest]
  n <- nrow(Owls)
  ifelse(runif(n)<plogis(logitzi),0,
         rpois(n,exp(logcount)))
}

owls_MCMCglmm_fit <- function(data,save_rand=FALSE) {
  fixef2 <- NCalls~trait-1+
    at.level(trait,1):logBroodSize+
      at.level(trait,1):((FoodTreatment+ArrivalTime)*SexParent)

  prior_overdisp  <- list(R=list(V=diag(c(1,1)),nu=0.002,fix=2),
                          G=list(list(V=diag(c(1,1e-6)),nu=0.002,fix=2)))

  prior_overdisp_broodoff <- within(prior_overdisp,
                                    { B <- list(mu=c(0,1)[offvec],
                                                V=diag(c(1e8,1e-6)[offvec]))})

  MCMCglmm(fixef2,
           rcov=~idh(trait):units,
           random=~idh(trait):Nest,
           prior=prior_overdisp_broodoff,
           pr=save_rand,  ## save random effects
           data=data,
           family="zipoisson",
           verbose=FALSE)
}


zipme.f <- function(maxitr, data) {
#####################################
## EM algorithm for fitting ZIP mixed-effects model
##
##   y is the observation from the distribution:
##           P(Y=0)=p+(1-p)F(0,lambda)
##           P(Y=k)=(1-p)F(k,lambda).
##
##   data : the owl data frame with covariates; assumes data
## already pre-processed per pg 333 of Zuur et al 2009;
##		column order/names: Nest, FoodTreatment, SexParent, ArrivalTime,## NCalls, BroodSize, NegPerChick,
##		logbrdsze; logbrdsze is log(BroodSize).
##
##   formlog : formula for logistic regression. left side should be: z~
##   formpoi : formula for Poisson or NB regression. left side should be: y~
##
##   maxitr  : maximum number of iterations
##
## 2011.3.14 modified from Mihoko's GAMZINB to run ZIP mixed-effect model
##
#############
  ## change NCalls (SiblingNegotiation) to y
  names(data)[5]<-"y"
#
# number of observations
  m<-nrow(data)
#
# model formulae
  formlog<-as.formula("z ~ SexParent*FoodTreatment + SexParent*ArrivalTime + (1|Nest)")
  formpoi<-as.formula("y ~ offset(logBroodSize) + SexParent*FoodTreatment + SexParent*ArrivalTime + (1|Nest)")
#
# initialize z and probz (z=1 -> perfect state; probz is probability of 0 in imperfect state for poisson)
    z<-numeric(m)
    probz<-numeric(m)    
    z[data$y==0]<- 1/(1+exp(-1))
#
# delta is used to gauge convergence. after initialization, it is the abs. difference between current z and new z.    
    itr = 1
    delta<-2
    deltainfo <- numeric(maxitr)
    while((delta>10^(-6)) & (itr <= maxitr)){
	  print(paste("itr: ",itr,sep=""))
#
# make (update) working data frame
          bydataw <- data.frame(z=z,data)
#
#  Maximization 1: logistic
          old.z<-z
          uu<-lmer(formlog, family=binomial, data=data)
# save current logistic model output
          u<-fitted(uu)
#
# Maximization 2: poisson loglinear with weights
          vv<-lmer(formpoi, family=poisson, weights=(1-z), data=bydataw)   
# save Poisson model output
           v<-fitted(vv)
#
# Expectation: used to update z with conditional expectation;only need to update at y=0.
           z[data$y==0]<-u[data$y==0]/( u[data$y==0]+(1-u[data$y==0])*exp(-v[data$y==0]))     
           new.z<-z
#
# updated convergence indicator
           delta<-max(abs(old.z-new.z))
# save delta for this iteration; to be output
           deltainfo[itr] <- delta
           itr = itr+1
     }            
#
     list("uu.binom"=uu, "vv.flm"=vv, itr=itr, deltainfo=deltainfo, z=z)
#
# the outputs are the following:
#    uu.binom : output object of logistic regression; 
#    vv.flm   : output object of poisson regression
}


## BMB generalized version
zipme <- function(cformula, zformula, cfamily=poisson,
                  data, maxitr=20, tol=1e-6, verbose=TRUE) {
#####################################
## EM algorithm for fitting ZIP mixed-effects model
##
##   y is the observation from the distribution:
##           P(Y=0)=p+(1-p)F(0,lambda)
##           P(Y=k)=(1-p)F(k,lambda).
##
##   data : the owl data frame with covariates; assumes data
## already pre-processed per pg 333 of Zuur et al 2009;
##		column order/names: Nest, FoodTreatment, SexParent, ArrivalTime,## NCalls, BroodSize, NegPerChick,
##		logbrdsze; logbrdsze is log(BroodSize).
##
##   formlog : formula for logistic regression. left side should be: z~
##   formpoi : formula for Poisson or NB regression. left side should be: y~
##
##   maxitr  : maximum number of iterations
##
## 2011.3.14 modified from Mihoko's GAMZINB to run ZIP mixed-effect model
##
#############
# number of observations
  m<-nrow(data)
  rname <- as.character(cformula)[2]

## initialize z and probz (z=1 -> perfect state; probz is probability of 0 in imperfect state for poisson)
  
  z<-numeric(m)
  probz<-numeric(m)
  z[data[[rname]]==0]<- 1/(1+exp(-1))  ## starting value

  ## n.b. we are looking for [3] since zformula has a LHS
  randz <- length(grep("\\(.*\\|.*\\)",as.character(zformula)[3]))>0
  ## delta is used to gauge convergence. after initialization, it is the abs. difference between current z and new z.    
  itr <- 1
  delta <- 2
  deltainfo <- numeric(maxitr)
  while(delta>tol & itr <= maxitr){
    if (verbose) cat("itr:",itr,"\n")
    ## make (update) working data frame
    bydataw <- data.frame(z=z,data)
    ##
    ## Maximization 1: logistic
    old.z<-z
    if (randz) {
      uu <- glmer(zformula, family=binomial, data=bydataw)
    } else {
        ## suppress warnings 
        uu <- suppressWarnings(glm(zformula, family=binomial, data=bydataw))
    }
    ## save current logistic model output
    u <- fitted(uu)
    ##
    ## Maximization 2: poisson loglinear with weights
    vv <- glmer(cformula, family=cfamily, weights=(1-z), data=bydataw)   
    ## save Poisson model output
    v <- fitted(vv)
    ##
    ## Expectation: used to update z with conditional expectation;only need to update at y=0.
    zdat <- data[[rname]]==0
    z[zdat] <- u[zdat]/( u[zdat]+(1-u[zdat])*exp(-v[zdat]))
    new.z<-z
    ## updated convergence indicator
    delta<-max(abs(old.z-new.z))
    ## save delta for this iteration; to be output
    deltainfo[itr] <- delta
    itr <- itr+1
  }            
  L <- list("zfit"=uu, "cfit"=vv, itr=itr, deltainfo=deltainfo, z=z)
  ##    uu.binom : output object of logistic regression; 
  ##    vv.flm   : output object of poisson regression
  class(L) <- "zipme"
  L
}
