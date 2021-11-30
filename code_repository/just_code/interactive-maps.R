library(readr)
marijuana <- read_csv("data/san_francisco_marijuana_geocoded.csv")
marijuana <- as.data.frame(marijuana)

head(marijuana)

## install.packages("leaflet")

library(leaflet)

leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors')

leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addMarkers(lng = marijuana$long, 
             lat = marijuana$lat)


leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat)


leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat,
                   radius = 5)

leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat,
                   radius = 5,
                   popup = marijuana$Business_Owner)

leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat,
                   radius = 5,
                   popup = paste("Business Owner:", marijuana$Business_Owner))

leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat,
                   radius = 5,
                   popup = paste("Business Owner:", marijuana$Business_Owner,
                                 "Address:", marijuana$Premise_Address,
                                 "License:", marijuana$License_Number))

leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat,
                   radius = 5,
                   popup = paste("Business Owner:", marijuana$Business_Owner,
                                 "<br>",
                                 "Address:", marijuana$Premise_Address,
                                 "<br>",
                                 "License:", marijuana$License_Number))

leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$long, 
                   lat = marijuana$lat,
                   radius = 5,
                   popup = paste("Business Owner:", marijuana$Business_Owner,
                                 "<br>",
                                 "Address:", marijuana$Premise_Address,
                                 "<br>",
                                 "License:", marijuana$License_Number),
                   clusterOptions = markerClusterOptions())

load("data/sf_neighborhoods_suicide.rda")

leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry)

library(sf)
sf_neighborhoods_suicide <- st_transform(sf_neighborhoods_suicide,
                                         crs = "+proj=longlat +datum=WGS84")

leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry)

leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry,
              color = "black",
              weight = 1)

leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Neighborhood: ", sf_neighborhoods_suicide$nhood,
                             "<br>",
                             "Number of Suicides: ", sf_neighborhoods_suicide$number_suicides))

pal <- colorNumeric("OrRd", sf_neighborhoods_suicide$number_suicides)
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Neighborhood: ", sf_neighborhoods_suicide$nhood,
                             "<br>",
                             "Number of Suicides: ", sf_neighborhoods_suicide$number_suicides),
              fillColor = pal(sf_neighborhoods_suicide$number_suicides))

pal <- colorNumeric("OrRd", sf_neighborhoods_suicide$number_suicides)
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Neighborhood: ", sf_neighborhoods_suicide$nhood,
                             "<br>",
                             "Number of Suicides: ", sf_neighborhoods_suicide$number_suicides),
              fillColor = pal(sf_neighborhoods_suicide$number_suicides),
              fillOpacity = 1)

pal <- colorNumeric("OrRd", sf_neighborhoods_suicide$number_suicides)
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Neighborhood: ", sf_neighborhoods_suicide$nhood,
                             "<br>",
                             "Number of Suicides: ", sf_neighborhoods_suicide$number_suicides),
              fillColor = pal(sf_neighborhoods_suicide$number_suicides),
              fillOpacity = 1) %>%
  addLegend(pal = pal, 
            values = sf_neighborhoods_suicide$number_suicides,
            opacity = 1)

pal <- colorNumeric("OrRd", sf_neighborhoods_suicide$number_suicides)
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = sf_neighborhoods_suicide$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Neighborhood: ", sf_neighborhoods_suicide$nhood,
                             "<br>",
                             "Number of Suicides: ", sf_neighborhoods_suicide$number_suicides),
              fillColor = pal(sf_neighborhoods_suicide$number_suicides),
              fillOpacity = 1) %>%
  addLegend(pal = pal, 
            values = sf_neighborhoods_suicide$number_suicides,
            opacity = 1,
            title = "Suicides")
