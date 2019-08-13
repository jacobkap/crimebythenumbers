
# Introduction to R

## Why learn to program?

With the exception of some more advanced techniques like scraping data from websites or from PDFs, nearly everything we do here can be done through Excel, a software you're probably more familiar with. The basic steps for research projects are generally 

1. Open up a data set - which frequently comes as an Excel file!
2. Change some values - misspelling or too specific categories are very common in crime data
3. Delete some values - such as states you won't be studying
4. Make some graphs
5. Calculate some values - such as number of crimes per year
6. Sometimes do a statistical analysis depending on type of project
7. Write up what you find 


R can do all of this but why should you want to (or have to) learn a entirely new skill just to do something you can already do. R is useful for two main reasons: scale and reproducibility.

### Scale

### Reproducibility

The second major benefit of using R over something like Excel is that R is reproducible. Every action you take is written down in the code 



As a common example in criminology, in comparing crime between two cities you generally don't want to compare counts due to population differences. A city with a million people often has more crime than a city with 50,000 people just due to the size difference. So you'd want to compare rates of crime per population (usually per 100,000 people). To do this you just divide the count by the city's population and multiple the result by 100,000. 

This concept - doing the same thing to multiple values - is important in R and will come in handy later. Imagine that we had an Excel file where a column shows the number of crimes in a given city (each row is a new city). Using the method above we can find the average number of crimes (or any other mathematical operation) easily by treating that column as the values in the `c()` above.


Yet, other functions operate on the whole collection of values in a vector. For each of these functions you will need to put the vector inside the parentheses of the main function. See the following examples:

  + `sum()` Sum
  + `mean()` Mean of the vector
  + `median()` Median of the vector
  + `length()` How many values there are in the vector


```r
sum(c(1, 10, 3, 6, 2, 5, 8, 4, 7, 9)) 
#> [1] 55
```


```r
mean(c(1, 10, 3, 6, 2, 5, 8, 4, 7, 9))
#> [1] 5.5
```


```r
median(c(1, 10, 3, 6, 2, 5, 8, 4, 7, 9)) 
#> [1] 5.5
```


```r
length(c(1, 10, 3, 6, 2, 5, 8, 4, 7, 9))
#> [1] 10
```

There are also some functions in R that help us find the biggest and smallest values. For example:

  + `max()` What is the biggest value in vector?
  + `which.max()` In which "spot" (or "index") would we find it? This will be useful for the lesson on subsetting which is a way to grab only specific rows or columns (such as the row with the largest value)
  + `min()` What is the smallest value in vector?
  + `which.min()` In which "spot" would we find it?


```r
max(c(1, 10, 3, 6, 2, 5, 8, 4, 7, 9)) 
#> [1] 10
```


```r
which.max(c(1, 10, 3, 6, 2, 5, 8, 4, 7, 9))
#> [1] 2
```


```r
min(c(1, 10, 3, 6, 2, 5, 8, 4, 7, 9))
#> [1] 1
```


```r
which.min(c(1, 10, 3, 6, 2, 5, 8, 4, 7, 9))
#> [1] 1
```

The `paste()` function pastes character strings together. By default, `paste()` puts a space between the strings being pasted together. It looks strange with that space after WV in "WV , USA". We can set the separator to be nothing (the empty string) by setting `sep = ""`. Remember that you need a comma before starting a new parameter. 

Being able to sort or manipulate strings/character values (i.e. not numbers) is important in research. When dealing with real crime data you'll find that there are often spelling issues where categories are slightly different (e.g. 'assault' 'asault' 'asslt') that you need to make consistent for an analysis. You will also likely want to grab only rows where the data is a certain crime, such as all assaults, which is something we'll learn later. 


## Reading data into R

In nearly every case in research you'll have data produced by some outside group (FBI, local police agencies) and you want to take that data and put it inside R to work on it. We call that reading data into R. R is capable of reading a number of different formats of data which we will discuss in a later chapter. Here, we will talk about the standard R data file only. 

### Setting the working directory

