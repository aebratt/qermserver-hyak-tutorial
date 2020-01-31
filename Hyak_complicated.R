# Fit an N-mixture model to estimate mallard abundance
# based on 239 sites monitored 1-3 times
# counts are number of mallard territories
# see ?mallard for more

##### load libraries #####
library(rjags,lib.loc="/gscratch/stf/UWNETID/rpackages")
library(unmarked, lib.loc="/gscratch/stf/UWNETID/rpackages")
data(mallard)

##### model #####
cat("
    model {
      for (i in 1:M) {
        N[i] ~ dpois(lambda)
        for (j in 1:J) {
          y[i,j] ~ dbin(p, N[i])
        }
      }
      lambda ~ dgamma(0.01, 0.01)
      p ~ dbeta(1,1)
    }
    ", fill=TRUE, file="Nmix.txt")

##### set up arguments to jags call #####
data = list(M=dim(mallard.y)[1], J=dim(mallard.y)[2], y=mallard.y)
parameters = c('lambda', 'p')
ySum = apply(mallard.y, 1, max, na.rm=T)
ySum[ySum == -Inf] <- 0
inits = function() {list(p=runif(1,0,1), lambda=rgamma(1, .1, .1), N=ySum+1)}

##### call to jags #####
mod <- jags.model("Nmix.txt", data, inits, n.chains=3, n.adapt=500)
update(mod, 500)
fit <- coda.samples(mod,parameters,n.iter=10000)
#plot(fit)
summ <- summary(fit)
# send parameter posterior means to file
paste(summ$statistics[, "Mean"])
