#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.

library(shiny)
library(leaflet)

# Load data previously downloaded and filtered by loaddata.R
load("dftrees_filtered.Rda")

shinyServer(function(input, output) {
   
  output$paristreemap <- renderLeaflet({
    dftrees %>% 
      leaflet() %>%
      addTiles() %>%
      addMarkers(popup = paste(dftrees$GENRE, dftrees$ESPECE),
                 clusterOptions = markerClusterOptions())
  })
  

})
