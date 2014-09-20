##give me power, number of data points, alpha, detectable difference, sigma
##sigma should be square root of sample variance
output_power=function(alpha,factor){
        power=1-pnorm(qnorm(1-alpha)-factor)
        return(power)
}

