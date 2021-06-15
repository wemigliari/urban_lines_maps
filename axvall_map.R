library(curl)
library(rsconnect)
library(readxl)
library(leaflet)
library(leaflet.extras)
library(sp)
library(plotly)
library(maps)
library(mapdata)
library(mapproj)
library(leaflet)
library(sf)
library(tmap)
library(transformr)
library(geojson)
library(rgdal)
library(raster) # union function

### Preparing the tags that will pop up when the red circles are clicked on the map,
### The field "<a href= ''> must contain the html address.


content1 <- paste(sep ="<br>", "<a href='repository_axvall.html', target='_blank'> Axvall </a>",
                  "Photo: Kommunalhuset",
                  "Size: 20x30cm", 
                  "Color: Black and White",
                  "Paper: Matte paper",
                  "Year: 1936",
                  "Archive: Skara kommun",
                  "Curated by: Sonia Lindblom")

content2 <- paste(sep ="<br>", "<a href='repository_skara.html', target='_blank'> Skara </a>",
                  "Photo: Kommunalhuset",
                  "Size: 20x30cm", 
                  "Color: Black and White",
                  "Paper: Matte paper",
                  "Year: 1936",
                  "Archive: Skara kommun",
                  "Curated by: Sonia Lindblom")


content3 <- paste(sep ="<br>", "<a href='repository_varnhem.html', target='_blank'> Varnhem </a>",
                  "Photo: Kommunalhuset",
                  "Size: 20x30cm", 
                  "Color: Black and White",
                  "Paper: Matte paper",
                  "Year: 1936",
                  "Archive: Skara kommun",
                  "Curated by: Sonia Lindblom")

# To include other points, just copy content and follow the number sequence.
# For example: content4 -< paste() ...

### Plotting the interactive maps
### Load the shapefiles from your directory (downloaded by and saved in your computer)

axvall <- readOGR("/Users/wemigliari/Documents/R/data/axvall.shp")
skara <- readOGR("/Users/wemigliari/Documents/R/data/skara.shp")
varnhem <- readOGR("/Users/wemigliari/Documents/R/data/varnhem.shp")


leaflet() %>% addTiles() %>% addProviderTiles(providers$CartoDB.Positron) %>%   
  addPolygons(data = axvall, fill = TRUE, stroke = TRUE, weight = .8, color = "#f5c71a", group = "Axvall") %>% 
  addPolygons(data = skara, fill = TRUE, stroke = TRUE, weight = .8, color = "#008900", group = "Skara") %>% 
  addPolygons(data = varnhem, fill = TRUE, stroke = TRUE, weight = .8, color = "#000000", group = "Varnhem")%>%
  addCircleMarkers(lat=58.38859250, lng=13.57441550, color = "red", popup=content1, radius = 10)%>%
  addCircleMarkers(lat=58.38659, lng = 13.43836, color = "red", popup=content2, radius = 10)%>%
  addCircleMarkers(lat=58.38417, lng=13.65417, color = "red",  popup = content3, radius = 10)%>%
  setView(lat=58.38659, lng = 13.53836, zoom = 12.2)%>%
  # add a legend
  addLegend("bottomright", colors = c("#f5c71a", "#008900", "#000000"), labels = c("Axvall", "Skara", "Varnhem")) %>%   
  # add layers control
  addLayersControl(
    overlayGroups = c("Axvall", "Skara", "Varnhem"),
    options = layersControlOptions(collapsed = FALSE)
  )



