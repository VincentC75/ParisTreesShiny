#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.

library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Outstanding Trees in Paris"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
#       sliderInput("bins",
#                   "Number of bins:",
#                   min = 1,
#                   max = 50,
#                   value = 30),
       # Select whether to display only outstanding trees or all trees
       checkboxInput(inputId = "outstanding", label = strong("Display only outstanding trees"), value = TRUE),
       sliderInput("height", "Heigth (m):", min = 0, max = 30, value = c(0,30)),
       sliderInput("girth", "Girth (cm):", min = 30, max = 695, value = c(30,695))
    ),

    
    mainPanel(
       leafletOutput("paristreemap", width = "100%", height = 800)
    )
  )
))