Now that we have covered a lot of fundamental R features, it is time to load in a real data set. However, before we do that, R needs to know where to find the data file. So we first need to talk about "the working directory". When you start R, it has a default folder or directory on your computer where it will retrieve or save any files. You can run `getwd()` to get the current working directory. Here's our current working directory, which will not be the same as yours.


```r
getwd()    
[1] "C:/Users/user/Dropbox/R_project/r4crim"
```

Almost certainly this default directory is *not* where you plan to have all of your data sets and files stored. Instead, you probably have an "analysis" or "project" or "R4crim" folder somewhere on your computer where you would like to store your data and work (you should also store the R files you write for that data to keep the data and code for that data together).

Use `setwd()` to tell R what folder you want it to use as the working directory. If you do not set the working directory, R will not know where to find the data you wish to import and will be unable to read the data. Make it a habit to have `setwd()` as the first line of every script you write. If you know the working directory you want to use, then you can just put it inside the `setwd()` function.

```
setwd("C:/Users/user/Dropbox/R_project/R4crim/data")    
```

If you do not know how to write your working directory, here comes R Studio to the rescue. In R Studio click Session -> Set Working Directory -> Choose Directory. Then click through to navigate to the working directory that you want to use. When you find it click "Select Folder". Then look over at the console. R Studio will construct the right `setwd()` syntax for you. Copy and paste that into your R script for use later. No need to have to click through the Session menu again now that you have your `setwd()` set up.

![](images/working_directory.PNG)

Now you can use R functions to load in any data sets that are in your working folder. If you have done your `setwd()` correctly, you shouldn't get any errors because R will know exactly where to look for the data files. If the working directory that you've given in the `setwd()` isn't right, R will think the file doesn't even exist. For example, if you give the path for, say, your R4econ folder, R won't be able to load data because the file isn't stored in what R thinks is your working directory. With that out of the way, let's load a data set.

### Loading data

The `load()` function lets us load data already in the R format. These files will end in the extension ".rda" or sometimes ".Rda" or ".RData". Since we are telling R to load a specific file we need to have that file name in quotes and include the file extension ".rda". With R data, the object inside the data already has a name so we don't need to assign (using the `<-` we learned above) a name to the data. With other forms of data such as .csv files we will need to do that as we'll see in Chapter \ref(Reading and Writing Data). 


```r
load("data/ucr2017.rda")
```

## First steps to exploring data

