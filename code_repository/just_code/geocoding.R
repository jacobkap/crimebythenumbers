if (!knitr:::is_html_output()) {
  options("width" = 56)
  knitr::opts_chunk$set(tidy.opts = list(width.cutoff = 56, indent = 2), tidy = TRUE)
  }

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

geocode(address_to_geocode, "address", method = "osm", full_results = TRUE)

geocode(address_to_geocode, "address", method = "census", full_results = TRUE)

geocode(address_to_geocode, "address", method = "arcgis", full_results = TRUE)

library(readr)
marijuana <- read_csv("data/san_francisco_active_marijuana_retailers.csv")
marijuana <- as.data.frame(marijuana)

head(marijuana)

names(marijuana) <- gsub(" ", "_", names(marijuana))

marijuana$Premise_Address <- gsub(" County: SAN FRANCISCO", "", marijuana$Premise_Address)

names(marijuana)
head(marijuana$Premise_Address)

marijuana <- geocode(marijuana, "Premise_Address")

summary(marijuana$long)

summary(marijuana$lat)

marijuana$long <- NULL
marijuana$lat  <- NULL
marijuana      <- geocode(marijuana, "Premise_Address", method = "arcgis")

summary(marijuana$long)

summary(marijuana$lat)

plot(marijuana$long, marijuana$lat)

write_csv(marijuana, file = "data/san_francisco_marijuana_geocoded.csv")
