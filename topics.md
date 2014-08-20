* This is a **preliminary** list of topics that I would like to cover.
* I have no idea if these ideas are really going to fit into the time available. Hopefully we will spend a chunk of time working on individual data sets.

Monday morning (9-noon)
=======================

## Introduction and context

* introductions
    * discuss available data sets/projects
	* references: 
	     * Bolker et al 2009 TREE (obsolete?)
		 * Bates et al in review ArXiv/JSS: LMMs
		 * Bates et al in prep: GLMMs
		 * Bolker in review Fox et al
    * methods/packages: `lme4`, `glmmADMB`, `MCMCglmm`, "other"
	     * `lme4`
		     * fastest
			 * user-specified families
	     * `glmmADMB`
		     * flexibility: zero-inflation, compounded/extended distributions
	     * `MCMCglmm`
		     * propagation of variability
			 * multi-type models, pedigree/phylogeny
* visualization: 
    * Cleveland hierarchy
	* grammar of graphics
    * exploratory vs diagnostic vs presentation
    * coefficient plots
    * graphical challenges of multi-level/hierarchical data	
	     * spaghetti plots; facets
* available examples:
    * Fox et al. chapter:
         * tundra carbon
		 * coral symbionts
		 * gopher tortoise mycoplasma
		 * grouse ticks
    * *Arabidopsis* clipping 
	* owls (Roulin and Bersier)
	* *Glycera*
	* `lme4` package: contagious bovine pleuropneumonia
	* `mlmRev` package
	     * contraception 
		 * Guatemala health care (Rodriguez and Goldman)
* model definition
    * notation (X, beta, Z, b, u, Lambda, Sigma)
    * GLMs: exponential family
    * random effects: varied perspectives (Gelman 2005)
	     * allowance for non-independence
	     * shrinkage estimation
		 * (random) sample from exchangeable units
		 * units within a hyperprior specification
		 * variance as target of estimation
		 * nuisance parameters
		 * allow extrapolation to other units
	* model specification: scalar vs non-scalar RE, grouping variables, crossed vs nested, etc.
	     * "keep it maximal" (Schielzeth and Forstmeier 2009, Barr et al 2013)?
	* advanced model specification (`flexLambda`, `dummy`/group-specific variances, double-bar notation, etc.)
	* overdispersion, observation-level random effects
	* R-side effects; correlation structures on latent variables
	* conditional, marginal, restricted likelihood
* avoiding mixed models
    * residual tests from iid model
	* use fixed effects
	* aggregate (Murtaugh 2007)
    * two-stage models (`lmList` etc.)
	* Hausman tests (`hausman.R`)
	
**ACTIVITY**

* pick one of the examples from the Fox *et al.* chapter (or?) the Banta example; work through it. Make a list of things that you can't do/would like to do; save any new pictures you create/conclusions you come to.  Try some of the extensions from the examples.
	
Monday afternoon (1-5 PM)
==========================

## Estimation

* estimation
    * finding conditional modes
        * `lme4` (linear solution; PIRLS)
		* `glmmADMB` (brute force)
		
**ACTIVITY** ??

Tuesday morning
============================

## Algorithms continued

* integration for GLMMs: deterministic algorithms
    * penalized quasi-likelihood
    * Laplace approximation
	* adaptive Gauss-Hermite quadrature
	* (INLA)
* integration; stochastic algorithms
    * MCMC
	* etc. (MCEM; data cloning)
* modular structure of `lme4`
    * conceptual
        * level I: PLS/finding conditional modes (lmer paper)
    	* level II: PIRLS/integration (glmer paper)
	    * level III: nonlinear optimization (lmer paper)
    	* level IV: formula construction, interface, accessor methods, prediction and simulation, etc.
	* programming
	    * `[g]lFormula`
		* `mk(Gl|L)merDevfun`
		* `optimize(Gl|L)mer`
		* `updateGlmerDevfun`
		* `mkMerMod`

## Diagnostics and troubleshooting

* troubleshooting
    * issues with few levels of RE (and solutions)
	* assessing singular fits, convergence warnings
	* slices
* diagnostics
    * individual-level
    * group-level
	* posterior predictive summaries
* assessing temporal/spatial covariance in residuals
    * spatial/temporal maps of residuals (colour, alpha, size), possibly interpolated
	* fit residuals with null model (e.g. `gls`), use `ACF` or `Variogram` from `nlme`; tools from `spdep` to compute Moran correlogram?

## Inference (core)

* model comparison: Wald < LRT < parametric bootstrap; MCMC
* confidence intervals: Wald < likelihood profile < PB; MCMC
* finite size effects (LMMs: $\chi^2$ vs $F$)
* finite size effects (Bartlett)
* boundary effects

Tuesday afternoon
===========================

## Post-fit assessment/extended inference

* Variances of conditional modes
* Prediction and simulation
* Confidence intervals on predictions/derived quantities
* information criteria and (G)LMMs: (levels of focus, AIC vs DIC vs cAIC)
* R-squared, repeatability, and all that
* Variable importance and all that
    * scaled coefficients
	
## Extensions	

* **zero-inflation**
* restricted variance structures, revisited
* **space/time: correlation structures**
    * nesting
	* spatial/temporal (phylogenetic) correlation structures, pedigrees, random fields
	* SAR/CAR??
	* discrete mixture models?
	* GAMMs
* **nonlinear models**
* **multinomial models** (??)
* compound distributions (negative binomial etc.)
    * `glmer.nb`
* penalized methods 
    * lasso; fence?
	* penalization via random effects specification with fixed $\theta$
* multivariate models via stacking; multitype models
* survival analysis, non-standard links, offsets ...

* tools:
    * core: `lme4`, `glmmADMB`, `MCMCglmm`, `nlme`
	* other R: `glmmML`, `MASS::glmmPQL`
	* toolboxes: BUGS (WinBUGS/OpenBUGS/JAGS); AD Model Builder
	* new: TMB, INLA, Stan, NIMBLE, ?? ...
	* commercial: Stata, AS-REML/Genstat, SAS

## To do

* worked example with pictures of linear model components (cf Bates chapter); add multi-effect model, e.g. Banta
* spatial/temporal correlation stuff: Contraception?  simulation
* convergence testing: kt_rep example, Banta example
      * add to 'troubleshooting'
	  * allFit
	  * refit
	  * slice2D
	  * multiStart
* zero-inflation	  
