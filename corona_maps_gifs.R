library(cartography)

corona_map <- read_excel("/Users/wemigliari/documents/R/tabelas/corona_outbreak.xlsx",
                         sheet = "maps")

coror <- cbind(nuts0.df, corona_map)


plot(nuts0.spdf, border = NA, col = NA, bg = "#006092")
plot(world.spdf, col = "#686c5e", border = NA, add = TRUE)
plot(nuts0.spdf, col = "#D1914D", border = "grey80",  add = TRUE)

# Add circles proportional to the total population
propSymbolsLayer(spdf = nuts0.spdf, df = coror,
                 var = "totalmars2", symbols = "circle", col = "#a5201980",
                 legend.pos = "right", legend.title.txt = "Total of People Infected (2020)", legend.style = "c")

layoutLayer(title = "Coronavirus in Europe for 2nd Week of March (2020)",
            author = "Migliari, W.", sources = "Worldometer, 2020",
            scale = NULL, south = TRUE)
###2

plot(nuts0.spdf, border = NA, col = NA, bg = "#006092")
plot(world.spdf, col = "#686c5e", border = NA, add = TRUE)
plot(nuts0.spdf, col = "#D1914D", border = "grey80",  add = TRUE)

propSymbolsLayer(spdf = nuts0.spdf, df = coror,
                 var = "totalmars3", symbols = "circle", col = "#00800080",
                 legend.pos = "right", legend.title.txt = "Total of People Infected (2020)", legend.style = "c")

# Add titles, legend...
layoutLayer(title = "Coronavirus in Europe for 3rd Week of March (2020)",
            author = "Migliari, W.", sources = "Worldometer, 2020",
            scale = NULL, south = TRUE)
###3

plot(nuts0.spdf, border = NA, col = NA, bg = "#006092")
plot(world.spdf, col = "#686c5e", border = NA, add = TRUE)
plot(nuts0.spdf, col = "#D1914D", border = "grey80",  add = TRUE)

propSymbolsLayer(spdf = nuts0.spdf, df = coror,
                 var = "totalapril1", symbols = "circle", col = "#fff0f580",
                 legend.pos = "right", legend.title.txt = "Total of People Infected (2020)", legend.style = "c")

# Add titles, legend...
layoutLayer(title = "Coronavirus in Europe for 1st Week of April (2020)",
            author = "Migliari, W.", sources = "Worldometer, 2020",
            scale = NULL, south = TRUE)
###4

plot(nuts0.spdf, border = NA, col = NA, bg = "#006092")
plot(world.spdf, col = "#686c5e", border = NA, add = TRUE)
plot(nuts0.spdf, col = "#D1914D", border = "grey80",  add = TRUE)

propSymbolsLayer(spdf = nuts0.spdf, df = coror,
                 var = "totalapril4", symbols = "circle", col = "#FFFF0080",
                 legend.pos = "right", legend.title.txt = "Total of People Infected (2020)", legend.style = "c")

# Add titles, legend...
layoutLayer(title = "Coronavirus in Europe for 4th Week of April (2020)",
            author = "Migliari, W.", sources = "Worldometer, 2020",
            scale = NULL, south = TRUE)
###

library(purrr)
library(magick)

list.files(path = "/Users/wemigliari/Documents/R/R_Scripts/map_codes", pattern = "*.png", full.names = T) %>% 
  map(image_read) %>% # reads each path file
  image_join() %>% # joins image
  image_animate(fps=0.5) %>% # animates, can opt for number of loops
  image_write("/Users/wemigliari/Documents/R/R_Scripts/map_codes/corona.gif") # write to current dir
