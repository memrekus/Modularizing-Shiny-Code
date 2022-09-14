#SOURCE CODE

#load libraries

library(shiny)
library(dplyr)
library(ggplot2)
library(shinydashboard)
library(DT)

#load data

df<-starwars

#ui module1

scatterUI <- function(id, label, choices, selected) {
  ns <- NS(id)
  tagList(
    selectInput(inputId =  ns("scatter"),
                label = "Choose Species",
                choices = starwars$species),
    plotOutput(outputId = ns("plot"))
)}


#server module1


scatterSERVER <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
      scatter_plot<- function(data, species_input, name) {
        dfx<-df[df$species==species_input,]
        a<-ggplot(data = dfx,
                  aes(x = name , y = height)) + 
          geom_point(color="Orange",
                     size=5,
                     shape=10) + 
          xlab("Character Name") + ylab("Height") 
        main = "Scatter Plot of Starwars dataset"
        print(a)
        
      }
      
      output$plot <- renderPlot({
        scatter_plot(data = df,
                   species_input = input$scatter)})
    })}


#ui module2


tableUI <- function(id, label, choices, selected) {
  ns <- NS(id)
  tagList(
    selectInput(inputId =  ns("table"),
                label = "Choose Character",
                choices = c(starwars$name),
                selected = "Yoda"),
    dataTableOutput(outputId = ns("character_table")),
    textOutput(ns("nasty1"))
  )
}


#server module2


tableSERVER <- function(id) {moduleServer(
  id,function(input, output, session) {
    output$character_table <- renderDataTable({
      df %>% filter(starwars$name %in% input$table)
    })
    output$nasty1<-renderText({
      paste("Your scatter plot specie choice is",input$scatter,sep = ":")
    })})}
    
    
