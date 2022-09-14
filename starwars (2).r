source("Helper(2).r")

ui <- dashboardPage(
  skin = "red",
  dashboardHeader(title = "STAR WARS"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("SPECIES", tabName = "species", icon = icon("dashboard")),
      menuItem("CHARACTERS", tabName = "char", icon = icon("dashboard"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("species",fluidPage(
        h1("STAR WARS"),
        h3("Choose a specie to view the heights."),
        selectBoxUI("one",label = "Specie Selection", 
                    choices = c(starwars$species,"All", -NA),selected = "All"))),
      
      
      tabItem("char",fluidPage(
        h1("STAR WARS"),
        h3("Choose the characters you would like to compare."),
        charBoxUI("one", label = "Character Selection",choices = starwars$name, selected = "Luke Skywalker"))
      )
    )))

server <- function(input, output, session) {
  selectBox("one")
  charBox("one")
}

# Run the app ----
shinyApp(ui = ui, server = server)

