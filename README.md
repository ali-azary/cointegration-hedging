# cointegration-hedging

Linear combination of nonstationary time series to get a stationary time series.
One application is mean reversion trading of a pair of assets, or also baskets of assets that are separately interrelated like cryptocurrencies that are highly correlated.
It can also be used for hedging purposes.

Cointegration

For non-stationary time series $x_t$ and $y_t$, if $a x_t + b y_t$ is stationary, then they are cointegrated.

stationarity

A time series (or stochastic process) is defined to be strongly stationary if its joint probability distribution is invariant under translations in time or space. the mean and variance of the process do not change over time or space and they each do not follow a trend.

Hurst Exponent

$$V(\tau)=E\{[log(t+\tau)-log(t)]^2\}\sim \tau^{2H}$$
A time series can then be characterized in the following manner:
H < 0.5: The time series is mean reverting
H = 0.5: The time series is a geometric Brownian motion
H > 0.5: The time series is trending

Mean reversion

A continuous mean-reverting time series can be represented by an Ornstein-Uhlenbeck stochastic differential equation:
$$dx_t=\theta(\mu-x_t)dt+\sigma dW_t$$
In a discrete setting the equation states that the change of the price series in the next time period is proportional to the difference between the mean price and the current price, with the addition of Gaussian noise. This property motivates the Augmented Dickey-Fuller Test.
Mathematically, the ADF is based on the idea of testing for the presence of a unit root in an autoregressive time series sample. It makes use of the fact that if a price series possesses mean reversion, then the next price level will be proportional to the current price level. A linear lag model of order p is used for the time series:
$$\Delta y_t=\alpha + \beta t + \gamma y_{t-1}+\delta_1 \Delta y_{t-1} + \cdots +\delta_{p-1} \Delta y_{t-p+1} + \epsilon_t$$
If the hypothesis that $\gamma=0$ can be rejected then the following movement of the price series is proportional to the current price and thus it is unlikely to be a random walk. 
$$DF_\tau=\frac{\hat \gamma}{SE(\hat \gamma)}$$
If p-value less than 0.01 null hyp rejected so time series is stationary.

Simulation of cointegrated time series

Time series $x_t$ and $y_t$ using the random walk $z_t=z_{t-1}+w_t$:
$$x_t=p z_t + w_{x,t}$$
$$y_t = q z_t + w_{y,t}$$
Taking a linear combination:
$$a x_t + b y_t = (a p + b q) z_t + a w_{x,t} + b w_{y,t}$$
So, if $a p + b q = 0$, then we have a stationary time series.

Engle–Granger two-step method

If  and $y_t$ are non-stationary and order of integration d=1, then a linear combination of them must be stationary for some value of $\beta$ and $u_t$:
$$y_t-\beta x_t=u_t$$
Estimate $\beta$ first by regressing y on x and run stationarity test like Dickey Fuller on the estimated residuals $\hat u_t$. Then, regress first difference variables on the lagged residuals $\hat u_{t-1}$.
$$A(L) \Delta y_t=\gamma+B(L) \Delta x_t+\alpha\left(y_{t-1}-\beta_0-\beta_1 x_{t-1}\right)+\nu_t$$
$$y_t=\beta_0+\beta_1 x_t+\varepsilon_t$$
$$\hat{\varepsilon_t}=y_t-\beta_0-\beta_1 x_t$$
$$A(L) \Delta y_t=\gamma+B(L) \Delta x_t+\alpha \hat{\varepsilon}_{t-1}+\nu_t$$

![Rplot](https://github.com/ali-azary/cointegration-hedging/assets/69943289/c8c2741a-ebdb-44a2-94cb-3ea6f4d069fe)

