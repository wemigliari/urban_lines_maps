### QTM + tmap

library(tmap)
library(sp)
library(sf)

df <- data.frame(region=c('Finland', 'Norway','Denmark','Sweden', 'Spain', 'United Kingdom', 'Germany','France', 'Italy'), 
                 value=c(7.5, 9, 13.7, 71, 250, 285, 196, 166, 241), 
                 stringsAsFactors=TRUE)

id <- c('FI','NO','DK', 'SE','ES', 'UK', 'DE', 'FR', 'IT')

test <- cbind(df, id)
test1 <- st_as_sf(nuts0.spdf) 
test2 <- merge(test, test1, by = "id")
class(test2)

test3 <- st_as_sf(test2)
class(test3)

qtm(test3, fill = "value", fill.breaks=c(0,10,15,85,170,200,250,300),
    fill.title = "Total Infected (thousands)",
    fill.palette = "Reds", ## Blues, Reds, Purples etc for different colors. To invert the scale of the colors, use the minus sign, for instance, -Reds.
    title = "COVID-19, July 2020",
    title.position = c("left", "top")) +
  tm_layout(asp=0) + 
  tm_compass (north = 2, type = "arrow", show.labels = 2, position = c("left", "BOTTOM")) +
  tm_layout(legend.title.size = .65, 
            legend.text.size = .65, 
            legend.frame = FALSE, title.size = 0.7,
            outer.margins = c(0,0,0,0),
            bg.color = "transparent") +
  tm_credits("", position = c("right", "BOTTOM"))