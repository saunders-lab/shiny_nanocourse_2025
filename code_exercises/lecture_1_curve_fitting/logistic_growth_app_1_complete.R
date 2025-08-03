#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

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
    titlePanel("Logistic growth curve fitting"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("Asym",
                        "Asymptote",
                        min = 1,
                        max = 100,
                        value = 30),
            sliderInput("xmid",
                        "Xmid",
                        min = 1,
                        max = 24,
                        value = 12),
            sliderInput("scal",
                        "Scale",
                        min = 1,
                        max = 10,
                        value = 3),
            sliderInput("noise_sd",
                        "Noise",
                        min = 1,
                        max = 20,
                        value = 5)
        ),

        # Show a plot of the generated distribution
        mainPanel(
          
          #verbatimTextOutput("cells_data")
          plotOutput("cells_plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  #output$cells_data <- renderPrint({  
  output$cells_plot <- renderPlot({  
    
    df_cells <- tibble(hrs = 1:24) %>% 
      mutate(cells = gen_logis(hrs, input$Asym, input$xmid, input$scal, input$noise_sd))
    
    ggplot(df_cells, aes(x = hrs)) + geom_point(aes(y = cells))
    
    })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
