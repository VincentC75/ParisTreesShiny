#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(dplyr)
library(RJSONIO)

dftrees <- read.csv2("les-arbres.csv", stringsAsFactors = FALSE) 
dftrees1 <- data.frame(do.call(rbind, lapply(strsplit(dftrees$geo_point_2d,','), 
                                            function(x) {c(
                                              coord = x
                                            )})),stringsAsFactors=FALSE)
dftrees$lat <- as.numeric(dftrees1$coord1)
dftrees$lon <- as.numeric(dftrees1$coord2)
dftrees$geo_point_2d <- NULL
rm(dftrees1)

#url <- "https://opendata.paris.fr/api/records/1.0/search/?dataset=les-arbres&rows=50&refine.domanialite=Jardin&refine.arrondissement=PARIS+7E+ARRDT"
#url <- "https://opendata.paris.fr/api/records/1.0/search/?dataset=les-arbres&rows=10000"
#trees <- fromJSON(url)$records
#dftrees <- data.frame(do.call(rbind, lapply(trees, 
#                                            function(x) {c(
#                                              name = ifelse(is.null(x$fields$libellefrancais), 'Unknown', x$fields$libellefrancais),
#                                              height = ifelse(is.null(x$fields$hauteurenm),0,x$fields$hauteurenm),
#                                              coord = x$geometry$coordinates
#                                              )})),stringsAsFactors=FALSE) %>%
#          rename( lng = coord1, lat = coord2) %>%
#          mutate( lat = as.numeric(lat), lng = as.numeric(lng), height = as.numeric(height))


shinyServer(function(input, output) {
   
  output$paristreemap <- renderLeaflet({
    dftrees %>% 
      leaflet() %>%
      addTiles() %>%
      addMarkers(popup = dftrees$name,
                 clusterOptions = markerClusterOptions())
  })
  

})
