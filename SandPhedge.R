# clear r environment variables
remove(list=ls())

# read data
SandPhedge<-read.csv('SandPhedge.csv')
SandPhedge$Date = as.Date(paste('01-',SandPhedge$Date), format="%d- %b-%y")

# log returns for spot and futures prices
SandPhedge$rspot = c(NA,100*diff(log(SandPhedge$Spot)))
SandPhedge$rfutures = c(NA,100*diff(log(SandPhedge$Futures)))

summary(SandPhedge[c("rspot","rfutures")])
lm_returns = lm(rspot ~ rfutures,data = SandPhedge)
summary(lm_returns)
lm_prices = lm(Spot ~ Futures,data = SandPhedge)
summary(lm_prices)

# log prices
SandPhedge$lspot = log(SandPhedge$Spot)
SandPhedge$lfutures = log(SandPhedge$Futures)
log_lm = lm(lspot ~ lfutures, data = SandPhedge)

# plot
par(lwd=2,cex.axis = 1)
plot(SandPhedge$Date,SandPhedge$lspot,type = "l",xlab = "",ylab = "",col="red")
lines(SandPhedge$Date,log_lm$fitted.values)
par(new=T)
plot(SandPhedge$Date,log_lm$residuals,col="blue",axes=F,type="l",xlab = "",ylab = "")
axis(side=4, at = pretty(range(log_lm$residuals)))
legend("bottomleft", legend=c("Actual", "Fitted"),col=c("black","red"),lty= 1)
legend("bottomright", legend=c("Resid"),col=c("blue"),lty= 1)

ecm = lm(SandPhedge$rspot[-1] ~ SandPhedge$rfutures[-1] + log_lm$residuals[-1])
summary(ecm)


