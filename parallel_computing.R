library(parallel)
library(doParallel)
library(foreach)


#Detects the number of cores in your computer

numCores <- detectCores()
numCores

#Forces parallelization 
registerDoParallel(numCores)

#Combining first and last column of iris dataset for 2 of the species
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- 10000

#Bootstrap
system.time({
  r <- foreach(icount(trials), .combine=rbind) %dopar% {
    ind <- sample(100, 100, replace=TRUE)
    result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
    coefficients(result1)
  }
})

#Without doParallel
system.time({
  r <- foreach(icount(trials), .combine=rbind) %do% {
    ind <- sample(100, 100, replace=TRUE)
    result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
    coefficients(result1)
  }
})



#Using lapply() instead of for loop- no parallelization
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- seq(1, 10000)
boot_fx <- function(trial) {
  ind <- sample(100, 100, replace=TRUE)
  result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
  r <- coefficients(result1)
  res <- rbind(data.frame(), r)
}
system.time({
  results <- lapply(trials, boot_fx)
})

#Using mclapply() - parallelization
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- seq(1, 10000)
boot_fx <- function(trial) {
  ind <- sample(100, 100, replace=TRUE)
  result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
  r <- coefficients(result1)
  res <- rbind(data.frame(), r)
}
system.time({
  results <- mclapply(trials, boot_fx, mc.cores = 1) ### Use mc.cores=numCores for non windows
})