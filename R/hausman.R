phtest_glmer <- function (glmerMod, glmMod, ...)  {
    coef.wi <- coef(glmMod)
    coef.re <- fixef(glmerMod)
    vcov.wi <- vcov(glmMod)
    vcov.re <- vcov(glmerMod)
    names.wi <- names(coef.wi)
    names.re <- names(coef.re)
    coef.h <- names.re[names.re %in% names.wi]
    dbeta <- coef.wi[coef.h] - coef.re[coef.h]
    df <- length(dbeta)
    dvcov <- vcov.re[coef.h, coef.h] - vcov.wi[coef.h, coef.h]
    stat <- abs(t(dbeta) %*% as.matrix(solve(dvcov)) %*% dbeta)
    pval <- pchisq(stat, df = df, lower.tail = FALSE)
    names(stat) <- "chisq"
    parameter <- df
    names(parameter) <- "df"
    alternative <- "one model is inconsistent"
    res <- list(statistic = stat, p.value = pval, parameter = parameter, 
        method = "Hausman Test",  alternative = alternative,
                data.name=deparse(glmerMod@call$data))
    class(res) <- "htest"
    return(res)
}

library(lme4)
gm1 <- glmer(cbind(incidence, size - incidence) ~ period + (1 | herd),
                   data = cbpp, family = binomial)
gm0 <- glm(cbind(incidence, size - incidence) ~ period +  herd,
                   data = cbpp, family = binomial)
  
phtest_glmer(gm1,gm0)
