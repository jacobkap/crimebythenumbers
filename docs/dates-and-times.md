
# Dates and Times

Working with dates and times is a lot different than working with the more familiar numbers. Months have different number of days. Sometimes we count hours of the day up to 12 and then start over. Sometimes we count hours up to 24 and then start over. Some years have 366 days. We have 24 times zones around the world. Twice a year we switch clocks for Daylight Saving Time, except in some places like Arizona and Hawaii. Arithmetic, such as adding one month to a date, is poorly defined. Which date is one month after January 31st? Is it February 28th? Or is it March 3rd?

Fortunately, software for working with dates exist to make these tasks easier. Unfortunately, every system seems to make their own design decisions. Excel stores dates as the number of days since January 0, 1900. That's not a typo, they count from January 0, 1900. Linux systems count days since January 1, 1970. SPSS stores times as the number of seconds since midnight October 14, 1582, the adoption date of the Gregorian calendar. Much of the world did not adopt the calendar in 1582. The American colonies did not adopt the Gregorian calendar until 1752 along with Great Britain. So beware if you are a historian digging through centuries old data. Aligning dates can become very messy.

## Why do dates and times matter?

Before we get started with any code, let's think about why we should care about any of this. Like most things you'll use R for in this class (and for your thesis), the data you have isn't in the format you want it to be. For simple questions like "what day has the most crime?" you'll need to know what day each crime occured on. For more complex questions like "did marijuana legalization affect murder?" you need to know how many crimes occurred on months or years before and after marijuana legalization. In almost every case where time matters for research (and it matters in many studies) you will have data in the **wrong** format to answer you question. You'll likely want to group all the days in a month together or just take crimes that happened at a certain time (as is common in studies of outdoor lighting). 

Most Master's theses are policy analyses comparing some outcome (e.g. number of crimes) in a state before and after a policy change compared to a similar locations without that change. In these cases you want to think about what time unit you data should be in (crimes per month, crime per year) and use the following tools to get the data into the right format. 

## `lubridate`

