# Reading and writing Data

For this chapter you'll need the following files, which are available for download [here](https://github.com/jacobkap/r4crimz/tree/master/data): fatal-police-shootings-data.csv, fatal-police-shootings-data.dta, fatal-police-shootings-data.sas, fatal-police-shootings-data.sav, sqf-2019.xlsx, sf_neighborhoods_suicide.rda, and shr_1976_2020.rds.

So far in these lessons we've used data from a number of sources but which all came as .rda or .rds files which are the standard R data formats. Many data sets, particularly older government data, will not come as .rda file but rather as Excel, Stata, SAS, SPSS, or fixed-width ASCII files. In this brief lesson we'll cover how to read these formats into R as well as how to save data into these formats. Since many criminologists do not use R, it is important to be able to save the data in the language they use to be able to collaborate with them. 

In this lesson we'll load and save multiple files into R as examples of how R can handle data that is used in many different software programs. 

When loading data into R remember that your data must be in your current working directory or R won't be able to read it. For a refresher on working directories please see Section \@ref(working-directory). In these examples I have my data in a folder called "data" that is in my working directory, which is why I use "data/" when naming the file. You do not need to include "data/" when loading in data on your computer. 

## Reading Data into R

### R 

#### .rda and .rdata files

As we've seen earlier, to read in data with a .rda or .rdata extension you use the function `load()` with the file name (including the extension) in quotation marks inside of the parentheses. This loads the data into R and calls the object the name it was when it was saved. Therefore we do not need to give it a name ourselves.

Below, we're loading the "sf_neighborhoods_suicide.rda" file and it creates an object in R (which we can look at in the Environment tab) called "sf_neighborhoods_suicide". It has the same name only because when I originally saved the file I saved it using the same name as it was called in R. But in practice I could have called it whatever I wanted. So it being the same name is convenient, as it is clear what the data is, but not necessary.


```r
load("data/sf_neighborhoods_suicide.rda")
```

#### .rds files

For each of the other types of data we'll need to assign a name to the data we're reading in. Whereas we've done `x <- 2` to say *x* gets the value of 2, now we'd do `x <- DATA` where DATA is the way to load in the data and *x* will get the entire data set that is read in. 

This includes the other kind of R data file, the .rds file. Here, we must explicitly name the data - there is no name by default like in a .rda or a .rdata file. We can load .rds files into R using the `readRDS()` which is built into R so we don't need any package to use it. Like in `load()`, we just put the name of the file (in quotes) in the parentheses. Here we're naming it "rds_example" but we can name it whatever we like.


```r
rds_example <- readRDS("data/shr_1976_2020.rds") 
```

### Excel 

