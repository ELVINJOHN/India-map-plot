#Import library for geocoding and obtaining city locations
library(ggmap)
#import India geo data from http://gadm.org/country
ind <- readRDS("IND_adm1.rds")
# plot district borders of Karnataka State
states <- read.csv("statecap.csv")
city <- as.character(states$Capital)
position = geocode(city) #Fetch position of city
clat = position$lat+0.05    #Position of city name
cities = data.frame(city, position$lon,position$lat,clat)
names(cities)[2] = "lon"
names(cities)[3] = "lat" #Header of cities dataframe "city" "lon"  "lat"  "clat"

text1 = list("panel.text", cities$lon, cities$clat, cities$city,col="red", cex = 0.75)
mark1 = list("panel.points", cities$lon, cities$lat, col="blue")
text2 = list("panel.text",87,15,"India map", col = "green", cex = 1.75)
spplot(ind, 
       "NAME_1",
       sp.layout=list(text1,mark1, text2),
       main="Karnataka",
       colorkey=F, 
       scales=list(draw=TRUE))

