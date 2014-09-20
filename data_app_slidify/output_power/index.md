---
title       : Statistical Power App
subtitle    : Calculate Your Power!
author      : Me
job         : unemployed
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Statistical Power App
 
- Use this app if you want to calculate the power of your experiment.
- You can also use this app to get a ballpark estimate of how many observations         you need to take, given a preferred statistical power, alpha, and estimated sigma.


--- .class #id 

## Step 1: Input your data

1. Number of Observations
2. alpha 
3. sigma (this is the population standard deviation) 
4. Estimated Detectable difference (in means of 2 Competing Hypotheses)

## Output on Main Panel
- Calculated Power
- A plot showing the distributions of the two hypotheses and a line marking alpha
- Your input parameters



--- .class #id
### Demo Inputs and Demo App Screen:

1. Number of Observations: 100
2. alpha : .05
3. sigma : 1 
4. Estimated Detectable difference : .1

![plot of chunk unnamed-chunk-1](assets/fig/unnamed-chunk-1.png) 



--- .class #id 

## Some R code Behind the App 


```r
output_power=function(alpha,factor){
        power=1-pnorm(qnorm(1-alpha)-factor)
        return(power)
}

alpha=.05
delta_mu=.1
sigma=1
n_observations=100
factor=delta_mu/(sigma/sqrt(n_observations))
power=output_power(alpha,factor)

y=delta_mu/(sigma/sqrt(n_observations))
x=seq(-abs(y)*.5,abs(y)*1.5,length.out=100)
```
### Power:

0.2595


```
## Warning: plot type 'ln' will be truncated to first character
```

![plot of chunk unnamed-chunk-3](assets/fig/unnamed-chunk-3.png) 
Hope you enjoy this application.




