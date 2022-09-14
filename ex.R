library(shiny)
library(data.table)
library(randomForest)
library(shinydashboard)
library(tidyverse)
library(recipes)
library(ggridges)
library(shinythemes)
library(ggplot2)
library(dplyr)

dfx<-as.data.frame(starwars)

scatter_UI <- function(id , label="scatterplot") {fluidPage(
  
  # Header or title Panel 
  titlePanel(h4('A Scatter Plot with Starwars dataset', align = "center")),
  
  # Sidebar panel
  sidebarPanel(
    selectInput("var", label = "Select the  Species", 
                choices = dfx$species),
  ),
  
  # Main Panel
  mainPanel(
    plotOutput(NS(id, "myscatter"))))}


scatter_server <- function(id,df){
  moduleServer(id, function(input, output, session){
    colm =reactive({dfx[dfx$species==input$var,]})
    output$myscatter <- renderPlot({
      ggplot(colm(), aes(x = name , y = height)) + 
          geom_point() + xlab("Character Name") + ylab("Height") 
             main = "Scatter Plot of Starwars dataset"
          }
      
    )    
  })
}  

ui <-scatter_UI("my_scatter")

server <- function(input, output,session) { 
  scatter_server("my_scatter", df=dfx)}    

shinyApp(ui, server)
  