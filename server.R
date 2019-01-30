#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.

library(shiny)
library(leaflet)

shinyServer(function(input, output) {

dfname <- reactive({
  if (input$outstanding == TRUE)
    name <- 'dftrees_filtered.Rda'
  else
    name <- 'dftrees_all.Rda'
})

  output$paristreemap <- renderLeaflet({
    load(dfname())
    dftrees <- dftrees %>%
      filter(height >= input$height[1]) %>%
      filter(height <= input$height[2])
    dftrees %>% 
      leaflet() %>%
      addTiles() %>%
      addMarkers(popup = paste(dftrees$GENRE, "<br>",
                               dftrees$ESPECE, "<br>",
                               "height = ", dftrees$HAUTEUR..m., "m<br>",
                               "girth = ", dftrees$CIRCONFERENCEENCM, "cm<br>",
                               dftrees$LIEU...ADRESSE),
                 clusterOptions = markerClusterOptions())
  })
  

})
