# -------------------------------------------------------------------------#
# SHINY EXERCISE 
# -------------------------------------------------------------------------#
# -------------------------------------------------------------------------#
#  Lecture 3 – Shiny SERVER-SIDE REACTIVITY PRACTICE
#
#  Goal: flesh out the *server* so the UI becomes interactive.
#
#  By the end you should be able to:
#    -build reactive expressions (`reactive`)
#    -trigger code only on events (`eventReactive`, `observeEvent`)
#    -differentiate `observe` vs. `observeEvent`
#    -use `renderPlot` and `renderPrint` to feed outputs
#    -guard execution with `req()`
#
#  What’s provided:
#    -A ready-made UI (numeric input, slider, text box, button, plot, message)
#    -Six numbered TODO blocks you must replace with working code.
#
#  How to proceed:
#    1. Fill in *TODO-1* through *TODO-6* using the hints.
#    2. Click “Run App” and test after each step.
#    3. Experiment—try changing the distribution or adding extra observers.
#
#  Have fun and watch the app come to life!
# -------------------------------------------------------------------------#

library(shiny)
#library(ggplot2) #in case you want to use ggplot instead of hist()

# ------------------------- UI ------------------------------
ui <- fluidPage(
  titlePanel("Lecture3_Exercise"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("n",     "Observations",  value = 100, min = 10,  max = 5000),
      sliderInput ("bins",  "Histogram bins",value = 20,  min = 1,   max = 100),
      textInput   ("name",  "Your name",     value = ""),
      actionButton("draw",  "Draw / Reshuffle")
    ), #end of sidebar panel
    mainPanel(
      plotOutput("hist"),
      verbatimTextOutput("msg")
    ) #end of mainpanel
  ) # end of sidebar layout
) # end Ui

# ------------------------ SERVER ---------------------------
server <- function(input, output, session){
  
  ## TODO-1
  ## Create a *reactive expression* using "input$n" that generates
  ## standard-normal draws every time the numeric input changes.
  ## Hints:
  ## Use  rnorm(...) and reactive({...})
  
  # rand <-
  
  ## TODO-2 
  ## Shuffle the vector, but *only* when the button is clicked.
  ## Hints:
  ## Use sample()
  ## Use eventReactive( ... , { ... } )
  
  # shuffled <- eventReactive( ... )
  
  ## TODO-3 
  ## Pop a notification every time the numeric input changes (input$n).
  ## Hints:
  ## Use observe({  showNotification(...)  })
  
  # observe({})
  
  ## TODO-4 
  ## Pop another notification only when the button is pressed.
  ## Hints:
  ## Use observeEvent( input$draw , { ... } )
  
  # observeEvent( ... )
  
  ## TODO-5 
  ## Render the histogram of *shuffled()* values.
  ## Hints:
  ## - Wait until shuffled() exists  →  req( shuffled() )
  ## - Build breaks with seq( min(shuffled()), max(shuffled()), length.out = input$bins + 1 )(Optional)
  ## - Draw with hist()
  ##    -hist(...,breaks = ...,main = "Histogram of random values",xlab   = "Value")
  
  # output$hist <- renderPlot({ ... })
  
  ## TODO-6 
  ## Friendly message once:
  ##   - the user typed a non-empty name, AND
  ##   - the button has been clicked at least once.
  ## Print:  "Hello <name>! You chose <n> samples."
  ## Hints:
  ## Guard with  req( input$name , input$draw > 0 )
  ## Use  paste0 / paste 
  
  # output$msg <- renderPrint({ ... })
}

# ----------------------  RUN APP ---------------------------
shinyApp(ui, server)
