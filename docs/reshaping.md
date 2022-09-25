# Reshaping data {#reshaping}

For this chapter you'll need the following file, which is available for download [here](https://github.com/jacobkap/r4crimz/tree/master/data): sqf-2019.xlsx. This file was initially downloaded from the New York City Police Department's page [here](https://www1.nyc.gov/site/nypd/stats/reports-analysis/stopfrisk.page). 

When you're using data for research, the end result is usually a regression or a graph (or both), and that requires your data to be in a particular format. Usually your data should have one row for each unit of analysis, and each column should have information about that unit. As an example, if you wanted to study city-level crime over time, you'd have each row be a single city in a single time period. If you looked at 10 different time periods, say 10 years, you'd have 10 rows for each city. And each column would have information about that city in that time period, such as the number of murders that occurred. 

This is what is known as "long" format, as this data often has many rows and few columns. The alternative is what's known as "wide" format, where each row (in our example) is a single agency and you'd have 10 times as many columns in "long" data as there are 10 time periods. Whereas with "long" data you'd have, for example, a "murder" column and 10 rows showing the murder in each year, with "wide" data you'd have 10 murder columns showing the value for each year's murder count. While long data is more commonly used in criminology research, some statistical and graphing approaches require wide data. If this seems like an abstract concept, bear with it for a bit as we'll go over several examples in this chapter.

Ideally, our data comes in the exact format we need. In cases where it doesn't, we need to be able to convert the data from long to wide or from wide to long format. This conversion is called "reshaping". There are many approaches and packages to doing reshaping in R, which makes reshaping actually one of the most confusing things to do in R. In this chapter we'll use an approach from the package `tidyr`, which, as the name suggests, is one of the packages from the tidyverse. To use this package we need to install it using `install.packages()`.


```r
install.packages("tidyr")
```

For this chapter we'll use microdata from the New York City Police Department for every stop and frisk they conducted in 2019. The data is in an .xlsx format so we can use the `readxl` package to read it into R. Let's call the data "sqf" as it is the abbreviation for "stop, question, and frisk," which is the full name of the data set. Following traditional R naming conventions, we'll keep the object name lowercased. 


```r
library(readxl)
# Warning: package 'readxl' was built under R version 4.1.3
sqf <- read_excel("data/sqf-2019.xlsx")
```

The first thing we want to do when loading in a new data set to R is to look at it. We can do this a few different ways, including using `View()`, which opens up an Excel-like tab where we can scroll through the data, and through `head()` which prints the first 6 rows of every column to the console. The `readxl` package converts the data into a "tibble". which is essentially a modified data.frame. One of the modifications is that it doesn't print out every single column when we use `head()` to view the first 6 rows of each column. That's because tibble's don't want to print large amounts of text to the console.

Normally we'd use `head()` to look at the data, but as there are dozens of columns in this data, I don't want to print out the first six rows of every column to the console as it will take up a lot of space in the book. If this were real data you were working on, you would use `head()` or `View()` to look at the data. Instead, here we'll use `names()` to see what columns are in the data. Let's also use `nrow()` to see how many rows of data we have.


```r
sqf <- data.frame(sqf)
names(sqf)
#  [1] "STOP_ID_ANONY"                                             
#  [2] "STOP_FRISK_DATE"                                           
#  [3] "STOP_FRISK_TIME"                                           
#  [4] "YEAR2"                                                     
#  [5] "MONTH2"                                                    
#  [6] "DAY2"                                                      
#  [7] "STOP_WAS_INITIATED"                                        
#  [8] "RECORD_STATUS_CODE"                                        
#  [9] "ISSUING_OFFICER_RANK"                                      
# [10] "ISSUING_OFFICER_COMMAND_CODE"                              
# [11] "SUPERVISING_OFFICER_RANK"                                  
# [12] "SUPERVISING_OFFICER_COMMAND_CODE"                          
# [13] "LOCATION_IN_OUT_CODE"                                      
# [14] "JURISDICTION_CODE"                                         
# [15] "JURISDICTION_DESCRIPTION"                                  
# [16] "OBSERVED_DURATION_MINUTES"                                 
# [17] "SUSPECTED_CRIME_DESCRIPTION"                               
# [18] "STOP_DURATION_MINUTES"                                     
# [19] "OFFICER_EXPLAINED_STOP_FLAG"                               
# [20] "OFFICER_NOT_EXPLAINED_STOP_DESCRIPTION"                    
# [21] "OTHER_PERSON_STOPPED_FLAG"                                 
# [22] "SUSPECT_ARRESTED_FLAG"                                     
# [23] "SUSPECT_ARREST_OFFENSE"                                    
# [24] "SUMMONS_ISSUED_FLAG"                                       
# [25] "SUMMONS_OFFENSE_DESCRIPTION"                               
# [26] "OFFICER_IN_UNIFORM_FLAG"                                   
# [27] "ID_CARD_IDENTIFIES_OFFICER_FLAG"                           
# [28] "SHIELD_IDENTIFIES_OFFICER_FLAG"                            
# [29] "VERBAL_IDENTIFIES_OFFICER_FLAG"                            
# [30] "FRISKED_FLAG"                                              
# [31] "SEARCHED_FLAG"                                             
# [32] "ASK_FOR_CONSENT_FLG"                                       
# [33] "CONSENT_GIVEN_FLG"                                         
# [34] "OTHER_CONTRABAND_FLAG"                                     
# [35] "FIREARM_FLAG"                                              
# [36] "KNIFE_CUTTER_FLAG"                                         
# [37] "OTHER_WEAPON_FLAG"                                         
# [38] "WEAPON_FOUND_FLAG"                                         
# [39] "PHYSICAL_FORCE_CEW_FLAG"                                   
# [40] "PHYSICAL_FORCE_DRAW_POINT_FIREARM_FLAG"                    
# [41] "PHYSICAL_FORCE_HANDCUFF_SUSPECT_FLAG"                      
# [42] "PHYSICAL_FORCE_OC_SPRAY_USED_FLAG"                         
# [43] "PHYSICAL_FORCE_OTHER_FLAG"                                 
# [44] "PHYSICAL_FORCE_RESTRAINT_USED_FLAG"                        
# [45] "PHYSICAL_FORCE_VERBAL_INSTRUCTION_FLAG"                    
# [46] "PHYSICAL_FORCE_WEAPON_IMPACT_FLAG"                         
# [47] "BACKROUND_CIRCUMSTANCES_VIOLENT_CRIME_FLAG"                
# [48] "BACKROUND_CIRCUMSTANCES_SUSPECT_KNOWN_TO_CARRY_WEAPON_FLAG"
# [49] "SUSPECTS_ACTIONS_CASING_FLAG"                              
# [50] "SUSPECTS_ACTIONS_CONCEALED_POSSESSION_WEAPON_FLAG"         
# [51] "SUSPECTS_ACTIONS_DECRIPTION_FLAG"                          
# [52] "SUSPECTS_ACTIONS_DRUG_TRANSACTIONS_FLAG"                   
# [53] "SUSPECTS_ACTIONS_IDENTIFY_CRIME_PATTERN_FLAG"              
# [54] "SUSPECTS_ACTIONS_LOOKOUT_FLAG"                             
# [55] "SUSPECTS_ACTIONS_OTHER_FLAG"                               
# [56] "SUSPECTS_ACTIONS_PROXIMITY_TO_SCENE_FLAG"                  
# [57] "SEARCH_BASIS_ADMISSION_FLAG"                               
# [58] "SEARCH_BASIS_CONSENT_FLAG"                                 
# [59] "SEARCH_BASIS_HARD_OBJECT_FLAG"                             
# [60] "SEARCH_BASIS_INCIDENTAL_TO_ARREST_FLAG"                    
# [61] "SEARCH_BASIS_OTHER_FLAG"                                   
# [62] "SEARCH_BASIS_OUTLINE_FLAG"                                 
# [63] "DEMEANOR_CODE"                                             
# [64] "DEMEANOR_OF_PERSON_STOPPED"                                
# [65] "SUSPECT_REPORTED_AGE"                                      
# [66] "SUSPECT_SEX"                                               
# [67] "SUSPECT_RACE_DESCRIPTION"                                  
# [68] "SUSPECT_HEIGHT"                                            
# [69] "SUSPECT_WEIGHT"                                            
# [70] "SUSPECT_BODY_BUILD_TYPE"                                   
# [71] "SUSPECT_EYE_COLOR"                                         
# [72] "SUSPECT_HAIR_COLOR"                                        
# [73] "SUSPECT_OTHER_DESCRIPTION"                                 
# [74] "STOP_LOCATION_PRECINCT"                                    
# [75] "STOP_LOCATION_SECTOR_CODE"                                 
# [76] "STOP_LOCATION_APARTMENT"                                   
# [77] "STOP_LOCATION_FULL_ADDRESS"                                
# [78] "STOP_LOCATION_STREET_NAME"                                 
# [79] "STOP_LOCATION_X"                                           
# [80] "STOP_LOCATION_Y"                                           
# [81] "STOP_LOCATION_ZIP_CODE"                                    
# [82] "STOP_LOCATION_PATROL_BORO_NAME"                            
# [83] "STOP_LOCATION_BORO_NAME"
nrow(sqf)
# [1] 13459
```

Each row of data is a stop and frisk, and there were 13,459 in 2019. That number may seem low to you, especially if you've read articles about how frequent stop and frisks happens in New York City. It is correct - at least correct in terms of reported stops. Stop and frisks in New York City peaked in 2011 with nearly 700,000 conducted, and then fell sharply after that to fewer than 23,000 from 2015 through 2019 (the last year available at the time of this writing). 

Looking at the results of `names()`, we can see that this is a rich data set with lots of information about each stop (though many columns also have missing data, so it is not as rich as it initially appears). Each stop has, for example, the date and time of the stop, whether an arrest was made and for what, physical characteristics (race, sex, age, height, weight, clothing) of the person stopped, and the location of the stop. One important variable that's missing is a unique identifier for either the officer or the person stopped so we can see how often they are in the data. The "ISSUING_OFFICER_COMMAND_CODE" variable may be a unique ID for the officer, but it's not clear that it is - there are different officer ranks for the same command code so this appears to me to be different officers. 

## Reshaping a single column

Relative to most data sets in criminology, this is an enormous amount of information. So I encourage you to explore this data and practice your R skills. As this chapter focuses on reshaping, we won't do much exploring of the data. This data is in long format as each row is a different stop, and the columns are information about that specific stop. We can't convert this to wide format as there are no repeated entries in the data; each row is of a unique person stopped (at least as far as we can tell. In reality, there are likely to be many people stopped multiple times in the data). We could use another variable such as stopped persons' race or gender and reshape it using that, but that'll lead to many thousands of columns so is not a great idea. 

Instead, we'll first aggregate the data and then reshape that aggregated data. We'll aggregate the data by month and by day of week and see how many people of each race were stopped at each month-day-of-week. In addition to `tidyr`, we'll use functions from `dplyr` to aggregate our data. Since we've already installed that package we just need to use `library()` and don't need to use `install.packages()` again. 

We've already used the `group_by()` function in aggregating, and now we'll introduce a new function: `count()`. In our earlier aggregation code (introduced in Section \@ref(aggregate)), we used the function `summarize()` and summed up columns that had a numeric variable (e.g. the number of murders). `count()` works similarly by sums up categorical variables, which in our case is the race of people stopped. Using `count()` we enter in the categorical column in the parentheses, and it'll make a new column called "n", which is the sum of each category. Since we're aggregating the data let's assign the result of our aggregating to a new object called "sqf_agg".


```r
library(tidyr)
library(dplyr)
# Warning: package 'dplyr' was built under R version 4.1.3
# 
# Attaching package: 'dplyr'
# The following objects are masked from 'package:stats':
# 
#     filter, lag
# The following objects are masked from 'package:base':
# 
#     intersect, setdiff, setequal, union
sqf_agg <- sqf %>% 
  group_by(MONTH2,
           DAY2) %>%
  count(SUSPECT_RACE_DESCRIPTION)
```

Now let's look at the `head()` of the result.


```r
head(sqf_agg)
# # A tibble: 6 x 4
# # Groups:   MONTH2, DAY2 [1]
#   MONTH2 DAY2   SUSPECT_RACE_DESCRIPTION     n
#   <chr>  <chr>  <chr>                    <int>
# 1 April  Friday (null)                       1
# 2 April  Friday ASIAN / PACIFIC ISLANDER     1
# 3 April  Friday BLACK                      104
# 4 April  Friday BLACK HISPANIC              17
# 5 April  Friday WHITE                       16
# 6 April  Friday WHITE HISPANIC              31
```

Each row is now a month-day-of-week-race combination, and we have two additional columns: first the person stopped's race and then the "n" column, which says how many people of that race were stopped in that month-day-of-week. The first race is "(null)", which means we don't know the race. We could keep these values as an "unknown" race, but for simplicity we'll just remove them using `filter()`. 

To make sure we only have values we expect, we can use the `unique()` function to check that we have only months and week-days we expect, and that our race names are consistent. This is important because even though you know, for example, that there are only seven days in a week, there may be more in our data due to typos or erroneous data entry. So it is always good to check.



```r
unique(sqf_agg$MONTH2)
#  [1] "April"     "August"    "December"  "February"  "January"   "July"     
#  [7] "June"      "March"     "May"       "November"  "October"   "September"
unique(sqf_agg$DAY2)
# [1] "Friday"    "Monday"    "Saturday"  "Sunday"    "Thursday"  "Tuesday"  
# [7] "Wednesday"
unique(sqf_agg$SUSPECT_RACE_DESCRIPTION)
# [1] "(null)"                    "ASIAN / PACIFIC ISLANDER" 
# [3] "BLACK"                     "BLACK HISPANIC"           
# [5] "WHITE"                     "WHITE HISPANIC"           
# [7] "AMERICAN INDIAN/ALASKAN N"
```

The months and days of the week look good. For an actual data analysis we may want to combine the Hispanic values to a single "Hispanic" value instead of splitting it between "BLACK HISPANIC" and "WHITE HISPANIC", but for this lesson we'll leave it as it is.

Now, we want to reshape the data from its current long format to a wide format. We do this using the `pivot_wider()` function from the `tidyr` package. In the function we need to input two values, the name of the column, which identifies what each value in the row means, and the column that has that value. In our case this is the "SUSPECT_RACE_DESCRIPTION" column and the "n" column. We don't need to put the column names in quotes. These function parameters are called "names_from" and "values_from" so we'll also include that in the `pivot_wider()` function. And finally before we run `pivot_wider()`, we'll first use `filter()` to remove any row where the race is "(null)". We'll assign the result of this code to an object called "sqf_agg_wide" and use `head()` to look at this result. 


```r
sqf_agg_wide <- sqf_agg %>%
  filter(SUSPECT_RACE_DESCRIPTION != "(null)") %>%
  pivot_wider(names_from = SUSPECT_RACE_DESCRIPTION,
              values_from = n) 
head(sqf_agg_wide)
# # A tibble: 6 x 8
# # Groups:   MONTH2, DAY2 [6]
#   MONTH2 DAY2     `ASIAN / PACIFIC ISLANDER` BLACK BLACK~1 WHITE WHITE~2 AMERI~3
#   <chr>  <chr>                         <int> <int>   <int> <int>   <int>   <int>
# 1 April  Friday                            1   104      17    16      31      NA
# 2 April  Monday                            1    92      10    32      29      NA
# 3 April  Saturday                          3   115      24    24      44      NA
# 4 April  Sunday                            2    96      12    15      38      NA
# 5 April  Thursday                          2   122      10    18      38      NA
# 6 April  Tuesday                           7   137      14    20      49      NA
# # ... with abbreviated variable names 1: `BLACK HISPANIC`, 2: `WHITE HISPANIC`,
# #   3: `AMERICAN INDIAN/ALASKAN N`
```

Now instead of having one row be a month-day-of-week-race combination, each row is a month-day-of-week pair, and we have one column for every race in our data. Each of these race columns tell us how many people of that race were stopped in that month-day-of-week. This allows for really easy comparison of things like racial differences in stops for each month-day-of-week as we just look at different columns in the same row. We have now successfully done our first reshaping, moving this data from long to wide format!

Now we want to reshape it again to go from wide to long. Our race columns names just took the values from the race column, which means that we have column names all in capital letters and with spaces and slashes in them. We could technically use this as it is, but it's a bit trickier to use any name with punctuation in it, and is against R column name convention, so we'll quickly fix this. To do so we'll use the `make_clean_names()` function from the `janitor` package that automatically makes all character inputs to the function lowercase and replaces all punctuation with an underscore. First, we need to install the package with `install.packages()`. 


```r
install.packages("janitor")
```

To use this function on the column names we'll make the input of the function `names(sqf_agg_wide)`, which returns the names of the "sqf_agg_wide" data, and assign the result back into `names(sqf_agg_wide)`. It might look weird to put a function inside of a function, but R is completely fine with it. Running `names(sqf_agg_wide)` at the end will print out the column names so we can check that it worked.


```r
library(janitor)
# 
# Attaching package: 'janitor'
# The following objects are masked from 'package:stats':
# 
#     chisq.test, fisher.test
names(sqf_agg_wide) <- make_clean_names(names(sqf_agg_wide))
names(sqf_agg_wide)
# [1] "month2"                    "day2"                     
# [3] "asian_pacific_islander"    "black"                    
# [5] "black_hispanic"            "white"                    
# [7] "white_hispanic"            "american_indian_alaskan_n"
```

Now each column name is lowercased and has only underscores instead of spaces and slashes.

To reshape this wide data to long format, we'll use the `tidyr` function `pivot_longer()`. There are three inputs here: "cols", which takes a vector of column names which have our value variables; "names_to", which is what it'll call the newly created categorical variable; and "values_to", which is what it'll call the newly created values column. For "cols" we want to include each of our race columns, and these column names must be in quotes and in a vector as there are multiple columns. For "names_to" we can call it whatever we want, but here we'll call it "race" as the variable is about the race of the person who was stopped. And for "values_to" we'll call it "number_of_people_stopped" though we can call it whatever we like.


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
# # A tibble: 6 x 4
# # Groups:   month2, day2 [1]
#   month2 day2   race                      number_of_people_stopped
#   <chr>  <chr>  <chr>                                        <int>
# 1 April  Friday asian_pacific_islander                           1
# 2 April  Friday black                                          104
# 3 April  Friday black_hispanic                                  17
# 4 April  Friday white                                           16
# 5 April  Friday white_hispanic                                  31
# 6 April  Friday american_indian_alaskan_n                       NA
```

In some cases you'll have many columns that you want to include while reshaping, which makes writing them all out by hand time consuming. If all of the columns are sequential you can use a trick in this function by writing `first_column:last_column` where the : will make it include each column (in order) from the first one you input to the last one. This is doing the same thing as `1:3`, which returns 1, 2, and 3, but for columns instead of numbers. This doesn't work in most cases but does work for many tidyverse packages. There are also a large number of functions from the `dplyr` package that are for selecting columns, and are very helpful for doing things like this. The functions are numerous and have changed relatively frequently in the past so I won't cover them in this book, but if you're interested you can look at them on [this page](https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html) of `dplyr`'s website.


```r
sqf_agg_long <- sqf_agg_wide %>%
  pivot_longer(cols = asian_pacific_islander:american_indian_alaskan_n,
               names_to = "race",
               values_to = "number_of_people_stopped")
head(sqf_agg_long)
# # A tibble: 6 x 4
# # Groups:   month2, day2 [1]
#   month2 day2   race                      number_of_people_stopped
#   <chr>  <chr>  <chr>                                        <int>
# 1 April  Friday asian_pacific_islander                           1
# 2 April  Friday black                                          104
# 3 April  Friday black_hispanic                                  17
# 4 April  Friday white                                           16
# 5 April  Friday white_hispanic                                  31
# 6 April  Friday american_indian_alaskan_n                       NA
```

## Reshaping multiple columns

So far we've just been reshaping using a single column. This is the simplest method, but in some cases we'll need to reshape using multiple columns. As an example, let's make a new column called "n2" in our "sqf_agg" data set, which just adds 10 to the value in our "n" column. 


```r
sqf_agg$n2 <- sqf_agg$n + 10
```

Since these columns both relate to the race column (called "SUSPECT_RACE_DESCRIPTION") we can reuse the `pivot_wider()` code from before, but now the `values_from` parameter takes a vector of column names instead of a single column name. Here we want to include both the "n" and the "n2" column. Since it's a `dplyr` function it's not necessary to put the column names in quotes. We also want to keep our `filter()` function from before which removes "(null)" races and then add a `head()` function at the end so it prints out the first six rows of our resulting data set. 


```r
sqf_agg_wide <- sqf_agg %>%
  filter(SUSPECT_RACE_DESCRIPTION != "(null)") %>%
  pivot_wider(names_from = SUSPECT_RACE_DESCRIPTION, 
              values_from = c(n, n2)) 
names(sqf_agg_wide) <- make_clean_names(names(sqf_agg_wide))
head(sqf_agg_wide)
# # A tibble: 6 x 14
# # Groups:   month2, day2 [6]
#   month2 day2    n_asi~1 n_black n_bla~2 n_white n_whi~3 n_ame~4 n2_as~5 n2_bl~6
#   <chr>  <chr>     <int>   <int>   <int>   <int>   <int>   <int>   <dbl>   <dbl>
# 1 April  Friday        1     104      17      16      31      NA      11     114
# 2 April  Monday        1      92      10      32      29      NA      11     102
# 3 April  Saturd~       3     115      24      24      44      NA      13     125
# 4 April  Sunday        2      96      12      15      38      NA      12     106
# 5 April  Thursd~       2     122      10      18      38      NA      12     132
# 6 April  Tuesday       7     137      14      20      49      NA      17     147
# # ... with 4 more variables: n2_black_hispanic <dbl>, n2_white <dbl>,
# #   n2_white_hispanic <dbl>, n2_american_indian_alaskan_n <dbl>, and
# #   abbreviated variable names 1: n_asian_pacific_islander,
# #   2: n_black_hispanic, 3: n_white_hispanic, 4: n_american_indian_alaskan_n,
# #   5: n2_asian_pacific_islander, 6: n2_black
# # i Use `colnames()` to see all variable names
```

We now have the same wide data set as before, but now there are twice as many race columns. And the `pivot_wider()` function renamed the columns so we can tell the "n" columns from the "n2" columns. The easiest way to reshape this data from wide to long is to again use the `pivot_longer()` function but now use it twice: first to reshape the "n" columns and then to reshape the "n2" columns. We'll use the exact same code as before, but change the column names to suit their new names. 


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
               values_to = "number_of_people_stopped2") 
head(sqf_agg_long)
# # A tibble: 6 x 6
# # Groups:   month2, day2 [1]
#   month2 day2   race                     number_of_people_stopped race2  numbe~1
#   <chr>  <chr>  <chr>                                       <int> <chr>    <dbl>
# 1 April  Friday n_asian_pacific_islander                        1 n2_as~      11
# 2 April  Friday n_asian_pacific_islander                        1 n2_bl~     114
# 3 April  Friday n_asian_pacific_islander                        1 n2_bl~      27
# 4 April  Friday n_asian_pacific_islander                        1 n2_wh~      26
# 5 April  Friday n_asian_pacific_islander                        1 n2_wh~      41
# 6 April  Friday n_asian_pacific_islander                        1 n2_am~      NA
# # ... with abbreviated variable name 1: number_of_people_stopped2
```

This now gives us two race columns - "race" and "race2" - which are ordered differently so we need to make sure to either reorder the data to be the same ordering or to keep that in mind when comparing the "number_of_people_stopped" and "number_of_people_stopped2" columns as they frequently refer to different races.
