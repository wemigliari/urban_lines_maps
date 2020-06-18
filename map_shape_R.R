# Libraries

library(sf) # Function st_read function
library(readxl) # Read the Excel table you have downloaded or from your desktop computer
library(tidyverse) # Function inner_joint (table with data + shape file or geometry)
library(tmap) # To plot/print the maps


# Shape file

shape_sao_paulo <- read_sf("/Users/wemigliari/Documents/R/Rshiny/metro_corona_brazil/sp/SP_Municipios_2019.shp", 
                           stringsAsFactors = FALSE)
class(shape_sao_paulo)


# Data

corona_brazil <- read_excel("/Users/wemigliari/Documents/R/Rshiny/metro_corona_brazil/corona_brazil.xlsx", 
                            col_types = c("text", "text", "text", 
                                          "numeric", "numeric", "numeric", 
                                          "text", "date", "numeric", "numeric", 
                                          "numeric", "numeric", "numeric", 
                                          "numeric", "numeric", "numeric"))

corona_brazil$data <- as.character(corona_brazil$data) # Making the column "date" appear as character in order to be possible the reading of data when saving the table

corona_sp <- as.data.frame(corona_brazil[grep("SP", corona_brazil$estado),]) # Selecting only the data about SP
names(corona_sp)[3]<-"NM_MUN" # It was município. I need a column with the same name of the column of my shape file, i.e., "NM_MUN".

# Data - aggregating values for a new table. Data come from the old table. New table  will be added to the shape file by the column "NM_MUN". We select the max date for data column also.

corona_sp1 <- aggregate(corona_sp$casosAcumulado ~ corona_sp$NM_MUN, corona_sp, max) # Capturing max values
names(corona_sp1)[1]<-"NM_MUN" #I need a column with the same name of the column of my shape file, i.e., "NM_MUN".
corona_sp11 <- aggregate(corona_sp$obitosAcumulado ~ corona_sp$NM_MUN, corona_sp, max) # Capturing max values
names(corona_sp11)[1]<-"NM_MUN" # I need a column with the same name of the column of my shape file, i.e., "NM_MUN".

corona_sp2 <- merge(corona_sp1, corona_sp11, by = "NM_MUN", all = T) # Merging "casos totais" com "óbitos totais".


# Polygons, joining polygons (spatial file) with table

shp_joined <- inner_join(corona_sp2, shape_sao_paulo, by = "NM_MUN")
class(shp_joined) # Dataframe. It does not work yet!

shp_joined <- st_as_sf(shp_joined) 
class(shp_joined) # It is now converted to "sf" and "data.frame". It works!


names(shp_joined)[2] <- "casos_totais"
names(shp_joined)[3] <- "obitos_totais"


# Reorder data to show biggest cities on top

data <- shp_joined %>%
  arrange(casos_totais) %>%
  mutate( name=factor(NM_MUN, unique(NM_MUN)))

# Printing


qtm(data, fill = "casos_totais", fill.breaks=c(0,10,50,100,200, 300, 400, 500, 1000, 2000, 3000, 4000, 5000, 7000, 10000, 100000, 150000),
    fill.title = "Infectados Totais",
    fill.palette = "Purples", ## Blues, Reds, Purples etc for different colors. To invert the scale of the colors, use the minus sign, for instance, -Reds.
    title = "COVID-19, Estado de São Paulo, Distribuição do Total de Infectados",
    title.position = c("right", "top")) +
  tm_layout(asp=0) + 
  tm_compass (north = 0, type = "arrow", show.labels = 2) +
  tm_layout(legend.title.size = .65, 
            legend.text.size = .65, 
            legend.frame = FALSE, title.size = 0.7,
            outer.margins = c(0,0,0,0)) +
  tm_credits("R Studio by Migliari, W. (2020).", position = c("right", "BOTTOM"))



qtm(data, fill = "obitos_totais", fill.breaks=c(0,10,20,30,40, 50, 100, 200, 300, 400, 500, 1000, 2000, 3000, 4000, 5000, 10000), 
    fill.title = "Óbitos Totais",
    fill.palette = "Reds", ## Blues, Reds, RdYlGn etc for different colors. To invert the scale of the colors, use the minus sign, for instance, -Reds.
    title = "COVID-19, Estado de São Paulo, Distribuição do Total de Óbitos",
    title.position = c("right", "top")) +
  tm_layout(asp=0) + 
  tm_compass (north = 0, type = "arrow", show.labels = 2) +
  tm_layout(legend.title.size = .65, 
            legend.text.size = .65, 
            legend.frame = FALSE,
            title.size = 0.7,
            outer.margins = c(0,0,0,0)) +
  tm_credits("R Studio by Migliari, W. (2020).", position = c("right", "BOTTOM"))



