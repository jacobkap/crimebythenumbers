# More Scraping tables from PDFs {#scrape-table2}

In  Chapter \@ref(scrape-table) we used the package `pdftools` to scrape tables on arrests/seizures from the United States Border Patrol that were only available in a PDF. Given the importance of PDF scraping - hopefully by the time you read this chapter more data will be available in reasonable formats and not in PDFs - in this chapter we'll continue working on scraping tables from PDFs. Here we will use the package `tabulizer` which has a number of features making it especially useful for grabbing tables from PDFs. One issue which we saw in Chapter \@ref(scrape-table) is that the table may not be the only thing on the page - the page could also have a title, page number etc. When using `pdftools` we use regular expressions and subsetting to remove all the extra lines. Using `tabulizer` we can simply say (through a handy function) that we only want a part of the page, so we only scrape the table itself.  For more info about the `tabulizer` package please see their site [here](https://docs.ropensci.org/tabulizer/). 

For this chapter we'll scrape data from the Texas Commission on Jail Standards - Abbreviated Population Report for xxx. This is a report that shows monthly data on people incarcerated in jails for counties in Texas and is available [here](https://github.com/jacobkap/crimebythenumbers/blob/master/data/AbbreRptCurrent.pdf).

This PDF is 9 pages long because of how many counties there are in Texas. Lets take a look at what the first page looks like. If you look at the PDF yourself you'll see that every page follows the format of the 1st page, which greatly simplifies our scrape. The data is in county-month units which means that each row of data has info for a single county in a single month. We know that because the first column is "County" and each row is a single county (this is not true is every case. For example, on page 3 there are the rows 'Fannin 1(P)' and 'Fannin 2(P)', possibly indicating that there are two jails in that county. It is unclear from this PDF what the '(P)' means.). For knowing that the data is monthly, the title of this document says 'for 06/01/2020' indicating that it is for that date, though this doesn't by itself mean the data is monthly - it could be daily based only on this data. 

