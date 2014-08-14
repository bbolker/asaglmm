This is a **preliminary** list of topics that I would like to cover.

* visualization: 
    * Cleveland hierarchy
	* grammar of graphics
    * graphical challenges of multi-level data	
	* exploratory vs diagnostic vs presentation
* model definition
    * random effects: varied perspectives
	* model specification: RE, grouping variables, crossed vs nested, etc.
	* advanced model specification (flexLambda, group-specific variances, etc.)
* avoiding mixed models
    * residual tests from unmixed
	* fixed effects
    * two-stage models
	* Hausman tests
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
