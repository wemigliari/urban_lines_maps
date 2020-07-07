

library(ggplot2) ## Functions to plot a map

WorldData <- map_data('world') 

df <- data.frame(region=c('Finland', 'Norway','Denmark','Sweden', 'Spain'), 
                 value=c(7.5, 9, 13.7, 71, 250), 
                 stringsAsFactors=TRUE)

p <- ggplot() +
  geom_map(data = WorldData, map = WorldData,
           aes(x = long, y = lat, group = group, map_id=region),
           fill = "white", colour = "lightgray", size=0.2) + 
  geom_map(data = df, map=WorldData,
           aes(fill=value, map_id=region),
           colour="white", size=1, show.legend = TRUE) +
  coord_map("orthographic", xlim=c(-10,25), ylim=c(35, 70)) +  
  #coord_map("rectangular", lat0=0, xlim=c(-10,40), ylim=c(0, 90)) +
  #scale_fill_continuous(low="#cedfd4", high="#0a5527", guide="colorbar") +
  #scale_y_continuous(breaks=c()) +
  #scale_x_continuous(breaks=c()) +
  scale_fill_gradient(name="Infected COVID-19 (thousands)", 
                      low = c("#e6efe9"), high = c("#062f16"),
                      space = "Lab", 
                      breaks = c(7.5, 9, 13.7, 71,250),
                      guide = "legend",
                      aesthetics = "fill") +
  labs(x = "", y = "") +
  theme_bw()
p

####
library(tmap)
library(dplyr)
library(sp)
library(sf)

id <- c('FI','NO','DK', 'SE','ES')

test <- cbind(df, id)
test1 <- st_as_sf(nuts0.spdf) 
test2 <- merge(test, test1, by = "id")
class(test2)

test3 <- st_as_sf(test2)
class(test3)

qtm(test3, fill = "value", fill.breaks=c(0,7.5,9,13,71,250))




###








