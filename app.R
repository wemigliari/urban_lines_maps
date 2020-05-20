library(shiny)
library(leaflet)
library(readxl)
library(rgdal)
library(sf)
library(data.table) ### Download the tables from a website
library(tidyverse)
library(mapview)

###################################################################################################
### SAO PAULO
###layers_sp
metro_sao_paulo <- st_read("/Users/wemigliari/Documents/R/Rshiny/metro_corona_brazil/Munic¡pios_RM_Sao_Paulo.shp")
class(metro_sao_paulo)
metro_layer_sp <- st_transform(metro_sao_paulo, "+proj=longlat +datum=WGS84")

###Converting multipolygons into two columns_sp
sf_centers <- metro_layer_sp %>%
    dplyr::mutate(geometry = st_centroid(geometry))
sf_centers1 <- sf_centers %>% mutate(lat = unlist(map(sf_centers$geometry,2)), long = unlist(map(sf_centers$geometry,1)))

##################################################################################################

### Data on coronavirus
brazil_corona <- read_excel("corona_brazil.xlsx")
brazil_corona <- mutate_all(brazil_corona, funs(toupper))
NM_MUNICIP <- brazil_corona$municipio
brazil_corona1 <- cbind(brazil_corona, NM_MUNICIP)

##################################################################################################

### Merging the shapefiles with the data_sp
sf_centers2 <- merge(sf_centers1, brazil_corona1, by= "NM_MUNICIP", all=T)
rownames(sf_centers2) <- sf_centers2$Row.names; sf_centers2$Row.names <- NULL
sf_centers2

##################################################################################################

###Labels_sp
tocan <- makeAwesomeIcon(icon = 'flag', markerColor = 'red', library='fa', iconColor = 'black')
deaths_sp <- paste(
    "Municipality: ",sf_centers2$NM_MUNICIP, "<br/>",
    "Fatal Cases: ",sf_centers2$obitosAcumulado, "<br/>",
    "Total Cases: ",sf_centers2$casosAcumulado, "<br/>",
    sep="") %>%
    lapply(htmltools::HTML)

###Map_sp

sao_paulo <- leaflet(sf_centers2) %>% addTiles() %>%
    addProviderTiles(providers$Stamen.Toner)%>%
    setView(-46.625290, -23.533773, zoom = 9)%>%
    addPolygons(data = metro_layer_sp, color = "gold")%>%
    addCircleMarkers(lng = sf_centers2$long, lat = sf_centers2$lat, weight = 1, 
                     radius = 5,
                     label = deaths_sp,
                     color = "purple",
                     fillOpacity = 0.6)%>%
    addAwesomeMarkers(-48.32766, -10.16745, label = "Berg e Cíntia, fiquem em casa!", icon = tocan)

sao_paulo

##################################################################################################

### RIO DE JANEIRO

###layers_rj
metro_rj <- st_read("/Users/wemigliari/Documents/R/Rshiny/metro_corona_brazil/Munic¡pios_RM_Rio_de_Janeiro.shp")
class(metro_rj)
metro_layer_rj <- st_transform(metro_rj, "+proj=longlat +datum=WGS84")

###Converting multipolygons into two columns_rj
sf_centers_rj <- metro_layer_rj %>%
    dplyr::mutate(geometry = st_centroid(geometry))
sf_centers_rj1 <- sf_centers_rj %>% mutate(lat = unlist(map(sf_centers_rj$geometry,2)), long = unlist(map(sf_centers_rj$geometry,1)))

##################################################################################################

### Data on coronavirus
brazil_corona <- read_excel("corona_brazil.xlsx")
brazil_corona <- mutate_all(brazil_corona, funs(toupper))
NM_MUNICIP <- brazil_corona$municipio
brazil_corona1 <- cbind(brazil_corona, NM_MUNICIP)

##################################################################################################

### Merging the shapefiles with the data_rj
sf_centers_rj2 <- merge(sf_centers_rj1, brazil_corona1, by= "NM_MUNICIP", all=T)
rownames(sf_centers_rj2) <- sf_centers_rj2$Row.names; sf_centers_rj2$Row.names <- NULL
sf_centers_rj2

##################################################################################################

###Labels_rj

deaths_rj <- paste(
    "Municipality: ",sf_centers_rj2$NM_MUNICIP, "<br/>",
    "Fatal Cases: ",sf_centers_rj2$obitosAcumulado, "<br/>",
    "Total Cases: ",sf_centers_rj2$casosAcumulado, "<br/>",
    sep="") %>%
    lapply(htmltools::HTML)

###Map_rj

rio_de_janeiro <- leaflet(sf_centers_rj2) %>% addTiles() %>%
    addProviderTiles(providers$Stamen.Toner)%>%
    setView(-43.196388, -22.908333, zoom = 9)%>%
    addPolygons(data = metro_layer_rj, color = "gold")%>%
    addCircleMarkers(lng = sf_centers_rj2$long, lat = sf_centers_rj2$lat, weight = 1, 
                     radius = 5,
                     label = deaths_rj,
                     color = "purple",
                     fillOpacity = 0.6)

rio_de_janeiro

##################################################################################################

sync(sao_paulo, rio_de_janeiro)


