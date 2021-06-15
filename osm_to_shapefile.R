
library(rgdal)

osm <- readOGR('/Users/wemigliari/Documents/R/data/skara.osm', c('multipolygons','lines'))
plot(osm)
writeOGR(osm, '/Users/wemigliari/Documents/R/data/', 'skara', driver = 'ESRI Shapefile')

axvall <- readOGR('/Users/wemigliari/Documents/R/data/axvall.osm', c('multipolygons','lines'))
plot(axvall)
writeOGR(axvall, '/Users/wemigliari/Documents/R/data/', 'axvall', driver = 'ESRI Shapefile')

varnhem <- readOGR('/Users/wemigliari/Documents/R/data/varnhem.osm', c('multipolygons','lines'))
plot(varnhem)
writeOGR(varnhem, '/Users/wemigliari/Documents/R/data/', 'varnhem', driver = 'ESRI Shapefile')

