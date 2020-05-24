
library(readxl)
pacman::p_load(rgeos, rgdal, ggmap, leaflet)
library(tmap)
library(tidyverse)
library(cartogram)
library(FRK)
library(varhandle)
library(sf)


## Shape

shape_sao_paulo <- st_read("/Users/wemigliari/Documents/R/Rshiny/metro_corona_brazil/Munic¡pios_RM_Sao_Paulo.shp")
class(shape_sao_paulo)


## Data

data_corona  <- read_excel("/Users/wemigliari/Documents/R/Rshiny/metro_corona_brazil/corona_brazil.xlsx")

data_corona1 <- mutate_all(data_corona, funs(toupper)) ### All the names in capital letters to match exactly with the names in the other table
NM_MUNICIP <- data_corona1$municipio ### Creating one column with the same name of a column in the other table
data_corona2 <- cbind(data_corona1, NM_MUNICIP) ## Binding the new column NM_MUNICIP to the data set


## Merging data
  
shape_data <- merge(shape_sao_paulo, data_corona2, by= "NM_MUNICIP", all=T)
rownames(shape_data) <- shape_data$Row.names; shape_data$Row.names <- NULL

## Excluding non-useful columns

shape_data1 <- shape_data[, -c(2, 3, 4, 7, 8, 9, 16, 17)]
class(shape_data1)


shape_data2 <- shape_data1[grep("SP", shape_data1$estado),]

#
shape_data3 <- as.data.frame(shape_data2)
shape_data4[, c(8,9)] <- sapply(shape_data3[, c(8,9)], as.numeric)
#

shape_data5 <- cbind(shape_data2, shape_data4$obitosAcumulado)
class(shape_data5)

shape_data6 <- shape_data5 %>% group_by(NM_MUNICIP) %>% slice(1L)



# Plotting

#1
qtm(shape_data6, fill= 'NM_MUNICIP', text = 'obitosAcumulado') 

#2

tm_shape(shape_data6) + tm_fill(col = "obitosAcumulado", palette = "Blues", title = "") + 
  tm_fill(title = "") +
  tm_borders() + tm_layout(frame=F) + 
  tm_layout(
    "Óbitos Acumulados, Região Metropolitana de São Paulo",
    legend.title.size=1,
    legend.text.size = 0.6,
    legend.position = c("right","bottom")) +
    tm_text("NM_MUNICIP", size = 0.3)
  
#3
tm_shape(shape_data6) + tm_fill(col = "casosAcumulado", palette = "BuGn", title = "") +
  tm_fill(title = "") +
  tm_borders() + tm_layout(frame=F)+  
  tm_layout(
    "Casos Acumulados, Região Metropolitana de São Paulo",
    legend.title.size=1,
    legend.text.size = 0.6,
    legend.position = c("right","bottom")) +
  tm_text("NM_MUNICIP", size = 0.3)

#4 
tm_shape(shape_data6) + tm_fill(col = "populacaoTCU2019", palette = "OrRd", title = "") +
  tm_fill(title = "") +
  tm_borders() + tm_layout(frame=F) + 
  tm_layout(
    "População, Região Metropolitana de São Paulo",
    legend.title.size=1,
    legend.text.size = 0.6,
    legend.position = c("right","bottom")) +
  tm_text("NM_MUNICIP", size = 0.3)










