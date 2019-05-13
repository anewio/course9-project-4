# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Cities of Canada"),
  withTags({
    div(class = "header", checked = NA,
        h4("Check to discover cities and population of each city in the selected province(s)."))
  }),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("provinces", "Select one or more provinces:", 
                         choices = provs_dt),
      
      submitButton("Update Maps", icon('refresh'))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("maps"),
      
      tableOutput('citylist')
    )
  )
)
