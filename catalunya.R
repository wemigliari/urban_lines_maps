library(readxl)
library(leaflet)
library(leaflet.extras)
library(sp)
library(sf)
library(plotly)
library(tidyverse)

### Download the shapefile from here https://www.diva-gis.org/datadown

spdf <- sf::st_read("/Users/wemigliari/Documents/R/data/ESP_adm/ESP_adm4.shp")

stat <- read_excel("/Users/wemigliari/Documents/R/tabelas/cat_precio_alq.xlsx")

cat <- filter(spdf, NAME_1 == "Cataluña")

cat2 <- inner_join(cat, stat, by = "NAME_4", all = T)



leaflet(cat2)%>% 
  addPolygons(fillColor = "yellow", color = "gray",
              opacity = 0.5,
              weight = .8, smoothFactor = 0.2, 
              popup = paste("Província: ", cat2$NAME_2, "<br>",
                            "Municipalitat: ", cat2$NAME_4, "<br>",
                            "Lloguer d'habitatge (Mitjana 2019): ", cat2$`2019`, "<br>"),
              highlightOptions = highlightOptions(color="red", weight=2, bringToFront = TRUE))%>%
  addProviderTiles(providers$CartoDB)%>%
  addCircles(lat=41.390205, lng=2.154007, color = "lightblue", label = "Barcelona", radius = 300)%>%
  setView(2.154007, 41.390205, zoom = 10)



