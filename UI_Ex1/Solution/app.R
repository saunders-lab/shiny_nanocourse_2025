library(shiny)


ui <- fluidPage(
  sliderInput('bins', "Enter number of bins for histogram:", 2, 100, 10),
  radioButtons('num', "Select number to print", 
               choices = c("One" = "1", "Five" = "5", "Ten" = "10"),
               selected = "1"),
  selectInput('data', "Choose your dataset", ls("package:datasets")),
  
  plotOutput('hist'),
  verbatimTextOutput('print'),
  tableOutput("summary")
)



server <- function(input, output){
  output$hist <- renderPlot({
    x<- faithful$waiting
    hist(x, breaks = input$bins, main = paste("Histograms of Waiting times with ", input$bins, " bins") , col = 'darkgreen')
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