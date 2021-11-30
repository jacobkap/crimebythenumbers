# Reshaping data {#reshaping}

For this chapter you'll need the following file, which are available for download [here](https://github.com/jacobkap/r4crimz/tree/master/data): sqf-2019.xlsx. These were initially downloaded from the New York City Police Department's page [here](https://www1.nyc.gov/site/nypd/stats/reports-analysis/stopfrisk.page). 

When you're using data for research the end result is usually a regression or a graph (or both) and that requires your data to be in a particular format. The data should have one row for each unit of analysis and each column should have information about that unit. As an example, if you wanted to study city-level crime over time, you'd have each row be a single city in a single time period. If you looked at 10 different time periods, say 10 years, you'd have 10 rows for each city. And each column would have information about that city in that time period, such as the number of murders that occurred. 

This is what is known as "long" format as this data often has many rows and few columns. The alternative is what's known as "wide" format where each row (in our example) is a single agency and you'd have 10 times as many columns as in "long" data as there are 10 time periods. Whereas with "long" data you'd have, for example, a "murder" column and 10 rows showing the murder in each year, with "wide" data you'd have 10 murder columns showing the value for each year's murder count. While long data is more commonly used in criminology research, some statistical and graphing approaches require wide data. If this seems like an abstract concept, bear with it for a bit as we'll go over several examples in this chapter.

Ideally, our data comes in the exact format we need. In cases where it doesn't, we need to be able to convert the data from long to wide or from wide to long format. This conversion is called "reshaping". There are many approaches and packages to doing reshaping in R which makes reshaping actually one of the most confusing things to do in R. In this chapter we'll use an approach from the package `tidyr` which, as the name suggests, is one of the packages from the tidyverse. To use this package we need to install it using `install.packages()`.


```r
install.packages("tidyr")
```

For this chapter we'll use microdata from the New York City Police Department for every stop and frisk they conducted in 2019. The data is in an .xlsx format so we can use the `readxl` package to read it into R. Let's call the data "sqf" as it is the abbreviation for "stop, question, and frisk" which is the full name of the dataset. Following traditional R naming conventions, we'll keep the object name lower cased. 


```r
library(readxl)
sqf <- read_excel("data/sqf-2019.xlsx")
```

The first thing we want to do when loading in a new dataset to R is to look at it. We can do this a few different ways, including using `View()` which opens up an Excel-like tab where we can scroll through the data, and through `head()`. We'll use `head()` here.

The `readxl` package converts the data into a "tibble" which is essentially a modified data.frame. One of the modifications is that is doesn't print out every single column when we use `head()` to view the first 6 rows of each columns. That's because tibble's don't want to print large amounts of text to the console. In our case, however, we do want to see each column so we'll first convert sqf to a data.frame using the `data.frame()` function and then look at `head()`. Let's also use `nrow()` to see how many rows of data we have.


```r
sqf <- data.frame(sqf)
head(sqf)
#>   STOP_ID_ANONY STOP_FRISK_DATE     STOP_FRISK_TIME YEAR2
#> 1             1      2019-01-02 1899-12-31 14:30:00  2019
#> 2             2      2019-01-08 1899-12-31 02:30:00  2019
#> 3             3      2019-01-12 1899-12-31 16:54:00  2019
#> 4             4      2019-01-14 1899-12-31 21:21:00  2019
#> 5             5      2019-01-15 1899-12-31 18:50:00  2019
#> 6             6      2019-01-23 1899-12-31 06:16:00  2019
#>    MONTH2      DAY2      STOP_WAS_INITIATED
#> 1 January Wednesday   Based on C/W on Scene
#> 2 January   Tuesday Based on Self Initiated
#> 3 January  Saturday      Based on Radio Run
#> 4 January    Monday      Based on Radio Run
#> 5 January   Tuesday      Based on Radio Run
#> 6 January Wednesday      Based on Radio Run
#>   RECORD_STATUS_CODE ISSUING_OFFICER_RANK
#> 1                APP                  POM
#> 2                APP                  POM
#> 3                APP                  POM
#> 4                APP                  POM
#> 5                APP                  POM
#> 6                APP                  POM
#>   ISSUING_OFFICER_COMMAND_CODE SUPERVISING_OFFICER_RANK
#> 1                            1                      SGT
#> 2                            1                      SGT
#> 3                            1                      SGT
#> 4                            1                      SGT
#> 5                            1                      SGT
#> 6                            1                      SGT
#>   SUPERVISING_OFFICER_COMMAND_CODE LOCATION_IN_OUT_CODE
#> 1                                1                    I
#> 2                                1                    O
#> 3                                1                    I
#> 4                                1                    O
#> 5                                1                    O
#> 6                                1               (null)
#>   JURISDICTION_CODE JURISDICTION_DESCRIPTION
#> 1                 P                      PSB
#> 2                 P                      PSB
#> 3                 P                      PSB
#> 4                 P                      PSB
#> 5                 P                      PSB
#> 6                 P                      PSB
#>   OBSERVED_DURATION_MINUTES SUSPECTED_CRIME_DESCRIPTION
#> 1                         1               PETIT LARCENY
#> 2                         1               GRAND LARCENY
#> 3                         1               PETIT LARCENY
#> 4                         0                     ROBBERY
#> 5                         1                     ASSAULT
#> 6                         1                    BURGLARY
#>   STOP_DURATION_MINUTES OFFICER_EXPLAINED_STOP_FLAG
#> 1                    10                           Y
#> 2                    10                           Y
#> 3                     4                           Y
#> 4                     5                           Y
#> 5                     5                           Y
#> 6                     5                           Y
#>   OFFICER_NOT_EXPLAINED_STOP_DESCRIPTION
#> 1                                 (null)
#> 2                                 (null)
#> 3                                 (null)
#> 4                                 (null)
#> 5                                 (null)
#> 6                                 (null)
#>   OTHER_PERSON_STOPPED_FLAG SUSPECT_ARRESTED_FLAG
#> 1                         N                     N
#> 2                         N                     Y
#> 3                         N                     Y
#> 4                         N                     N
#> 5                         N                     Y
#> 6                         Y                     N
#>   SUSPECT_ARREST_OFFENSE SUMMONS_ISSUED_FLAG
#> 1                 (null)                   N
#> 2          GRAND LARCENY                   N
#> 3          PETIT LARCENY                   N
#> 4                 (null)                   N
#> 5                ASSAULT                   N
#> 6                 (null)                   N
#>   SUMMONS_OFFENSE_DESCRIPTION OFFICER_IN_UNIFORM_FLAG
#> 1                      (null)                       Y
#> 2                      (null)                       N
#> 3                      (null)                       Y
#> 4                      (null)                       Y
#> 5                      (null)                       N
#> 6                      (null)                       Y
#>   ID_CARD_IDENTIFIES_OFFICER_FLAG
#> 1                          (null)
#> 2                          (null)
#> 3                          (null)
#> 4                          (null)
#> 5                          (null)
#> 6                          (null)
#>   SHIELD_IDENTIFIES_OFFICER_FLAG
#> 1                         (null)
#> 2                              S
#> 3                         (null)
#> 4                         (null)
#> 5                              S
#> 6                         (null)
#>   VERBAL_IDENTIFIES_OFFICER_FLAG FRISKED_FLAG SEARCHED_FLAG
#> 1                         (null)            Y             N
#> 2                              V            N             Y
#> 3                         (null)            N             N
#> 4                         (null)            N             N
#> 5                              V            Y             N
#> 6                         (null)            Y             N
#>   ASK_FOR_CONSENT_FLG CONSENT_GIVEN_FLG
#> 1                   Y                 Y
#> 2                   N                 N
#> 3                   N                 (
#> 4                   N                 N
#> 5                   N                 N
#> 6                   N                 N
#>   OTHER_CONTRABAND_FLAG FIREARM_FLAG KNIFE_CUTTER_FLAG
#> 1                     N       (null)            (null)
#> 2                     N       (null)            (null)
#> 3                     N       (null)            (null)
#> 4                     N       (null)            (null)
#> 5                     N       (null)            (null)
#> 6                     N       (null)            (null)
#>   OTHER_WEAPON_FLAG WEAPON_FOUND_FLAG
#> 1            (null)                 N
#> 2            (null)                 N
#> 3            (null)                 N
#> 4            (null)                 N
#> 5            (null)                 N
#> 6            (null)                 N
#>   PHYSICAL_FORCE_CEW_FLAG
#> 1                  (null)
#> 2                  (null)
#> 3                  (null)
#> 4                  (null)
#> 5                  (null)
#> 6                  (null)
#>   PHYSICAL_FORCE_DRAW_POINT_FIREARM_FLAG
#> 1                                 (null)
#> 2                                 (null)
#> 3                                 (null)
#> 4                                 (null)
#> 5                                 (null)
#> 6                                 (null)
#>   PHYSICAL_FORCE_HANDCUFF_SUSPECT_FLAG
#> 1                                    Y
#> 2                               (null)
#> 3                               (null)
#> 4                               (null)
#> 5                                    Y
#> 6                               (null)
#>   PHYSICAL_FORCE_OC_SPRAY_USED_FLAG
#> 1                            (null)
#> 2                            (null)
#> 3                            (null)
#> 4                            (null)
#> 5                            (null)
#> 6                            (null)
#>   PHYSICAL_FORCE_OTHER_FLAG
#> 1                    (null)
#> 2                    (null)
#> 3                    (null)
#> 4                    (null)
#> 5                    (null)
#> 6                    (null)
#>   PHYSICAL_FORCE_RESTRAINT_USED_FLAG
#> 1                             (null)
#> 2                             (null)
#> 3                             (null)
#> 4                             (null)
#> 5                             (null)
#> 6                             (null)
#>   PHYSICAL_FORCE_VERBAL_INSTRUCTION_FLAG
#> 1                                      (
#> 2                                      Y
#> 3                                      Y
#> 4                                      Y
#> 5                                      Y
#> 6                                      Y
#>   PHYSICAL_FORCE_WEAPON_IMPACT_FLAG
#> 1                            (null)
#> 2                            (null)
#> 3                            (null)
#> 4                            (null)
#> 5                            (null)
#> 6                            (null)
#>   BACKROUND_CIRCUMSTANCES_VIOLENT_CRIME_FLAG
#> 1                                     (null)
#> 2                                     (null)
#> 3                                     (null)
#> 4                                     (null)
#> 5                                          Y
#> 6                                          Y
#>   BACKROUND_CIRCUMSTANCES_SUSPECT_KNOWN_TO_CARRY_WEAPON_FLAG
#> 1                                                     (null)
#> 2                                                     (null)
#> 3                                                     (null)
#> 4                                                     (null)
#> 5                                                     (null)
#> 6                                                     (null)
#>   SUSPECTS_ACTIONS_CASING_FLAG
#> 1                       (null)
#> 2                       (null)
#> 3                       (null)
#> 4                       (null)
#> 5                       (null)
#> 6                       (null)
#>   SUSPECTS_ACTIONS_CONCEALED_POSSESSION_WEAPON_FLAG
#> 1                                            (null)
#> 2                                            (null)
#> 3                                            (null)
#> 4                                            (null)
#> 5                                            (null)
#> 6                                            (null)
#>   SUSPECTS_ACTIONS_DECRIPTION_FLAG
#> 1                           (null)
#> 2                           (null)
#> 3                                Y
#> 4                                Y
#> 5                                Y
#> 6                           (null)
#>   SUSPECTS_ACTIONS_DRUG_TRANSACTIONS_FLAG
#> 1                                  (null)
#> 2                                  (null)
#> 3                                  (null)
#> 4                                  (null)
#> 5                                  (null)
#> 6                                  (null)
#>   SUSPECTS_ACTIONS_IDENTIFY_CRIME_PATTERN_FLAG
#> 1                                       (null)
#> 2                                       (null)
#> 3                                       (null)
#> 4                                       (null)
#> 5                                       (null)
#> 6                                       (null)
#>   SUSPECTS_ACTIONS_LOOKOUT_FLAG SUSPECTS_ACTIONS_OTHER_FLAG
#> 1                        (null)                           Y
#> 2                        (null)                           Y
#> 3                        (null)                      (null)
#> 4                        (null)                      (null)
#> 5                        (null)                      (null)
#> 6                        (null)                           Y
#>   SUSPECTS_ACTIONS_PROXIMITY_TO_SCENE_FLAG
#> 1                                   (null)
#> 2                                   (null)
#> 3                                        Y
#> 4                                        Y
#> 5                                        Y
#> 6                                   (null)
#>   SEARCH_BASIS_ADMISSION_FLAG SEARCH_BASIS_CONSENT_FLAG
#> 1                      (null)                    (null)
#> 2                      (null)                    (null)
#> 3                      (null)                    (null)
#> 4                      (null)                    (null)
#> 5                      (null)                    (null)
#> 6                      (null)                    (null)
#>   SEARCH_BASIS_HARD_OBJECT_FLAG
#> 1                        (null)
#> 2                        (null)
#> 3                        (null)
#> 4                        (null)
#> 5                        (null)
#> 6                        (null)
#>   SEARCH_BASIS_INCIDENTAL_TO_ARREST_FLAG
#> 1                                 (null)
#> 2                                      Y
#> 3                                 (null)
#> 4                                 (null)
#> 5                                 (null)
#> 6                                 (null)
#>   SEARCH_BASIS_OTHER_FLAG SEARCH_BASIS_OUTLINE_FLAG
#> 1                  (null)                    (null)
#> 2                  (null)                    (null)
#> 3                  (null)                    (null)
#> 4                  (null)                    (null)
#> 5                  (null)                    (null)
#> 6                  (null)                    (null)
#>   DEMEANOR_CODE DEMEANOR_OF_PERSON_STOPPED
#> 1            DE              UNDERSTANDING
#> 2            DE                     NORMAL
#> 3            DE                       CALM
#> 4            DE                   CONFUSED
#> 5          <NA>                       <NA>
#> 6            DE               COORPERATIVE
#>   SUSPECT_REPORTED_AGE SUSPECT_SEX SUSPECT_RACE_DESCRIPTION
#> 1                   30        MALE                    BLACK
#> 2                   22        MALE                    BLACK
#> 3                   56        MALE                    WHITE
#> 4               (null)        MALE                    BLACK
#> 5                   21        MALE                    BLACK
#> 6                   17        MALE                    BLACK
#>   SUSPECT_HEIGHT SUSPECT_WEIGHT SUSPECT_BODY_BUILD_TYPE
#> 1           5.11            230                     HEA
#> 2           5.10            190                     MED
#> 3           5.90            250                     HEA
#> 4             NA             NA                  (null)
#> 5           5.90            150                     THN
#> 6           5.90            150                     MED
#>   SUSPECT_EYE_COLOR SUSPECT_HAIR_COLOR
#> 1               BRO                BLK
#> 2               BRO                BLK
#> 3               BLU                BLK
#> 4            (null)             (null)
#> 5               BLK                BLK
#> 6               BLK                RED
#>                                            SUSPECT_OTHER_DESCRIPTION
#> 1                                                            UNKNOWN
#> 2                                                             (null)
#> 3 BLACK LONG COAT, BLACK PANTS, BLACK FEDORA HAT, CANE, BIG SUITCASE
#> 4                                                             (null)
#> 5                                                             (null)
#> 6                                                BLACK WOODED JACKET
#>   STOP_LOCATION_PRECINCT STOP_LOCATION_SECTOR_CODE
#> 1                      1                         C
#> 2                      1                         C
#> 3                      1                         D
#> 4                      1                         (
#> 5                      1                         D
#> 6                      1                         B
#>   STOP_LOCATION_APARTMENT STOP_LOCATION_FULL_ADDRESS
#> 1                  (null)           230 VESEY STREET
#> 2                  (null)             9 WHITE STREET
#> 3                  (null)          131 SPRING STREET
#> 4                  (null)    GRAND STREET && 6TH AVE
#> 5                  (null)         32 THOMPSON STREET
#> 6                  (null)             8 STONE STREET
#>   STOP_LOCATION_STREET_NAME STOP_LOCATION_X STOP_LOCATION_Y
#> 1              VESEY STREET          979667          199737
#> 2              WHITE STREET          982650          201326
#> 3             SPRING STREET          984063          203033
#> 4              GRAND STREET          982848          202677
#> 5           THOMPSON STREET          983100          202705
#> 6              STONE STREET          980765          195773
#>   STOP_LOCATION_ZIP_CODE STOP_LOCATION_PATROL_BORO_NAME
#> 1                 (null)                           PBMS
#> 2                 (null)                           PBMS
#> 3                 (null)                           PBMS
#> 4                 (null)                           PBMS
#> 5                 (null)                           PBMS
#> 6                 (null)                           PBMS
#>   STOP_LOCATION_BORO_NAME
#> 1               MANHATTAN
#> 2               MANHATTAN
#> 3               MANHATTAN
#> 4               MANHATTAN
#> 5               MANHATTAN
#> 6               MANHATTAN
nrow(sqf)
#> [1] 13459
```

Each row of data is a stop and frisk, and there were 13,459 in 2019. That number may seem low to you, especially if you've read articles about how frequent stop and frisks happens in New York City. It is correct - at least correct in terms of reported stops. Stop and frisks in New York City peaked in 2011 with nearly 700,000 conducted, and then fell sharply after that to fewer than 23,000 from 2015 through 2019 (the last year available at the time of this writing). 

Looking at the results of `head()`, we can see that this is a rich dataset with lots of information about each stop (though many columns also have missing data, so not as rich as it initially appears). Each stop has, for example, the date and time of the stop, whether and arrest was made and for what, physical characteristics (race, sex, age, height, weight, clothing) of the person stopped, and the location of the stop. One important variable that's missing is a unique identifier for either the officer or the person stopped so we can see how often they are in the data. The "ISSUING_OFFICER_COMMAND_CODE" variable may be a unique ID for the officer but it's not clear that it is - there are different officer ranks for the same command code so this appears to me to be different officers. 

## Reshaping a single column

Relative to most datasets in criminology, this is an enormous amount of information. So I encourage you to explore this data and practice your R skills. As this chapter focuses on reshaping, we won't do much exploring of the data. This data is in long format as each row is a different stop and the columns are information about that specific stop. We can't convert this to wide format as there are no repeated entries in the data; each row is of a unique person stopped (at least as far as we can tell. In reality there are likely to be many people stopped multiple times in the data). We could use another variable such as stopped persons' race or gender and reshape it using that, but that'll lead to many thousands of columns so is not a great idea. 

Instead, we'll first aggregate the data and then reshape that aggregated data. We'll aggregate the data by month and by day of week, and see how many people of each race were stopped at each month-day-of-week. In addition to `tidyr`, we'll use functions from `dplyr` to aggregate our data. Since we've already installed that package we just need to use `library()` and don't need to use `install.packages()` again. We've already used the `group_by()` function in aggregating, and now we'll introduce a new function: `count()`. In our earlier aggregation code, we used the function `summarize()` and summed up columns which had a numeric variable (e.g. the number of murders). `count()` works similarly by sums up categorical variables, which in our case is the race of people stopped. Using `count()` we enter in the categorical column in the parentheses and it'll make a new column called "n" which is the sum of each category. Since we're aggregating the data let's save the result of our aggregating to a new object called "sqf_agg".


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

Now let's look at the `head()` of the result.


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
```

Each row is now a month-day-of-week-race combination and we have two additional columns: first the person stopped's race and then the "n" column which says how many people of that race were stopped in that month-day-of-week. The first race is "(null)" which means we don't know the race. We could keep these values as an "unknown" race but for simplicity we'll just remove those using `filter()`. 

To make sure we only have values we expect, we can use the `unique()` function to check that we have only months and week days we expect, and that our race names are consistent. This is important because even though you know, for example, that there are only seven days in a week, there may be more in our data due to typos or erroneous data entry. So it is always good to check.



```r
unique(sqf_agg$MONTH2)
#>  [1] "April"     "August"    "December"  "February" 
#>  [5] "January"   "July"      "June"      "March"    
#>  [9] "May"       "November"  "October"   "September"
unique(sqf_agg$DAY2)
#> [1] "Friday"    "Monday"    "Saturday"  "Sunday"   
#> [5] "Thursday"  "Tuesday"   "Wednesday"
unique(sqf_agg$SUSPECT_RACE_DESCRIPTION)
#> [1] "(null)"                    "ASIAN / PACIFIC ISLANDER" 
#> [3] "BLACK"                     "BLACK HISPANIC"           
#> [5] "WHITE"                     "WHITE HISPANIC"           
#> [7] "AMERICAN INDIAN/ALASKAN N"
```
The months and days of the week look good. For an actual data analysis we may want to combine the Hispanic values to a single "Hispanic" value instead of splitting it between 'BLACK HISPANIC" and "WHITE HISPANIC" but for this lesson we'll leave it as it is.

Now, we want to reshape the data from its current long format to a wide format. We do this using the `pivot_wider()` function from the `tidyr` package. In the function we need to input two values, the name of the column which has the categorical values (this also includes values such as dates or years or ID numbers) which identify what each value in the row means, and the column which has that value. In our case this is the "SUSPECT_RACE_DESCRIPTION" column and the "n" column. We don't need to put the column names in quotes. These inputs are called "names_from" and "values_from" so we'll also include that in the `pivot_wider()` function. And finally before we run `pivot_wider()` we'll first use `filter()` to remove any row where the race is "(null)". We'll save the result of this code to an object called "sqf_agg_wide" and use `head()` to look at this result. 


```r
sqf_agg_wide <- sqf_agg %>%
  filter(SUSPECT_RACE_DESCRIPTION != "(null)") %>%
  pivot_wider(names_from = SUSPECT_RACE_DESCRIPTION, values_from = n) 
head(sqf_agg_wide)
#> # A tibble: 6 x 8
#> # Groups:   MONTH2, DAY2 [6]
#>   MONTH2 DAY2  `ASIAN / PACIFI~ BLACK `BLACK HISPANIC` WHITE
#>   <chr>  <chr>            <int> <int>            <int> <int>
#> 1 April  Frid~                1   104               17    16
#> 2 April  Mond~                1    92               10    32
#> 3 April  Satu~                3   115               24    24
#> 4 April  Sund~                2    96               12    15
#> 5 April  Thur~                2   122               10    18
#> 6 April  Tues~                7   137               14    20
#> # ... with 2 more variables: WHITE HISPANIC <int>,
#> #   AMERICAN INDIAN/ALASKAN N <int>
```

Now instead of having one row be a month-day-of-week-race combination, each row is a month-day-of-week pair and we have one column for every race in our data. Each of these race columns tell us how many people of that race were stopped in that month-day-of-week. This allows for really easy comparison of things like racial differences in stops for each month-day-of-week as we just look at different columns in the same row. We have now successfully done our first reshaping, moving this data from long to wide format!

Now we want to reshape it again to go from wide to long. Our race columns names just took the values from the race column which means that we have column names all in capital letters and with spaces and slashes in it. We could technically use this as it is but it's a bit trickier to use any name with punctuation in it, and is against R column name convention, so we'll quickly fix this. To do so we'll use the package `make_clean_names()` function from the janitor package that automatically makes all character inputs to the function lower case and replaces all punctuation with an underscore. First we need to install the package with `install.packages()`. 


```r
install.packages("janitor")
```

To use this function on the column names we'll make the input of the function `names(sqf_agg_wide` which returns the names of the "sqf_agg_wide" data and save the result also into `names(sqf_agg_wide)`. It might look weird to put a function inside of a function but R is completely fine with it. Running `names(sqf_agg_wide)` at the end will print out the column names so we can check that it worked.


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

Now each column name is lower cases and has only underscores instead of spaces and slashes.



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
#>   month2 day2   race                      number_of_people_~
#>   <chr>  <chr>  <chr>                                  <int>
#> 1 April  Friday asian_pacific_islander                     1
#> 2 April  Friday black                                    104
#> 3 April  Friday black_hispanic                            17
#> 4 April  Friday white                                     16
#> 5 April  Friday white_hispanic                            31
#> 6 April  Friday american_indian_alaskan_n                 NA
```

In some cases you'll have many columns that you want to include while reshaping which makes writing them all out by handle time consuming. If all of the columns are sequential you can use a trick in this function to writing `first_column:last_column` where the : will make it include each column (in order) from the first one you input to the last one. This is doing the same thing as `1:3` which returns 1, 2, and 3, but for columns instead of numbers. This doesn't work in most cases but does work for many tidyverse packages. There are also a large number of functions from the `dplyr` package that are for selecting columns, and are very helpful for doing things like this. The functions are numerous are have changed relatively frequently in the past so I won't cover them in this book, but if you're interested you can look at them on [this page](https://dplyr.tidyverse.org/reference/dplyr_tidy_select.html) of `dplyr`'s website.


```r
sqf_agg_long <- sqf_agg_wide %>%
  pivot_longer(cols = asian_pacific_islander:american_indian_alaskan_n,
               names_to = "race",
               values_to = "number_of_people_stopped")
head(sqf_agg_long)
#> # A tibble: 6 x 4
#> # Groups:   month2, day2 [1]
#>   month2 day2   race                      number_of_people_~
#>   <chr>  <chr>  <chr>                                  <int>
#> 1 April  Friday asian_pacific_islander                     1
#> 2 April  Friday black                                    104
#> 3 April  Friday black_hispanic                            17
#> 4 April  Friday white                                     16
#> 5 April  Friday white_hispanic                            31
#> 6 April  Friday american_indian_alaskan_n                 NA
```

## Reshaping a multiple columns


```r
sqf_agg$n2 <- sqf_agg$n + 10
sqf_agg_wide <- sqf_agg %>%
  filter(SUSPECT_RACE_DESCRIPTION != "(null)") %>%
  pivot_wider(names_from = SUSPECT_RACE_DESCRIPTION, values_from = c(n, n2)) 
names(sqf_agg_wide) <- make_clean_names(names(sqf_agg_wide))
head(sqf_agg_wide)
#> # A tibble: 6 x 14
#> # Groups:   month2, day2 [6]
#>   month2 day2     n_asian_pacific_islander n_black n_black_hispanic
#>   <chr>  <chr>                       <int>   <int>            <int>
#> 1 April  Friday                          1     104               17
#> 2 April  Monday                          1      92               10
#> 3 April  Saturday                        3     115               24
#> 4 April  Sunday                          2      96               12
#> 5 April  Thursday                        2     122               10
#> 6 April  Tuesday                         7     137               14
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
#>   month2 day2   race     number_of_people~ number_of_people~
#>   <chr>  <chr>  <chr>                <int>             <dbl>
#> 1 April  Friday n_asian~                 1                11
#> 2 April  Friday n_asian~                 1               114
#> 3 April  Friday n_asian~                 1                27
#> 4 April  Friday n_asian~                 1                26
#> 5 April  Friday n_asian~                 1                41
#> 6 April  Friday n_asian~                 1                NA
```



