# -------------------------------------------------------------------------#
# SHINY EXERCISE 
# -------------------------------------------------------------------------#
#  Case study – Shiny workflow practice, part 1
#
#  GOAL: Translate the static analysis CS_logistic_static_analysis.R into an app.
#  Starting simple, your first goal is to make an app that generates and plots
#  logistic data according to user inputs
#
#  What’s provided:
#    -The UI structure is largely defined
#    -The gen_logis function from the static analysis is already defined here
#
#  How to proceed:
#    1. Fill in *TODO-1* through *TODO-3* using the hints.
#    2. Click “Run App” and test after each step.
#
#  Have fun and watch the app come to life!
# -------------------------------------------------------------------------#

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

# Define UI 
ui <- fluidPage(

    # Application title
    titlePanel("Logistic growth curve fitting 1"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          
          ### TODO-1: Add inputs for the gen_logis() arguments:
          #   - Asym
          #   - xmid
          #   - scal
          #   - noise_sd
          
          # for example: sliderInput('noise_sd')
          
          
        ),

        # Show a plot
        mainPanel(
          

          ### TODO-2: Add plot here ###
          ### Make sure to refer to your plot name here!
          
          # plotOutput(...)
          
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  ### TODO-3: Define data and plot inside renderPlot ###
  ### Make sure to give your output plot a name!
  
  # output$... <- renderPlot({  
    
    #df_cells <- tibble(hrs = 1:24) %>% 
    #  mutate(cells = gen_logis(input=hrs, Asym=..., xmid=..., scal=..., noise_sd=...))
    
    #ggplot(df_cells, aes(x = hrs, y = cells)) + geom_point()
    
    #})
  
}

# Run the application
shinyApp(ui = ui, server = server)
