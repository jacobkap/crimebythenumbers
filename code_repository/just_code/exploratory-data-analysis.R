if (!knitr:::is_html_output()) {
  options("width" = 56)
  knitr::opts_chunk$set(tidy.opts = list(width.cutoff = 56, indent = 2), tidy = TRUE)
  }

load("data/ucr2017.rda")

nrow(ucr2017)

ncol(ucr2017)

head(ucr2017)

names(ucr2017)

summary(ucr2017)

head(ucr2017$agency_name)

table(ucr2017$year)

table(ucr2017$state)

sort(table(ucr2017$state))

sort(table(ucr2017$state), decreasing = TRUE)

plot(ucr2017$actual_murder, ucr2017$actual_robbery_total)

ucr2017_big_cities <- ucr2017[ucr2017$population > 1000000, ]

plot(ucr2017_big_cities$actual_murder, ucr2017_big_cities$actual_robbery_total)

plot(ucr2017_big_cities$actual_murder, ucr2017_big_cities$actual_robbery_total,
     xlab = "Murder",
     ylab = "Robberies",
     main = "Relationship between murder and robbery")

offenses_known_yearly_1960_2020 <- readRDS("data/offenses_known_yearly_1960_2020.rds")
colorado <- offenses_known_yearly_1960_2020[offenses_known_yearly_1960_2020$state == "colorado", ]
colorado <- colorado[colorado$year %in% 2011:2017, ]
colorado <- colorado[ , c("actual_murder", "state", "year", "population", "ori", "agency_name")]

aggregate(actual_murder ~ year, FUN = sum, data = colorado)

aggregate(actual_murder ~ year + state, FUN = sum, data = colorado)

colorado_agg <- aggregate(cbind(population, actual_murder) ~ year, FUN = sum, data = colorado)

colorado_agg$murder_rate <- colorado_agg$actual_murder / colorado_agg$population * 100000

colorado_agg

plot(x = colorado_agg$year, y = colorado_agg$murder_rate)

plot(x = colorado_agg$year, y = colorado_agg$murder_rate, type = "l")

plot(x = colorado_agg$year, y = colorado_agg$murder_rate, type = "l",
     xlab = "Year",
     ylab = "Murders per 100k Population",
     main = "Murder Rate in Colorado, 2011-2017")
