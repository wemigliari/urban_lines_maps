library(writexl)
library(rgdal)
library(dplyr)

##### qtm (uninteractive map)

### Shapefiles
brazil <- read_sf("/Users/wemigliari/Documents/R/data/BRA_adm3.shp") ### Shape in form of sf
saopaulo <- brazil%>%filter(NAME_2=="São Paulo")

### Data on IDH
idh0 <- read_excel("/Users/wemigliari/Documents/R/data/saopaulo_idh_2000_2010.xls", sheet = "idh")
idh0 <- as.data.frame(idh0,na.rm = TRUE)
names(idh0)[233] <- "NAME_3"

### Merging shapefiles and data
idh0 <- merge(saopaulo, idh0, by = "NAME_3")

sp00 <- st_as_sf(idh0) ## It works!
class(sp00)


### Média

qtm(sp00, fill = "RENOCUP", fill.breaks=c(0, 650, 1500, 2000, 3000, 4500, 12300, 16200),
    fill.title = "Renda Média Ocupados 2000-2010",
    fill.palette = "Purples", ## Blues, Reds, Purples etc for different colors. To invert the scale of the colors, use the minus sign, for instance, -Reds.
    title = "Renda Média Ocupados 2000-2010",
    title.position = c("left", "top")) +
  tm_layout(asp=0) + 
  tm_text("NAME_3", 
          size = 0.6, 
          remove.overlap = TRUE, 
          auto.placement=FALSE) +
  tm_compass (north = 0, type = "arrow", show.labels = 2) +
  tm_layout(legend.title.size = .65, 
            legend.text.size = .65, 
            legend.frame = FALSE, title.size = 0.7,
            outer.margins = c(0,0,0,0)) +
  tm_credits("R Studio by Migliari, W. (2020).", position = c("left", "BOTTOM"))


#################################################################################
### Leaflet (interactive map) BUBBLES
#################################################################################


### Shapefiles
brazil1 <- read_sf("/Users/wemigliari/Documents/R/data/BRA_adm3.shp") ### Shape in form of sf
saopaulo1 <- brazil1%>%filter(NAME_2=="São Paulo")

###Converting multipolygons into two columns_sp
library(dplyr)
shape1 <- saopaulo1 %>% mutate(geometry = st_centroid(geometry))

shape2 <- shape1 %>% mutate(lat = unlist(map(shape1$geometry,2)), long = unlist(map(shape1$geometry,1)))

shape2 <- as.data.frame(shape2,na.rm = TRUE)
class(shape2)

### Data on IDH
idh <- read_excel("/Users/wemigliari/Documents/R/data/saopaulo_idh_2000_2010.xls", sheet = "idh")
idh <- as.data.frame(idh,na.rm = TRUE)
names(idh)[233] <- "NAME_3"

### Merging shapefiles and data
idh <- merge(brazil1, idh, by = "NAME_3")

### Merging shapefiles and data
sp <- merge(shape2, idh, by = "NAME_3") ## It works!

sp1 <- st_as_sf(sp) ## It works!
class(sp1)


# Create a color palette with handmade bins.
mybins <- seq(0, 13000, by= 1650.00)
mypalette <- colorBin( palette="YlOrBr", domain=sp1$RENOCUP, na.color="transparent", bins=mybins)

mytext <- paste(
  "Distrito:", sp1$NAME_3, "<br/>",
  "Renda Média: ", sp1$RENOCUP, "<br/>",
  sep="") %>%
  lapply(htmltools::HTML)

###

library(RColorBrewer)

leaflet(sp1) %>% 
  addTiles()  %>% 
  setView(-46.625290, -23.533773, zoom = 11) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addCircleMarkers(sp1$long, sp1$lat, 
                   fillColor = ~mypalette(sp1$RENOCUP), 
                   fillOpacity = 0.7, 
                   radius= sp1$RENOCUP/500, 
                   stroke=FALSE,
                   label = mytext,
                   labelOptions = labelOptions( style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "auto")
  ) %>%
  addLegend(pal=mypalette, values=~sp1$RENOCUP, opacity=0.9, title = "Renda Média Ocupados", position = "bottomright" )

