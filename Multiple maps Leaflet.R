

brazil <- readOGR("/Users/wemigliari/Documents/R/data/BRA_adm2.shp")

braziltest <- read_sf("/Users/wemigliari/Documents/R/data/BRA_adm2.shp")

braziltest1 <- braziltest%>%filter(NAME_1=="Minas Gerais")
braziltest2 <- braziltest1%>%filter(NAME_2=="Nova Lima")
braziltest3 <- braziltest1%>%filter(NAME_2=="Belo Horizonte")


library(RColorBrewer)
  


leaflet() %>% 
  addTiles() %>% 
  addPolygons(data=braziltest2$geometry, weight = 3, fillColor = 'red', opacity = 0.3, color = 'gray', label = "Nova Lima") %>%
  addPolygons(data=braziltest3$geometry, weight = 3, fillColor = 'lightblue', opacity = 0.3, color = 'gray', label = "Belo Horizonte")%>%
  addProviderTiles(providers$CartoDB.Positron)


leaflet() %>% 
  addTiles() %>% 
  addPolygons(data=braziltest2$geometry, weight = 3, fillColor = 'red', opacity = 0.1, color = 'gray', label = "Nova Lima") %>%
  addPolygons(data=braziltest3$geometry, weight = 3, fillColor = 'lightblue', opacity = 0.3, color = 'gray', label = "Belo Horizonte")%>%
  addProviderTiles(providers$CartoDB.Positron)%>% 
  addProviderTiles(providers$CartoDB.Positron)%>%
  addCircles(lat=-20.070318, lng=-43.939247, color = "red", radius = 250)%>%
  addMarkers(lat=-20.070318, lng=-43.939247, popup = content1, icon = list(iconUrl = '/Users/wemigliari/Documents/R/R_Scripts/Rmarkdown/village.png', iconSize = c(25, 25)), clusterOptions = markerClusterOptions())%>%
  addCircles(lat=-20.042998, lng=-43.916308, color = "red", radius = 250)%>%
  addMarkers(lat=-20.042998, lng=-43.916308, popup = content2, icon = list(iconUrl = '/Users/wemigliari/Documents/R/R_Scripts/Rmarkdown/village.png', iconSize = c(25, 25)), clusterOptions = markerClusterOptions())%>%
  addCircles(lat=-20.038238, lng=-43.917172, color = "red", radius = 250)%>%
  addMarkers(lat=-20.038238, lng=-43.917172, popup = content3, icon = list(iconUrl = '/Users/wemigliari/Documents/R/R_Scripts/Rmarkdown/village.png', iconSize = c(25, 25)), clusterOptions = markerClusterOptions())%>%
  addCircles(lat=-20.044444, lng=-43.916249, color = "red", radius = 250)%>%
  addMarkers(lat=-20.044444, lng=-43.916249, popup = content4, icon = list(iconUrl = '/Users/wemigliari/Documents/R/R_Scripts/Rmarkdown/village.png', iconSize = c(25, 25)), clusterOptions = markerClusterOptions())%>%
  addCircles(lat=-20.064656, lng=-43.943534, color = "red", radius = 250)%>%
  addMarkers(lat=-20.064656, lng=-43.943534, popup = content5, icon = list(iconUrl = '/Users/wemigliari/Documents/R/R_Scripts/Rmarkdown/village.png', iconSize = c(25, 25)), clusterOptions = markerClusterOptions())%>%
  addCircles(lat=-20.047058, lng=-43.936836, color = "red", radius = 250)%>%
  addMarkers(lat=-20.047058, lng=-43.936836, popup = content6, icon = list(iconUrl = '/Users/wemigliari/Documents/R/R_Scripts/Rmarkdown/village.png', iconSize = c(25, 25)), clusterOptions = markerClusterOptions())%>%
  addCircles(lat=-20.047373, lng=-43.926524, color = "red", radius = 250)%>%
  addMarkers(lat=-20.047373, lng=-43.926524, popup = content7, icon = list(iconUrl = '/Users/wemigliari/Documents/R/R_Scripts/Rmarkdown/village.png', iconSize = c(25, 25)), clusterOptions = markerClusterOptions())%>%
  addCircles(lat=-20.056941, lng=-43.914252, color = "red", radius = 250)%>%
  addMarkers(lat=-20.056941, lng=-43.914252, popup = content8, icon = list(iconUrl = '/Users/wemigliari/Documents/R/R_Scripts/Rmarkdown/village.png', iconSize = c(25, 25)), clusterOptions = markerClusterOptions())%>%
  addMarkers(lat=-20.044801, lng=-43.957048, label = "Vale S/A, Mina de Mar Azul",icon = list(iconUrl = '/Users/wemigliari/Documents/R/R_Scripts/Rmarkdown/pickaxe.png', iconSize = c(25, 25)), clusterOptions = markerClusterOptions())%>%
  setView(lat=-20.070318, lng = -43.939247, zoom = 11.2)
