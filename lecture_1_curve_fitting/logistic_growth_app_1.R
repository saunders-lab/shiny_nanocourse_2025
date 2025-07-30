#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

# Code example: curve fitting 1
# Fill in the "..." "sections below to create an app that generates a logistic growth data.
# The app should take in logistic parameters as inputs and display the data as a plot.

library(shiny)
library(tidyverse)
library(modelr)

# Write a function to generate logistic curve data with noise
gen_logis <- function(input, Asym = 100, xmid = 12, scal = 3, noise_sd = 5){
  
  # Calcululate logistic curve for inputs from defined parameters
  vals <- Asym/(1+exp((xmid-input)/scal))
  
  # Add gaussian noise with fixed sd
  noisy_vals <- rnorm(n = length(input), mean = vals, sd = noise_sd)
  
  return(noisy_vals)
  
}

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Logistic growth curve fitting 1"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          
          ### Add inputs here ###
          
          # sliderInput(...)
          
          # numericInput(...)
          
        ),

        # Show a plot of the generated distribution
        mainPanel(
          

          ### Add plot here ###
          ### Make sure to refer to your plot name here!
          
          # plotOutput(...)
          
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  ### Define data and plot inside renderPlot ###
  ### Make sure to give your output plot a name!
  
  # output$... <- renderPlot({  
    
    #df_cells <- tibble(hrs = 1:24) %>% 
    #  mutate(cells = gen_logis(input=hrs, Asym=..., xmid=..., scal=..., noise_sd=...))
    
    #ggplot(df_cells, aes(x = hrs, y = cells)) + geom_point()
    
    #})
  
}

# Run the application
shinyApp(ui = ui, server = server)
