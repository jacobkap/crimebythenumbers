## install.packages("tidygeocoder")

library(tidygeocoder)

geocode("750 Race St. Philadelphia, PA 19106")

address_to_geocode <- data.frame(address = "750 Race St. Philadelphia, PA 19106")

geocode(address_to_geocode, address)

geocode(address_to_geocode, "address")

geocode(address_to_geocode, "address", method = "osm")

geocode(address_to_geocode, "address", method = "census")

geocode(address_to_geocode, "address", method = "arcgis")

example <- geocode(address_to_geocode, "address", method = "arcgis")
example <- data.frame(example)
example

example <- geocode(address_to_geocode, "address", method = "osm", full_results = TRUE)
example <- data.frame(example)
example

example <- geocode(address_to_geocode, "address", method = "census", full_results = TRUE)
example <- data.frame(example)
example

example <- geocode(address_to_geocode, "address", method = "arcgis", full_results = TRUE)
example <- data.frame(example)
example

library(readr)
marijuana <- read_csv("data/san_francisco_active_marijuana_retailers.csv")
marijuana <- data.frame(marijuana)

head(marijuana)

marijuana$Premise.Address <- gsub(" County: SAN FRANCISCO", "", marijuana$Premise.Address)

names(marijuana)
head(marijuana$Premise.Address)

marijuana <- geocode(marijuana, "Premise.Address")

summary(marijuana$long)

summary(marijuana$lat)

marijuana$long <- NULL
marijuana$lat  <- NULL
marijuana      <- geocode(marijuana, "Premise.Address", method = "arcgis")

summary(marijuana$long)

summary(marijuana$lat)

plot(marijuana$long, marijuana$lat)
