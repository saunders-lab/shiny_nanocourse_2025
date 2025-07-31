
library(shiny)
library(ggplot2)
library(dplyr)
library(tibble)




ui <- fluidPage(
  titlePanel("Reactive Sampling App"),

  sidebarLayout(
    sidebarPanel(
      numericInput("n", "Observations"),
      textInput("name",   "Greeting name",  value = ""),
      actionButton("go", "Sample")
    ),

    mainPanel(
      plotOutput("hist"),
      verbatimTextOutput("msg")
    )
  )
)

server <- function(input, output, session) {


  ## ── 1. Reactive expression ───────────────────────────────────
  ## Generate 'input$n' random N(0,1) numbers whenever input$n changes.
  ## use rnorm
  # TODO-1: rand <- reactive( ... )

  ## ── 2. Observer (runs on every change of ANY dependency) ────
  ## Show a notification each time the numericInput changes.
  # TODO-2:
  # observe({
  #   ...
  # })

  ## ── 3. observeEvent (runs ONLY when the button is clicked) ──
  ## Pop a quick message when the user hits “Sample”.
  # TODO-3:
  # observeEvent(input$go, {
  #   ...
  # })

  ## ── 4. eventReactive (returns a value after the event) ──────
  ## Take input$n draws from the current rand() vector, but only
  ## after the button is pressed.
  # TODO-4: sampled <- eventReactive( ... )

  ## ── 5. Render a histogram of the sampled data ───────────────
  # TODO-5:
  # output$hist <- renderPlot({
  #   ...
  # })

  ## TODO 6: Render a message in output$msg that:
  ##   • waits until the user has entered a non-empty name
  ##     AND has clicked “Sample” more than once
  ##   • then prints:
  ##       "Hello <name>! You sampled more than once <n> values."
  ##
  ## Hint: use `req()`—it will block until its argument is `TRUE`/non-NULL.
  ##   e.g. `req(input$name)` stops if name == ""
  ##        `req(input$go > 1)` stops until go > 1
  # output$msg <- renderPrint({ ... })



}




shinyApp(ui, server)