library(readr)
suicide <- read_csv("data/san_francisco_suicide_2003_2017.csv")
suicide <- as.data.frame(suicide)

## install.packages("sf")

library(sf)

sf_neighborhoods <- st_read("data/san_francisco_neighborhoods.shp")

head(sf_neighborhoods)

plot(sf_neighborhoods$geometry)

st_crs(sf_neighborhoods)

st_crs(2227)

sf_neighborhoods <- st_transform(sf_neighborhoods, crs = 2227)
st_crs(sf_neighborhoods)

suicide <- st_as_sf(suicide, 
                    coords = c("X", "Y"),
                    crs = "+proj=longlat +ellps=WGS84 +no_defs")

suicide <- st_transform(suicide, 
                        crs = st_crs(sf_neighborhoods))

head(suicide)

plot(sf_neighborhoods$geometry)
plot(suicide$geometry, add = TRUE, col = "red")

suicide_agg <- st_join(suicide, sf_neighborhoods)

head(suicide_agg)

suicide_agg$number_suicides <- 1

library(dplyr)
suicide_agg <- suicide_agg %>% group_by(nhood) %>% summarize(number_suicides = sum(number_suicides))

summary(suicide_agg$number_suicides)

nrow(suicide_agg)

nrow(sf_neighborhoods)

suicide_agg$geometry <- NULL

sf_neighborhoods_suicide <- left_join(sf_neighborhoods, suicide_agg)

summary(sf_neighborhoods_suicide$number_suicides)

sf_neighborhoods_suicide$number_suicides[is.na(sf_neighborhoods_suicide$number_suicides)] <- 0

summary(sf_neighborhoods_suicide$number_suicides)

library(ggplot2)

ggplot(sf_neighborhoods_suicide, aes(fill = number_suicides)) +
  geom_sf() 

ggplot(sf_neighborhoods_suicide, aes(fill = number_suicides)) +
  geom_sf() +
  scale_fill_gradient(low = "white", high = "red") 

ggplot(sf_neighborhoods_suicide, aes(fill = number_suicides)) +
  geom_sf() +
  scale_fill_gradient(low = "white", high = "red") +
  labs(fill = "# of suicides",
       title = "Suicides in San Francisco, by neighborhood",
       subtitle = "2003 - 2017") 

ggplot(sf_neighborhoods_suicide, aes(fill = number_suicides)) +
  geom_sf() +
  scale_fill_gradient(low = "white", high = "red") +
  labs(fill = "# of suicides",
       title = "Suicides in San Francisco, by neighborhood",
       subtitle = "2003 - 2017") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank())

save(sf_neighborhoods_suicide, file = "data/sf_neighborhoods_suicide.rda")
