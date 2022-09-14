#libraries

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


# ui <- fluidPage(
#   titlePanel("starwars"),
#   sidebarLayout(
#     sidebarPanel(
#       selectInput(
#         "x", "Species:",
#         choices=df$species
#       ),
#       actionButton("submitbutton", "Submit")
#     ),
#     mainPanel(
#       plotOutput(outputId = "scatterplot")
#     )))

# server <- function(input, output) {
#   
#   observeEvent(input$submitbutton,{
#   # browser()
#   
#   output$scatterplot <- renderPlot({
#     ggplot(df[df$species==input$x,], aes(x = name , y = height)) + 
#       geom_point() + xlab("Character Name") + ylab("Height") + 
#       ggtitle("Starwars")
#     
#   })
# })}
# 

#data

df<-as.data.frame(starwars)

#module1

scatter_UI <- function(id){
  plotOutput(NS(id, "scatter_plot"))
}

scatter_server <- function(id, df, type){
  moduleServer(id, function(input, output, session){
      # browser()
      output$scatter_plot <- renderPlot({
        ggplot(df[df$species==input$x,], aes(x = name , y = height, color =input$colour)) + 
          geom_point() + xlab("Character Name") + ylab("Height")
      })})}



#ui

 ui <- dashboardPage(
   dashboardHeader(title = "Starwars Universe"),
   dashboardSidebar(
     sidebarMenu(
       menuItem("Module1", tabName = "module1")
       )
   ),
   dashboardBody(
     tabItems(
       tabItem(tabName = "module1",
               fluidRow(box(scatter_UI("Module1_Scatter")),           
                 selectInput("x", "Species:",
                              choices=df$species
                 ),
                
                 )
              
                 ))
               ))
     
   
 

#server

server <- function(input, output) { 
  
  # Module1 Tab --------------------------------------------------------------
  scatter_server("Module1_Scatter", df =(df[df$species==input$x,]), type = "Module1")
  
  # # Module2 ---------------------------------------------------------------
  # table_server("table", df = df, type = "Module2")
  # 
  # # Nested ------------------------------------------------------------------
  # table_server("gentoo_table", df = df, type = "Nested")
  # 
}
shinyApp(ui = ui, server = server)
