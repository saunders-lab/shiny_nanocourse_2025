# ───────────────────────────────────────────────────────────
# SHINY EXERCISE Lecture 3 
# ───────────────────────────────────────────────────────────
library(shiny)
#library(ggplot2)

# -----------------------  UI  ------------------------------
ui <- fluidPage(
  titlePanel("Lecture3_Exercise"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("n",     "Observations",  value = 100, min = 10,  max = 5e4),
      sliderInput ("bins",  "Histogram bins",value = 20,  min = 1,   max = 100),
      textInput   ("name",  "Your name",     value = ""),
      actionButton("draw",  "Draw / Reshuffle")
    ), #end of sidebar panel
    mainPanel(
      plotOutput("hist"),
      verbatimTextOutput("msg")
    ) #end of mainpanel
  ) #end of sidebar layout
) # end Ui

# --------------------- SERVER ------------------------------
server <- function(input, output, session){
  
  ## TODO-1
  rand <- reactive({
    rnorm(input$n)
  })
  
  ## TODO-2 
  shuffled <- eventReactive(input$draw, {
    sample(rand())
  })
  
  ## TODO-3 
  observe({
    showNotification(
      paste("New vector length:", input$n),
      type = "message", duration = 2
    )
  })
  
  ## TODO-4 
  observeEvent(input$draw, {
    showNotification("Values reshuffled!", duration = 1)
  })
  
  ## TODO-5 
  output$hist <- renderPlot({
    req(shuffled())                        
    brks <- seq(min(shuffled()),
                max(shuffled()),
                length.out = input$bins + 1)
    hist(shuffled(),
         breaks = brks,
         main   = "Histogram of random values",
         xlab   = "Value")
  })
  
  ## TODO-6
  output$msg <- renderPrint({
    req(input$name, input$draw > 0)
    paste0("Hello ", input$name, "! ",
               "You chose ", input$n, " samples.")
  })
}

# --------------------  RUN APP  -----------------------------
shinyApp(ui, server)


