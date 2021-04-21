# Reading and Writing Data




So far in these lessons we've used data from a number of sources but which all came as .rda files which is the standard R data format. Many data sets, particularly older government data, will not come as .rda file but rather as Excel, Stata, SAS, SPSS, or fixed-width ASCII files. In this brief lesson we'll cover how to read these formats into R as well as how to save data into these formats. Since many criminologists do not use R, it is important to be able to save the data in the language they use to be able to collaborate with them. 

Fixed-width ASCII files are not very common and require a bit more effort than the other formats so we'll leave those until later to discuss.

In this lesson we'll use data about officer-involved shootings. 

## Reading Data into R

### R 

As we've seen earlier, to read in data with a .rda or .rdata extension you use the function `load()` with the file name (including the extension) in quotation marks inside of the parentheses. This loads the data into R and calls the object the name it was when it was saved. Therefore we do not need to give it a name ourselves.

For each of the other types of data we'll need to assign a name to the data we're reading in so it has a name. Whereas we've done `x <- 2` to say *x* gets the value of 2, now we'd do `x <- DATA` where DATA is the way to load in the data and *x* will get the entire data.frame that is read in. 

### Excel 

To read in Excel files, those ending in .csv, we can use the function `read_csv()` from the package `readr` (the function `read.csv()` is included in R by default so it doesn't require any packages but is far slower than `read_csv()` so we will not use it).


```r
install.packages("readr")
```


```r
library(readr)
```

The input in the () is the file name ending in ".csv". As it is telling R to read a file that is stored on your computer, the whole name must be in quotes. Unlike loading an .rda file using `load()`, there is no name for the object that gets read in so we must assign the data a name. We can use the name *shootings* as it's relatively descriptive and easy for us to write. 


```r
shootings <- read_csv("data/fatal-police-shootings-data.csv")
#> 
#> -- Column specification --------------------------------
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
#>      id name     date       manner_of_death armed    age
#>   <dbl> <chr>    <date>     <chr>           <chr>  <dbl>
#> 1     3 Tim Ell~ 2015-01-02 shot            gun       53
#> 2     4 Lewis L~ 2015-01-02 shot            gun       47
#> 3     5 John Pa~ 2015-01-03 shot and Taser~ unarm~    23
#> 4     8 Matthew~ 2015-01-04 shot            toy w~    32
#> 5     9 Michael~ 2015-01-04 shot            nail ~    39
#> 6    11 Kenneth~ 2015-01-04 shot            gun       18
#> # ... with 8 more variables: gender <chr>, race <chr>,
#> #   city <chr>, state <chr>,
#> #   signs_of_mental_illness <lgl>, threat_level <chr>,
#> #   flee <chr>, body_camera <lgl>
```

We can convert it to a data.frame using the function `as.data.frame()` though that isn't strictly necessary since tibbles and data.frames operate so similarly.


```r
shootings <- as.data.frame(shootings)
```

### Stata 

For the remaining three data types we'll use the package `haven`.


```r
install.packages("haven")
```


```r
library(haven)
```

`haven` follows the same syntax for each data type and is the same as with `read_csv()` - for each data type we simply include the file name (in quotes, with the extension) and designate an name to be assigned the data.

Like with `read_csv()` the functions to read data through `haven` all start with `read_` and end with the extension you're reading in. 

  * `read_dta()` - Stata file, extension "dta"
  * `read_sas()` - SAS file, extension "sas"
  * `read_sav()` - SPSS file, extension "sav"
  
To read the data as a .dta format we can copy the code to read it as a .csv but change .csv to .dta.


```r
shootings <- read_dta("data/fatal-police-shootings-data.dta")
```

Since we called this new data *shootings*, R overwrote that object (without warning us!). This is useful because we often want to subset or aggregate data and call it by the same name to avoid making too many objects to keep track of, but watch out for accidentally overwriting an object without noticing! 

### SAS 


```r
shootings <- read_sas("data/fatal-police-shootings-data.sas")
```

### SPSS


```r
shootings <- read_sav("data/fatal-police-shootings-data.sav")
```

## Writing Data 

When we're done with a project (or an important part of a project) or when we need to send data to someone, we need to save the data we've worked on in a suitable format. For each format, we are saving the data in we will follow the same syntax of 

`function_name(data, "file_name")`

As usual we start with the function name. Then inside the parentheses we have the name of the object we are saving (as it refers to an object in R, we do not use quotations) and then the file name, in quotes, ending with the extension you want. 

For saving an .rda file we use the `save()` function, otherwise we follow the syntax of `write_` ending with the file extension. 

  * `write_csv()` - Excel file, extension "csv"
  * `write_dta()` - Stata file, extension "dta"
  * `write_sas()` - SAS file, extension "sas"
  * `write_sav()` - SPSS file, extension "sav"

As with reading the data, `write_csv()` comes from the `readr` package while the other formats are from the `haven` package. 

### R 

For saving an .rda file we must set the parameter `file` to be the name we're saving. For the other types of data they use the parameter `path` rather than `file` but it is not necessary to call them explicitly.


```r
save(shootings, file =  "data/shootings.rda")
```

### Excel 


```r
write_csv(shootings, "data/shootings.csv")
```

### Stata 


```r
write_dta(shootings, "data/shootings.dta")
```

### SAS 


```r
write_sas(shootings, "data/shootings.sas")
```

### SPSS


```r
write_sav(shootings, "data/shootings.sav")
```

