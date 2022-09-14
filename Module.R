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

# Modül 1 --> input1, output1
# Modül 2 --> input2, output2, output3
# 
# Kullanıcı input1'e hangi species'i istediğini yazacak (eg. droid, human etc)
# 
# starwars data frame input1'deki girdiye göre filtrelenecek ve bu filtrelenmiş data frame'den output1 oluşturulacak
# 
# Output1 character name (x) vs height ( y) olarak scatter plot oluşturacak
# 
# Kullanıcı input2'ye hangi character istediğini yazacak (eg. luke skywalker)
# 	
# starwars data frame input2'ye göre filtrelenecek ve filtrelenmiş data frame'i output2 olarak tablo çıktısı şeklinde gösterilecek
# 	
# output3, input1'in ne olduğunu gösteren basit bir text olmalı (eg droid, human)
# 
# Output3'ün kodu modül2'de olmalı ancak modül1'deki input parametresini (input1) görebilmeli


#data

df<-starwars   ##%>% drop_na()

#module1


scatter_UI <- function(id){
  plotOutput(NS(id, "scatter_plot"))
}
scatter_server <- function(id, df, type){
  moduleServer(id, function(input, output, session){
    output$scatter_plot <- renderPlot({
        ggplot(data=df,
               mapping=aes_string(x,height) + 
                 geom_point(colour="red", size=4))
        observeEvent(input$submitbutton)
})})}
    
  
  


#module2


# table_UI <- function(id){
#   DT::dataTableOutput(NS(id, "table"))
# }
# 


#nested





ui <- fluidPage(theme = shinytheme("flatly"),
                navbarPage(
                  
                  "Starwars Universe",
                  tabPanel("Module1",
                           sidebarLayout(
                           sidebarPanel(
                             tags$h1("Do your choice please..."),
                             selectInput("x", 
                                         label = "Species:", 
                                         choices = df$species),
                                         
                             selectInput("y",
                                         label = "unVariables:",
                                         choices = "height"),
                             actionButton("submitbutton", "Submit")
                             
                           ), 
                           mainPanel(
                             h1("Species vs Variables "),
                             
                             h4("Scatter Plot"),
                             plotOutput("scatter_plot")
                           )))))



#ui

# ui <- dashboardPage(
#   dashboardHeader(title = "Starwars Universe"),
#   dashboardSidebar(
#     sidebarMenu(
#       menuItem("Module1", tabName = "module1", icon = icon("dashboard")),
#       menuItem("Module2", tabName = "module2", icon = icon("dashboard")),
#       menuItem("Nested", tabName = "nested", icon = icon("dashboard"))
#     )
#   ),
#   dashboardBody(
#     tabItems(
#       tabItem(tabName = "module1",
#             
#               sidebarPanel(
#                 selectInput(inputId = "x", 
#                             label = "Species:", 
#                             choices = df$species,
#                             selected = "Human"),
#                 selectInput(inputId = "y",
#                             label = "Variables:",
#                             choices = colnames(df)[2:3],
#                             selected = df$height),
#                 actionButton("submitbutton", "Submit", class = "btn btn-primary")
#               ),
#             mainPanel = (
#                 plotOutput(outputId = "scatterplot")
#               ),
#       
#       tabItem(tabName = "module2",
#               
#               
#               ),
#       
#       tabItem(tabName = "nested",
#               fluidRow(box(table_UI("nested")), box(scatter_UI("NESTED"))),
#               )
#     )
#   )
# ))

server <- function(input, output) { 
  
  # Module1 Tab --------------------------------------------------------------
  scatter_server("scatter_plot", df = df, type = "Module1")

  # # Module2 ---------------------------------------------------------------
  # table_server("table", df = df, type = "Module2")
  # 
  # # Nested ------------------------------------------------------------------
  # table_server("gentoo_table", df = df, type = "Nested")
  # 
}

shinyApp(ui = ui, server = server)


input$var<-
colm = as.numeric(input$var)
ggplot(dfx[colm,], aes(x = name , y = height, color =input$colour)) + 
  geom_point() + xlab("Character Name") + ylab("Height") 
main = "Scatter Plot of Starwars dataset"


