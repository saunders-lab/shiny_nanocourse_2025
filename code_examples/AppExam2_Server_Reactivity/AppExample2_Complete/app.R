
library(shiny)
library(ggplot2)
library(dplyr)
library(tibble)




ui <- fluidPage(
  titlePanel("Reactive Sampling App"),

  sidebarLayout(
    sidebarPanel(
      numericInput("n", "Observations",value=100),
      textInput("name",   "Greeting name",  value = ""),
      actionButton("go", "Sample")
    ),

    mainPanel(
      plotOutput("hist"),
      verbatimTextOutput("msg")
    )
  )
)

server <- function(input, output, session){

  rand <- reactive(rnorm(input$n))        

  observe({                              
    showNotification("n is now", input$n)
  })

  observeEvent(input$go, {               
    showNotification("Sampled!")
  })

  picked <- eventReactive(input$go, {     
    sample(rand(),  input$n)
  })

  output$hist <- renderPlot({ hist(picked(),xlab  = "Histogram")})


 
   output$msg <- renderPrint({
    req(input$name)
    req(input$go > 1)
    paste0("Hello ", input$name, 
           "! You sampled more than once ", input$n, " values.")
   })
 
}

shinyApp(ui, server)