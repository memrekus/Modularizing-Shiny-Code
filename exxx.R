# Define UI for application
shinyUI(fluidPage(
  
  # Header or title Panel 
  titlePanel(h4('Demostration of the renderPlot() - A Histogram with iris dataset', align = "center")),
  
  # Sidebar panel
  sidebarPanel(
    selectInput("var", label = "1. Select the quantitative Variable", 
                choices = c("Sepal.Length" = 1, "Sepal.Width" = 2, "Petal.Length" = 3, "Petal.Width"=4),
                selected = 3), 
    
    
    sliderInput("bin", "2. Select the number of histogram BINs by using the slider below", min=5, max=25, value=15),
    
    radioButtons("colour", label = "3. Select the color of histogram",
                 choices = c("Green", "Red",
                             "Yellow"), selected = "Green")
  ),
  
  # Main Panel
  mainPanel(
    textOutput("text1"),
    textOutput("text2"),
    textOutput("text3"),
    plotOutput("myhist")
    
  )
  
)
)

shinyServer(
  function(input, output) {
    
    output$text1 <- renderText({ 
      colm = as.numeric(input$var)
      paste("Data set variable/column name is", names(iris[colm]))
      
    })
    
    output$text2 <- renderText({ 
      paste("Color of histogram is", input$radio)
    })
    
    output$text3 <- renderText({ 
      paste("Number of histogram BINs is", input$bin)
    })
    
    output$myhist <- renderPlot(
      
      {
        colm = as.numeric(input$var)
        hist(iris[,colm], col =input$colour, xlim = c(0, max(iris[,colm])), 
             main = "Histogram of Iris dataset", 
             breaks = seq(0, max(iris[,colm]),l=input$bin+1), xlab = names(iris[colm]))}
      
    )    
  }
)


dfx=starwars
colm = dfx[dfx$species=="Human",]
ggplot(colm, aes(x = name , y = height)) + 
  geom_point() + xlab("name") + ylab("height") 
