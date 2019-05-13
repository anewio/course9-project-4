# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(dplyr)
library(leaflet)

server <- function(input, output) {
  output$maps <- renderLeaflet({
    cities <- (cities_dt[cities_dt$admin %in% c(input$provinces), ])
    leaflet() %>%
      addTiles() %>%
      addMarkers(lat = ~lat, lng = ~lng, 
                 popup = paste("City: ", cities$city, '<br/>',
                               'Population: ', 
                               formatC(cities$population, format="f", big.mark=",", digits = 0)),
                 clusterOptions = markerClusterOptions(),
                 data = cities)
  })
  
  output$citylist <- renderTable({
    
    cities_dt %>% select(admin,city, population) %>% 
      filter(admin %in% c(input$provinces)) %>%
      group_by(admin) %>% 
      summarise(City_Count = n_distinct(city), 
                Total_Population = sum(population)) %>%
      rename(Province = admin)
  })
}