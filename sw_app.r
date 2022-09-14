#Modularized App Code


source("source.r")


#user interface


ui <- dashboardPage(
  dashboardHeader(title = "Starwars Universe"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Module 1", tabName = "mod1"),
      menuItem("Module 2", tabName = "mod2"))
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "mod1",
              fluidPage(h1("Scatter Plot"),
                box(
                   scatterUI("module")))),
      tabItem(tabName = "mod2",
              fluidPage(h2("Character Table"),
                box(
                tableUI("module"))))
      )))
    

#server

server <- function(input, output, session) {
  
  scatterSERVER("module")
  
  tableSERVER("module")
  
  }

# Run the app ----
shinyApp(ui = ui, server = server)

