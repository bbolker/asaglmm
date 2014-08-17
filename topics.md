* This is a **preliminary** list of topics that I would like to cover.
* I have no idea if these ideas are really going to fit into the time available. Hopefully we will spend a chunk of time working on individual data sets.

Monday morning (9-noon)
=======================

## Introduction and context

* introductions
* visualization: 
    * Cleveland hierarchy
	* grammar of graphics
    * exploratory vs diagnostic vs presentation
    * coefficient plots
    * graphical challenges of multi-level/hierarchical data	
	     * spaghetti plots; facets
* model definition
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
	     * "keep it maximal" (Barr et al 2013)?
	* advanced model specification (`flexLambda`, `dummy`/group-specific variances, double-bar notation, etc.)
	* overdispersion, observation-level random effects
	* R-side effects; correlation structures on latent variables
	* conditional, marginal, restricted likelihood
* avoiding mixed models
    * residual tests from iid model
	* fixed effects
	* aggregate (Murtaugh 2007)
    * two-stage models (`lmList` etc.)
	* Hausman tests (?)
* examples:
    * tundra carbon
	* *Glycera*
	* *Arabidopsis* clipping
	* owls
	* ticks
	* wildflowers?
	* gopher tortoise
* *exercise*: Banta, owls, stuff from GLMM chapter?
	
Monday afternoon (1-5 PM)
==========================

## Estimation

* estimation
    * finding conditional modes
        * `lme4` (linear solution; PIRLS)
		* `glmmADMB` (brute force)
    * integration: deterministic algorithms
        * method of moments
		* PQL
		* Laplace approximation
		* adaptive Gauss-Hermite quadrature
		* (INLA)
	* integration; stochastic algorithms
	    * MCMC
		* etc. (MCEM; data cloning)
* modular structure of `lme4`
    * conceptual
        * level I: PLS/finding conditional modes (lmer paper
    	* level II: PIRLS/integration
	    * level III: nonlinear optimization
    	* level IV: formula construction, interface, accessor methods, prediction and simulation, etc.
	* programming
	    * `[g]lFormula`
		* `mk(Gl|L)merDevfun`
		* `optimize(Gl|L)mer`
		* `updateGlmerDevfun`
		* `mkMerMod`

Tuesday morning
============================

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

* compound distributions (negative binomial etc.)
    * `glmer.nb`
* zero-inflation
* restricted variance structures, revisited
* correlation structures
    * nesting
	* spatial/temporal (phylogenetic) correlation structures, pedigrees, random fields
	* SAR/CAR??
	* discrete mixture models?
	* GAMMs
* penalized methods 
    * lasso; fence?
	* penalization via random effects specification with fixed $\theta$
* multivariate models via stacking; multitype models
* survival analysis, non-standard links, offsets ...

* tools:
    * core: lme4, glmmADMB, MCMCglmm, nlme
	* other R: glmmML, MASS::glmmPQL
	* toolboxes: BUGS; AD Model Builder
	* new: TMB, INLA, Stan, NIMBLE

