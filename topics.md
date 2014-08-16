This is a **preliminary** list of topics that I would like to cover.

Monday morning (9-noon)
=======================

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
	     * "keep it maximal"? 
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
* *exercise*: Banta, owls, wildflowers, stuff from GLMM chapter?
	
Monday afternoon (1-5 PM)
==========================

* estimation
    * deterministic algorithms
        * method of moments
		* PQL
		* Laplace approximation
		* adaptive Gauss-Hermite quadrature
* simulation and prediction	
* computation and modularity
* inference
    * Wald < LRT/profile < parametric bootstrap; MCMC
	* issues: finite size, boundaries
* information criteria and (G)LMMs: (levels of focus, AIC vs cAIC)
* R-squared and variable importance measures
* troubleshooting
    * issues with few levels of RE (and solutions)
	* assessing singular fits, convergence warnings
* diagnostics
    * individual-level
    * group-level
	* posterior predictive summaries
* GLMMs: PQL vs Laplace vs AGHQ
	
Tuesday morning (9-noon)
==========================
* extensions:
    * zero-inflation
	* compound distributions (negative binomial etc.)
	* spatial/temporal (phylogenetic) correlation structures, random fields
	* mixture models?
	* GAMMs
* penalized methods (lasso/fence)
* tools:
    * core: lme4, glmmADMB, MCMCglmm, nlme
	* other R: glmmML, MASS::glmmPQL
	* toolboxes: BUGS; AD Model Builder
	* new: TMB, INLA, Stan, NIMBLE

Tuesday afternoon (1-5 PM)
==========================

Papers
===========

* Bolker et al. 2008
* Pinheiro and Chao (GHQ)
* Pinheiro and Bates (variance-cov parameterizations)
* Stroup
* Roulin et al 2007 (owls)
* McKeon et al (Culcita)
* Belshe et al (tundra)
* Elston et al (ticks)
* Breslow 2003 (PQL)
* Vaida and Blanchard (conditional AIC)
* Spiegelhalter et al (DIC)
* Bolker et al 2013
* Gelman et al 2006 (priors)
* Ozgul et al 2009 (tortoises)
* Gelman 2005 (ANOVA)
* Kenward et al 1997
* Schaalje 2002
* Greven et al 2010
* van de Pol (decomposition)
* Murtaugh 2007 (simplicity)
* Jiang (fence)