The object we loaded is called `ucr2017`. We'll explore this data more thoroughly in the Chapter \ref(exploratory-data-analysis) but for now let's use four simple (and important) functions to get a sense of what the data holds. For each of these functions write the name of the data set (without quotes since we don't need quotes for an object already made in R) inside the (). 

`head()`
`summary()`
`plot()`
`View()`

Note that the first three functions are lowercase while `View()` is capitalized. That is simply because older functions in R were often capitalized while newer ones use all lowercase letters. R is case sensitive so using `view()` will not work. 

The `head()` function prints the first 6 rows of each column out in the console. This is useful to get a quick glance at the data but has some important drawbacks. When using data sets with a large number of columns it can be quickly overwhelming by printing too much. There may also be differences in the first 6 rows with other rows. For example if the rows are ordered chronologically (as is the case with most crime data) the first 6 rows will be the most recent. If data collection methods or the quality of collection changed over time, these 6 rows won't be representative of the data.  


```r
head(ucr2017)
#>       ori year agency_name  state population actual_murder
#> 1 AK00101 2017   anchorage alaska     296188            27
#> 2 AK00102 2017   fairbanks alaska      32937            10
#> 3 AK00103 2017      juneau alaska      32344             1
#> 4 AK00104 2017   ketchikan alaska       8230             1
#> 5 AK00105 2017      kodiak alaska       6198             0
#> 6 AK00106 2017        nome alaska       3829             0
#>   actual_rape_total actual_robbery_total actual_assault_aggravated
#> 1               391                  778                      2368
#> 2                24                   40                       131
#> 3                50                   46                       206
#> 4                19                    0                        14
#> 5                15                    4                        41
#> 6                 7                    0                        52
```

The `summary()` function gives a six number summary of each numeric or Date column in the data. For other types of data, such as "character" types which are just columns with words rather than numbers, it'll say what type of data it is.

The six values it returns for numeric and Date columns are

  + The minimum value
  + The value at the 1st quartile
  + The median value
  + The mean value
  + The value at the 3rd quartile
  + The max value
  + In cases where there are NAs, it will say how many NAs there are. An NA value is a missing value. Think of it like an empty cell in an Excel file. NA values will cause issues when doing math such as finding the mean of a column as R doesn't know how to handle a NA value in these situations. We'll learn how to deal with this later.


```r
summary(ucr2017)
#>      ori                 year      agency_name           state          
#>  Length:15764       Min.   :2017   Length:15764       Length:15764      
#>  Class :character   1st Qu.:2017   Class :character   Class :character  
#>  Mode  :character   Median :2017   Mode  :character   Mode  :character  
#>                     Mean   :2017                                        
#>                     3rd Qu.:2017                                        
#>                     Max.   :2017                                        
#>    population      actual_murder     actual_rape_total 
#>  Min.   :      0   Min.   :  0.000   Min.   :  -2.000  
#>  1st Qu.:    914   1st Qu.:  0.000   1st Qu.:   0.000  
#>  Median :   4460   Median :  0.000   Median :   1.000  
#>  Mean   :  19872   Mean   :  1.069   Mean   :   8.262  
#>  3rd Qu.:  15390   3rd Qu.:  0.000   3rd Qu.:   5.000  
#>  Max.   :8616333   Max.   :653.000   Max.   :2455.000  
#>  actual_robbery_total actual_assault_aggravated
#>  Min.   :   -1.00     Min.   :   -1.00         
#>  1st Qu.:    0.00     1st Qu.:    1.00         
#>  Median :    0.00     Median :    5.00         
#>  Mean   :   19.85     Mean   :   49.98         
#>  3rd Qu.:    4.00     3rd Qu.:   21.00         
#>  Max.   :13995.00     Max.   :29771.00
```

The `plot()` function allows us to graph our data. For criminology research we generally want to make scatterplots to show the relationship between two numeric variables, time-series graphs to see how a variable (or variables) change over time, or barplots comparing categorical variables. Here we'll make a scatterplot seeing the relationship between a city's number of murders and their number of aggravated assault (assault with a weapon or that causes serious bodily injury).

To do so we must specify which column is displayed on the x-axis and which one is displayed on the y-axis. In Chapter \ref(Select a specific column) we'll talk explicitly about how to select specific columns from our data. For now all you need to know is to select a column you write the data set name followed by dollar sign `$` followed by the column name. Do not include any quotations or spaces (technically spaces can be included but make it a bit harder to read and are against conventional style when writing R code so we'll exclude them). Inside of `plot()` we say that "x = ucr2017\$actual_murder" so that column goes on the x-axis and "y = ucr2017\$actual_assault_aggravated" so aggravated assault goes on the y-axis. And that's all it takes to make a simple graph. 


```r
plot(x = ucr2017$actual_murder, y = ucr2017$actual_assault_aggravated)
```

<img src="intro-to-r_files/figure-html/unnamed-chunk-14-1.png" width="90%" style="display: block; margin: auto;" />

Finally, `View()` opens essentially an Excel file of the data set you put inside the (). This allows you to look at the data as if it were in Excel and is a good way to start to understand the data. 


```r
View(ucr2017)
```

## Finding help about functions

If you are having trouble understanding what a function does, you can ask R for help and it will open up a page explaining what the function does, what options it has, and examples of how to use it. To do so we write `help(function)` or `?function` in the console and it will open up that function's help page. 

If we wrote `help(c)` to figure out what the `c()` function does, it will open up this page. For finding the help page of a function the parentheses (e.g. `c()`) are optional.

![](images/help_page.PNG)