R has had a variety of attempts at providing a means for managing dates. We are going to use the [`lubridate`](https://lubridate.tidyverse.org/) package that addresses just about everything you might need to do with dates and times. A useful cheat sheet is available [here](https://rawgit.com/rstudio/cheatsheets/master/lubridate.pdf).

`lubridate` is not part of R by default. You will need to install it. Run


```r
install.packages("lubridate")
```

and R will hit the web, download the `lubridate` package and any supporting packages it needs (and it does need a few), and installs them. This is a one time event. Once you have `lubridate` on your machine you will not need to reinstall it every time you need it. You will, however, have to tell R that you will use `lubridate` at the beginning of each session that you use it (as we do below).

Some of our students, particularly on Macs, have encountered trouble installing some packages for R. R will sometimes try to download the source code for the packages and compile them from scratch on your machine. Sometimes that goes well and other times it requires that you have other tools installed on your machine. An easy solution is to run


```r
install.packages("lubridate", type="mac.binary")
```

instead to insist that R finds and installs a ready-to-use version of the packages.

## Working with dates

While `lubridate` is now installed, once per R session you will need to load `lubridate`. 


```r
library(lubridate)
```

If you close R and restart it, then you'll need to run this line again. `library(package)` is the way you tell R that you need to use the functions included in that package. 

Before using real data, we'll start with defining useful functions and using a toy example. Below we have made the object called "dates" with three character values showing the dates August 7th for the years 2010-2012. Please note that Dates (capital D) are a special type of value that R understands and just putting what we can read as a date in quotes doesn't make it so. 


```r
dates <- c("2010-08-07", "2011-08-07", "2012-08-07")
```

When we look at these dates we can see that it starts with the year, then has the month, then the day. R doesn't know that. We have to tell R what order the year, month, and day are in. This is the key part of the `lubridate` package. There are three functions which tell R which order to use. Year, month, and day are all abbreviated to the first letter and all lowercase. Inside the parentheses we put the dates.

  + `ymd()` Order is year-month-day
  + `mdy()` Order is month-day-year (common in crime data)
  + `dmy()` Order is day-month-year
  
Since our date are in year-month-day order, we will use `ymd()`.


```r
ymd(dates)
#> [1] "2010-08-07" "2011-08-07" "2012-08-07"
```

If you tell R the wrong order, it will not be able to read the data and will return NAs.


```r
myd(dates)
#> Warning: All formats failed to parse. No formats found.
#> [1] NA NA NA
```
  
Some dates come with hour, minutes, and even seconds telling exactly when the event happened. In those cases you must add _hm to the end of your code to indicate that there are hour and minute information in the data. If there are also seconds, use _hms. 

  + `ymd_hms()`
  + `mdy_hms()`
  + `dmy_hms()`
  + `ymd_hm()`
  + `mdy_hm()`
  + `dmy_hm()`
  
Like before, telling R the wrong order will return all NAs. If the date has hours and minutes (and seconds) you must have _hm or it won't work right, and if it doesn't you must not include it.
  

```r
ymd_hms(dates)
#> Warning: All formats failed to parse. No formats found.
#> [1] NA NA NA
```

Once you have the dates in the Date format, you can use a number of useful functions to extract information from these Dates such as the year or month of the date, the hour if hours are available, and even the day of the month or week. 
  
  + `year()` Gives the year
  + `month()`Gives the month
  + `day()` Gives the day of year
  + `hour()` Gives the hour (only in cases where an hour is present)
  + `mday()` Gives the day of month 
  + `wday()` Gives the day of week


```r
year(dates)
#> [1] 2010 2011 2012
```

This gives us an error. Why? When we ran the code `ymd(dates)` it changed the value in "dates" to Date type and printed out those new values. But it didn't save it anywhere so "dates" is still a vector of characters rather than Dates. We need to run `ymd(dates)` again and save the result somewhere. Generally, to reduce the number of objects created when you're making a change you just save it back in the original object, overwriting it. **This doesn't change the raw data found in .csv or .rda files, only the data that is read into R. This is important because we always want to keep the raw data unchanged and have all our changes recorded in code.**


```r
dates <- ymd(dates)
```

Now that we have save our changes in the "dates" object, lets try again.


```r
year(dates)
#> [1] 2010 2011 2012
```



```r
month(dates)
#> [1] 8 8 8
```

By default `month()` gives the month number rather than the name of the month. We need to set the paramater `label` to TRUE to get the month name. 


```r
month(dates, label = TRUE)
#> [1] Aug Aug Aug
#> 12 Levels: Jan < Feb < Mar < Apr < May < Jun < Jul < Aug < Sep < ... < Dec
```

We can also set the parameter `abbr` to FALSE if we want the full month name rather than the abbreviation. 


```r
month(dates, label = TRUE, abbr = FALSE)
#> [1] August August August
#> 12 Levels: January < February < March < April < May < June < ... < December
```


  
The final useful function we will discuss is `floor_date()` which rounds down the date to the first day of the unit given. There are a number of possible units, the most common in our purposes will be "year", "month" "week", and "day".


  + `floor_date()`
  

```r
floor_date(dates, unit = "month")
#> [1] "2010-08-01" "2011-08-01" "2012-08-01"
```

If we change the unit to "year" it'll change the date to the first date in the year.


```r
floor_date(dates, unit = "year")
#> [1] "2010-01-01" "2011-01-01" "2012-01-01"
```

Using `floor_date()` will be very useful when you want to find the number of crimes in each month/year as you can do this to get a single date for each month/year and aggregate crimes in that month/year.

## Chicago crime data

Let's reload the sample Chicago data we used earlier and work with real data.


```r
load("data/chicago.rda")
```

We can use `head()` to look at the first 6 rows of dates


```r
head(chicago$Date)
[1] "12/09/2014 11:54:00 PM" "12/09/2014 11:45:00 PM"
[3] "12/09/2014 11:42:00 PM" "12/09/2014 11:42:00 PM"
[5] "12/09/2014 11:40:00 PM" "12/09/2014 11:37:00 PM"
```

Now let's use the square bracket [] indexing to also see the first 6 rows of dates. Remember, we're going to want a vector of nubmers 1 through 6 for this. Since these numbers are sequential without any missing we can use 1:6 instead of manually making a vector c(1, 2, 3, 4, 5, 6). Since we already specify we want the Date column, we don't need any commas after the vector of numbers. 


```r
chicago$Date[1:6]
[1] "12/09/2014 11:54:00 PM" "12/09/2014 11:45:00 PM"
[3] "12/09/2014 11:42:00 PM" "12/09/2014 11:42:00 PM"
[5] "12/09/2014 11:40:00 PM" "12/09/2014 11:37:00 PM"
```

As you can see the dates include the date in month-day-year format and the time includes hours, minutes, and seconds. So we must read in the data using `mdy_hms()` to tell R the proper order of the date and that it includes time up to the second. Lets save the results in a new column called "real_date". It's often useful when changing a column to save it as a new column in case you make a mistake in the code - that way you don't have to reload the data to fix it. 


```r
chicago$real_date <- mdy_hms(chicago$Date)
```

Now lets use `head()` again on our new column to see what we made.


```r
head(chicago$real_date)
[1] "2014-12-09 23:54:00 UTC" "2014-12-09 23:45:00 UTC"
[3] "2014-12-09 23:42:00 UTC" "2014-12-09 23:42:00 UTC"
[5] "2014-12-09 23:40:00 UTC" "2014-12-09 23:37:00 UTC"
```

Lets make new columns for the year, month, and weekday for each date and then do some basic exploring on these new variables.


```r
chicago$year <- year(chicago$real_date)
```


```r
chicago$month <- month(chicago$real_date,label = TRUE, abbr = FALSE)
```


```r
chicago$weekday <- wday(chicago$real_date, label = TRUE, abbr = FALSE)
```

First we can use `table()` on each of these new columns to see how frequently each value in the category appears in our data. 


```r
table(chicago$year)
#> 
#>  2014 
#> 10000
```


```r
table(chicago$month)
#> 
#>   January  February     March     April       May      June      July 
#>         0         0         0         0         0         0         0 
#>    August September   October  November  December 
#>         0         0         0      4179      5821
```

Our data comes entirely from November and December in 2014. This certainly limits our ability to see if crime changes across seasons or over years. 


```r
table(chicago$weekday)
#> 
#>    Sunday    Monday   Tuesday Wednesday  Thursday    Friday  Saturday 
#>      1260      1855      1832      1341      1092      1312      1308
```

It looks like there's a difference in which days have the most crime with Monday and Tuesday being the most dangerous days. For easier interpretation let's turn these counts into percents. An easy way is to divide the results by the total number of rows in our data.


```r
table(chicago$weekday) / nrow(chicago)
#> 
#>    Sunday    Monday   Tuesday Wednesday  Thursday    Friday  Saturday 
#>    0.1260    0.1855    0.1832    0.1341    0.1092    0.1312    0.1308
```

This gives us proportions - we can multiple by 100 to get percents.


```r
table(chicago$weekday) / nrow(chicago) * 100
#> 
#>    Sunday    Monday   Tuesday Wednesday  Thursday    Friday  Saturday 
#>     12.60     18.55     18.32     13.41     10.92     13.12     13.08
```

Now we see that indeed Monday and Tuesday have a much higher percent of crime in the data than other days. Is this reasonable? Most studies find that weekends have the highest amount of crime and than Mondays and Tuesdays are relatively low crime. But remember that we're only using a sample of 10,000 crimes across two months in a single year from Chicago. Our data is likely not representative and we shouldn't interpret it too much.

## Time zones

`lubridate` has converted the date and time formats to a more standardized form, one that is easier to use on a computer.

The default time zone is Coordinated Universal Time abbreviated UTC, which is the same as Greenwich Mean Time. Interestingly, the abbreviation CUT would make more sense in English, but TCU would make more sense in French, so the compromise was to universally abbreviate as UTC. Since all of these crimes occurred in Chicago, let's explicitly set the time zone to Central Time. The function `OlsonNames()` will give you a list of all possible time zones you can use.


```r
chicago$real_date <- force_tz(chicago$real_date, "America/Chicago")
chicago$real_date[1:5]   # show just the first five dates
[1] "2014-12-09 23:54:00 CST" "2014-12-09 23:45:00 CST"
[3] "2014-12-09 23:42:00 CST" "2014-12-09 23:42:00 CST"
[5] "2014-12-09 23:40:00 CST"
```

Now when printed you can see that the timezone is set to Central Standard Time. R will automatically handle Daylight Saving Time. Note that an August date reports Central Daylight Time.


```r
force_tz(mdy_hms("8/1/2014 12:00:00"), "America/Chicago")
[1] "2014-08-01 12:00:00 CDT"
```


### Exercises

1. What is the most common crime on Fridays?
2. How many assaults happened on Fridays?
3. Which weekday had the fewest assaults?
  + How many fewer assaults did it have than on Fridays?
