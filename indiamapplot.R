# http://r-nold.blogspot.in/2012/08/provincial-map-using-gadm.html
# http://blog.revolutionanalytics.com/2009/10/geographic-maps-in-r.html
# http://gis.stackexchange.com/questions/80565/plotting-a-map-of-new-zealand-with-regional-boundaries-in-r
# https://ryouready.wordpress.com/2009/11/16/infomaps-using-r-visualizing-german-unemployment-rates-by-color-on-a-map/
# http://rstudio-pubs-static.s3.amazonaws.com/6772_441847b522584d1095daddc2677e4ddb.html -- comprehensive 

# Load required libraries
library(sp)
library(RColorBrewer)

# load level 1 india data downloaded from http://gadm.org/country
ind1 <- readRDS("IND_adm1.rds")

# simple map of India with states drawn
# unfortunately, Kashmir will get truncated 
spplot(ind1, "NAME_1", scales=list(draw=T), colorkey=F, main="India")

# map of India with states coloured with an arbitrary fake data
ind1$NAME_1 = as.factor(ind1$NAME_1)
ind1$fake.data = runif(length(ind1$NAME_1))
spplot(ind1,"NAME_1",  col.regions=rgb(0,ind1$fake.data,0), colorkey=T, main="Indian States")


# list of states avaialable
ind1$NAME_1

# map of Karnataka 
kar1 = (ind1[ind1$NAME_1=="Karnataka",])
spplot(kar1,"NAME_1", col.regions=rgb(0,0,1), main = "Karnataka, India",scales=list(draw=T), colorkey =F)

# --------------------------------------------------------------------------------------
# load level 2 india data downloaded from http://gadm.org/country
ind2 =readRDS("IND_adm2.rds")

# plotting districts of a State, in this case West Bengal
kar2 = (ind2[ind2$NAME_1=="Karnataka",])
spplot(kar2,"NAME_1", main = "Karnataka Districts", scales=list(draw=T), colorkey =F)

# colouring the districts with some simulated, fake data
kar2$NAME_2 = as.factor(kar2$NAME_2)
kar2$fake.data = runif(length(kar2$NAME_1)) 
spplot(kar2,"NAME_2",  col.regions=rgb(0,kar2$fake.data, 0), colorkey=T)

# colouring the districts with rainbow of colours
# wb2$NAME_2 = as.factor(wb2$NAME_2)
col = rainbow(length(levels(kar2$NAME_2)))
spplot(kar2,"NAME_2",  col.regions=col, colorkey=T)

# colouring the districts with range of colours
col_no = as.factor(as.numeric(cut(kar2$fake.data, c(0,0.2,0.4,0.6,0.8,1))))
levels(col_no) = c("<20%", "20-40%", "40-60%","60-80%", ">80%")
kar2$col_no = col_no
myPalette = brewer.pal(5,"Greens")
spplot(kar2, "col_no", col=grey(.9), col.regions=myPalette, main="District Wise Data")

# --------------------------------------------------------------------------------------
# load level 3 india data downloaded from http://gadm.org/country
ind3 =readRDS("IND_adm3.rds")

# extracting data for West Bengal
kar3 = (ind3[ind3$NAME_1=="Karnataka",])

#plotting districts and sub-divisions / taluk
kar3$NAME_3 = as.factor(kar3$NAME_3)
col = rainbow(length(levels(kar3$NAME_3)))
spplot(kar3,"NAME_3", main = "Taluk, District - Karnataka", colorkey=T,col.regions=col,scales=list(draw=T))

# get list of sub districts avaialable
kar3$NAME_3

# get map for "North 24 Parganas District"
kar3 = (ind3[ind3$NAME_1=="Karnataka",])
bang1 = (kar3[kar3$NAME_2=="Bangalore",])
spplot(bang1,"NAME_3", colorkey =F, scales=list(draw=T), main = "Bangalore")

bang1$NAME_3 = as.factor(bang1$NAME_3)
bang1$fake.data = runif(length(bang1$NAME_3))
spplot(bang1,"NAME_3", col.regions=rgb(0, bang1$fake.data, 0), colorkey=T,scales=list(draw=T))

# get map for "South 24 Parganas District"
mys1 = (kar3[kar3$NAME_2=="Mysore",])
spplot(mys1,"NAME_3", colorkey =F, scales=list(draw=T), main = "Mysore")

mys1$NAME_3 = as.factor(mys1$NAME_3)
mys1$fake.data = runif(length(mys1$NAME_3))
spplot(mys1,"NAME_3", col.regions=rgb(0, mys1$fake.data, 0), colorkey=T,scales=list(draw=T),main = "Mysore")



# Add 2 areas bangalore rural and urban
bang1 = (kar3[kar3$NAME_2=="Bangalore Rural",])
bang2 = (kar3[kar3$NAME_2=="Bangalore",])
bang3 <- rbind(bang1,bang2)
spplot(bang3,"NAME_3", colorkey =F, scales=list(draw=T), main = "Bangalore")

# -------------------------------------------------------------------------------------------
# load level 2 india data downloaded from http://gadm.org/country
ind2 <-readRDS("IND_adm2.rds")

# plotting selected districts of Karnataka
kar4 = (ind2[ind2$NAME_1=="Karnataka",])
spplot(kar4,"NAME_1", main = "Karnataka Districts", scales=list(draw=T),xlim=c(75,78),ylim=c(12,14),colorkey =F)

kar5 = (ind2[ind2$NAME_1=="Karnataka",])
kar5$NAME_2 = as.factor(kar5$NAME_2)
col = rainbow(length(levels(kar5$NAME_2)))
spplot(kar5,"NAME_2",  col.regions=col,scales=list(draw=T),ylim=c(12,14),xlim=c(75,78), colorkey=T)

