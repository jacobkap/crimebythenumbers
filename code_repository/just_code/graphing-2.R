library(readr)
shootings <- read_csv("data/fatal-police-shootings-data.csv")

shootings <- as.data.frame(shootings)

nrow(shootings)
ncol(shootings)

head(shootings)

summary(shootings$date)
summary(shootings$age)

table(shootings$manner_of_death)

table(shootings$manner_of_death) / nrow(shootings) * 100

table(shootings$armed) / nrow(shootings) * 100

temp <- table(shootings$armed) / nrow(shootings) * 100
temp <- sort(temp, decreasing = TRUE)
temp <- round(temp, digits = 2)
temp

table(shootings$gender) / nrow(shootings) * 100

temp <- table(shootings$race) / nrow(shootings) * 100
temp <- sort(temp)
temp <- round(temp, digits = 2)
temp

library(ggplot2)

ggplot(shootings, aes(x = age))

ggplot(shootings, aes(x = age)) + 
  geom_histogram()

ggplot(shootings, aes(x = age)) + 
  geom_histogram(bins = 15)

ggplot(shootings, aes(x = age)) + 
  geom_histogram(bins = 45)

ggplot(shootings, aes(x = age)) + 
  geom_histogram(aes(y = (..count..)/sum(..count..)))

ggplot(shootings, aes(x = age)) + 
  geom_density()

ggplot(shootings, aes(x = age)) + 
  stat_count()

ggplot(shootings, aes(x = age)) + 
  stat_count(aes(y = (..count..)/sum(..count..)))

ggplot(shootings, aes(x = race)) + 
  geom_bar()

table(shootings$race)

sort(table(shootings$race))

sort(table(shootings$race), decreasing = TRUE)

names(sort(table(shootings$race), decreasing = TRUE))

shootings$race <- factor(shootings$race,
                         levels = names(sort(table(shootings$race), decreasing = TRUE)))

ggplot(shootings, aes(x = race)) + 
  geom_bar() 

ggplot(shootings, aes(x = race)) + 
  geom_bar() +
  coord_flip() 

shootings$race <- factor(shootings$race,
                         levels = names(sort(table(shootings$race), decreasing = FALSE)))
ggplot(shootings, aes(x = race)) + 
  geom_bar() +
  coord_flip() 

shootings$race <- as.character(shootings$race)
shootings$race[is.na(shootings$race)] <- "Unknown"

shootings$race[shootings$race == "O"] <- "Other"
shootings$race[shootings$race == "N"] <- "Native American"
shootings$race[shootings$race == "A"] <- "Asian"
shootings$race[shootings$race == "H"] <- "Hispanic"
shootings$race[shootings$race == "B"] <- "Black"
shootings$race[shootings$race == "W"] <- "White"

shootings$race <- factor(shootings$race,
                         levels = names(sort(table(shootings$race), decreasing = FALSE)))
ggplot(shootings, aes(x = race)) + 
  geom_bar() +
  coord_flip() 

ggplot(shootings, aes(x = race)) + 
  geom_bar(aes(y = (..count..)/sum(..count..))) +
  coord_flip() 

shootings$dummy <- 1
ggplot(shootings, aes(x = date, y = dummy)) +
  geom_line()

## install.packages("lubridate")

library(lubridate)

shootings$month_year <- floor_date(shootings$date, unit = "month")
shootings$year <- year(shootings$date)

head(shootings$month_year)
head(shootings$year)

library(dplyr)
monthly_shootings <- shootings %>%
  group_by(month_year) %>% 
  summarize(dummy = sum(dummy))
head(monthly_shootings)

ggplot(monthly_shootings, aes(x = month_year, y = dummy)) +
  geom_line()

yearly_shootings <- shootings %>%
  group_by(year) %>% 
  summarize(dummy = sum(dummy))
ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line()

## install.packages("ggthemes")

library(ggthemes)
ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line() +
  theme_fivethirtyeight()

ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line() +
  theme_tufte()

ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line() +
  theme_few()

ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line() +
  theme_excel()
