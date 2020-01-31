# Plot counts of mallard territories
# based on 239 sites monitored 1-3 times
# counts are number of mallard territories
# see ?mallard for more

##### load libraries #####
library(unmarked, lib.loc="/gscratch/stf/UWNETID/rpackages")
data(mallard)

##### call to jags #####
pdf("Hyak_complicated_output.pdf")
par(mfrow = c(1,3))
hist(mallard.y[, 1])
hist(mallard.y[, 2])
hist(mallard.y[, 3])
dev.off()
