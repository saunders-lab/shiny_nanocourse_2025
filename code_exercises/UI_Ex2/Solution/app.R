
# Load required libraries
library(shiny)      # Core Shiny library

# -----------------------------
# Define UI for the application
# -----------------------------
ui <- navbarPage(
  title = "Exercise 2",  # App title shown in the navbar
  
  theme = bslib::bs_theme(bootswatch = "darkly"),  # Apply a dark theme using Bootswatch
  
  # -------- Tab 1: Histogram --------
  tabPanel(
    "histogram",
    sidebarLayout(
      sidebarPanel(
        # Slider input to select the number of bins
        sliderInput('bins', "Enter number of bins for histogram:", min = 2, max = 100, value = 10)
      ),
      mainPanel(
        # Area to display the histogram plot
        plotOutput('hist')
      )
    )
  ),
  
  # -------- Tab 2: Print --------
  tabPanel(
    "print",
    sidebarLayout(
      sidebarPanel(
        # Radio buttons to select a number to print
        radioButtons('num', "Select number to print", 
                     choices = c("One" = "1", "Five" = "5", "Ten" = "10"),
                     selected = "1")
      ),
      mainPanel(
        # Area to print the selected number
        verbatimTextOutput('print')
      )
    )
  ),
  
  # -------- Tab 3: Table --------
  tabPanel(
    "table",
    sidebarLayout(
      sidebarPanel(
        # Dropdown to select a dataset from the 'datasets' package
        selectInput('data', "Choose your dataset", ls("package:datasets"))
      ),
      mainPanel(
        # Area to show the top rows of the selected dataset
        tableOutput("summary")
      )
    )
  )
)

# -----------------------------
# Define server logic
# -----------------------------
server <- function(input, output) {
  # Automatically theme plots to match the UI theme
  thematic::thematic_shiny()
  
  # Render the histogram based on the selected number of bins
  output$hist <- renderPlot({
    x <- faithful$waiting  # Use the 'waiting' column from the built-in 'faithful' dataset
    hist(x,
         breaks = input$bins,
         main = paste("Histogram of Waiting Times with", input$bins, "bins"),
         col = 'blue')
  })
  
  # Render the selected number as text
  output$print <- renderPrint({
    paste("Selected number", input$num)
  })
  
  # Render the first few rows of the selected dataset
  output$summary <- renderTable({
    dataset <- get(input$data, "package:datasets")  # Retrieve dataset by name
    head(dataset)  # Display first 6 rows
  })
}

# -----------------------------
# Launch the Shiny App
# -----------------------------
shinyApp(ui, server)
