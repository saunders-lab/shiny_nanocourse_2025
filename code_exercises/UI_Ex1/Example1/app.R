# Exercise 1
# In this exercise you will learn how input and output functions work
# The code below is incomplete. Comments have been provided to help you fill it with code
# You will have to work on most of the UI code and also some parts of the Server

## ------- Loading required Libraries --------------
library(shiny)


##----------------------UI--------------------------

ui <- fluidPage(
  
  ## TODO
  ## 1. define a slider that decides how many bins are present in the plotted histogram
  
  ## 2. Define a user input where user can select one option from 
  ##     multiple pre-specified numbers 
  ##     Give the user any 3 numbers as input.
  ##     This number will be printed on the screen
  
  ## 3. Define a drop down to select from list of datasets
  ##    You can use ls("package:datasets) as input to the function
  
  
  ## Define the output functions
  ## Look at the server code and ensure that the placeholder IDs match
  
  ## 4. Define an output function for plotting the histogram
  
  ## 5. Define an output function to print the number selected by the user 
  ##   Keep in mind that renderPrint() was used for printing in the server code
  ##  use the appropriate function that works with renderPrint()
  
  ## 6. Define an output function to show the dataset selected as a Table on the screen
)


## --------------- SERVER ---------------------------------

server <- function(input, output){
  output$hist <- renderPlot({
    x<- faithful$waiting
    hist(x, breaks = ## Enter user input for bins
         main = paste("Histograms of Waiting times with ",
                      ## Enter user input for bins, 
                      " bins") , 
         col = 'darkgreen')
  })
  
  output$print <- renderPrint({
    paste("Selected number ", 
          ## Enter user input for number 
          )
  })
  
  output$summary <-renderTable({
    dataset <- get( ## Enter user input for dataset, 
                   "package:datasets")
    head(dataset)
  })
}


shinyApp(ui, server)
