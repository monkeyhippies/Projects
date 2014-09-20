#server.R
source("output_power.R")

shinyServer(function(input,output){
        output$n_observations=renderPrint({input$n_observations})
        output$alpha=renderPrint({input$alpha})
        output$delta_mu=renderPrint({input$delta_mu})
        output$sigma=renderPrint({input$sigma})
        factor=reactive({input$delta_mu/(input$sigma/sqrt(input$n_observations))})
        output$power=renderPrint({output_power(input$alpha,factor())})
        output$newPlot=renderPlot({
                y=input$delta_mu/(input$sigma/sqrt(input$n_observations))
                x=seq(-abs(y)*.5,abs(y)*1.5,length.out=100)
                plot(x,dnorm(x),type="ln", col="blue")
                lines(x,dnorm(x,mean=y), col="red")
                lines(rep(qnorm(1-input$alpha),2),c(0,.5))
                legend('topright',legend=c("Test 1 Distribution", "Test 2 Distribution", "alpha"), col=c("blue","red","black"),lty=1,cex=.75) 
        })
        
}
)