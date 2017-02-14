#Import library for geocoding and obtaining city locations
library(ggmap)
#import India geo data from http://gadm.org/country
ind <- readRDS("IND_adm2.rds")
# plot district borders of Karnataka State
kar = (ind[ind$NAME_1=="Karnataka",])
#Select cities of karnataka
city = kar$NAME_2
position = geocode(city) #Fetch position of city
clat = position$lat+0.05    #Position of city name
cities = data.frame(city, position$lon,position$lat,clat)
names(cities)[2] = "lon"
names(cities)[3] = "lat" #Header of cities dataframe "city" "lon"  "lat"  "clat"

text1 = list("panel.text", cities$lon, cities$clat, cities$city,col="red", cex = 0.75)
mark1 = list("panel.points", cities$lon, cities$lat, col="blue")
text2 = list("panel.text",77.8,14.8,"Karnataka map", col = "green", cex = 0.75)
spplot(kar5, 
       "NAME_1",
       sp.layout=list(text1,mark1, text2),
       main="Karnataka",
       colorkey=F, 
       scales=list(draw=TRUE))

