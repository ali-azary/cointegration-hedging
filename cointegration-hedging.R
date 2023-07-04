# clear R environment variables
remove(list=ls())

# load libraries
library("zoo")
library("urca")

# monthly prices of jet fuel and heating oil
prices <- read.zoo("JetFuelHedging.csv", sep = ",",
                   FUN = as.yearmon, format = "%Y-%m", header = TRUE)

# fit a linear model to explain jet fuel price change by heating oil price  
# changes. the coefficient of the regression is the optimal hedge ratio.
# setting the intercept to zero, i.e., no cash holdings.
simple_mod <- lm(diff(prices$JetFuel) ~ diff(prices$HeatingOil)+0)
# summary(simple_mod)
cat('optimal hedge ratio: '); cat(unname(simple_mod$coefficients))
cat('residual standard error: '); cat(unname(summary(simple_mod)$sigma))

# plot prices
plot(prices$JetFuel, main = "Jet Fuel and Heating Oil Prices",
     xlab = "Date", ylab = "USD")
lines(prices$HeatingOil, col = "red")

# augmented Dickey-Fuller test for unit root (non-stationarity)
jf_adf <- ur.df(prices$JetFuel, type = "drift")
summary(jf_adf)
ho_adf <- ur.df(prices$HeatingOil, type = "drift")
summary(ho_adf)
# non-stationarity cannot be rejected at 1% significance level

# estimate static equilibrium
mod_static <- summary(lm(prices$JetFuel ~ prices$HeatingOil))
error <- residuals(mod_static)
error_cadf <- ur.df(error, type = "none")
summary(error_cadf)
# very small p-value so stationary

# error correction model
djf <- diff(prices$JetFuel)
dho <- diff(prices$HeatingOil)
error_lag <- lag(error, k = -1)
mod_ecm <- lm(djf ~ dho + error_lag)
summary(mod_ecm)

