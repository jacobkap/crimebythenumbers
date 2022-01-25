library(readr)
suicide <- read_csv("data/san_francisco_suicide_2003_2017.csv")
suicide <- as.data.frame(suicide)

head(suicide)

## install.packages("ggmap")

library(ggmap)

knitr::include_graphics('images/bounding_box.PNG')

sf_map <- ggmap(get_map(c(-122.530392,37.698887,-122.351177,37.812996), 
                            source = "stamen"))
sf_map

sf_map +
  geom_point(aes(x = X, y = Y),
             data  = suicide)

sf_map +
  geom_point(aes(x = X, y = Y),
             data  = suicide,
             color = "forestgreen")

sf_map +
  geom_point(aes(x = X, y = Y),
             data  = suicide,
             color = "forestgreen",
             size  = 0.5)

sf_map +
  geom_point(aes(x = X, y = Y),
             data  = suicide,
             color = "forestgreen",
             size  = 2)

sf_map +
  geom_point(aes(x = X, y = Y),
             data  = suicide,
             color = "forestgreen",
             size  = 2,
             alpha = 0.5)

plot(suicide$X, suicide$Y, col = "forestgreen")

## install.packages("hexbin")

sf_map +
  stat_binhex(aes(x = X, y = Y),
              bins = 60,
              data = suicide) +
  coord_cartesian() 

sf_map +
  stat_binhex(aes(x = X, y = Y),
              bins = 30,
              data = suicide) +
  coord_cartesian() 

sf_map +
  stat_binhex(aes(x = X, y = Y),
              bins = 100,
              data = suicide) +
  coord_cartesian() 

sf_map +
  stat_binhex(aes(x = X, y = Y),
              bins  = 60,
              data = suicide) +
  coord_cartesian() +
  scale_fill_gradient(low = "#ffeda0",
                      high = "#f03b20")

sf_map +
  stat_binhex(aes(x = X, y = Y),
              bins  = 60,
              data = suicide) +
  coord_cartesian() +
  scale_fill_gradient('Suicides',
                      low = "#ffeda0",
                      high = "#f03b20")
