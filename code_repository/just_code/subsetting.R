if (!knitr:::is_html_output()) {
  options("width" = 56)
  knitr::opts_chunk$set(tidy.opts = list(width.cutoff = 56, indent = 2), tidy = TRUE)
  }

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

x = 2

x

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

2 == 3 | 2 > 1

2 == 3 & 2 > 1

offenses_known_yearly_1960_2020 <- readRDS("data/offenses_known_yearly_1960_2020.rds")

offenses_known_yearly_1960_2020[1:6, 1:6]

nrow(offenses_known_yearly_1960_2020)

ncol(offenses_known_yearly_1960_2020)

names(offenses_known_yearly_1960_2020)

head(offenses_known_yearly_1960_2020$agency_name)

head(offenses_known_yearly_1960_2020$actual_murder)

offenses_known_yearly_1960_2020[1, 1]

offenses_known_yearly_1960_2020[1:6, 1:6]

offenses_known_yearly_1960_2020[1:6, c("ori", "year")]

offenses_known_yearly_1960_2020[1, ]

offenses_known_yearly_1960_2020[1 1]

head(offenses_known_yearly_1960_2020[1])

head(offenses_known_yearly_1960_2020[1000])

offenses_known_yearly_1960_2020$agency_name[15]

colorado <- offenses_known_yearly_1960_2020[offenses_known_yearly_1960_2020$state == "colorado", ]

colorado <- colorado[colorado$year %in% 2011:2017, ]

colorado <- colorado[ , c("actual_murder", "state", "year", "population", "ori", "agency_name")]

unique(colorado$state)

unique(colorado$year)
