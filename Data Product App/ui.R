library(shiny)

shinyUI(pageWithSidebar(
        headerPanel("Calculate Power for your Data"),
        sidebarPanel(
                h3("Input Your Specifications Below"), 
                sliderInput("alpha","alpha for test", min=.01, max=.5, value=.05, step=.01),
                numericInput("n_observations","Number of Observations",value=100,step=1),
                numericInput("delta_mu","Detectable Difference of Competing Tests",value=1,step=.01),
                numericInput("sigma","Estimated sigma of Data", value=1,step=.01),
                h5("Defaults Shown Below:"),
                h6("Number of Observations: 100"),
                h6("alpha: .05"),
                h6("Detectable Difference of Competing Tests: 1"),
                h6("Estimated sigma of Data: 1"),
                p(em("Documentation:",a("Statistical Power",href="index.html")))
        ),
        mainPanel(
                h2("Calculated Power and Relevant Plot"),
                h3("Calculated Power:"),
                verbatimTextOutput("power"),
                h3("Plot showing Power and Means of Competing Tests"),
                plotOutput("newPlot"),
                h3("Your Inputs:"),
                h4("Number of observations"),
                verbatimTextOutput("n_observations"),
                h4("alpha"),
                verbatimTextOutput("alpha"),
                h4("Detectable Difference of Competing Tests"),
                verbatimTextOutput("delta_mu"),
                h4("Sigma"),
                verbatimTextOutput("sigma") 
        )
))