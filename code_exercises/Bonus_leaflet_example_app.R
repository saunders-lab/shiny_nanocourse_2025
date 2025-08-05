library(shiny)
library(leaflet)

r_colors <- rgb(t(col2rgb(colors()) / 255))
names(r_colors) <- colors()

points <-     cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)

ui <- fluidPage(
  leafletOutput("mymap"),
  verbatimTextOutput('point_click')
)

server <- function(input, output, session) {
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$CartoDB.Positron,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(data = points)
  })
  
  output$point_click <- renderPrint({
    

    input$mymap_marker_click
    
    #These data don't actually have ids, but if they did you could do the following
    #input$mymap_marker_click$id
    
  })
}

shinyApp(ui, server)