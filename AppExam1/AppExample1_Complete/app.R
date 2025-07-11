library(shiny)
library(ggplot2)
library(reactlog)



ui <- fluidPage(

  titlePanel("Histogram & Greeting"),
    
  sidebarLayout(
    sidebarPanel(
      numericInput("count",  "Observations",   value = 100, min = 10,  max = 1000),
      sliderInput ("bins",   "Number of bins", value = 10,  min = 1,   max = 50),
      textInput   ("name",   "Greeting name",  value = "Alice")
    ), #end of sidebar panel
    
    mainPanel(
      plotOutput("dist"),
      br(),
      br(),
      textOutput("greeting")
    ) #end of mainpanel
  )# end of sidebar layout
) # end Ui




server <- function(input, output, session) {


   # 1. Greeting text
   output$greeting <- renderText({
    paste0("Hello ", input$name, ", you chose ", input$count, " samples.")
  })
  
  # 2. Reactive expression for random draws
  rand_vals <- reactive({
    rnorm(input$count)
  })
  
  # 3. Histogram
  output$dist <- renderPlot({
    x <- rand_vals()

    #---- In case you use Hist------#
    # # build break sequence so that we have exactly input$bins bins
    # brks <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # hist(x,
    #      breaks = brks,
    #      main  = paste("Histogram of", input$count, "N(0,1) draws"),
    #      xlab  = "Value",
    #      col   = "steelblue",
    #      border= "white")


    df<- data.frame( rand_vals())

    ggplot(df, aes(x)) +
        geom_histogram(
          bins   = input$bins,     
          fill   = "steelblue",   
          colour = "black"  
           ) +
           labs(
             title = "Random normal draws",
             x = "Value",
             y = "Frequency"
           ) +
           theme_minimal()
            
  })
}



shinyApp(ui, server)




