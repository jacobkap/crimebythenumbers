# Reshaping data {#reshaping}

For this chapter you'll need the following file, which are available for download [here](https://github.com/jacobkap/r4crimz/tree/master/data): sqf-2019.xlsx. These were initially downloaded from the New York City Police Department's page [here](https://www1.nyc.gov/site/nypd/stats/reports-analysis/stopfrisk.page). 


```r
library(readxl)
sqf <- read_excel("data/sqf-2019.xlsx")
```


```r
head(sqf)
#> # A tibble: 6 x 83
#>   STOP_ID_ANONY STOP_FRISK_DATE     STOP_FRISK_TIME    
#>           <dbl> <dttm>              <dttm>             
#> 1             1 2019-01-02 00:00:00 1899-12-31 14:30:00
#> 2             2 2019-01-08 00:00:00 1899-12-31 02:30:00
#> 3             3 2019-01-12 00:00:00 1899-12-31 16:54:00
#> 4             4 2019-01-14 00:00:00 1899-12-31 21:21:00
#> 5             5 2019-01-15 00:00:00 1899-12-31 18:50:00
#> 6             6 2019-01-23 00:00:00 1899-12-31 06:16:00
#> # ... with 80 more variables: YEAR2 <dbl>,
#> #   MONTH2 <chr>, DAY2 <chr>, STOP_WAS_INITIATED <chr>,
#> #   RECORD_STATUS_CODE <chr>,
#> #   ISSUING_OFFICER_RANK <chr>,
#> #   ISSUING_OFFICER_COMMAND_CODE <dbl>,
#> #   SUPERVISING_OFFICER_RANK <chr>,
#> #   SUPERVISING_OFFICER_COMMAND_CODE <dbl>, ...
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
#>  [1] "April"     "August"    "December"  "February" 
#>  [5] "January"   "July"      "June"      "March"    
#>  [9] "May"       "November"  "October"   "September"
unique(sqf_agg$DAY2)
#> [1] "Friday"    "Monday"    "Saturday"  "Sunday"   
#> [5] "Thursday"  "Tuesday"   "Wednesday"
unique(sqf_agg$SUSPECT_RACE_DESCRIPTION)
#> [1] "(null)"                   
#> [2] "ASIAN / PACIFIC ISLANDER" 
#> [3] "BLACK"                    
#> [4] "BLACK HISPANIC"           
#> [5] "WHITE"                    
#> [6] "WHITE HISPANIC"           
#> [7] "AMERICAN INDIAN/ALASKAN N"
```



```r
sqf_agg_wide <- sqf_agg %>%
  filter(SUSPECT_RACE_DESCRIPTION != "(null)") %>%
  pivot_wider(names_from = SUSPECT_RACE_DESCRIPTION, values_from = n) 
head(sqf_agg_wide)
#> # A tibble: 6 x 8
#> # Groups:   MONTH2, DAY2 [6]
#>   MONTH2 DAY2     `ASIAN / PACIFIC ISLANDER` BLACK `BLACK HISPANIC`
#>   <chr>  <chr>                         <int> <int>            <int>
#> 1 April  Friday                            1   104               17
#> 2 April  Monday                            1    92               10
#> 3 April  Saturday                          3   115               24
#> 4 April  Sunday                            2    96               12
#> 5 April  Thursday                          2   122               10
#> 6 April  Tuesday                           7   137               14
#> # ... with 3 more variables: WHITE <int>,
#> #   WHITE HISPANIC <int>,
#> #   AMERICAN INDIAN/ALASKAN N <int>
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
#> [1] "month2"                   
#> [2] "day2"                     
#> [3] "asian_pacific_islander"   
#> [4] "black"                    
#> [5] "black_hispanic"           
#> [6] "white"                    
#> [7] "white_hispanic"           
#> [8] "american_indian_alaskan_n"
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
#>   month2 day2   race                      number_of_peopl~
#>   <chr>  <chr>  <chr>                                <int>
#> 1 April  Friday asian_pacific_islander                   1
#> 2 April  Friday black                                  104
#> 3 April  Friday black_hispanic                          17
#> 4 April  Friday white                                   16
#> 5 April  Friday white_hispanic                          31
#> 6 April  Friday american_indian_alaskan_n               NA
```


```r
sqf_agg_long <- sqf_agg_wide %>%
  pivot_longer(cols = asian_pacific_islander:american_indian_alaskan_n,
               names_to = "race",
               values_to = "number_of_people_stopped")
head(sqf_agg_long)
#> # A tibble: 6 x 4
#> # Groups:   month2, day2 [1]
#>   month2 day2   race                      number_of_peopl~
#>   <chr>  <chr>  <chr>                                <int>
#> 1 April  Friday asian_pacific_islander                   1
#> 2 April  Friday black                                  104
#> 3 April  Friday black_hispanic                          17
#> 4 April  Friday white                                   16
#> 5 April  Friday white_hispanic                          31
#> 6 April  Friday american_indian_alaskan_n               NA
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
#>   month2 day2     n_asian_pacific~ n_black n_black_hispanic
#>   <chr>  <chr>               <int>   <int>            <int>
#> 1 April  Friday                  1     104               17
#> 2 April  Monday                  1      92               10
#> 3 April  Saturday                3     115               24
#> 4 April  Sunday                  2      96               12
#> 5 April  Thursday                2     122               10
#> 6 April  Tuesday                 7     137               14
#> # ... with 9 more variables: n_white <int>,
#> #   n_white_hispanic <int>,
#> #   n_american_indian_alaskan_n <int>,
#> #   n2_asian_pacific_islander <dbl>, n2_black <dbl>,
#> #   n2_black_hispanic <dbl>, n2_white <dbl>,
#> #   n2_white_hispanic <dbl>,
#> #   n2_american_indian_alaskan_n <dbl>
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
#>   month2 day2   race   number_of_peopl~ number_of_peopl~
#>   <chr>  <chr>  <chr>             <int>            <dbl>
#> 1 April  Friday n_asi~                1               11
#> 2 April  Friday n_asi~                1              114
#> 3 April  Friday n_asi~                1               27
#> 4 April  Friday n_asi~                1               26
#> 5 April  Friday n_asi~                1               41
#> 6 April  Friday n_asi~                1               NA
```



https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html

