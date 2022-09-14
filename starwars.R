source("helper.R")

ui <- fluidPage(
      selectBoxUI("one")
    )

server <- function(input, output, session) {
  selectBox("one")
}

# Run the app ----
shinyApp(ui = ui, server = server)