To read in Excel files that end in .csv, we can use the function `read_csv()` from the package `readr` (the function `read.csv()` is included in R by default so it doesn't require any packages but is far slower than `read_csv()` so we will not use it).


```r
install.packages("readr")
```


```r
library(readr)
```

The input in the () is the file name ending in ".csv". As it is telling R to read a file that is stored on your computer, the whole name must be in quotes. Unlike loading an .rda file using `load()`, there is no name for the object that gets read in so we must assign the data a name. We can use the name *shootings* as it's relatively descriptive for what this data is and it is easy for us to write. 


```r
shootings <- read_csv("data/fatal-police-shootings-data.csv")
#> Rows: 4371 Columns: 14
#> -- Column specification ----------------------------------------------
#> Delimiter: ","
#> chr  (9): name, manner_of_death, armed, gender, race, city, state,...
#> dbl  (2): id, age
#> lgl  (2): signs_of_mental_illness, body_camera
#> date (1): date
#> 
#> i Use `spec()` to retrieve the full column specification for this data.
#> i Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

`read_csv()` also reads in data to an object called a `tibble` which is very similar to a data.frame but has some differences in displaying the data. If we run `head()` on the data it doesn't show all columns. This is useful to avoid accidentally printing out a massive amounts of columns.


```r
head(shootings)
#> # A tibble: 6 x 14
#>      id name      date       manner_of_death armed    age gender race 
#>   <dbl> <chr>     <date>     <chr>           <chr>  <dbl> <chr>  <chr>
#> 1     3 Tim Elli~ 2015-01-02 shot            gun       53 M      A    
#> 2     4 Lewis Le~ 2015-01-02 shot            gun       47 M      W    
#> 3     5 John Pau~ 2015-01-03 shot and Taser~ unarm~    23 M      H    
#> 4     8 Matthew ~ 2015-01-04 shot            toy w~    32 M      W    
#> 5     9 Michael ~ 2015-01-04 shot            nail ~    39 M      H    
#> 6    11 Kenneth ~ 2015-01-04 shot            gun       18 M      W    
#> # ... with 6 more variables: city <chr>, state <chr>,
#> #   signs_of_mental_illness <lgl>, threat_level <chr>, flee <chr>,
#> #   body_camera <lgl>
```

We can convert it to a data.frame using the function `as.data.frame()` though that isn't strictly necessary since tibbles and data.frames operate so similarly.


```r
shootings <- as.data.frame(shootings)
```

To read in Excel files that end in .xls or .xlsx, we need to use the `readxl` package and use the `read_excel()` function. We'll read in data on stop, question, and frisks in New York City.


```r
install.packages("readxl")
```


```r
library(readxl)
```


```r
sqf <- read_excel("data/sqf-2019.xlsx")
```

### Stata 

For the next three files, we'll use the package `haven`.


```r
install.packages("haven")
```


```r
library(haven)
```

`haven` follows the same syntax for each data type and is the same as with `read_csv()` - for each data type we simply include the file name (in quotes, with the extension) and designate an name to be assigned the data.

Like with `read_csv()` the functions to read data through `haven` all start with `read_` and end with the extension you're reading in. 

  * `read_dta()` - Stata file, extension ".dta"
  * `read_sas()` - SAS file, extension ".sas"
  * `read_sav()` - SPSS file, extension ".sav"
  
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

### Fixed-width ASCII

The final type of data source we'll talk about is a fixed-width ASCII. An ASCII file is just a text file and the fixed-width part means that each row has the exact same number of characters. This is a very old file format system that hopefully you'll never encounter but is one that some government agencies - including the FBI for their annual data releases (though some individuals and organizations re-release the data in better formats like R and Stata files) - still use, so is good to know to how handle. A fixed-width ASCII file is essentially an Excel file but with all of the columns smushed together. It also tries to reduce its file size by replacing long strings of text with short ones. For example, instead of including a state name it'll usually have a number - as a number has fewer characters than an entire name, the file is therefore smaller. 

Each fixed-width ASCII file also comes with what is called a "setup" file which is some code that tells the program you're reading the data into how to separate columns and when to replace the (in our example) numbers that indicate the state with the actual state name. In nearly all cases where you have a fixed-width ASCII you'll also be able to download the setup file from the same source, so I won't cover how to make a setup file yourself.

To read fixed-width ASCII files into R we'll use the `asciiSetupReader` package which I created myself for this very purpose. For more information on this package including details on all of the different options in the function, please see the package's site [here](https://jacobkap.github.io/asciiSetupReader/).


```r
install.packages("asciiSetupReader")
```

We'll use the `read_ascii_setup()` function which takes two mandatory inputs in the parentheses: the name of the data file (which will have a file name ending in .txt or .dat) and the name of the setup file (which will have a file name ending is .sps or .sas). Each of these file names must be in your current working directory and you must put the names in quotes. For this example the data file is the 2020 FBI Supplementary Homicide Report data (their murder dataset) which is called "2020_SHR_NATIONAL_MASTER_FILE.txt" and the setup file is one that I wrote myself and is called "ucr_shr.sps". We can name the object we read "shr".


```r
library(asciiSetupReader)
shr <- read_ascii_setup("data/2020_SHR_NATIONAL_MASTER_FILE.txt", "data/ucr_shr.sps")
```

## Writing Data 

When we're done with a project (or an important part of a project) or when we need to send data to someone, we need to save the data we've worked on in a suitable format. For each format, we are saving the data in we will follow the same syntax of 

`function_name(data, "file_name")`

As usual we start with the function name. Then inside the parentheses we have the name of the object we are saving (as it refers to an object in R, we do not use quotations) and then the file name, in quotes, ending with the extension you want. 

For saving an .rda or .rdata file we use the `save()` function. For saving a .rds file we use the `saveRDS()` function. Otherwise we follow the syntax of `write_` ending with the file extension. 

  * `write_csv()` - Excel file, extension ".csv"
  * `write_dta()` - Stata file, extension ".dta"
  * `write_sas()` - SAS file, extension ".sas"
  * `write_sav()` - SPSS file, extension ".sav"

As with reading the data, `write_csv()` comes from the `readr` package while the other formats are from the `haven` package. Though the `readxl` package lets you read .xls and .xlsx files, it does not have functions that let you save a file to that type. 

There are other packages that let you save .xls and .xlsx file but in the interest of keeping the packages we learn to a minimum, I won't include those here. In nearly all cases you'll want to save your data as an .rds, .csv, or a .dta file. Fixed-width ASCII files are so primitive that while we may need to load them into R, we should never save data in this format.

### R 

### .rda and .rdata

For saving an .rda file we must set the parameter `file` to be the name we're saving. For the other types of data they use the parameter `path` rather than `file` but it is not necessary to call them explicitly. Only for `save()` do we need to write `file = ` explicitly in the function.


```r
save(shootings, file =  "data/shootings.rda")
```

### .rds


```r
saveRDS(shootings, "data/shootings.rds")
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


## Practice problems

For answers, please see Section \@ref(problem-answers-chapter-5). Please keep in mind that the goal is to have your answers be the same as mine, even if the code isn't. With R you can answer a question in multiple ways, so different code can lead to the same answer.
