# More graphing with `ggplot2` {#ois_graphs}


For this chapter you'll need the following file, which is available for download [here](https://github.com/jacobkap/r4crimz/tree/master/data): fatal-police-shootings-data.csv.

In this lesson we will continue to explore graphing using `ggplot()`. The data we will use is microdata on officer-involved shootings that result in a death in the United States since January 1st, 2015. This data has been compiled and released by the Washington Post so it will be a useful exercise in exploring data from non-government sources. This data is useful for our purposes as it has a number of variables related to the person who was shot, allowing us to practice making many types of graphs. Each row of data is a different person who was shot and killed by the police, and each column gives us information about the individual or the shooting, such as their age, their location, and whether they carried any weapon. 

To explore the data on their website, see [here](https://www.washingtonpost.com/graphics/2019/national/police-shootings-2019/?utm_term=.e870afc9a00c). 
To examine their methodology, see [here](https://www.washingtonpost.com/national/how-the-washington-post-is-examining-police-shootings-in-the-united-states/2016/07/07/d9c52238-43ad-11e6-8856-f26de2537a9d_story.html?utm_term=.f07e9800092b).

The data initially comes as a .csv file so we'll use the `read_csv()` function from the `readr` package.


```r
library(readr)
shootings <- read_csv("data/fatal-police-shootings-data.csv")
#> Rows: 4371 Columns: 14
#> -- Column specification ------------------------------------
#> Delimiter: ","
#> chr  (9): name, manner_of_death, armed, gender, race, ci...
#> dbl  (2): id, age
#> lgl  (2): signs_of_mental_illness, body_camera
#> date (1): date
#> 
#> i Use `spec()` to retrieve the full column specification for this data.
#> i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

Since `read_csv()` reads files into a tibble object, we'll turn it into a data.frame so `head()` shows every single column.


```r
shootings <- as.data.frame(shootings)
```

## Exploring Data

Now that we have the data read in, let's look at it.


```r
nrow(shootings)
#> [1] 4371
ncol(shootings)
#> [1] 14
```

The data has 14 variables and covers 4371 shootings. Let's check out some of the variables, first using `head()` then using `summary()` and `table()`.


```r
head(shootings)
#>   id               name       date  manner_of_death
#> 1  3         Tim Elliot 2015-01-02             shot
#> 2  4   Lewis Lee Lembke 2015-01-02             shot
#> 3  5 John Paul Quintero 2015-01-03 shot and Tasered
#> 4  8    Matthew Hoffman 2015-01-04             shot
#> 5  9  Michael Rodriguez 2015-01-04             shot
#> 6 11  Kenneth Joe Brown 2015-01-04             shot
#>        armed age gender race          city state
#> 1        gun  53      M    A       Shelton    WA
#> 2        gun  47      M    W         Aloha    OR
#> 3    unarmed  23      M    H       Wichita    KS
#> 4 toy weapon  32      M    W San Francisco    CA
#> 5   nail gun  39      M    H         Evans    CO
#> 6        gun  18      M    W       Guthrie    OK
#>   signs_of_mental_illness threat_level        flee
#> 1                    TRUE       attack Not fleeing
#> 2                   FALSE       attack Not fleeing
#> 3                   FALSE        other Not fleeing
#> 4                    TRUE       attack Not fleeing
#> 5                   FALSE       attack Not fleeing
#> 6                   FALSE       attack Not fleeing
#>   body_camera
#> 1       FALSE
#> 2       FALSE
#> 3       FALSE
#> 4       FALSE
#> 5       FALSE
#> 6       FALSE
```

Each row is a single shooting and it includes variables such as the victim's name, the date of the shooting, demographic information about that person, the city and state where the shooting occurred, and some information about the incident. It is clear from these first 6 rows that most variables are categorical so we can't use `summary()` on them. Let's use `summary()` on the date and age columns and then use `table()` for the rest. 


```r
summary(shootings$date)
#>         Min.      1st Qu.       Median         Mean 
#> "2015-01-02" "2016-02-07" "2017-03-16" "2017-03-18" 
#>      3rd Qu.         Max. 
#> "2018-04-11" "2019-06-25"
summary(shootings$age)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#>    6.00   27.00   35.00   36.84   45.00   91.00     182
```


From this we can see that the data is from early January through about a week ago. From the age column we can see that the average age is about 37 with most people around that range. Now we can use `table()` to see how often each value appears in each variable. We don't want to do this for city or name as there would be too many values, but it will work for the other columns. Let's start with the "manner_of_death" column.


```r
table(shootings$manner_of_death)
#> 
#>             shot shot and Tasered 
#>             4146              225
```

To turn these counts into percentages we can divide the results by the number of rows in our data and multiply by 100.


```r
table(shootings$manner_of_death) / nrow(shootings) * 100
#> 
#>             shot shot and Tasered 
#>        94.852437         5.147563
```

Now it is clear to see that in about 95% of shootings, officers used a gun and in 5% of shootings they also used a Taser. As this is data on officer shooting deaths, this is unsurprising. Let's take a look at whether the victim was armed.


```r
table(shootings$armed) / nrow(shootings) * 100
#> 
#>                  air conditioner 
#>                       0.02287806 
#>                               ax 
#>                       0.48043926 
#>                         barstool 
#>                       0.02287806 
#>                     baseball bat 
#>                       0.27453672 
#>          baseball bat and bottle 
#>                       0.02287806 
#> baseball bat and fireplace poker 
#>                       0.02287806 
#>                            baton 
#>                       0.09151224 
#>                          bayonet 
#>                       0.02287806 
#>                           BB gun 
#>                       0.06863418 
#>                     bean-bag gun 
#>                       0.02287806 
#>                      beer bottle 
#>                       0.06863418 
#>                     blunt object 
#>                       0.11439030 
#>                    bow and arrow 
#>                       0.02287806 
#>                       box cutter 
#>                       0.22878060 
#>                            brick 
#>                       0.04575612 
#>                          carjack 
#>                       0.02287806 
#>                            chain 
#>                       0.04575612 
#>                        chain saw 
#>                       0.04575612 
#>                         chainsaw 
#>                       0.02287806 
#>                            chair 
#>                       0.04575612 
#>              claimed to be armed 
#>                       0.02287806 
#>               contractor's level 
#>                       0.02287806 
#>                   cordless drill 
#>                       0.02287806 
#>                         crossbow 
#>                       0.20590254 
#>                          crowbar 
#>                       0.06863418 
#>                        fireworks 
#>                       0.02287806 
#>                         flagpole 
#>                       0.02287806 
#>                       flashlight 
#>                       0.02287806 
#>                      garden tool 
#>                       0.02287806 
#>                      glass shard 
#>                       0.06863418 
#>                              gun 
#>                      55.43353924 
#>                      gun and car 
#>                       0.11439030 
#>                    gun and knife 
#>                       0.34317090 
#>                    gun and sword 
#>                       0.02287806 
#>                  gun and vehicle 
#>                       0.04575612 
#>              guns and explosives 
#>                       0.06863418 
#>                           hammer 
#>                       0.22878060 
#>                       hand torch 
#>                       0.02287806 
#>                          hatchet 
#>                       0.18302448 
#>                  hatchet and gun 
#>                       0.04575612 
#>                incendiary device 
#>                       0.04575612 
#>                            knife 
#>                      14.96225120 
#>                 lawn mower blade 
#>                       0.04575612 
#>                          machete 
#>                       0.86936628 
#>                  machete and gun 
#>                       0.02287806 
#>                     meat cleaver 
#>                       0.06863418 
#>                  metal hand tool 
#>                       0.02287806 
#>                     metal object 
#>                       0.09151224 
#>                       metal pipe 
#>                       0.25165866 
#>                       metal pole 
#>                       0.04575612 
#>                       metal rake 
#>                       0.02287806 
#>                      metal stick 
#>                       0.06863418 
#>                       motorcycle 
#>                       0.02287806 
#>                         nail gun 
#>                       0.02287806 
#>                              oar 
#>                       0.02287806 
#>                       pellet gun 
#>                       0.02287806 
#>                              pen 
#>                       0.02287806 
#>                     pepper spray 
#>                       0.02287806 
#>                         pick-axe 
#>                       0.06863418 
#>                    piece of wood 
#>                       0.06863418 
#>                             pipe 
#>                       0.13726836 
#>                        pitchfork 
#>                       0.04575612 
#>                             pole 
#>                       0.04575612 
#>                   pole and knife 
#>                       0.04575612 
#>                             rock 
#>                       0.09151224 
#>                    samurai sword 
#>                       0.02287806 
#>                         scissors 
#>                       0.06863418 
#>                      screwdriver 
#>                       0.18302448 
#>                     sharp object 
#>                       0.11439030 
#>                           shovel 
#>                       0.06863418 
#>                            spear 
#>                       0.02287806 
#>                          stapler 
#>                       0.02287806 
#>              straight edge razor 
#>                       0.06863418 
#>                            sword 
#>                       0.34317090 
#>                            Taser 
#>                       0.41180508 
#>                        tire iron 
#>                       0.02287806 
#>                       toy weapon 
#>                       3.54609929 
#>                          unarmed 
#>                       6.36010066 
#>                     undetermined 
#>                       4.30107527 
#>                   unknown weapon 
#>                       1.25829330 
#>                          vehicle 
#>                       1.57858614 
#>                  vehicle and gun 
#>                       0.02287806 
#>                    walking stick 
#>                       0.02287806 
#>                           wrench 
#>                       0.02287806
```

This is fairly hard to interpret as it is sorted alphabetically when we'd prefer it to be sorted by most common weapon. It also doesn't round the numbers so there are many numbers past the decimal point shown. Let's solve these two issues using `sort()` and `round()`. We could just wrap our initial code inside each of these functions but to avoid making too complicated code, we save the results in a temp object and incrementally use `sort()` and `round()` on that. We'll set the parameter `decreasing` to TRUE in the `sort()` function so that it is in descending order of how common each value is. And we'll round to two decimal places by setting the parameter `digits` to 2.


```r
temp <- table(shootings$armed) / nrow(shootings) * 100
temp <- sort(temp, decreasing = TRUE)
temp <- round(temp, digits = 2)
temp
#> 
#>                              gun 
#>                            55.43 
#>                            knife 
#>                            14.96 
#>                          unarmed 
#>                             6.36 
#>                     undetermined 
#>                             4.30 
#>                       toy weapon 
#>                             3.55 
#>                          vehicle 
#>                             1.58 
#>                   unknown weapon 
#>                             1.26 
#>                          machete 
#>                             0.87 
#>                               ax 
#>                             0.48 
#>                            Taser 
#>                             0.41 
#>                    gun and knife 
#>                             0.34 
#>                            sword 
#>                             0.34 
#>                     baseball bat 
#>                             0.27 
#>                       metal pipe 
#>                             0.25 
#>                       box cutter 
#>                             0.23 
#>                           hammer 
#>                             0.23 
#>                         crossbow 
#>                             0.21 
#>                          hatchet 
#>                             0.18 
#>                      screwdriver 
#>                             0.18 
#>                             pipe 
#>                             0.14 
#>                     blunt object 
#>                             0.11 
#>                      gun and car 
#>                             0.11 
#>                     sharp object 
#>                             0.11 
#>                            baton 
#>                             0.09 
#>                     metal object 
#>                             0.09 
#>                             rock 
#>                             0.09 
#>                           BB gun 
#>                             0.07 
#>                      beer bottle 
#>                             0.07 
#>                          crowbar 
#>                             0.07 
#>                      glass shard 
#>                             0.07 
#>              guns and explosives 
#>                             0.07 
#>                     meat cleaver 
#>                             0.07 
#>                      metal stick 
#>                             0.07 
#>                         pick-axe 
#>                             0.07 
#>                    piece of wood 
#>                             0.07 
#>                         scissors 
#>                             0.07 
#>                           shovel 
#>                             0.07 
#>              straight edge razor 
#>                             0.07 
#>                            brick 
#>                             0.05 
#>                            chain 
#>                             0.05 
#>                        chain saw 
#>                             0.05 
#>                            chair 
#>                             0.05 
#>                  gun and vehicle 
#>                             0.05 
#>                  hatchet and gun 
#>                             0.05 
#>                incendiary device 
#>                             0.05 
#>                 lawn mower blade 
#>                             0.05 
#>                       metal pole 
#>                             0.05 
#>                        pitchfork 
#>                             0.05 
#>                             pole 
#>                             0.05 
#>                   pole and knife 
#>                             0.05 
#>                  air conditioner 
#>                             0.02 
#>                         barstool 
#>                             0.02 
#>          baseball bat and bottle 
#>                             0.02 
#> baseball bat and fireplace poker 
#>                             0.02 
#>                          bayonet 
#>                             0.02 
#>                     bean-bag gun 
#>                             0.02 
#>                    bow and arrow 
#>                             0.02 
#>                          carjack 
#>                             0.02 
#>                         chainsaw 
#>                             0.02 
#>              claimed to be armed 
#>                             0.02 
#>               contractor's level 
#>                             0.02 
#>                   cordless drill 
#>                             0.02 
#>                        fireworks 
#>                             0.02 
#>                         flagpole 
#>                             0.02 
#>                       flashlight 
#>                             0.02 
#>                      garden tool 
#>                             0.02 
#>                    gun and sword 
#>                             0.02 
#>                       hand torch 
#>                             0.02 
#>                  machete and gun 
#>                             0.02 
#>                  metal hand tool 
#>                             0.02 
#>                       metal rake 
#>                             0.02 
#>                       motorcycle 
#>                             0.02 
#>                         nail gun 
#>                             0.02 
#>                              oar 
#>                             0.02 
#>                       pellet gun 
#>                             0.02 
#>                              pen 
#>                             0.02 
#>                     pepper spray 
#>                             0.02 
#>                    samurai sword 
#>                             0.02 
#>                            spear 
#>                             0.02 
#>                          stapler 
#>                             0.02 
#>                        tire iron 
#>                             0.02 
#>                  vehicle and gun 
#>                             0.02 
#>                    walking stick 
#>                             0.02 
#>                           wrench 
#>                             0.02
```

Now it is a little easier to interpret. In over half of the cases the victim was carrying a gun. 15% of the time they had a knife. And 6% of the time they were unarmed. In 4% of cases there is no data on any weapon. That leaves about 20% of cases where one of the many rare weapons were used, including some that overlap with one of the more common categories.

Think about how you'd graph this data. There are 85 unique values in this column though fewer than ten of them are common enough to appear more than 1% of the time. Should we graph all of them? No, that would overwhelm any graph. For a useful graph we would need to combine many of these into a single category - possibly called "other weapons." And how do we deal with values where they could meet multiple larger categories? There is not always a clear answer for these types of questions. It depends on what data you're interested in, the goal of the graph, the target audience, and personal preference. 

Let's keep exploring the data by looking at gender and race. 


```r
table(shootings$gender) / nrow(shootings) * 100
#> 
#>         F         M 
#>  4.667124 95.218485
```

Nearly all of the shootings are of a man. Given that we saw most shootings involved a person with a weapon and that most violent crimes are committed by men, this shouldn't be too surprising. 


```r
temp <- table(shootings$race) / nrow(shootings) * 100
temp <- sort(temp)
temp <- round(temp, digits = 2)
temp
#> 
#>     O     N     A     H     B     W 
#>  0.87  1.46  1.62 16.45 22.90 44.89
```

White people are the largest race group that is killed by police, followed by Black people and Hispanic people. In fact, there are about twice as many White people killed than Black people killed, and about 2.5 times as many White people killed than Hispanic people killed. Does this mean that the oft-repeated claim that Black people are killed at disproportionate rates is wrong? No. This data simply shows the number of people killed; it doesn't give any indication on rates of death per group. You'd need to merge it with Census data to get population to determine a rate per race group. And even that would be insufficient since people are, for example, stopped by police at different rates. This data provides a lot of information on people killed by the police, but even so it is insufficient to answer many of the questions on that topic. It's important to understand the data not only to be able to answer questions about it, but to know what questions you can't answer - and you'll find when using criminology data that there are a *lot* of questions that you can't answer.^[It is especially important to not overreach when trying to answer a question when the data can't do it well. Often, no answer is better than a wrong one - especially in a field with serious consequences like criminology. For example, using the current data we'd determine that there's no (or not as much as people claim) racial bias in police killings. If we come to that conclusion based on the best possible evidence, that's okay - even if we're wrong. But coming to that conclusion based on inadequate data could lead to policies that actually cause harm. This isn't to say that you should never try to answer questions since no data is perfect and you may be wrong. You should try to develop a deep understanding of the data and be confident that you can actually answer those questions with confidence.]  

One annoying thing with the gender and race variables is that they don't spell out the name. Instead of "Female", for example, it has "F". For our graphs we want to spell out the words so it is clear to viewers. We'll fix this issue, and the issue of having many weapon categories, as we graph each variable.

## Graphing a Single Numeric Variable

We've spent some time looking at the data so now we're ready to make the graphs. We need to load the `ggplot2` package if we haven't done so already this session (i.e. since you last closed RStudio).


```r
library(ggplot2)
```

As a reminder, the benefit of using `ggplot()` is we can start with a simple plot and build our way up to more complicated graphs. We'll start here by building some graphs to depict a numeric variable - in this case the "age" column. We start every `ggplot()` the same, by inserting the dataset first and then put our x and y variables inside of the `aes()` parameter. In this case we're only going to be plotting an x variable so we don't need to write anything for y.


```r
ggplot(shootings, aes(x = age))
```

<img src="graphing-2_files/figure-html/unnamed-chunk-13-1.png" width="90%" style="display: block; margin: auto;" />
Running the above code returns a blank graph since we haven't told `ggplot()` what type of graph we want yet. Below are a few different types of ways to display a single numeric variable. They're essentially all variations of each other and show the data at different levels of precision. It's hard to say which is best - you'll need to use your best judgment and consider your audience. 

### Histogram

The histogram is a very common type of graph for a single numeric variable. Histograms group a numeric variable into categories and then plot then, with the heights of each bar indicating how common the group is. We can make a histogram by adding `geom_histogram()` to the `ggplot()`.


```r
ggplot(shootings, aes(x = age)) + 
  geom_histogram()
#> `stat_bin()` using `bins = 30`. Pick better value with
#> `binwidth`.
#> Warning: Removed 182 rows containing non-finite values
#> (stat_bin).
```

<img src="graphing-2_files/figure-html/unnamed-chunk-14-1.png" width="90%" style="display: block; margin: auto;" />

The x-axis is ages with each bar being a group of certain ages, and the y-axis is how many people are in each group. The grouping is done automatically and we can alter it by changing the `bin` parameter in `geom_histogram()`. By default this parameter is set to 30 but we can make each group smaller (have fewer ages per group) by **increasing** it from 30 or make each group larger by **decreasing** it.


```r
ggplot(shootings, aes(x = age)) + 
  geom_histogram(bins = 15)
#> Warning: Removed 182 rows containing non-finite values
#> (stat_bin).
```

<img src="graphing-2_files/figure-html/unnamed-chunk-15-1.png" width="90%" style="display: block; margin: auto;" />


```r
ggplot(shootings, aes(x = age)) + 
  geom_histogram(bins = 45)
#> Warning: Removed 182 rows containing non-finite values
#> (stat_bin).
```

<img src="graphing-2_files/figure-html/unnamed-chunk-16-1.png" width="90%" style="display: block; margin: auto;" />

Note that while the overall trend (of most deaths being around age 25) doesn't change when we alter `bin`, the data gets more or less precise. Having fewer bins means fewer, but larger, bars which can obscure trends that more, smaller, bars would show. But having too many bars may make you focus on minor variations that could occur randomly and take away attention from the overall trend. I prefer to err on the side of more precise graphs (more, smaller bars) but be careful over-interpreting data from small groups.

These graphs show the y-axis as the number of people in each bar. If we want to show percent instead, we can add in a parameter for `y` in the `aes()` of the `geom_histogram()`. We add in `y = (..count..)/sum(..count..))` which automatically converts the counts to percentages. The "(..count..)/sum(..count..))" stuff is just taking each group and dividing it from the sum of all groups. You could, of course, do this yourself before making the graph, but it's an easy helper. If you do this, make sure to relabel the y-axis so you don't accidentally call the percent a count!


```r
ggplot(shootings, aes(x = age)) + 
  geom_histogram(aes(y = (..count..)/sum(..count..)))
#> `stat_bin()` using `bins = 30`. Pick better value with
#> `binwidth`.
#> Warning: Removed 182 rows containing non-finite values
#> (stat_bin).
```

<img src="graphing-2_files/figure-html/unnamed-chunk-17-1.png" width="90%" style="display: block; margin: auto;" />

### Density plot

Density plots are essentially smoothed versions of histograms. They're especially useful for numeric variables which are not integers (integers are whole numbers). They're also useful when you want to be more precise than a histogram as they are - to simplify - histograms where each bar is very narrow. Note that the y-axis of a density plot is automatically labeled "density" and has very small numbers. Interpreting the y-axis is fairly hard to explain to someone not familiar with statistics so I'd caution against using this graph unless your audience is already familiar with it. To interpret these kinds of graphs, I recommend looking for trends rather than trying to identify specific points. For example, in the below graph we can see that shootings rise rapidly starting around age 10, peak at around age 30 (if we were presenting this graph to other people we'd probably want more ages shown on the x-axis), and then steadily decline until about age 80 where it's nearly flat.   


```r
ggplot(shootings, aes(x = age)) + 
  geom_density()
#> Warning: Removed 182 rows containing non-finite values
#> (stat_density).
```

<img src="graphing-2_files/figure-html/unnamed-chunk-18-1.png" width="90%" style="display: block; margin: auto;" />

### Count Graph

A count graph is essentially a histogram with a bar for every value in the numeric variable - like a less-smooth density plot. Note that this won't work well if you have too many unique values so I'd strongly recommend rounding the data to the nearest whole number first. Our age variable is already rounded so we don't need to do that. To make a count graph, we add `stat_count()` to the `ggplot()`. 


```r
ggplot(shootings, aes(x = age)) + 
  stat_count()
#> Warning: Removed 182 rows containing non-finite values
#> (stat_count).
```

<img src="graphing-2_files/figure-html/unnamed-chunk-19-1.png" width="90%" style="display: block; margin: auto;" />
Now we have a single bar for every age in the data. Like the histogram, the y-axis shows the number of people that are that age. And like the histogram, we can change this from number of people to percent of people using the exact same code.


```r
ggplot(shootings, aes(x = age)) + 
  stat_count(aes(y = (..count..)/sum(..count..)))
#> Warning: Removed 182 rows containing non-finite values
#> (stat_count).
```

<img src="graphing-2_files/figure-html/unnamed-chunk-20-1.png" width="90%" style="display: block; margin: auto;" />

### Graphing a Categorical Variable 

## Bar graph

To make this barplot we'll set the x-axis variable to our "race" column and add `geom_bar()` to the end. 


```r
ggplot(shootings, aes(x = race)) + 
  geom_bar()
```

<img src="graphing-2_files/figure-html/unnamed-chunk-21-1.png" width="90%" style="display: block; margin: auto;" />
This gives us a barplot in alphabetical order. In most cases we want the data sorted by frequency, so we can easily see what value is the most common, second most common, etc. There are a few ways to do this but we'll do this by turning the "race" variable into a factor and ordering it by frequency. We can do that using the `factor()` function. The first input will be the "race" variable and then we will need to set the `levels` parameter to a vector of values sorted by frequency. An easy way to know how often values are in a column is to use the `table()` function on that column, such as below.


```r
table(shootings$race)
#> 
#>    A    B    H    N    O    W 
#>   71 1001  719   64   38 1962
```

It's still alphabetical so let's wrap that in a `sort()` function. 


```r
sort(table(shootings$race))
#> 
#>    O    N    A    H    B    W 
#>   38   64   71  719 1001 1962
```

It's sorted from smallest to largest. We usually want to graph from largest to smallest so let's set the parameter `decreasing` in `sort()` to TRUE.


```r
sort(table(shootings$race), decreasing = TRUE)
#> 
#>    W    B    H    A    N    O 
#> 1962 1001  719   71   64   38
```

Now, we only need the names of each value, not how often they occur. So we can against wrap this whole thing in `names()` to get just the names.


```r
names(sort(table(shootings$race), decreasing = TRUE))
#> [1] "W" "B" "H" "A" "N" "O"
```

If we tie it all together, we can make the "race" column into a factor variable.


```r
shootings$race <- factor(shootings$race,
                         levels = names(sort(table(shootings$race), decreasing = TRUE)))
```

Now let's try that barplot again.


```r
ggplot(shootings, aes(x = race)) + 
  geom_bar() 
```

<img src="graphing-2_files/figure-html/unnamed-chunk-27-1.png" width="90%" style="display: block; margin: auto;" />
It works! Note that all the values that are missing in our data are still reported in the barplot under a column called "NA". This is not sorted properly since there are more NA values than three of the other values but is still at the far right of the graph. We can change this if we want to make all the NA values an actual character type and call it something like "Unknown". But this way it does draw attention to how many values are missing from this column. Like most things in graphing, this is a personal choice as to what to do.

For bar graphs it is often useful to flip the graph so each value is a row in the graph rather than a column. This also makes it much easier to read the value name. If the value names are long, it'll shrink the graph to accommodate the name. This is usually a sign that you should try to shorten the name to avoid reducing the size of the graph. 


```r
ggplot(shootings, aes(x = race)) + 
  geom_bar() +
  coord_flip() 
```

<img src="graphing-2_files/figure-html/unnamed-chunk-28-1.png" width="90%" style="display: block; margin: auto;" />
Since it's flipped, now it's sorted from smallest to largest. So we'll need to change the `factor()` code to fix that.


```r
shootings$race <- factor(shootings$race,
                         levels = names(sort(table(shootings$race), decreasing = FALSE)))
ggplot(shootings, aes(x = race)) + 
  geom_bar() +
  coord_flip() 
```

<img src="graphing-2_files/figure-html/unnamed-chunk-29-1.png" width="90%" style="display: block; margin: auto;" />
The NA value is now at the top, which looks fairly bad. Let's change all NA values to the string "Unknown". And while we're at it, let's change all the abbreviated race values to actual names. We can get all the NA values by using `is.na(shootings$race)` and using a conditional statement to get all rows that meet that condition, then assign them the value "Unknown". Instead of trying to subset a factor variable to change the values, we should convert it back to a character type first using `as.character()`, and then convert it to a factor again once we're done. 


```r
shootings$race <- as.character(shootings$race)
shootings$race[is.na(shootings$race)] <- "Unknown"
```

Now we can use conditional statements to change all the race letters to names. It's not clear what race "O" and "N" are so I checked the [Washington Post's GitHub page](https://github.com/washingtonpost/data-police-shootings) which explains. Instead of `is.na()` we'll use `shootings$race == ""` where we put the letter inside of the quotes.


```r
shootings$race[shootings$race == "O"] <- "Other"
shootings$race[shootings$race == "N"] <- "Native American"
shootings$race[shootings$race == "A"] <- "Asian"
shootings$race[shootings$race == "H"] <- "Hispanic"
shootings$race[shootings$race == "B"] <- "Black"
shootings$race[shootings$race == "W"] <- "White"
```

Now let's see how our graph looks. We'll need to rerun the `factor()` code since now all of the values are changed.


```r
shootings$race <- factor(shootings$race,
                         levels = names(sort(table(shootings$race), decreasing = FALSE)))
ggplot(shootings, aes(x = race)) + 
  geom_bar() +
  coord_flip() 
```

<img src="graphing-2_files/figure-html/unnamed-chunk-32-1.png" width="90%" style="display: block; margin: auto;" />
As earlier, we can show percentage instead of count by adding `y = (..count..)/sum(..count..)` to the `aes()` in `geom_bar()`.


```r
ggplot(shootings, aes(x = race)) + 
  geom_bar(aes(y = (..count..)/sum(..count..))) +
  coord_flip() 
```

<img src="graphing-2_files/figure-html/unnamed-chunk-33-1.png" width="90%" style="display: block; margin: auto;" />

## Graphing Data Over Time

We went over time-series graphs in Chapter \@ref(graphing-intro) but it's such an important topic we'll cover it again. A lot of criminology research is seeing if a policy had an effect, which means we generally want to compare an outcome over time (and compare the treated group to a similar untreated group). To graph that we look at an outcome, in this case numbers of killings, over time. In our case we aren't evaluating any policy, just seeing if the number of police killings change over time. 

We'll need to make a variable to indicate that the row is for one shooting. We can call this "dummy" and assign it a value of 1. Then we can make the `ggplot()` and set this "dummy" column to the y-axis value and set our date variable "date" to the x-axis (the time variable is **always** on the x-axis). Then we'll set the type of plot to `geom_line()` so we have a line graph showing killings over time.


```r
shootings$dummy <- 1
ggplot(shootings, aes(x = date, y = dummy)) +
  geom_line()
```

<img src="graphing-2_files/figure-html/unnamed-chunk-34-1.png" width="90%" style="display: block; margin: auto;" />
This graph is clearly wrong. Why? Well, our y-axis variable is always 1 so there's no variation to plot. Every single value, even if there are more than one shooting per day, is on the 1 line on the y-axis. And the fact that we have multiple killings per day is an issue because we only want a single line in our graph. We'll need to aggregate our data to some time period (e.g. day, month, year) so that we have one row per time-period and know how many people were killed in that period. We'll start with yearly data and then move to monthly data. Since we're going to be dealing with dates, lets load the `lubridate()` package that is well-suited for this task. 


```r
library(lubridate)
#> 
#> Attaching package: 'lubridate'
#> The following objects are masked from 'package:base':
#> 
#>     date, intersect, setdiff, union
```

We'll use two functions to create variables that tell us the month and the year of each date in our data. We'll use these new variables to aggregate our data to that time unit. First, the `floor_date()` function is a very useful tool that essentially rounds a date. Here we have the exact date the killing happened on, and we want to determine what month that date is from. So we'll use the parameter `unit` in `floor_date()` and tell the function we want to know the "month" (for a full set of options please see the documentation for `floor_date()` by entering `?floor_date` in the console). So we can do `floor_date(shootings$date, unit = "month")` to get the month - specifically, it returns the date that is the first of the month for that month - the killing happened on. Even simpler, to get the year, we simple use `year()` and put our "date" variable in the parentheses. We'll call the new variables "month_year" and "year", respectively.


```r
shootings$month_year <- floor_date(shootings$date, unit = "month")
shootings$year <- year(shootings$date)

head(shootings$month_year)
#> [1] "2015-01-01" "2015-01-01" "2015-01-01" "2015-01-01"
#> [5] "2015-01-01" "2015-01-01"
head(shootings$year)
#> [1] 2015 2015 2015 2015 2015 2015
```

Since the data is already sorted by date, all the values printed from `head()` are the same. But you can look at the data using `View()` to confirm that the code worked properly. 

We can now aggregate the data by the "month_year" variable and save the result into a new dataset we'll call *monthly_shootings*. We'll use the `group_by()` and `summarize()` functions from `dplyr` that were introduced in Chapter \@ref(#explore) to do this. And we'll use the pipe method of writing `dplyr` code that was discussed in Section \@ref(#dplyr-pipes)


```r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
monthly_shootings <- shootings %>% group_by(month_year) %>% summarize(dummy = sum(dummy))
head(monthly_shootings)
#> # A tibble: 6 x 2
#>   month_year dummy
#>   <date>     <dbl>
#> 1 2015-01-01    76
#> 2 2015-02-01    77
#> 3 2015-03-01    92
#> 4 2015-04-01    84
#> 5 2015-05-01    71
#> 6 2015-06-01    65
```

Since we now have a variable that shows for each month the number of people killed, we can graph this new dataset. We'll use the same process as earlier but our dataset is now `monthly_shootings` instead of `shootings` and the x-axis variable is "month_year" instead of "date".


```r
ggplot(monthly_shootings, aes(x = month_year, y = dummy)) +
  geom_line()
```

<img src="graphing-2_files/figure-html/unnamed-chunk-38-1.png" width="90%" style="display: block; margin: auto;" />
The process is the same for yearly data.


```r
yearly_shootings <- shootings %>% group_by(year) %>% summarize(dummy = sum(dummy))
ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line()
```

<img src="graphing-2_files/figure-html/unnamed-chunk-39-1.png" width="90%" style="display: block; margin: auto;" />

Note the steep drop-off at the end of each graph. Is that due to fewer shooting occurring more recently? No, it's simply an artifact of the graph comparing whole months (years) to parts of a month (year) since we haven't finished this month (year) yet (and the data has a small lag in reporting). 

## Pretty Graphs

What's next for these graphs? You'll likely want to add labels for the axes and the title. We went over how to do this in Section \@ref(time-series-plots) so please refer to that for more info. Also, check out `ggplot2`'s [website](https://ggplot2.tidyverse.org/reference/index.html#section-scales) to see more on this very versatile package. As I've said all chapter, a lot of this is going to be personal taste so please spend some time exploring the package and changing the appearance of the graph to learn what looks right to you. 

### Themes

In addition to making changes to the graph's appearance yourself, you can use a theme that someone else made. A theme is just a collection of changes to the graph's appearance that someone put in a function for others to use. Each theme is different and is fairly opinionated, so you should only use one that you think looks best for your graph. To use a theme, simply add the theme (exactly as spelled on the site) to your ggplot using the + as normal (and make sure to include the () since each theme is actually a function. `ggplot2` comes with a series of themes that you can look at [here](https://ggplot2.tidyverse.org/reference/ggtheme.html). Here, we'll be looking at themes from the `ggthemes` package which is a great source of different themes to modify the appearance of your graph. Check out this [website](https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/) to see a depiction of all of the possible themes. If you don't have the `ggthemes` package installed, do so using `install.packages("ggthemes"). 

Let's do a few examples using the graph made above. First, we'll need to load the `ggthemes` library.


```r
library(ggthemes)
ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line() +
  theme_fivethirtyeight()
```

<img src="graphing-2_files/figure-html/unnamed-chunk-40-1.png" width="90%" style="display: block; margin: auto;" />



```r
ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line() +
  theme_tufte()
```

<img src="graphing-2_files/figure-html/unnamed-chunk-41-1.png" width="90%" style="display: block; margin: auto;" />



```r
ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line() +
  theme_few()
```

<img src="graphing-2_files/figure-html/unnamed-chunk-42-1.png" width="90%" style="display: block; margin: auto;" />



```r
ggplot(yearly_shootings, aes(x = year, y = dummy)) +
  geom_line() +
  theme_excel()
```

<img src="graphing-2_files/figure-html/unnamed-chunk-43-1.png" width="90%" style="display: block; margin: auto;" />
