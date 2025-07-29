#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- navbarPage(
    title ="Exercise 2",
    theme = bslib::bs_theme(bootswatch = "darkly"),
    # Tab to plot histogram
      tabPanel(
        "histogram",
        sidebarLayout(
          sidebarPanel(
            sliderInput('bins', "Enter number of bins for histogram:", 2, 100, 10)
          ),
          mainPanel(plotOutput('hist')))),
      
      # Tab for printing user selected number  
      tabPanel(
        "print",
        sidebarLayout(
          sidebarPanel(
            radioButtons('num', "Select number to print", 
                         choices = c("One" = "1", "Five" = "5", "Ten" = "10"),
                         selected = "1")
          ),
          mainPanel(verbatimTextOutput('print')))),
        
      # Tab to show the user selected table
      tabPanel(
        "table",
        sidebarLayout(
          sidebarPanel(
            selectInput('data', "Choose your dataset", ls("package:datasets"))
          ),
          mainPanel(tableOutput("summary")))),
  
    
  )
    
    

# Define server logic required to draw a histogram
server <- function(input, output){
  thematic::thematic_shiny()
  output$hist <- renderPlot({
    x<- faithful$waiting
    hist(x, breaks = input$bins, main = paste("Histograms of Waiting times with ", input$bins, " bins") , col = 'blue')
  })
  
  output$print <- renderPrint({
    paste("Selected number", input$num )
  })
  
  output$summary <-renderTable({
    dataset <- get(input$data, "package:datasets")
    head(dataset)
  })
}


shinyApp(ui, server)

