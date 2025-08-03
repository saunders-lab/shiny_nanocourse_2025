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
library(plotly)
library(ggiraph)
library(bslib)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      numericInput("bins",
                   "Number of bins:",
                   min = 1,
                   max = 50,
                   value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(   
        tabPanel("plotly",      
                 plotlyOutput("distPlot"),
                 verbatimTextOutput('plot_info')
                 ),
        tabPanel( "ggiraph",     
          girafeOutput("distPlot2"),
          verbatimTextOutput('plot_info2')
        ),

      
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$plot_info <- renderPrint({
    #input$plot_click
    
    #nearPoints(faithful, input$plot_brush)
    
    #brushedPoints(faithful, input$plot_brush)
    
    event_data('plotly_brushed')
    
    
  })
  
  output$plot_info2 <- renderPrint({
    
    input$distPlot2_selected
    
    
  })
  
  output$distPlot <- renderPlotly({
    
    plot <- ggplot(faithful, aes(x = waiting,y= eruptions)) + geom_point()
    
    ggplotly(plot)
    
  })
  
  
  output$distPlot2 <- renderGirafe({
    
    plot2 <- ggplot(faithful, aes(x = waiting,y= eruptions, label = waiting, data_id = waiting)) + geom_point_interactive()
    
    
    girafe(ggobj = plot2)
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
