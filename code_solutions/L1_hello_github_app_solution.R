# -------------------------------------------------------------------------#
# SHINY EXERCISE - ***SOLVED VERSION***
# -------------------------------------------------------------------------#
#  Lecture 1 – Shiny Overview
#
#  Goal: Get code exercise from course github and successfully modify file!
#
#  What’s provided:
#    -A ready-made UI (numeric input, slider, text box, button, plot, message)
#    -Six numbered TODO blocks you must replace with working code.
#
#  How to proceed:
#    1. Fill in *TODO-1* through *TODO-6* using the hints.
#    2. Click “Run App” and test after each step.
#
#  Have fun and watch the app come to life!
# -------------------------------------------------------------------------#

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Hello github!"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({

    
    ## TODO-1: Reformat base old faithful histogram to ggplot code
    
    ggplot(faithful, aes(x = waiting)) +
      geom_histogram(bins = input$bins, fill = 'light blue', color = 'black') +
      theme_classic()+
      labs(x='Old faithful eruption waiting times (min)')
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
