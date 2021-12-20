animals <- c("cat", "dog", "gorilla", "buffalo", "lion", "snake")

animals

animals[6]

animals[3]

animals[c(1, 2, 3)]

1:3

animals[1:3]

animals[c(3, 4, 1)]

animals[-1]

animals[-c(1, 2, 3)]

-1:3

animals[-(1:3)]

animals[-1]

animals

animals[c(TRUE, TRUE, FALSE, FALSE, FALSE, FALSE)]

numbers <- 1:10

2 == 2

2 == 3

numbers == 2

animals == "gorilla"

2 %in% c(1, 2, 3) 

animals %in% c("cat", "dog", "gorilla")

2 != 3

"cat" != "gorilla"

!animals %in% c("cat", "dog", "gorilla")

6 > 5

6 < 5

6 >= 5

5 <= 5

numbers > 3

knitr::include_graphics('images/peanut.png')

knitr::include_graphics('images/dog_food.PNG')

2 == 3 | 2 > 1

2 == 3 & 2 > 1

ucr <- readRDS("data/offenses_known_yearly_1960_2020.rds")

ucr[1:6, 1:6]

nrow(ucr)

ncol(ucr)

names(ucr)

head(ucr$agency_name)

head(ucr$actual_murder)

knitr::include_graphics('images/tab_example.PNG')

ucr[1, 1]

ucr[1:6, 1:6]

ucr[1:6, c("ori", "year")]

ucr[1, ]

ucr[1 1]

head(ucr[1])

head(ucr[1000])

ucr$agency_name[15]

colorado <- ucr[ucr$state == "colorado", ]

colorado <- colorado[colorado$year %in% 2011:2017, ]

colorado <- colorado[ , c("actual_murder", "state", "year",
                          "population", "ori", "agency_name")]

unique(colorado$state)

unique(colorado$year)

colorado <- ucr[ucr$state == "colorado", ]
colorado <- colorado[colorado$year %in% 2011:2017, ]
colorado <- colorado[ , c("actual_murder", "state", "year",
                          "population", "ori", "agency_name")]

## install.packages("dplyr")

library(dplyr)
colorado <- filter(ucr, state == "colorado")

colorado <- filter(ucr, year %in% 2011:2017)

colorado <- filter(ucr, state == "colorado", year %in% 2011:2017)

colorado <- select(colorado, actual_murder, state, year, population, ori, agency_name)

unique(colorado$state)

unique(colorado$year)
