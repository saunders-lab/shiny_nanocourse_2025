## 
## Shiny Demo App - Plot interactivity with libraries plotly & ggiraph 
## Explore the code below to get a feel for these advanced interactive plotting libraries
## And see how we can get plot inputs from these libraries, similar to ggplot2/base.

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
      sliderInput("max_wait",
                   "Max waiting time:",
                   min = 1,
                   max = 100,
                   value = 100)
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
  
  #Plotly selected example
  output$plot_info <- renderPrint({
    
    event_data('plotly_brushed')
    
    
  })
  
  #Ggiraph selected example
  output$plot_info2 <- renderPrint({
    
    input$distPlot2_selected
    
  })
  
  #Plotly plot example
  output$distPlot <- renderPlotly({
    
    plot <- ggplot(faithful%>% filter(waiting<input$max_wait),
                   aes(x = waiting,y= eruptions)) + 
      geom_point()
    
    ggplotly(plot)
    
  })
  
  
  output$distPlot2 <- renderGirafe({
    
    #Ggiraph plot example
    plot2 <- ggplot(faithful %>% filter(waiting<input$max_wait), 
                    aes(x = waiting,y= eruptions, label = waiting, data_id = waiting)) + 
      geom_point_interactive()
    
    
    girafe(ggobj = plot2)
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
