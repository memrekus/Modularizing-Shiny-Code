#Helper Script

#Load Packages
library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(DT)

#Star Wars scatterplot function, "sw_scatter"
#'if&else' is used in the function to speerate 2 cases;
#case 1) no specie is chosen
#case 2) a spesific is chosen

sw_scatter <- function(data, specie_type, name) {
  #case 1 scatterplot
  if(specie_type == "All") { #NO spesific specie is chosen; see all species
    scatterPlot <- data %>% 
      ggplot(aes(x = species,
                 y = height,
                 color = species)) +
      geom_point(size = 2,
                 shape = 3) +
      theme(axis.text.x = element_text(angle = 90)) +
      labs(title = "Height of All Species", x = "All Species", y = "Height (cm)")
  } else {
    scatterPlot <- data %>% 
      filter(species %in% specie_type) %>% 
      ggplot(aes(x = name,
                 y= height)) +
      geom_point(color = "red",
                 size = 2,
                 shape = 8) +
      theme_bw() +
      theme(axis.text.x = element_text(angle = 90)) +
      labs(title = if(endsWith(specie_type, "s")) {
        paste(specie_type,"' Height", sep = "")}
           else {paste(specie_type,"s' Height", sep = "")},
        x = specie_type, y = "Height (cm)")
  }
  return(scatterPlot)
}


selectBoxUI <- function(id, label, choices, selected) {
  ns <- NS(id)
  tagList(
    selectInput(inputId =  ns("selectBox"),
                label,
                choices,
                selected),
    plotOutput(outputId = ns("sw_plot"))
  )
}

selectBox <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      output$sw_plot <- renderPlot({
        #using function from helper.R script
        sw_scatter(data = starwars,
                   specie_type = input$selectBox)})})}

charBoxUI <- function(id, label, choices, selected) {
  ns <- NS(id)
  tagList(
    selectInput(inputId =  ns("charBox"),
                label,
                choices,
                selected,
                multiple = TRUE),
    DTOutput(outputId = ns("char_df")),
    textOutput(ns("chosen_specie"))
  )
}


charBox <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      
      output$char_df = renderDT({
        starwars %>% filter(starwars$name %in% input$charBox)
      })
      output$chosen_specie <- renderText({
        paste("You have selected the specie", input$selectBox, ".")
      })
    }
  )
}