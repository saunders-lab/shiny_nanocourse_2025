# Exercise 2
# In this exercise, you will learn to play around with the app layout and themes
# The code below is incomplete. Comments have been provided to help you fill out the code
# You will have to work on most of the UI code and also some parts of the Server


## ------- Loading required Libraries --------------
library(shiny)

##----------------------UI--------------------------
ui <- ## TODO
  ## Set the title for the app,
  ## If you're using navbarPage(), you can just use title = ""
  ## If your using fluidPage(),  titlePanel() can be used
  
  ## Set a theme for the app
  ## refer to https://rstudio.github.io/shinythemes/ to select theme
  
  ## Now use tabs and sidebar layout to display the same inputs and outputs you displayed in Exercise 1
  ## 1. Inside the first tab panel define a side bar layout.
  ##    The side bar should have the slider we defined in Exercise 1.
  ##    The main panel should have the histogram plotted.
  
  ## 2. Similar to the first tab, the second tab should have a sidebar layout.
  ##    The sidebar contains the radio buttons input function. 
  ##    The main panel contains the printed text.

  ## 3. Similarly, add inputs and outputs to display the table in the third tab
  



## --------------- SERVER ---------------------------------

server <- function(input, output){
  # OPTIONAL: match the plot themes with the overall app theme using thematic
  
  output$hist <- renderPlot({
    x<- faithful$waiting
    hist(x, breaks = ## Enter user input for bins
           main = paste("Histograms of Waiting times with ",
                        ## Enter user input for bins, 
                        " bins") , 
         col = 'blue')
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
