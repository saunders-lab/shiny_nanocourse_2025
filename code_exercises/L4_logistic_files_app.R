# -------------------------------------------------------------------------#
# SHINY EXERCISE 
# -------------------------------------------------------------------------#
#  Case study – Shiny workflow practice, part 3
#
#  GOAL: Convert the part 2 app to now take in logistic data files (csv).
#        Use plot interactivity to select a subset of data to fit the model to.
#        Display the new subsetted data and model if in a separate tab / plot.
#
#  What’s provided:
#    -The solution to CS_logistic_app_2 has been refactored to help you construct this app 3.
#    -Use the csv file 'L4_logistic_data_Asym100_xmid12_scal2_noise3.csv' to test the app
#
#  How to proceed:
#    1. Fill in *TODO-1* through *TODO-6* using the hints.
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
          
          # TODO-1: Define an upload button with fileInput()
          #################################################
        ),

        mainPanel(
          
          ## TODO-2: Add a brush to the cells_plot in tab 1. You will use this brush input to subset the uploaded data.
          tabsetPanel(
            tabPanel("Plot data", plotOutput("cells_plot")),
            tabPanel("Subset data", plotOutput("subset_model_plot")),
            tabPanel("Model estimates", verbatimTextOutput("mod_summary"))
          )
          
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  ## TODO-3: Define a reactive, df_cells, that imports the input file with read_csv
  df_cells <- reactive({  
    #############################
  })
  
  # TODO-4: Make a new reactive, df_cells_subset, that uses brushedPoints to subset df_cells()
  # Bonus: To avoid the error before file upload / brushing, also add req() here
  df_cells_subset <- reactive({

    #############################

  })
  
  # TODO-5: Update nls to use df_cells_subset instead of the original df_cells
  mod_logis <- reactive({
    
    nls(formula = cells~SSlogis(input = hrs, Asym, xmid, scal), data = df_cells())
    
  })
  
  output$cells_plot <- renderPlot({  
  
    ## Bonus: To avoid the error before file upload, add req() here
    
    #This is just the standard logistic plot we have made - no model
    ggplot(df_cells(), aes(x = hrs, y = cells)) + geom_point()
    
  })
  

  output$subset_model_plot <- renderPlot({

    ## TODO-6: Update to use df_cells_subset, instead of the original df_cells.
    df_cells_pred <- df_cells() %>% 
      add_predictions(mod_logis())
    
    #print(df_cells_pred)
    
    ggplot(df_cells_pred, aes(x = hrs)) + 
      geom_point(aes(y = cells)) + 
      geom_line(aes(y = pred), color = 'blue', size =1)

  })
  
  #This part does not need to change if you structure the app correctly
  output$mod_summary <- renderPrint({ 
    
    summary(mod_logis())
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
