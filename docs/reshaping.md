# Reshaping data {#reshaping}

For this chapter you'll need the following file, which are available for download [here](https://github.com/jacobkap/r4crimz/tree/master/data): sqf-2019.xlsx. These were initially downloaded from the New York City Police Department's page [here](https://www1.nyc.gov/site/nypd/stats/reports-analysis/stopfrisk.page). 


```r
library(readxl)
sqf <- read_excel("data/sqf-2019.xlsx")
```


```r
head(sqf)
#> # A tibble: 6 x 83
#>   STOP_ID_ANONY STOP_FRISK_DATE     STOP_FRISK_TIME     YEAR2 MONTH2  DAY2     
#>           <dbl> <dttm>              <dttm>              <dbl> <chr>   <chr>    
#> 1             1 2019-01-02 00:00:00 1899-12-31 14:30:00  2019 January Wednesday
#> 2             2 2019-01-08 00:00:00 1899-12-31 02:30:00  2019 January Tuesday  
#> 3             3 2019-01-12 00:00:00 1899-12-31 16:54:00  2019 January Saturday 
#> 4             4 2019-01-14 00:00:00 1899-12-31 21:21:00  2019 January Monday   
#> 5             5 2019-01-15 00:00:00 1899-12-31 18:50:00  2019 January Tuesday  
#> 6             6 2019-01-23 00:00:00 1899-12-31 06:16:00  2019 January Wednesday
#> # ... with 77 more variables: STOP_WAS_INITIATED <chr>,
#> #   RECORD_STATUS_CODE <chr>, ISSUING_OFFICER_RANK <chr>,
#> #   ISSUING_OFFICER_COMMAND_CODE <dbl>, SUPERVISING_OFFICER_RANK <chr>,
#> #   SUPERVISING_OFFICER_COMMAND_CODE <dbl>, LOCATION_IN_OUT_CODE <chr>,
#> #   JURISDICTION_CODE <chr>, JURISDICTION_DESCRIPTION <chr>,
#> #   OBSERVED_DURATION_MINUTES <dbl>, SUSPECTED_CRIME_DESCRIPTION <chr>,
#> #   STOP_DURATION_MINUTES <dbl>, OFFICER_EXPLAINED_STOP_FLAG <chr>, ...
```


```r
install.packages("tidyr")
```



```r
library(tidyr)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
sqf_agg <- sqf %>% 
  group_by(MONTH2,
           DAY2) %>%
  count(SUSPECT_RACE_DESCRIPTION)
```



```r
head(sqf_agg)
#> # A tibble: 6 x 4
#> # Groups:   MONTH2, DAY2 [1]
#>   MONTH2 DAY2   SUSPECT_RACE_DESCRIPTION     n
#>   <chr>  <chr>  <chr>                    <int>
#> 1 April  Friday (null)                       1
#> 2 April  Friday ASIAN / PACIFIC ISLANDER     1
#> 3 April  Friday BLACK                      104
#> 4 April  Friday BLACK HISPANIC              17
#> 5 April  Friday WHITE                       16
#> 6 April  Friday WHITE HISPANIC              31
unique(sqf_agg$MONTH2)
#>  [1] "April"     "August"    "December"  "February"  "January"   "July"     
#>  [7] "June"      "March"     "May"       "November"  "October"   "September"
unique(sqf_agg$DAY2)
#> [1] "Friday"    "Monday"    "Saturday"  "Sunday"    "Thursday"  "Tuesday"  
#> [7] "Wednesday"
unique(sqf_agg$SUSPECT_RACE_DESCRIPTION)
#> [1] "(null)"                    "ASIAN / PACIFIC ISLANDER" 
#> [3] "BLACK"                     "BLACK HISPANIC"           
#> [5] "WHITE"                     "WHITE HISPANIC"           
#> [7] "AMERICAN INDIAN/ALASKAN N"
```



```r
sqf_agg_wide <- sqf_agg %>%
  filter(SUSPECT_RACE_DESCRIPTION != "(null)") %>%
  pivot_wider(names_from = SUSPECT_RACE_DESCRIPTION, values_from = n) 
head(sqf_agg_wide)
#> # A tibble: 6 x 8
#> # Groups:   MONTH2, DAY2 [6]
#>   MONTH2 DAY2     `ASIAN / PACIFIC ISLANDER` BLACK `BLACK HISPANIC` WHITE `WHITE HISPANIC`
#>   <chr>  <chr>                         <int> <int>            <int> <int>            <int>
#> 1 April  Friday                            1   104               17    16               31
#> 2 April  Monday                            1    92               10    32               29
#> 3 April  Saturday                          3   115               24    24               44
#> 4 April  Sunday                            2    96               12    15               38
#> 5 April  Thursday                          2   122               10    18               38
#> 6 April  Tuesday                           7   137               14    20               49
#> # ... with 1 more variable: AMERICAN INDIAN/ALASKAN N <int>
```


```r
install.packages("janitor")
```


```r
library(janitor)
#> 
#> Attaching package: 'janitor'
#> The following objects are masked from 'package:stats':
#> 
#>     chisq.test, fisher.test
names(sqf_agg_wide) <- make_clean_names(names(sqf_agg_wide))
names(sqf_agg_wide)
#> [1] "month2"                    "day2"                     
#> [3] "asian_pacific_islander"    "black"                    
#> [5] "black_hispanic"            "white"                    
#> [7] "white_hispanic"            "american_indian_alaskan_n"
```





```r
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
#> # A tibble: 6 x 4
#> # Groups:   month2, day2 [1]
#>   month2 day2   race                      number_of_people_stopped
#>   <chr>  <chr>  <chr>                                        <int>
#> 1 April  Friday asian_pacific_islander                           1
#> 2 April  Friday black                                          104
#> 3 April  Friday black_hispanic                                  17
#> 4 April  Friday white                                           16
#> 5 April  Friday white_hispanic                                  31
#> 6 April  Friday american_indian_alaskan_n                       NA
```


```r
sqf_agg_long <- sqf_agg_wide %>%
  pivot_longer(cols = asian_pacific_islander:american_indian_alaskan_n,
               names_to = "race",
               values_to = "number_of_people_stopped")
head(sqf_agg_long)
#> # A tibble: 6 x 4
#> # Groups:   month2, day2 [1]
#>   month2 day2   race                      number_of_people_stopped
#>   <chr>  <chr>  <chr>                                        <int>
#> 1 April  Friday asian_pacific_islander                           1
#> 2 April  Friday black                                          104
#> 3 April  Friday black_hispanic                                  17
#> 4 April  Friday white                                           16
#> 5 April  Friday white_hispanic                                  31
#> 6 April  Friday american_indian_alaskan_n                       NA
```


```r
sqf_agg$n2 <- sqf_agg$n + 10
sqf_agg_wide <- sqf_agg %>%
  filter(SUSPECT_RACE_DESCRIPTION != "(null)") %>%
  pivot_wider(names_from = SUSPECT_RACE_DESCRIPTION, values_from = c(n, n2)) 
names(sqf_agg_wide) <- make_clean_names(names(sqf_agg_wide))
head(sqf_agg_wide)
#> # A tibble: 6 x 14
#> # Groups:   month2, day2 [6]
#>   month2 day2     n_asian_pacific_islander n_black n_black_hispanic n_white
#>   <chr>  <chr>                       <int>   <int>            <int>   <int>
#> 1 April  Friday                          1     104               17      16
#> 2 April  Monday                          1      92               10      32
#> 3 April  Saturday                        3     115               24      24
#> 4 April  Sunday                          2      96               12      15
#> 5 April  Thursday                        2     122               10      18
#> 6 April  Tuesday                         7     137               14      20
#> # ... with 8 more variables: n_white_hispanic <int>,
#> #   n_american_indian_alaskan_n <int>, n2_asian_pacific_islander <dbl>,
#> #   n2_black <dbl>, n2_black_hispanic <dbl>, n2_white <dbl>,
#> #   n2_white_hispanic <dbl>, n2_american_indian_alaskan_n <dbl>
```


```r
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
#> # A tibble: 6 x 5
#> # Groups:   month2, day2 [1]
#>   month2 day2   race                     number_of_people_s~ number_of_people_s~
#>   <chr>  <chr>  <chr>                                  <int>               <dbl>
#> 1 April  Friday n_asian_pacific_islander                   1                  11
#> 2 April  Friday n_asian_pacific_islander                   1                 114
#> 3 April  Friday n_asian_pacific_islander                   1                  27
#> 4 April  Friday n_asian_pacific_islander                   1                  26
#> 5 April  Friday n_asian_pacific_islander                   1                  41
#> 6 April  Friday n_asian_pacific_islander                   1                  NA
```



https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html

