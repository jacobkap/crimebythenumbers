
# Graphing Officer-Involved Shootings

In this lesson we will continue to explore graphing using `ggplot()`. While the Philadelphia Police website does have a number of variables available in a table on the site for shootings since 2013, since we did not scrape them initially we'll turn to a new data set. The data we will use is a data base of officer-involved shootings that result in a death in the United States since January 1st, 2015. This data has been compiled and released by the Washington Post so it will be a useful exercise in exploring data from non-government sources. This data is useful for our purposes as it has a number of variables related to the victim of the shootings, allowing us to practice making many types of graphs. 

To explore the data on their website, see [here](https://www.washingtonpost.com/graphics/2019/national/police-shootings-2019/?utm_term=.e870afc9a00c) . To examine their methodology, see [here](https://www.washingtonpost.com/national/how-the-washington-post-is-examining-police-shootings-in-the-united-states/2016/07/07/d9c52238-43ad-11e6-8856-f26de2537a9d_story.html?utm_term=.f07e9800092b) .

The data initially comes as a .csv file. TO read in .csv files (which are a common format you'll find data in) we can use the `read.csv()` function built into R (meaning we don't need to load any packages). The input in the () is the file name ending in ".csv". As it is telling R to read a file on the computer, the whole name must be in quotes. 

Unlike loading an .rda file using `load()`, there is no name for the object that gets read in so we must assign the data a name. We can using "shootings" as it's relatively descriptive and easy for us to write. 


```r
shootings <- read.csv("data/fatal-police-shootings-data.csv")
```

Another function worth mentioning in reading .csv files to R is `read_csv()` - note that it uses an underscore rather than a period. This function is part of the `readr` package so you need to install it once and then use `library()` every R session to use it. 


```r
install.packages("readr")
```


```r
library(readr)
```

The primary benefit to `read_csv()` is speed. When dealing with a large file, `read_csv()` is much faster than `read.csv()` though there is not much difference when it comes to small data. 


```r
shootings <- read_csv("data/fatal-police-shootings-data.csv")
#> Parsed with column specification:
#> cols(
#>   id = col_double(),
#>   name = col_character(),
#>   date = col_date(format = ""),
#>   manner_of_death = col_character(),
#>   armed = col_character(),
#>   age = col_double(),
#>   gender = col_character(),
#>   race = col_character(),
#>   city = col_character(),
#>   state = col_character(),
#>   signs_of_mental_illness = col_logical(),
#>   threat_level = col_character(),
#>   flee = col_character(),
#>   body_camera = col_logical()
#> )
```

`read_csv()` also reads in data to an object called a `tibble` which is very similar to a data.frame but has some differences in displaying the data. If we run `head()` on the data it doesn't show all columns. This is useful to avoid accidentally printing out a massive amounts of columns.


```r
head(shootings)
#> # A tibble: 6 x 14
#>      id name  date       manner_of_death armed   age gender race  city 
#>   <dbl> <chr> <date>     <chr>           <chr> <dbl> <chr>  <chr> <chr>
#> 1     3 Tim ~ 2015-01-02 shot            gun      53 M      A     Shel~
#> 2     4 Lewi~ 2015-01-02 shot            gun      47 M      W     Aloha
#> 3     5 John~ 2015-01-03 shot and Taser~ unar~    23 M      H     Wich~
#> 4     8 Matt~ 2015-01-04 shot            toy ~    32 M      W     San ~
#> 5     9 Mich~ 2015-01-04 shot            nail~    39 M      H     Evans
#> 6    11 Kenn~ 2015-01-04 shot            gun      18 M      W     Guth~
#> # ... with 5 more variables: state <chr>, signs_of_mental_illness <lgl>,
#> #   threat_level <chr>, flee <chr>, body_camera <lgl>
```

We'll turn the "shootings" object into a data.frame just for simplicity.


```r
shootings <- as.data.frame(shootings)
```

Now that we have the data read in, let's look at it.


```r
nrow(shootings)
#> [1] 4371
ncol(shootings)
#> [1] 14
```

The data has 14 variables and covers over 4,000 shootings. Let's check out some of the variables, first using `head()` then using `summary()` and `table()`.


```r
head(shootings)
#>   id               name       date  manner_of_death      armed age gender
#> 1  3         Tim Elliot 2015-01-02             shot        gun  53      M
#> 2  4   Lewis Lee Lembke 2015-01-02             shot        gun  47      M
#> 3  5 John Paul Quintero 2015-01-03 shot and Tasered    unarmed  23      M
#> 4  8    Matthew Hoffman 2015-01-04             shot toy weapon  32      M
#> 5  9  Michael Rodriguez 2015-01-04             shot   nail gun  39      M
#> 6 11  Kenneth Joe Brown 2015-01-04             shot        gun  18      M
#>   race          city state signs_of_mental_illness threat_level
#> 1    A       Shelton    WA                    TRUE       attack
#> 2    W         Aloha    OR                   FALSE       attack
#> 3    H       Wichita    KS                   FALSE        other
#> 4    W San Francisco    CA                    TRUE       attack
#> 5    H         Evans    CO                   FALSE       attack
#> 6    W       Guthrie    OK                   FALSE       attack
#>          flee body_camera
#> 1 Not fleeing       FALSE
#> 2 Not fleeing       FALSE
#> 3 Not fleeing       FALSE
#> 4 Not fleeing       FALSE
#> 5 Not fleeing       FALSE
#> 6 Not fleeing       FALSE
```

Each row is a single shooting and it includes variables such as the victim's name, the date of the shooting, demographic information about that person, the shooting city and state, and some information about the incident. It is clear from these first 6 rows that most variables are categorical so we can't use `summary()` on them. Let's use `summary()` on the date and age columns and then use `table()` for the rest. 


```r
summary(shootings$date)
#>         Min.      1st Qu.       Median         Mean      3rd Qu. 
#> "2015-01-02" "2016-02-07" "2017-03-16" "2017-03-18" "2018-04-11" 
#>         Max. 
#> "2019-06-25"
```


```r
summary(shootings$age)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#>    6.00   27.00   35.00   36.84   45.00   91.00     182
```

From this we can see that the data is from January 1st through the middle of 2019 (The Washington Post is contintuously updating their data but I downloaded in on June 27th, 2019 which is why June 2019 is the end of our data). From the age column we can see that the average age is about 35 with most victim's around that range. However, the youngest victim is 6 years old while the oldest is 91. Additionally, 182 rows have missing values for this variable. 

Now we can use `table()` to see how often each value appears in each variable. We don't want to do this for city or name as there would be too many values, but it will work for the other columns. Let's start with manne_of_death.


```r
table(shootings$manner_of_death)
#> 
#>             shot shot and Tasered 
#>             4146              225
```

To turn these counts into percentages we can divide the results by the number of rows in our data and miltiple by 100.


```r
table(shootings$manner_of_death) / nrow(shootings) * 100
#> 
#>             shot shot and Tasered 
#>        94.852437         5.147563
```

Now it is clear to see that in 95% of shootings, officers used a gun and in 5% of shootings they also used Taser. As this is data on officer shooting deaths, this is unsurprising. Let's take a look at where the victim was armed.


```r
table(shootings$armed) / nrow(shootings) * 100
#> 
#>                  air conditioner                               ax 
#>                       0.02287806                       0.48043926 
#>                         barstool                     baseball bat 
#>                       0.02287806                       0.27453672 
#>          baseball bat and bottle baseball bat and fireplace poker 
#>                       0.02287806                       0.02287806 
#>                            baton                          bayonet 
#>                       0.09151224                       0.02287806 
#>                           BB gun                     bean-bag gun 
#>                       0.06863418                       0.02287806 
#>                      beer bottle                     blunt object 
#>                       0.06863418                       0.11439030 
#>                    bow and arrow                       box cutter 
#>                       0.02287806                       0.22878060 
#>                            brick                          carjack 
#>                       0.04575612                       0.02287806 
#>                            chain                        chain saw 
#>                       0.04575612                       0.04575612 
#>                         chainsaw                            chair 
#>                       0.02287806                       0.04575612 
#>              claimed to be armed               contractor's level 
#>                       0.02287806                       0.02287806 
#>                   cordless drill                         crossbow 
#>                       0.02287806                       0.20590254 
#>                          crowbar                        fireworks 
#>                       0.06863418                       0.02287806 
#>                         flagpole                       flashlight 
#>                       0.02287806                       0.02287806 
#>                      garden tool                      glass shard 
#>                       0.02287806                       0.06863418 
#>                              gun                      gun and car 
#>                      55.43353924                       0.11439030 
#>                    gun and knife                    gun and sword 
#>                       0.34317090                       0.02287806 
#>                  gun and vehicle              guns and explosives 
#>                       0.04575612                       0.06863418 
#>                           hammer                       hand torch 
#>                       0.22878060                       0.02287806 
#>                          hatchet                  hatchet and gun 
#>                       0.18302448                       0.04575612 
#>                incendiary device                            knife 
#>                       0.04575612                      14.96225120 
#>                 lawn mower blade                          machete 
#>                       0.04575612                       0.86936628 
#>                  machete and gun                     meat cleaver 
#>                       0.02287806                       0.06863418 
#>                  metal hand tool                     metal object 
#>                       0.02287806                       0.09151224 
#>                       metal pipe                       metal pole 
#>                       0.25165866                       0.04575612 
#>                       metal rake                      metal stick 
#>                       0.02287806                       0.06863418 
#>                       motorcycle                         nail gun 
#>                       0.02287806                       0.02287806 
#>                              oar                       pellet gun 
#>                       0.02287806                       0.02287806 
#>                              pen                     pepper spray 
#>                       0.02287806                       0.02287806 
#>                         pick-axe                    piece of wood 
#>                       0.06863418                       0.06863418 
#>                             pipe                        pitchfork 
#>                       0.13726836                       0.04575612 
#>                             pole                   pole and knife 
#>                       0.04575612                       0.04575612 
#>                             rock                    samurai sword 
#>                       0.09151224                       0.02287806 
#>                         scissors                      screwdriver 
#>                       0.06863418                       0.18302448 
#>                     sharp object                           shovel 
#>                       0.11439030                       0.06863418 
#>                            spear                          stapler 
#>                       0.02287806                       0.02287806 
#>              straight edge razor                            sword 
#>                       0.06863418                       0.34317090 
#>                            Taser                        tire iron 
#>                       0.41180508                       0.02287806 
#>                       toy weapon                          unarmed 
#>                       3.54609929                       6.36010066 
#>                     undetermined                   unknown weapon 
#>                       4.30107527                       1.25829330 
#>                          vehicle                  vehicle and gun 
#>                       1.57858614                       0.02287806 
#>                    walking stick                           wrench 
#>                       0.02287806                       0.02287806
```

This is fairly hard to interpret as it is sorted alphabetically when we'd prefer it to be sorted by most common weapon and it doesn't round the percents. Let's solve these two issues using `sort()` and `round()`. We could just wrap our initial code inside each of these functions but to avoid making too complicated code, we save the results in a temp object and incrementally use `sort()` and `round()` on that. We'll round to two decimal places by setting the parameter `digits` to 2.


```r
temp <- table(shootings$armed) / nrow(shootings) * 100
temp <- sort(temp)
temp <- round(temp, digits = 2)
temp
#> 
#>                  air conditioner                         barstool 
#>                             0.02                             0.02 
#>          baseball bat and bottle baseball bat and fireplace poker 
#>                             0.02                             0.02 
#>                          bayonet                     bean-bag gun 
#>                             0.02                             0.02 
#>                    bow and arrow                          carjack 
#>                             0.02                             0.02 
#>                         chainsaw              claimed to be armed 
#>                             0.02                             0.02 
#>               contractor's level                   cordless drill 
#>                             0.02                             0.02 
#>                        fireworks                         flagpole 
#>                             0.02                             0.02 
#>                       flashlight                      garden tool 
#>                             0.02                             0.02 
#>                    gun and sword                       hand torch 
#>                             0.02                             0.02 
#>                  machete and gun                  metal hand tool 
#>                             0.02                             0.02 
#>                       metal rake                       motorcycle 
#>                             0.02                             0.02 
#>                         nail gun                              oar 
#>                             0.02                             0.02 
#>                       pellet gun                              pen 
#>                             0.02                             0.02 
#>                     pepper spray                    samurai sword 
#>                             0.02                             0.02 
#>                            spear                          stapler 
#>                             0.02                             0.02 
#>                        tire iron                  vehicle and gun 
#>                             0.02                             0.02 
#>                    walking stick                           wrench 
#>                             0.02                             0.02 
#>                            brick                            chain 
#>                             0.05                             0.05 
#>                        chain saw                            chair 
#>                             0.05                             0.05 
#>                  gun and vehicle                  hatchet and gun 
#>                             0.05                             0.05 
#>                incendiary device                 lawn mower blade 
#>                             0.05                             0.05 
#>                       metal pole                        pitchfork 
#>                             0.05                             0.05 
#>                             pole                   pole and knife 
#>                             0.05                             0.05 
#>                           BB gun                      beer bottle 
#>                             0.07                             0.07 
#>                          crowbar                      glass shard 
#>                             0.07                             0.07 
#>              guns and explosives                     meat cleaver 
#>                             0.07                             0.07 
#>                      metal stick                         pick-axe 
#>                             0.07                             0.07 
#>                    piece of wood                         scissors 
#>                             0.07                             0.07 
#>                           shovel              straight edge razor 
#>                             0.07                             0.07 
#>                            baton                     metal object 
#>                             0.09                             0.09 
#>                             rock                     blunt object 
#>                             0.09                             0.11 
#>                      gun and car                     sharp object 
#>                             0.11                             0.11 
#>                             pipe                          hatchet 
#>                             0.14                             0.18 
#>                      screwdriver                         crossbow 
#>                             0.18                             0.21 
#>                       box cutter                           hammer 
#>                             0.23                             0.23 
#>                       metal pipe                     baseball bat 
#>                             0.25                             0.27 
#>                    gun and knife                            sword 
#>                             0.34                             0.34 
#>                            Taser                               ax 
#>                             0.41                             0.48 
#>                          machete                   unknown weapon 
#>                             0.87                             1.26 
#>                          vehicle                       toy weapon 
#>                             1.58                             3.55 
#>                     undetermined                          unarmed 
#>                             4.30                             6.36 
#>                            knife                              gun 
#>                            14.96                            55.43
```

Now it is a little easier to interpret. In over half of the cases the victim was carrying a gun. 15% of the time they had a knife. And 6% of the time they were unarmed. in 4% of cases there is no data on any weapon. That leaves about 20% of cases where one of the many rare weapons were used, including some that overlap with previous categories such as "hatchet and gun".

Think about how you'd graph this data. There are 85 unique values in this column though only 7 of them are common enough to appear more than 1% of the time. Should we graph all of them? That's overwhelm any plot. For a useful graph we would need to combine many of these into a single category - possible called "other weapons". And how do we deal with values where they could meet multiple larger categories? There is not always a clear answer for these types of questions. It depends on what data you're interested in, the goal of the graph, the target audience, and personal preference. 

Let's keep moving and look at gender and race. 


```r
table(shootings$gender) / nrow(shootings) * 100
#> 
#>         F         M 
#>  4.667124 95.218485
```

Nearly all of the shootings are of a man. Given that we saw most shootings involved a victim with a weapon and that most violent crimes are committed by men, this shouldn't be too surprising. 


```r
temp <- table(shootings$race) / nrow(shootings) * 100
temp <- sort(temp)
temp <- round(temp, digits = 2)
temp
#> 
#>     O     N     A     H     B     W 
#>  0.87  1.46  1.62 16.45 22.90 44.89
```

White people are the most likely to be killed by police followed by Black people and Hispanic people. 

We can do a simple cross-tab to see if there the relationship beteen gender and race.


```r
table(shootings$gender, shootings$race)
#>    
#>        A    B    H    N    O    W
#>   F    3   42   21    5    3  107
#>   M   68  959  697   59   35 1853
```

There doesn't appear to be any difference by race or gender. 

One annoying thing with these two variables is that it doesn't spell out the name. Instead of "Female" it has "F". For our graphs we want to spell out the words so it is clear to viewers. 

We've spent some time looking at the data so now we're ready to make the graphs. We need to load the `ggplot2` package.


```r
library(ggplot2)
```

## Graphing a single variable

### Numeric variable

As a reminder, the benefit of using `ggplot()` is we can start with a simple plot and build out way up to more complicated, or better looking, plots. 


```r
ggplot(shootings, aes(x = age)) + 
  geom_density()
#> Warning: Removed 182 rows containing non-finite values (stat_density).
```

<img src="graphing-officer-shootings_files/figure-html/unnamed-chunk-20-1.png" width="90%" style="display: block; margin: auto;" />


```r
ggplot(shootings, aes(x = age)) + 
  geom_histogram()
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
#> Warning: Removed 182 rows containing non-finite values (stat_bin).
```

<img src="graphing-officer-shootings_files/figure-html/unnamed-chunk-21-1.png" width="90%" style="display: block; margin: auto;" />

### Categorical variable


```r
ggplot(shootings, aes(x = race)) + 
  geom_bar()
```

<img src="graphing-officer-shootings_files/figure-html/unnamed-chunk-22-1.png" width="90%" style="display: block; margin: auto;" />


```r
race_order <- names(sort(table(shootings$race), decreasing = TRUE))

ggplot(shootings, aes(x = race)) + 
  geom_bar() +
  scale_x_discrete(limits = race_order)
#> Warning: Removed 516 rows containing non-finite values (stat_count).
```

<img src="graphing-officer-shootings_files/figure-html/unnamed-chunk-23-1.png" width="90%" style="display: block; margin: auto;" />


For bar graphs it is often useful to flip the graph so each value is a row in the graph rather than a column. This also makes it much easier to read the value name.


```r
race_order <- names(sort(table(shootings$race)))
ggplot(shootings, aes(x = race)) + 
  geom_bar(aes(y = (..count..)/sum(..count..))) +
  coord_flip() +
  scale_x_discrete(limits = race_order)
#> Warning: Removed 516 rows containing non-finite values (stat_count).
```

<img src="graphing-officer-shootings_files/figure-html/unnamed-chunk-24-1.png" width="90%" style="display: block; margin: auto;" />



```r
race_order <- names(sort(table(shootings$race)))
ggplot(shootings, aes(x = race)) + 
  geom_bar(aes(y = (..count..)/sum(..count..))) +
  coord_flip() +
  scale_x_discrete(limits = race_order) +
  scale_y_continuous(labels = scales::percent)
#> Warning: Removed 516 rows containing non-finite values (stat_count).
```

<img src="graphing-officer-shootings_files/figure-html/unnamed-chunk-25-1.png" width="90%" style="display: block; margin: auto;" />


We can reuse this code to make a similar graph for the gender variable.


```r
race_order <- names(sort(table(shootings$gender)))
ggplot(shootings, aes(x = gender)) + 
  geom_bar(aes(y = (..count..)/sum(..count..))) +
  coord_flip() +
  scale_x_discrete(limits = race_order) +
  scale_y_continuous(labels = scales::percent)
#> Warning: Removed 5 rows containing non-finite values (stat_count).
```

<img src="graphing-officer-shootings_files/figure-html/unnamed-chunk-26-1.png" width="90%" style="display: block; margin: auto;" />


## Time Series


```r
library(lubridate)
#> 
#> Attaching package: 'lubridate'
#> The following object is masked from 'package:base':
#> 
#>     date
```




```r
shootings$dummy <- 1
shootings$month_year <- floor_date(shootings$date, unit = "month")
shootings$year <- year(shootings$date)
```


```r
monthly_shootings <- aggregate(dummy ~ month_year, data = shootings, FUN = sum)
```


```r
ggplot(monthly_shootings, aes(x = month_year, y = dummy)) +
  geom_line()
```

<img src="graphing-officer-shootings_files/figure-html/unnamed-chunk-30-1.png" width="90%" style="display: block; margin: auto;" />


```r
yearly_shootings <- aggregate(dummy ~ year, data = shootings, FUN = sum)
```


```r
ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line()
```

<img src="graphing-officer-shootings_files/figure-html/unnamed-chunk-32-1.png" width="90%" style="display: block; margin: auto;" />


```r
ggplot(yearly_shootings[yearly_shootings$year != 2019, ], aes(x = year, y = dummy)) +
  geom_line()
```

<img src="graphing-officer-shootings_files/figure-html/unnamed-chunk-33-1.png" width="90%" style="display: block; margin: auto;" />



```r
yearly_shootings <- aggregate(dummy ~ month_year, data = shootings[shootings$armed == "unarmed", ], FUN = sum)
ggplot(yearly_shootings, aes(x = month_year, y = dummy)) +
  geom_line()
```

<img src="graphing-officer-shootings_files/figure-html/unnamed-chunk-34-1.png" width="90%" style="display: block; margin: auto;" />
