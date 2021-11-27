if (!knitr:::is_html_output()) {
  options("width" = 56)
  knitr::opts_chunk$set(tidy.opts = list(width.cutoff = 56, indent = 2), tidy = TRUE)
  }

## install.packages("ggplot2")

library(ggplot2)

load("data/apparent_per_capita_alcohol_consumption.rda")

alcohol <- apparent_per_capita_alcohol_consumption

penn_alcohol <- alcohol[alcohol$state == "pennsylvania", ]

names(penn_alcohol)

summary(penn_alcohol)

head(penn_alcohol)

ggplot(penn_alcohol, aes(x = year,
                         y = number_of_beers))

penn_alcohol$year <- as.numeric(penn_alcohol$year)

ggplot(penn_alcohol, aes(x = year,
                         y = number_of_beers))

ggplot(penn_alcohol, aes(x = year, y = number_of_beers)) +
  geom_point()

ggplot(penn_alcohol, aes(x = year, y = number_of_beers)) +
  geom_line()

ggplot(penn_alcohol, aes(x = year, y = number_of_beers)) +
  geom_point() +
  geom_line()

ggplot(penn_alcohol, aes(x = year, y = number_of_beers)) +
  geom_point() +
  geom_line() +
  expand_limits(y = 0)

ggplot(penn_alcohol, aes(x = year, y = number_of_beers)) +
  geom_line(color = "forestgreen", size = 1.3)

ggplot(penn_alcohol, aes(x = year, y = number_of_beers)) +
  geom_line(color = "forestgreen", size = 1.3) +
  xlab("Year") +
  ylab("Number of Beers") +
  ggtitle("PA Annual Beer Consumption Per Capita (1977-2017)")

ggplot(penn_alcohol, aes(x = year, y = number_of_glasses_wine)) +
  geom_line()

ggplot(penn_alcohol, aes(x = year, y = number_of_glasses_wine)) +
  geom_line() +
  geom_line(aes(x = year, y = number_of_shots_liquor))

ggplot(penn_alcohol, aes(x = year, y = number_of_glasses_wine,
                         color = "Glasses of Wine")) +
  geom_line() +
  geom_line(aes(x = year, y = number_of_shots_liquor,
                color = "Shots of Liquor"))

ggplot(penn_alcohol, aes(x = year, y = number_of_glasses_wine,
                         color = "Glasses of Wine")) +
  geom_line() +
  geom_line(aes(x = year, y = number_of_shots_liquor,
                color = "Shots of Liquor")) +
  labs(color = "Alcohol Type")

ggplot(penn_alcohol, aes(x = year, y = number_of_glasses_wine,
                         color = "Glasses of Wine")) +
  geom_line() +
  geom_line(aes(x = year, y = number_of_shots_liquor,
                color = "Shots of Liquor")) +
  labs(color = "Alcohol Type") +
  theme(legend.position = "bottom")

ggplot(penn_alcohol, aes(x = number_of_shots_liquor,
                         y = number_of_beers)) +
  geom_point()

ggplot(penn_alcohol, aes(x = year, y = number_of_glasses_wine,
                         color = "Glasses of Wine")) +
  geom_line() +
  geom_line(aes(x = year, y = number_of_shots_liquor,
                color = "number_of_shots_liquor")) +
  labs(color = "Alcohol Type") +
  theme(legend.position = "bottom") +
  scale_color_manual(values = c("#7570b3", "#d95f02"))
