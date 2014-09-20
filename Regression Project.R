data(mtcars)
data=data.frame(mtcars)
##0=automatic 1=maual
##Exploratory Summaries
table(data$am) ##shows there are 16 manual and 16 automatic

mpg_manual=subset(data,data$am==1)
mpg_automatic=subset(data,data$am==0)


summary(mpg_manual$mpg)##seems in general that manual data shows higher mileage
summary(mpg_automatic$mpg)

sapply(mpg_manual,mean) ##seems that automatic cars are generally heavier,have more cylinders, and have more horsepower, and more displacement
sapply(mpg_automatic,mean)
pairs(data) ###From graphs, it seems weight, horsepower, number of cylinders, displacement all seem to negatively affect mpg.  Knowing this, it's unclear how automatic and manual settings affect mpg
##Exploratory Histogram
library(ggplot2)
data$am=factor(data$am)
qplot(mpg,data=data,color=am,binwidth=2,fill=am)



##Models

## First, look just at mpg versus manual/automatic
        fits=lm(data$mpg~factor(data$am))
        fits_coeff=summary(fits)$coefficients
        qt(.975,32-4)*fits_coeff[2,2]*c(-1,1)+fits_coeff[2,1]##shows that ignoring all other variables, 95% confidence interval shows manual has better mileage
##look mpg with various variables:
fit0=lm(data$mpg~data$wt)
plot(data$wt,data$mpg,col=(data$am==0)*1+1)
abline(c(fit0$coefficients[1],fit0$coefficients[2]),col=4)
title("Red=Automatic; Black=Manual")

fit=lm(data$mpg~data$wt+data$am*data$wt)
plot(data$wt,data$mpg,col=(data$am==0)*1+1)
abline(c(fit$coefficients[1],fit$coefficients[2]),col=2)
abline(c(fit$coefficients[1]+fit$coefficients[3],fit$coefficients[2]+fit$coefficients[4]),col=1)
title("Red=Automatic; Black=Manual")
        ###Calculate confidence interval of fit
                fit_coeff=summary(fit)$coefficients
                qt(.975,32-4)*fit_coeff[4,2]*c(-1,1)+fit_coeff[4,1] ##shows that within 95% confidence interval, automatic has better mpg for high weight and worse for lighter weight (around a little less than 3000 pounds is where intersect is)

fit2=lm(data$mpg~data$wt+data$am*data$wt+data$disp)
fit3=lm(data$mpg~data$wt+data$am*data$wt+data$disp+data$hp)
anova(fit0,fit,fit2,fit3)  ##shows that fitting data; Shows that we can account for weight, manual/automatic, and displacement, but other variables seem unnecessary

##Residuals for fits and fit plots:
plot(data$wt,resid(fit))
lm(data$wt~resid(fit))##plot shows residuals are good, no pattern, and talking regression of resids shows no slope to residuals
plot(data$wt,resid(fits))
lm(data$wt~resid(fits)) ##fits shows a slight downward slope to resids, which indicates this model might not be that good
dfbetas=dfbetas(fit)
max(dfbetas[,4]) ##max in dfbetas for our interaction coefficient(weight&am) is relatively small ~.4, which is less than 10% of coefficient's value

t.test(mpg_manual,mpg_automatic)