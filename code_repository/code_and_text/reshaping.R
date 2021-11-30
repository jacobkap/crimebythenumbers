#' # Reshaping data {#reshaping}
#' 
#' For this chapter you'll need the following file, which are available for download [here](https://github.com/jacobkap/r4crimz/tree/master/data): sqf-2019.xlsx. These were initially downloaded from the New York City Police Department's page [here](https://www1.nyc.gov/site/nypd/stats/reports-analysis/stopfrisk.page). 
#' 
## ---------------------------------------------------------------------------------------------------
library(readxl)
sqf <- read_excel("data/sqf-2019.xlsx")

#' 
## ---------------------------------------------------------------------------------------------------
head(sqf)

#' 
## ---- eval = FALSE----------------------------------------------------------------------------------
## install.packages("tidyr")

#' 
#' 
## ---------------------------------------------------------------------------------------------------
library(tidyr)
library(dplyr)
sqf_agg <- sqf %>% 
  group_by(MONTH2,
           DAY2) %>%
  count(SUSPECT_RACE_DESCRIPTION)

#' 
#' 
## ---------------------------------------------------------------------------------------------------
head(sqf_agg)
unique(sqf_agg$MONTH2)
unique(sqf_agg$DAY2)
unique(sqf_agg$SUSPECT_RACE_DESCRIPTION)

#' 
#' 
## ---------------------------------------------------------------------------------------------------
sqf_agg_wide <- sqf_agg %>%
  filter(SUSPECT_RACE_DESCRIPTION != "(null)") %>%
  pivot_wider(names_from = SUSPECT_RACE_DESCRIPTION, values_from = n) 
head(sqf_agg_wide)

#' 
## ---- eval = FALSE----------------------------------------------------------------------------------
## install.packages("janitor")

#' 
## ---------------------------------------------------------------------------------------------------
library(janitor)
names(sqf_agg_wide) <- make_clean_names(names(sqf_agg_wide))
names(sqf_agg_wide)

#' 
#' 
#' 
#' 
## ---------------------------------------------------------------------------------------------------
sqf_agg_long <- sqf_agg_wide %>%
  pivot_longer(cols = c("asian_pacific_islander", 
                        "black",
                        "black_hispanic",
                        "white",
                        "white_hispanic",
                        "american_indian_alaskan_n"),
               names_to = "race",
               values_to = "number_of_people_stopped")
head(sqf_agg_long)

#' 
## ---------------------------------------------------------------------------------------------------
sqf_agg_long <- sqf_agg_wide %>%
  pivot_longer(cols = asian_pacific_islander:american_indian_alaskan_n,
               names_to = "race",
               values_to = "number_of_people_stopped")
head(sqf_agg_long)

#' 
## ---------------------------------------------------------------------------------------------------
sqf_agg$n2 <- sqf_agg$n + 10
sqf_agg_wide <- sqf_agg %>%
  filter(SUSPECT_RACE_DESCRIPTION != "(null)") %>%
  pivot_wider(names_from = SUSPECT_RACE_DESCRIPTION, values_from = c(n, n2)) 
names(sqf_agg_wide) <- make_clean_names(names(sqf_agg_wide))
head(sqf_agg_wide)

#' 
## ---------------------------------------------------------------------------------------------------
sqf_agg_long <- sqf_agg_wide %>%
  pivot_longer(cols = c("n_asian_pacific_islander", 
                        "n_black",
                        "n_black_hispanic",
                        "n_white",
                        "n_white_hispanic",
                        "n_american_indian_alaskan_n"),
               names_to = "race",
               values_to = "number_of_people_stopped") %>%
  pivot_longer(cols = c("n2_asian_pacific_islander", 
                        "n2_black",
                        "n2_black_hispanic",
                        "n2_white",
                        "n2_white_hispanic",
                        "n2_american_indian_alaskan_n"),
               names_to = "race2",
               values_to = "number_of_people_stopped2") %>%
  select(-race2)
head(sqf_agg_long)


#' 
#' 
#' 
#' https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html
#' 
