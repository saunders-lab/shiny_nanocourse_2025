# Load the shiny package
library(shiny)

# ----------------------
# User Interface (UI)
# ----------------------
ui <- fluidPage(
  
  # Slider input to select the number of bins for the histogram
  sliderInput('bins', "Enter number of bins for histogram:", min = 2, max = 100, value = 10),
  
  # Radio buttons to select a number (mapped to values 1, 5, or 10)
  radioButtons('num', "Select number to print", 
               choices = c("One" = "1", "Five" = "5", "Ten" = "10"),
               selected = "1"),
  
  # Dropdown to select a dataset from the base R 'datasets' package
  selectInput('data', "Choose your dataset", ls("package:datasets")),
  
  # Output placeholders
  plotOutput('hist'),             # For the histogram
  verbatimTextOutput('print'),    # For printing the selected number
  tableOutput("summary")          # For showing the selected dataset's first rows
)

# ----------------------
# Server Logic
# ----------------------
server <- function(input, output){
  
  # Render a histogram of the 'faithful$waiting' variable
  output$hist <- renderPlot({
    x <- faithful$waiting  # Use the 'waiting' column from the built-in 'faithful' dataset
    hist(x,
         breaks = input$bins,  # Use the number of bins selected by the user
         main = paste("Histogram of Waiting Times with", input$bins, "bins"),
         col = 'darkgreen')
  })
  
  # Render the selected number from the radio buttons
  output$print <- renderPrint({
    paste("Selected number", input$num)
  })
  
  # Render the first few rows of the selected dataset
  output$summary <- renderTable({
    dataset <- get(input$data, "package:datasets")  # Load the selected dataset from the 'datasets' package
    head(dataset)  # Show the first 6 rows
  })
}

# ----------------------
# Launch the App
# ----------------------
shinyApp(ui, server)
