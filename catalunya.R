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

class(cat2)

cat2 <- cat2 %>% arrange(`2015`)



### MAP Average Prices

leaflet(cat2)%>% 
  addPolygons(fillColor = "yellow", color = "gray",
              opacity = 0.5,
              weight = .8, smoothFactor = 0.2, 
              popup = paste("Província: ", cat2$NAME_2, "<br>",
                            "Municipalitat: ", cat2$NAME_4, "<br>",
                            "Lloguer d'habitatge (Mitjana Euros, 2019): ", cat2$`2019`, "<br>"),
              highlightOptions = highlightOptions(color="red", weight=2, bringToFront = TRUE))%>%
  addProviderTiles(providers$CartoDB)%>%
  addCircles(lat=41.390205, lng=2.154007, color = "lightblue", label = "Barcelona", radius = 300)%>%
  setView(2.154007, 41.390205, zoom = 10)


### Graph Average Prices

library(plotly)
library(dplyr)


plot_ly(cat2 ,type = 'scatter', mode = 'lines')%>%
  add_trace(x = cat2$NAME_4, y = cat2$`2015`, name = "2015", mode = 'lines+markers', 
            line = list(dash = "dash"),
            color = I("steelblue"), marker = list(color = "steelblue"))%>%
  add_trace(x = cat2$NAME_4, y = cat2$`2016`, name = "2016", mode = 'lines+markers', 
            line = list(dash = "dot"),
            color = I("gray"), marker = list(color = "gray"))%>%
  add_trace(x = cat2$NAME_4, y = cat2$`2017`, name = "2017", mode = 'lines+markers', 
            color = I("lightgreen"), marker = list(color = "lightgreen"))%>%
  add_trace(x = cat2$NAME_4, y = cat2$`2018`, name = "2018", mode = 'lines+markers',
            line = list(dash = "dash"),
            color = I("lightblue"), marker = list(color = "lightblue"))%>%
  add_trace(x = cat2$NAME_4, y = cat2$`2019`, name = "2019", mode = 'lines+markers',
            color = I("darkgreen"), marker = list(color = "darkgreen"))%>%
  layout(title = "Mitjana en Euros del Preu de Lloguers a Catalunya",
         xaxis = list(title = ""),
         yaxis = list (title = ""))




###

spdf2 <- sf::st_read("/Users/wemigliari/Documents/R/data/ESP_adm/ESP_adm2.shp")

demoab <- read_excel("/Users/wemigliari/Documents/R/tabelas/cat_demografia.xlsx",
                         sheet = "var_abs")

demorel <- read_excel("/Users/wemigliari/Documents/R/tabelas/cat_demografia.xlsx",
                      sheet = "var_rel")

catt <- filter(spdf2, NAME_1 == "Cataluña")

cat3 <- inner_join(catt, demoab, by = "NAME_2", all = T)

cat3 <- cat3 %>% arrange(`1998`)

cat4 <- inner_join(catt, demorel, by = "NAME_2", all = T)

cat4 <- cat4 %>% arrange(`1998`)



### Bubble Chart Absolute Variation

plot_ly(cat3, x = cat3$NAME_2, y = cat3$`2019`, type = "scatter", mode = "markers", color = I("black"), opacity = 0.3, marker = list(size = cat3$`2019`/500, color = "lightgreen"), name = '2019') %>%
  add_markers(y = cat3$`2018`, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "lightgray"), name = '2018') %>%
  add_markers(y = cat3$`2017`, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "blue"), name = '2017') %>%
  add_markers(y = cat3$`2016`, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "darkgreen"), name = '2016') %>%
  add_markers(y = cat3$`2015`, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "purple"), name = '2015')%>%
  add_markers(y = cat3$`2014`, type = "scatter", mode = "markers", color = I("black"), marker = list(color = "steelblue"), name = '2014') %>%
  layout(title = "Variació Demogràfica Absoluta (1.000) a Catalunya, Províncies",
         xaxis = list(title = ""),
         yaxis = list (title = ""))

### MAP Absolute Demographic Variation

leaflet(cat3)%>% 
  addPolygons(fillColor = "yellow", color = "gray",
              opacity = 0.5,
              weight = .8, smoothFactor = 0.2, 
              popup = paste("2019:", cat3$`2019`, "<br>",
                            "2018:", cat3$`2018`, "<br>",
                            "2017:", cat3$`2017`, "<br>",
                            "2016:", cat3$`2016`, "<br>"),
              highlightOptions = highlightOptions(color="red", weight=2, bringToFront = TRUE))%>%
  addProviderTiles(providers$CartoDB)%>%
  addCircles(lat=41.390205, lng=2.154007, color = "lightblue", label = "Barcelona", radius = 300)%>%
  setView(1.704007, 41.690205, zoom = 8)

### Stacked Bar Graph/Absolute Numbers

plot_ly(cat3, type = "bar", x=cat3$`2019`, y = cat3$NAME_2, color = I("lightgreen"), 
        orientation="h", opacity = 0.5, name = "2019")%>%
  add_trace(x = cat3$`2018`, y = cat3$NAME_2, color = I("lightgray"), name = "2018")%>%
  add_trace(x = cat3$`2017`, y = cat3$NAME_2, color = I("blue"), name = "2017")%>%
  add_trace(x = cat3$`2016`, y = cat3$NAME_2, color = I("darkgreen"), name = "2016")%>%
  add_trace(x = cat3$`2015`, y = cat3$NAME_2, color = I("purple"), name = "2015")%>%
  add_trace(x = cat3$`2014`, y = cat3$NAME_2, color = I("steelblue"), name = "2014")%>%
  layout(barmode = "absolute",
         xaxis = list(title = "Variació Demogràfica Absoluta (1.000), 2014-2019",
                      ticksuffix = ""),
         yaxis = list(title = NA))


### MAP Relative Demographic Variation

leaflet(cat4)%>% 
  addPolygons(fillColor = "steelblue", color = "gray",
              opacity = 0.5,
              weight = .8, smoothFactor = 0.2, 
              popup = paste("2019:", cat4$`2019`, "<br>",
                            "2018:", cat4$`2018`, "<br>",
                            "2017:", cat4$`2017`, "<br>",
                            "2016:", cat4$`2016`, "<br>"),
              highlightOptions = highlightOptions(color="red", weight=2, bringToFront = TRUE))%>%
  addProviderTiles(providers$CartoDB)%>%
  addCircles(lat=41.390205, lng=2.154007, color = "lightblue", label = "Barcelona", radius = 300)%>%
  setView(1.704007, 41.690205, zoom = 8)

### Stacked Bar Graph/Relative Numbers

plot_ly(cat4, type = "bar", x=cat4$`2019`, y = cat4$NAME_2, color = I("red"), 
        orientation="h", opacity = 0.5, name = "2019")%>%
  add_trace(x = cat4$`2018`, y = cat4$NAME_2, color = I("red"), name = "2018")%>%
  add_trace(x = cat4$`2017`, y = cat4$NAME_2, color = I("blue"), name = "2017")%>%
  add_trace(x = cat4$`2016`, y = cat4$NAME_2, color = I("blue"), name = "2016")%>%
  add_trace(x = cat4$`2015`, y = cat4$NAME_2, color = I("gold"), name = "2015")%>%
  add_trace(x = cat4$`2014`, y = cat4$NAME_2, color = I("gold"), name = "2014")%>%
  layout(barmode = "absolute",
         xaxis = list(title = "Variació Demogràfica Relativa (%), 2014-2019",
                      ticksuffix = ""),
         yaxis = list(title = NA))




