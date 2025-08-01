# ───────────────────────────────────────────────────────────
# Shiny template: complete the server logic
# ───────────────────────────────────────────────────────────

library(shiny)          # every Shiny app needs this
library(ggplot2)        # if you use ggplot

# ------------------- UI ------------------------------------
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
        textOutput("greeting")
      ) #end of mainpanel
    )# end of sidebar layout
  ) # end Ui
  
# ----------------- SERVER (your turn!) ---------------------
server <- function(input, output, session) {


    ## TODO
  ## 1. Display a friendly sentence like:
  ##    “Hello Alice ,  you chose 100 samples.”
  ##    
  ## Use renderText({ … }) and paste() together

  # output$greeting <- 



  ## TODO
  ## 2. Create a *reactive expression* that generates
  ##    `input$count` standard-normal draws every time the
  ##    numeric input changes.
  ##    
  ## Hint: use `reactive({ rnorm( … ) })`
  
  # rand_vals <- 


  ## TODO
  ## 3. Build the histogram.  It should:
  ##    a) take the vector from rand_vals()
  ##
  ##    b) cut it into *exactly* input$bins bins (tip: build
  ##          your own break sequence with seq(min, max, length.out = ...))
  ##
  ##    c) create histogram: use hist or ggplot
  ##       Example with:   hist( x,breaks = brks, main = "Title",xlab = "x-axis label")
  ##       
  ##        
  ## Remember: put the whole block inside renderPlot({ … }).

   # output$dist <- 

}

# ----------------- RUN THE APP -----------------------------
shinyApp(ui, server)

