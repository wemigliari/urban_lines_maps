### tmap and tm_shape

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

first <- tm_shape(test3) +
  tm_borders(col = 'white', lwd = 0.3) +
  tm_fill(col = 'value', title = 'Totals (thousands)', 
          breaks=c(0,10,15,85,170,200,250,300),
          palette = "Greens",
          legend.hist = FALSE) +
  tm_legend(legend.outside = TRUE, position = c("right", "center")) +
  tm_compass (north = 2, type = "arrow", show.labels = 2, position = c("right", "BOTTOM")) +
  tm_layout(legend.title.size = .65, 
            legend.text.size = .65, 
            legend.frame = FALSE, title.size = 0.7,
            title = "Infected, COVID-19, July 2020",
            outer.margins = c(0,0,0,0),
            bg.color = "transparent") +
  tm_credits('', position = 'right') +
  tm_shape(nuts0.spdf) +
  tm_borders()



## Number of Passengers intra-EU flights

n_a <- data.frame(region=c('Finland', 'Norway','Denmark','Sweden', 'Spain', 'United Kingdom', 'Germany','France', 'Italy'), 
                  value=c(13.579, 24.102, 23.475, 23.710, 148.341, 167.477, 123.158, 72.894, 90.443), 
                  stringsAsFactors=TRUE)


id <- c('FI','NO','DK', 'SE','ES', 'UK', 'DE', 'FR', 'IT')


n_a1 <- cbind(n_a, id)
n_a2 <- st_as_sf(nuts0.spdf) 
n_a3 <- merge(n_a1, n_a2, by = "id")
class(n_a3)

n_a4 <- st_as_sf(n_a3)
class(n_a4)


second <- tm_shape(n_a4) +
  tm_borders(col = 'white', lwd = 0.3) +
  tm_fill(col = 'value', title = 'Totals (thousands)', 
          breaks=c(0,15, 25, 75, 100, 125, 160,200),
          legend.hist = FALSE,
          palette = "Greens") +
  tm_legend(legend.outside = TRUE, position = c("right", "center")) +
  tm_compass (north = 2, type = "arrow", show.labels = 2, position = c("right", "BOTTOM")) +
  tm_layout(legend.title.size = .65, 
            legend.text.size = .65, 
            legend.frame = FALSE, title.size = 0.7,
            title = "Air Travels, 2018, Intra-EU",
            outer.margins = c(0,0,0,0),
            bg.color = "transparent") +
  tm_credits('', position = 'right') +
  tm_shape(nuts0.spdf) +
  tm_borders()

tmap_arrange(second, first)