To know that it's monthly data we'd have to go to the original source on the Texas Commission on Jail Standards website [here](https://www.tcjs.state.tx.us/historical-population-reports/#1580454195676-420daca6-0a306). On this page it says that 'Monthly population reports are available for review below," which tells us that the data is monthly. It's important to know the unit so you can understand the data properly - primarily so you know what kinds of questions you can answer. If someone asks whether yearly trends on jail incarceration change in Texas, you can answer that with this data. If they ask whether more people are in jail on a Tuesday than on a Friday, you can't.

Just to understand what units our data is in we had to look at both the PDF itself and the site it came from. This kind of multi-step process is tedious but often necessary to truly understand your data. And even now we have questions - what does the (P) that's in some rows mean? For this we'd have to email or call the people who handle the data and ask directly. This is often the easiest way to answer your question, though different organizations have varying speeds in responding - if ever. 
Now lets look at what columns are available. It looks like each column is the number of people incarcerated in the jail, broken down into categories of people. For example, the first two columns after County are 'Pretrial Felons' and 'Conv. Felons' so those are probably how many people are incarcerated who are awaiting trial for a felony and those already convicted of a felony. The other columns seem to follow this same format until the last few ones which describe the jails capacity (i.e. how many people they can hold), what percent of capacity they are at, and specifically how many open beds they have. 

![](images/tabulizer1.PNG)

Now that we've familiarized ourselves with the data, lets begin scraping this data using `tabulizer`. If you don't have this package installed you'll need to install it using `install.packages("tabulizer")`. Then we'll need to run `library(tabulizer)`.


```r
library(tabulizer)
```

The main function that we'll be using from the `tabulizer` package is `extract_tables()`. This function basically looks at a PDF page, figures out which part of the page is a table, and then scrapes just that table. As we'll see, it's not always perfect at figuring out what part of the page is a table so we can also tell it exactly where to look. You can look at all of the features of `extract_tables()` by running `help(extract_tables)`. 


```r
data <- extract_tables(file = "data/Abbreviated Pop Rpt Dec 2017.pdf")
is(data)
#> [1] "list"   "vector"
length(data)
#> [1] 19
data[[1]]
#>      [,1]     [,2]       [,3]     [,4]           [,5]        [,6]        
#> [1,] ""       ""         ""       "Conv. Felons" ""          "Parole"    
#> [2,] ""       ""         ""       "Sentenced to" ""          "Violators" 
#> [3,] ""       ""         ""       "County Jail"  ""          "with a New"
#> [4,] ""       "Pretrial" "Conv."  ""             "Parole"    ""          
#> [5,] ""       ""         ""       "time"         ""          "Charge"    
#> [6,] "County" "Felons"   "Felons" ""             "Violators" ""          
#>      [,7]       [,8]    [,9]       [,10]     [,11]      [,12]        
#> [1,] ""         ""      ""         ""        ""         "Conv. SJF"  
#> [2,] ""         ""      ""         ""        ""         "Sentenced"  
#> [3,] ""         ""      ""         ""        ""         "to Co. Jail"
#> [4,] "Pretrial" "Conv." "Bench"    ""        "Pretrial" ""           
#> [5,] ""         ""      ""         ""        ""         "Time"       
#> [6,] "Misd."    "Misd." "Warrants" "Federal" "SJF"      ""           
#>      [,13]           [,14]    [,15]   [,16]      [,17]        [,18]     
#> [1,] "Conv."         ""       ""      ""         ""           ""        
#> [2,] "SJF"           ""       ""      ""         ""           ""        
#> [3,] "Sentenced"     ""       ""      ""         ""           ""        
#> [4,] ""              "Total"  "Total" "Total"    "Total"      "Total"   
#> [5,] "to State Jail" ""       ""      ""         ""           ""        
#> [6,] ""              "Others" "Local" "Contract" "Population" "Capacity"
#>      [,19]      [,20]      
#> [1,] ""         ""         
#> [2,] ""         ""         
#> [3,] ""         ""         
#> [4,] "% of"     "Available"
#> [5,] ""         ""         
#> [6,] "Capacity" "Beds"
head(data[[2]])
#>      [,1]        [,2]  [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12]
#> [1,] "Anderson"  "90"  "2"  "2"  "4"  "14" "18" "2"  "1"  "0"   "33"  "2"  
#> [2,] "Andrews"   "20"  "11" "0"  "2"  "6"  "5"  "0"  "1"  "0"   "3"   "0"  
#> [3,] "Angelina"  "105" "26" "1"  "9"  "13" "10" "12" "6"  "0"   "28"  "0"  
#> [4,] "Aransas"   "27"  "6"  "0"  "7"  "9"  "5"  "6"  "7"  "81"  "14"  "0"  
#> [5,] "Archer"    "10"  "0"  "0"  "0"  "2"  "3"  "0"  "2"  "1"   "7"   "0"  
#> [6,] "Armstrong" "0"   "0"  "0"  "0"  "0"  "0"  "0"  "0"  "0"   "0"   "0"  
#>      [,13] [,14] [,15] [,16] [,17] [,18] [,19]   [,20]
#> [1,] "0"   "0"   "168" "0"   "168" "300" "56.00" "102"
#> [2,] "2"   "0"   "26"  "0"   "26"  "50"  "52.00" "19" 
#> [3,] "2"   "0"   "212" "0"   "212" "279" "75.99" "39" 
#> [4,] "3"   "4"   "88"  "81"  "169" "212" "79.72" "22" 
#> [5,] "1"   "0"   "25"  "5"   "30"  "48"  "62.50" "13" 
#> [6,] "0"   "0"   "0"   "0"   "0"   "8"   "0.00"  "0"
```

Above is scraping code and some output when running `extract_tables()` on our PDF using all of the default options in that function. The only parameter we put in the function is `file = "data/Abbreviated Pop Rpt Dec 2017.pdf"`. This is just telling the function where to look for the PDF. I have the PDF in the data folder of my project; you'll need to change this to have `extract_tables()` look in the right place for the PDF on your computer. 

You can see from the output that the scrape was successful - but out work isn't done yet. The results from `is(data)` say that the scrape returned a list, and from `length(data)` we learn that it's a list of length 18. Why is this? We have 9 pages so it is reasonable that we would have 9 lists since we have one table per page, but we shouldn't have 19 tables. Lets look again at just the first table - as it is a list we'll need double square brackets to pull just the first element in the list.


```r
data[[1]]
#>      [,1]     [,2]       [,3]     [,4]           [,5]        [,6]        
#> [1,] ""       ""         ""       "Conv. Felons" ""          "Parole"    
#> [2,] ""       ""         ""       "Sentenced to" ""          "Violators" 
#> [3,] ""       ""         ""       "County Jail"  ""          "with a New"
#> [4,] ""       "Pretrial" "Conv."  ""             "Parole"    ""          
#> [5,] ""       ""         ""       "time"         ""          "Charge"    
#> [6,] "County" "Felons"   "Felons" ""             "Violators" ""          
#>      [,7]       [,8]    [,9]       [,10]     [,11]      [,12]        
#> [1,] ""         ""      ""         ""        ""         "Conv. SJF"  
#> [2,] ""         ""      ""         ""        ""         "Sentenced"  
#> [3,] ""         ""      ""         ""        ""         "to Co. Jail"
#> [4,] "Pretrial" "Conv." "Bench"    ""        "Pretrial" ""           
#> [5,] ""         ""      ""         ""        ""         "Time"       
#> [6,] "Misd."    "Misd." "Warrants" "Federal" "SJF"      ""           
#>      [,13]           [,14]    [,15]   [,16]      [,17]        [,18]     
#> [1,] "Conv."         ""       ""      ""         ""           ""        
#> [2,] "SJF"           ""       ""      ""         ""           ""        
#> [3,] "Sentenced"     ""       ""      ""         ""           ""        
#> [4,] ""              "Total"  "Total" "Total"    "Total"      "Total"   
#> [5,] "to State Jail" ""       ""      ""         ""           ""        
#> [6,] ""              "Others" "Local" "Contract" "Population" "Capacity"
#>      [,19]      [,20]      
#> [1,] ""         ""         
#> [2,] ""         ""         
#> [3,] ""         ""         
#> [4,] "% of"     "Available"
#> [5,] ""         ""         
#> [6,] "Capacity" "Beds"
```

The results from `data[[1]]` provide some answers. It has the right number of columns but only 6 rows! This is our first table so should be the entire table we can see on page 1. Instead, it appears to be just the column names, with 6 rows because some column names are on multiple rows. Here's the issue, we can read the table and easily see that the column names may be on multiple rows but belong together, and that they are part of the table. `tabulizer` can't see this obvious fact as we can, it must rely on a series of rules to indicate what is part of a table and what isn't. For example, having white space between columns and thin black lines around rows tells it where each row and column is. Our issue is that the column names appear to just be text until there is a thick black line and (in `tabulizer's` mind) the table begins, so it keeps the column name part separate from the rest of the table. Now lets look closer at table 2 and see if it is correct for the table on page 1 of our PDF. 


```r
head(data[[2]])
#>      [,1]        [,2]  [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12]
#> [1,] "Anderson"  "90"  "2"  "2"  "4"  "14" "18" "2"  "1"  "0"   "33"  "2"  
#> [2,] "Andrews"   "20"  "11" "0"  "2"  "6"  "5"  "0"  "1"  "0"   "3"   "0"  
#> [3,] "Angelina"  "105" "26" "1"  "9"  "13" "10" "12" "6"  "0"   "28"  "0"  
#> [4,] "Aransas"   "27"  "6"  "0"  "7"  "9"  "5"  "6"  "7"  "81"  "14"  "0"  
#> [5,] "Archer"    "10"  "0"  "0"  "0"  "2"  "3"  "0"  "2"  "1"   "7"   "0"  
#> [6,] "Armstrong" "0"   "0"  "0"  "0"  "0"  "0"  "0"  "0"  "0"   "0"   "0"  
#>      [,13] [,14] [,15] [,16] [,17] [,18] [,19]   [,20]
#> [1,] "0"   "0"   "168" "0"   "168" "300" "56.00" "102"
#> [2,] "2"   "0"   "26"  "0"   "26"  "50"  "52.00" "19" 
#> [3,] "2"   "0"   "212" "0"   "212" "279" "75.99" "39" 
#> [4,] "3"   "4"   "88"  "81"  "169" "212" "79.72" "22" 
#> [5,] "1"   "0"   "25"  "5"   "30"  "48"  "62.50" "13" 
#> [6,] "0"   "0"   "0"   "0"   "0"   "8"   "0.00"  "0"
tail(data[[2]])
#>       [,1]          [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12]
#> [24,] "Brooks"      "14" "3"  "0"  "1"  "1"  "1"  "0"  "0"  "0"   "0"   "0"  
#> [25,] "Brooks (P)"  "0"  "0"  "0"  "0"  "0"  "0"  "0"  "0"  "431" "0"   "0"  
#> [26,] "Brown"       "57" "18" "2"  "9"  "15" "7"  "0"  "2"  "0"   "4"   "0"  
#> [27,] "Burleson"    "34" "10" "0"  "1"  "7"  "3"  "0"  "1"  "0"   "5"   "1"  
#> [28,] "Burnet 1(P)" "53" "22" "4"  "2"  "11" "12" "3"  "1"  "0"   "14"  "1"  
#> [29,] "Caldwell"    "52" "7"  "2"  "1"  "5"  "34" "10" "2"  "0"   "15"  "0"  
#>       [,13] [,14] [,15] [,16] [,17] [,18] [,19]   [,20]
#> [24,] "0"   "3"   "23"  "0"   "23"  "36"  "63.89" "0"  
#> [25,] "0"   "0"   "0"   "549" "549" "652" "84.20" "38" 
#> [26,] "3"   "8"   "125" "2"   "127" "196" "64.80" "49" 
#> [27,] "2"   "17"  "69"  "2"   "71"  "96"  "73.96" "15" 
#> [28,] "0"   "1"   "124" "228" "352" "595" "59.16" "184"
#> [29,] "1"   "0"   "129" "25"  "154" "301" "51.16" "117"
```

We're looking just at the `head()` and `tail()` to get the first and 6 six rows as otherwise we'd print out all 29 rows in that table. When you are exploring you own data you'd probably want to be more thorough and ensure that rows around the middle are also correct - but this is a good first pass. If you look at the output the table and compare it to the PDF, you'll see that the scrape was successful. Every row is where it should be and the columns are correct - unlike using `pdftools()` we have the results already in proper columns. One thing to note is that this data isn't in a data.frame format, it's in a matrix. Matrices are the default output of `extract_tables()` though you can set it to output a data.frame by setting the parameter `output = "data.frame"`. In out case we actually wouldn't want that due to the issue of the column names. 


```r
data <- extract_tables(file = "data/Abbreviated Pop Rpt Dec 2017.pdf", output = "data.frame")
head(data[[2]])
#>    Anderson X90 X2 X2.1 X4 X14 X18 X2.2 X1 X0 X33 X2.3 X0.1 X0.2 X168 X0.3
#> 1   Andrews  20 11    0  2   6   5    0  1  0   3    0    2    0   26    0
#> 2  Angelina 105 26    1  9  13  10   12  6  0  28    0    2    0  212    0
#> 3   Aransas  27  6    0  7   9   5    6  7 81  14    0    3    4   88   81
#> 4    Archer  10  0    0  0   2   3    0  2  1   7    0    1    0   25    5
#> 5 Armstrong   0  0    0  0   0   0    0  0  0   0    0    0    0    0    0
#> 6  Atascosa  69 11    0  2   2  14    1  1  0  11    0    2    3  116    0
#>   X168.1 X300 X56.00 X102
#> 1     26   50  52.00   19
#> 2    212  279  75.99   39
#> 3    169  212  79.72   22
#> 4     30   48  62.50   13
#> 5      0    8   0.00    0
#> 6    116  138  84.06    0
```
Above we reran the `extract_tables()` code and just added a parameter to make the output a data.frame instead of a matrix. Now it sets the first row - which should be the columns - as the column name, which is not correct. We'll have to fix the column names first before we can convert the result from a matrix to a data.frame.

To attempt to handle this we'll use the very helpful function `locate_areas()`. This function will let you choose exactly where on the page to get the table - overriding the function's automatic detection method.


We'll use the `apply()` function on our data to create column names from it. The `apply()` function is actual part of a "family" of similar function which essentially operate as quicker for loops - we could have done a for loop to solve this problem. The `apply()` function takes as an input a vector or matrix dataset, and then performs some function on either its rows or its columns. Our first input is our data, the first element of the `data` list. Then we put the number 2 to indicate that we want it to perform our function on each column of the matrix - if we put 1, that would perform the function on each row. So now what function to use on this data? We want to combine each row together into a single string per column. To do that we can use the `paste()` function and use the `collapse` parameter to combine multiple strings to a single string. So after the 2 we enter `paste`, and then just add `collapse = ""` (the "" means that we're not putting anything between the strings when combining them) separated by a comma. Lets see what it returns.


```r
apply(data[[1]], 2, paste, collapse = "")
#>                             X                           X.1 
#>                      "County"              "PretrialFelons" 
#>                           X.2                  Conv..Felons 
#>                 "Conv.Felons" "Sentenced toCounty Jailtime" 
#>                           X.3                        Parole 
#>             "ParoleViolators"   "Violatorswith a NewCharge" 
#>                           X.4                           X.5 
#>               "PretrialMisd."                  "Conv.Misd." 
#>                           X.6                           X.7 
#>               "BenchWarrants"                     "Federal" 
#>                           X.8                     Conv..SJF 
#>                 "PretrialSJF"    "Sentencedto Co. JailTime" 
#>                         Conv.                           X.9 
#>   "SJFSentencedto State Jail"                 "TotalOthers" 
#>                          X.10                          X.11 
#>                  "TotalLocal"               "TotalContract" 
#>                          X.12                          X.13 
#>             "TotalPopulation"               "TotalCapacity" 
#>                          X.14                          X.15 
#>                "% ofCapacity"               "AvailableBeds"
```

Now we have a vector of 20 strings, one per column in our data. We will use this to name the columns in our dataset with the actual info from the scraped table. One helper function first. The column names don't follow conventional R style for column names - it has spaces, uppercased letters, punctuation other than the underscore. To easily fix this we can use the `make_clean_names()` function from the `janitor` package. If you don't have this package installed, install it using `install.packages("janitor")`. We'll first save the results of the above `apply()` function as a vector we can call `column_names` and then run the `make_clean_names()` function on it. The input to `make_clean_names()` is the vector of strings (our column names) and it'll return that vector but now with names in R's common style.


```r
library(janitor)
#> 
#> Attaching package: 'janitor'
#> The following objects are masked from 'package:stats':
#> 
#>     chisq.test, fisher.test
column_names <- apply(data[[1]], 2, paste, collapse = "")
column_names <- make_clean_names(column_names)
column_names
#>  [1] "county"                       "pretrial_felons"             
#>  [3] "conv_felons"                  "sentenced_to_county_jailtime"
#>  [5] "parole_violators"             "violatorswith_a_new_charge"  
#>  [7] "pretrial_misd"                "conv_misd"                   
#>  [9] "bench_warrants"               "federal"                     
#> [11] "pretrial_sjf"                 "sentencedto_co_jail_time"    
#> [13] "sjf_sentencedto_state_jail"   "total_others"                
#> [15] "total_local"                  "total_contract"              
#> [17] "total_population"             "total_capacity"              
#> [19] "percent_of_capacity"          "available_beds"
```

Now the column names are in the proper style. And notice the 19th value, it changed from the percent sign to the word "percent".


## Pregnant Women Incarcerated

We'll finish this lesson with another example of data from Texas - this time using data on the number of pregnant women booked in Texas county jails. This data has a unique challenge, it has 10 columns but we want to make it have only 2. In the data (shown below), it starts with a column of county names, then a column of the number of pregnant women booked into that county's jail. Next is another column of county names - instead of continuing onto another page, this data just makes new columns when it runs out of room. We'll scrape this PDF using `tabulizer()` and then work to fix this multiple-column issue. 

![](images/pregnant.PNG)

Notice that this data doesn't even have column names. Whereas earlier in this chapter we have to combine multiple rows to form the column names, here we will have to create the names entirely ourselves. This is always a bit risky as maybe next month the table will change and if we hard-code any column names, we'll either have code that breaks or - much more dangerous - mislabel the columns without noticing. In cases like this we have no other choice, but if you intend to scrape something that recurring - that is, that you'll scrape a future version of - be careful about situations like this.

