load("data/ucr2017.rda")

head(ucr2017)

names(ucr2017)

summary(ucr2017)

head(ucr2017$agency_name)

table(ucr2017$year)

table(ucr2017$state)

sort(table(ucr2017$state))

sort(table(ucr2017$state), decreasing = TRUE)

plot(ucr2017$actual_murder, ucr2017$actual_robbery_total)

library(dplyr)
ucr2017_big_cities <- filter(ucr2017, population > 1000000) 

plot(ucr2017_big_cities$actual_murder, ucr2017_big_cities$actual_robbery_total)

plot(ucr2017_big_cities$actual_murder, ucr2017_big_cities$actual_robbery_total,
     xlab = "Murders",
     ylab = "Robberies",
     main = "Relationship between murder and robbery")

ucr <- readRDS("data/offenses_known_yearly_1960_2020.rds")
colorado <- filter(ucr, state == "colorado", 
                   year %in% 2011:2017)
colorado <- select(colorado, actual_murder, actual_robbery_total, state, year, population, ori, agency_name)

colorado <- group_by(colorado, year)

summarize(colorado, sum(actual_murder))

summarize(colorado, sum(actual_murder), 
          sum(actual_robbery_total))

summarize(colorado, sum(actual_murder),
          sum(actual_robbery_total),
          mean(actual_robbery_total))

colorado_agg <- summarize(colorado,
                          murders    = sum(actual_murder),
                          robberies  = sum(actual_robbery_total),
                          population = sum(population))
colorado_agg

colorado_agg$murder_rate <- colorado_agg$murders / colorado_agg$population * 100000

colorado_agg$robbery_rate <- colorado_agg$robberies / colorado_agg$population * 100000

mutate(colorado_agg,
       murder_rate  = murders / population * 100000,
       robbery_rate = robberies / population * 100000)

plot(x = colorado_agg$year,
     y = colorado_agg$murder_rate)

plot(x = colorado_agg$year,
     y = colorado_agg$murder_rate,
     type = "l")

plot(x = colorado_agg$year,
     y = colorado_agg$murder_rate,
     type = "l",
     xlab = "Year",
     ylab = "Murders per 100k Population",
     main = "Murder Rate in Colorado, 2011-2017")

colorado <- filter(ucr, state == "colorado",
                   year %in% 2011:2017)
colorado <- select(colorado,
                   actual_murder, 
                   actual_robbery_total,
                   state, 
                   year,
                   population,
                   ori,
                   agency_name)
head(colorado)

colorado <- ucr %>% filter(state == "colorado", year %in% 2011:2017) %>%   select(actual_murder, actual_robbery_total, state, year, population, ori, agency_name)

head(colorado)

colorado <- ucr %>%
  filter(state == "colorado",
         year %in% 2011:2017) %>%
  select(actual_murder, 
         actual_robbery_total,
         state, 
         year,
         population,
         ori, 
         agency_name)
