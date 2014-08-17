* spatial and temporal autocorrelation: diagnostics and treatments.
* What is the difference between GLMM and hierarchical models?
* Spend some time on the basics of terminology. Is the term "random effects" used consistently in the ecological literature? If so, why am I always so confused?
* I am most interested in the applying this course to a situation where I wish to make a predictive species distribution model (response = occurrence or abundance of white spruce) combining abiotic spatial factors (e.g. topography and climate) with biotic interactions (e.g. biomass of a competitor).
* Predictions from glmm models ... count data of a duck species collected using aerial surveys (transects) on a wildlife refuge.
* Confidence intervals on predictions from the glmms.  It is obvious how we incorporate the fixed effects, but incorporating the predicted variation from the random effects is not intuitive to me.
* algorithms, algorithms, algorithms.  Tell us how those models are being fit behind the scenes.
* Nested vs crossed random effects.   Is this mainly a biological decision?  Could you go through a messy example of the logic you used for sorting out how to set up the random-effects part of your model?
* A study where sampling units are plots along a transect ... These plots are essentially segments of the transect (i.e they are not independent) where adjacent plots are more closely related than those far away (dependency decreases with distance from the center of a plot).  I currently have the random effects part of the model as plot nested in transect (plot| transect), but wondered if there is a better way to deal with this problem.
