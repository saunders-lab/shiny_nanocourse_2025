# -------------------------------------------------------------------------#
# SHINY EXERCISE - ***SOLVED VERSION***
# -------------------------------------------------------------------------#
#  Case study – Shiny workflow practice, part 2
#
#  GOAL: Translate the static analysis CS_logistic_static_analysis.R into an app.
#  Building in complexity, your goal is to advance the CS_logistic_app_1 to now
#  fit the generated logistic data and present the model estimates in a new tab.
#
#  What’s provided:
#    -The solution to CS_logistic_app_1 is provided, now with TODOs and hints
#
#  How to proceed:
#    1. Fill in *TODO-1* through *TODO-3* using the hints.
#    2. Click “Run App” and test after each step.
#
#  Have fun and watch the app come to life!
# -------------------------------------------------------------------------#

library(shiny)
library(tidyverse)
library(modelr)

# Write a function to generate logistic curve data with noise
gen_logis <- function(input, Asym = 100, xmid = 12, scal = 3, noise_sd = 5){
  
  # Calcululate logistic curve for inputs from defined parameters
  vals <- Asym/(1+exp((xmid-input)/scal))
  
  # Add gaussian noise with fixed sd
  noisy_vals <- rnorm(n = length(input), mean = vals, sd = noise_sd)
  
  return(noisy_vals)
  
}

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Logistic growth curve fitting 2"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("Asym",
                        "Asymptote",
                        min = 1,
                        max = 100,
                        value = 30),
            sliderInput("xmid",
                        "Xmid",
                        min = 1,
                        max = 24,
                        value = 12),
            sliderInput("scal",
                        "Scale",
                        min = 1,
                        max = 10,
                        value = 3),
            sliderInput("noise_sd",
                        "Noise",
                        min = 1,
                        max = 20,
                        value = 5)
        ),

        # Show a plot of the generated distribution
        mainPanel(
          
          ## TODO-1: Convert the UI to have two tabs, one for the plot output and one for the model estimates (probably verbatimTextOutput)
          tabsetPanel(
            tabPanel("Plot data", plotOutput("cells_plot")),
            tabPanel("Model estimates", verbatimTextOutput("mod_summary"))
          )
          
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  ## TODO-2: Restructure the server with two reactives, one for the data, df_cells, and one for the model, mod_logis
  # Each of these are needed in both the plot output and the model estimates output, so we need reactives to do this correctly
  
  #df_cells <- reactive()
  df_cells <- reactive({  
    tibble(hrs = 1:24) %>% 
      mutate(cells = gen_logis(hrs, input$Asym, input$xmid, input$scal, input$noise_sd))
  })
  
  #mod_logis <- reactive()
  mod_logis <- reactive({
    nls(formula = cells~SSlogis(input = hrs, Asym, xmid, scal), data = df_cells())
  })
  
  
  output$cells_plot <- renderPlot({  
    
    ## TODO-3: You will need to modify this to now add the model predictions to the dataframe and plot them
    df_cells_pred <- df_cells() %>% 
      add_predictions(mod_logis())
    
    ggplot(df_cells_pred, aes(x = hrs)) + 
      geom_point(aes(y = cells)) + 
      geom_line(aes(y = pred), color = 'blue', size =1)
    
  })
  
  ## TODO-4: Define an output for the model estimates, probably renderPrint.
  output$mod_summary <- renderPrint({ 
    summary(mod_logis())
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
