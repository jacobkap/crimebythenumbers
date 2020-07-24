# More scraping tables from PDFs {#scrape-table2}

In Chapter \@ref(scrape-table) we used the package `pdftools` to scrape tables on arrests/seizures from the United States Border Patrol that were only available in a PDF. Given the importance of PDF scraping - hopefully by the time you read this chapter more data will be available in reasonable formats and not in PDFs - in this chapter we'll continue working on scraping tables from PDFs. Here we will use the package `tabulizer` which has a number of features making it especially useful for grabbing tables from PDFs. One issue which we saw in Chapter \@ref(scrape-table) is that the table may not be the only thing on the page - the page could also have a title, page number etc. When using `pdftools` we use regular expressions and subsetting to remove all the extra lines. Using `tabulizer` we can simply say (through a handy function) that we only want a part of the page, so we only scrape the table itself.  For more info about the `tabulizer` package please see their site [here](https://docs.ropensci.org/tabulizer/). 

For this chapter we'll scrape data from the Texas Commission on Jail Standards - Abbreviated Population Report. This is a report that shows monthly data on people incarcerated in jails for counties in Texas and is available [here](https://github.com/jacobkap/crimebythenumbers/blob/master/data/AbbreRptCurrent.pdf). Make sure to download this file and put it in the working directory that you use to follow along. 

This PDF is 9 pages long because of how many counties there are in Texas. Let's take a look at what the first page looks like. If you look at the PDF yourself you'll see that every page follows the format of the 1st page, which greatly simplifies our scrape. The data is in county-month units which means that each row of data has info for a single county in a single month. We know that because the first column is "County" and each row is a single county (this is not true is every case. For example, on page 3 there are the rows 'Fannin 1(P)' and 'Fannin 2(P)', possibly indicating that there are two jails in that county. It is unclear from this PDF what the '(P)' means.). For knowing that the data is monthly, the title of this document says 'for 06/01/2020' indicating that it is for that date, though this doesn't by itself mean the data is monthly - it could be daily based only on this data. 

To know that it's monthly data we'd have to go to the original source on the Texas Commission on Jail Standards website [here](https://www.tcjs.state.tx.us/historical-population-reports/#1580454195676-420daca6-0a306). On this page it says that 'Monthly population reports are available for review below," which tells us that the data is monthly. It's important to know the unit so you can understand the data properly - primarily so you know what kinds of questions you can answer. If someone asks whether yearly trends on jail incarceration change in Texas, you can answer that with this data. If they ask whether more people are in jail on a Tuesday than on a Friday, you can't.

Just to understand what units our data is in we had to look at both the PDF itself and the site it came from. This kind of multi-step process is tedious but often necessary to truly understand your data. And even now we have questions - what does the (P) that's in some rows mean? For this we'd have to email or call the people who handle the data and ask directly. This is often the easiest way to answer your question, though different organizations have varying speeds in responding - if ever. 

Now let's look at what columns are available. It looks like each column is the number of people incarcerated in the jail, broken down into categories of people. For example, the first two columns after County are 'Pretrial Felons' and 'Conv. Felons' so those are probably how many people are incarcerated who are awaiting trial for a felony and those already convicted of a felony. The other columns seem to follow this same format until the last few ones which describe the jails capacity (i.e. how many people they can hold), what percent of capacity they are at, and specifically how many open beds they have. 

![](images/tabulizer1.PNG)

Now that we've familiarized ourselves with the data, let's begin scraping this data using `tabulizer`. If you don't have this package installed, you'll need to install it using `install.packages("tabulizer")`. Then we'll need to run `library(tabulizer)`.


```r
library(tabulizer)
```

The main function that we'll be using from the `tabulizer` package is `extract_tables()`. This function basically looks at a PDF page, figures out which part of the page is a table, and then scrapes just that table. As we'll see, it's not always perfect at figuring out what part of the page is a table so we can also tell it exactly where to look. You can look at all of the features of `extract_tables()` by running `help(extract_tables)`. 


```r
data <- extract_tables(file = "data/AbbreRptCurrent.pdf")
is(data)
#> [1] "list"   "vector"
length(data)
#> [1] 18
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
#>      [,1]        [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12]
#> [1,] "Anderson"  "81" "13" "3"  "1"  "5"  "12" "1"  "0"  "0"   "21"  "0"  
#> [2,] "Andrews"   "23" "11" "0"  "2"  "4"  "11" "0"  "0"  "0"   "5"   "0"  
#> [3,] "Angelina"  "79" "35" "4"  "6"  "0"  "14" "0"  "3"  "0"   "23"  "0"  
#> [4,] "Aransas"   "23" "10" "0"  "2"  "6"  "7"  "0"  "6"  "73"  "2"   "0"  
#> [5,] "Archer"    "12" "3"  "0"  "0"  "1"  "3"  "1"  "1"  "2"   "5"   "0"  
#> [6,] "Armstrong" "1"  "1"  "0"  "0"  "0"  "0"  "0"  "0"  "0"   "0"   "0"  
#>      [,13] [,14] [,15] [,16] [,17] [,18] [,19]   [,20]
#> [1,] "1"   "0"   "138" "0"   "138" "300" "46.00" "132"
#> [2,] "6"   "0"   "35"  "0"   "35"  "50"  "70.00" "10" 
#> [3,] "3"   "1"   "168" "0"   "168" "279" "60.22" "83" 
#> [4,] "0"   "0"   "56"  "73"  "129" "212" "60.85" "62" 
#> [5,] "0"   "1"   "26"  "9"   "35"  "48"  "72.92" "0"  
#> [6,] "0"   "0"   "2"   "0"   "2"   "8"   "25.00" "0"
```

Above is scraping code and some output when running `extract_tables()` on our PDF using all of the default options in that function. The only parameter we put in the function is `file = "data/Abbreviated Pop Rpt Dec 2017.pdf"`. This is just telling the function where to look for the PDF. I have the PDF in the data folder of my project; you'll need to change this to have `extract_tables()` look in the right place for the PDF on your computer. 

You can see from the output that the scrape was successful - but our work isn't done yet. The results from `is(data)` say that the scrape returned a list, and from `length(data)` we learn that it's a list of length 18. Why is this? We have 9 pages so it is reasonable that we would have 9 lists since we have one table per page, but we shouldn't have 19 tables. Let's look again at just the first table - as it is a list, we'll need double square brackets to pull just the first element in the list.


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

The results from `data[[1]]` provide some answers. It has the right number of columns but only 6 rows! This is our first table so should be the entire table we can see on page 1. Instead, it appears to be just the column names, with 6 rows because some column names are on multiple rows. Here's the issue, we can read the table and easily see that the column names may be on multiple rows but belong together, and that they are part of the table. `tabulizer` can't see this obvious fact as we can, it must rely on a series of rules to indicate what is part of a table and what isn't. For example, having white space between columns and thin black lines around rows tells it where each row and column is. Our issue is that the column names appear to just be text until there is a thick black line and (in `tabulizer's` mind) the table begins, so it keeps the column name part separate from the rest of the table. Now let's look closer at table 2 and see if it is correct for the table on page 1 of our PDF. 


```r
head(data[[2]])
#>      [,1]        [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12]
#> [1,] "Anderson"  "81" "13" "3"  "1"  "5"  "12" "1"  "0"  "0"   "21"  "0"  
#> [2,] "Andrews"   "23" "11" "0"  "2"  "4"  "11" "0"  "0"  "0"   "5"   "0"  
#> [3,] "Angelina"  "79" "35" "4"  "6"  "0"  "14" "0"  "3"  "0"   "23"  "0"  
#> [4,] "Aransas"   "23" "10" "0"  "2"  "6"  "7"  "0"  "6"  "73"  "2"   "0"  
#> [5,] "Archer"    "12" "3"  "0"  "0"  "1"  "3"  "1"  "1"  "2"   "5"   "0"  
#> [6,] "Armstrong" "1"  "1"  "0"  "0"  "0"  "0"  "0"  "0"  "0"   "0"   "0"  
#>      [,13] [,14] [,15] [,16] [,17] [,18] [,19]   [,20]
#> [1,] "1"   "0"   "138" "0"   "138" "300" "46.00" "132"
#> [2,] "6"   "0"   "35"  "0"   "35"  "50"  "70.00" "10" 
#> [3,] "3"   "1"   "168" "0"   "168" "279" "60.22" "83" 
#> [4,] "0"   "0"   "56"  "73"  "129" "212" "60.85" "62" 
#> [5,] "0"   "1"   "26"  "9"   "35"  "48"  "72.92" "0"  
#> [6,] "0"   "0"   "2"   "0"   "2"   "8"   "25.00" "0"
tail(data[[2]])
#>       [,1]         [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12]
#> [24,] "Brooks"     "15" "1"  "1"  "1"  "0"  "0"  "0"  "0"  "0"   "0"   "0"  
#> [25,] "Brooks (P)" "0"  "0"  "0"  "0"  "0"  "0"  "0"  "0"  "164" "0"   "0"  
#> [26,] "Brown"      "70" "20" "0"  "7"  "20" "9"  "0"  "2"  "0"   "0"   "3"  
#> [27,] "Burleson"   "19" "2"  "0"  "2"  "0"  "3"  "0"  "0"  "0"   "0"   "0"  
#> [28,] "Burnet"     "57" "23" "1"  "5"  "9"  "3"  "0"  "1"  "0"   "10"  "1"  
#> [29,] "Caldwell"   "89" "4"  "0"  "3"  "2"  "26" "1"  "2"  "19"  "13"  "0"  
#>       [,13] [,14] [,15] [,16] [,17] [,18] [,19]   [,20]
#> [24,] "0"   "0"   "18"  "0"   "18"  "36"  "50.00" "14" 
#> [25,] "0"   "0"   "0"   "408" "408" "652" "62.58" "179"
#> [26,] "0"   "2"   "133" "7"   "140" "196" "71.43" "36" 
#> [27,] "0"   "1"   "27"  "0"   "27"  "96"  "28.13" "59" 
#> [28,] "0"   "0"   "110" "158" "268" "595" "45.04" "268"
#> [29,] "3"   "0"   "143" "21"  "164" "301" "54.49" "107"
```

We're looking just at the `head()` and `tail()` to get the first and 6 six rows as otherwise we'd print out all 29 rows in that table. When you are exploring you own data, you'll probably want to be more thorough and ensure that rows around the middle are also correct - but this is a good first pass. If you look at the output the table and compare it to the PDF, you'll see that the scrape was successful. Every row is where it should be and the columns are correct - unlike using `pdftools()` we have the results already in proper columns. One thing to note is that this data isn't in a data.frame format, it's in a matrix. Matrices are the default output of `extract_tables()` though you can set it to output a data.frame by setting the parameter `output = "data.frame"`. In our case we actually wouldn't want that due to the issue of the column names. 


```r
data <- extract_tables(file = "data/AbbreRptCurrent.pdf", output = "data.frame")
head(data[[2]])
#>    Anderson X81 X13 X3 X1 X5 X12 X1.1 X0 X0.1 X21 X0.2 X1.2 X0.3 X138 X0.4
#> 1   Andrews  23  11  0  2  4  11    0  0    0   5    0    6    0   35    0
#> 2  Angelina  79  35  4  6  0  14    0  3    0  23    0    3    1  168    0
#> 3   Aransas  23  10  0  2  6   7    0  6   73   2    0    0    0   56   73
#> 4    Archer  12   3  0  0  1   3    1  1    2   5    0    0    1   26    9
#> 5 Armstrong   1   1  0  0  0   0    0  0    0   0    0    0    0    2    0
#> 6  Atascosa  54   2  0  8  4  21    0  5    0  29    0    4    0  127   29
#>   X138.1 X300 X46.00 X132
#> 1     35   50  70.00   10
#> 2    168  279  60.22   83
#> 3    129  212  60.85   62
#> 4     35   48  72.92    0
#> 5      2    8  25.00    0
#> 6    156  250  62.40   69
```
Above we reran the `extract_tables()` code and just added a parameter to make the output a data.frame instead of a matrix. Now it sets the first row - which should be the columns - as the column name, which is not correct. We'll have to fix the column names first before we can convert the result from a matrix to a data.frame.

We'll use the `apply()` function on our data to create column names from it. The `apply()` function is actual part of a "family" of similar function which essentially operate as quicker for loops - we could have done a for loop to solve this problem. The `apply()` function takes as an input a vector or matrix data set, and then performs some function on either its rows or its columns. Our first input is our data, the first element of the `data` list. Then we put the number 2 to indicate that we want it to perform our function on each column of the matrix - if we put 1, that would perform the function on each row. So now what function to use on this data? We want to combine each row together into a single string per column. To do that we can use the `paste()` function and use the `collapse` parameter to combine multiple strings to a single string. So after the 2 we enter `paste`, and then just add `collapse = ""` (the "" means that we're not putting anything between the strings when combining them) separated by a comma. Let's see what it returns.


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

Now we have a vector of 20 strings, one per column in our data. We will use this to name the columns in our data set with the actual info from the scraped table. One helper function first. The column names don't follow conventional R style for column names - it has spaces, uppercase letters, punctuation other than the underscore. To easily fix this we can use the `make_clean_names()` function from the `janitor` package. If you don't have this package installed, install it using `install.packages("janitor")`. We'll first save the results of the above `apply()` function as a vector we can call `column_names` and then run the `make_clean_names()` function on it. The input to `make_clean_names()` is the vector of strings (our column names) and it'll return that vector but now with names in R's common style.


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

We can combine the results from the first table - the column names - with that of the second table - the actual data - to have a complete table from page 1 of our PDF. We do this simply by making table 2 a data.frame and using `names()` to rename the columns to the ones we made above. Since this is the table from page 1 of the PDF, we'll call the object `page1_table`.


```r
page1_table <- data[[2]]
page1_table <- data.frame(page1_table)
names(page1_table) <- column_names
head(page1_table)
#>      county pretrial_felons conv_felons sentenced_to_county_jailtime
#> 1   Andrews              23          11                            0
#> 2  Angelina              79          35                            4
#> 3   Aransas              23          10                            0
#> 4    Archer              12           3                            0
#> 5 Armstrong               1           1                            0
#> 6  Atascosa              54           2                            0
#>   parole_violators violatorswith_a_new_charge pretrial_misd conv_misd
#> 1                2                          4            11         0
#> 2                6                          0            14         0
#> 3                2                          6             7         0
#> 4                0                          1             3         1
#> 5                0                          0             0         0
#> 6                8                          4            21         0
#>   bench_warrants federal pretrial_sjf sentencedto_co_jail_time
#> 1              0       0            5                        0
#> 2              3       0           23                        0
#> 3              6      73            2                        0
#> 4              1       2            5                        0
#> 5              0       0            0                        0
#> 6              5       0           29                        0
#>   sjf_sentencedto_state_jail total_others total_local total_contract
#> 1                          6            0          35              0
#> 2                          3            1         168              0
#> 3                          0            0          56             73
#> 4                          0            1          26              9
#> 5                          0            0           2              0
#> 6                          4            0         127             29
#>   total_population total_capacity percent_of_capacity available_beds
#> 1               35             50               70.00             10
#> 2              168            279               60.22             83
#> 3              129            212               60.85             62
#> 4               35             48               72.92              0
#> 5                2              8               25.00              0
#> 6              156            250               62.40             69
tail(page1_table)
#>        county pretrial_felons conv_felons sentenced_to_county_jailtime
#> 23     Brooks              15           1                            1
#> 24 Brooks (P)               0           0                            0
#> 25      Brown              70          20                            0
#> 26   Burleson              19           2                            0
#> 27     Burnet              57          23                            1
#> 28   Caldwell              89           4                            0
#>    parole_violators violatorswith_a_new_charge pretrial_misd conv_misd
#> 23                1                          0             0         0
#> 24                0                          0             0         0
#> 25                7                         20             9         0
#> 26                2                          0             3         0
#> 27                5                          9             3         0
#> 28                3                          2            26         1
#>    bench_warrants federal pretrial_sjf sentencedto_co_jail_time
#> 23              0       0            0                        0
#> 24              0     164            0                        0
#> 25              2       0            0                        3
#> 26              0       0            0                        0
#> 27              1       0           10                        1
#> 28              2      19           13                        0
#>    sjf_sentencedto_state_jail total_others total_local total_contract
#> 23                          0            0          18              0
#> 24                          0            0           0            408
#> 25                          0            2         133              7
#> 26                          0            1          27              0
#> 27                          0            0         110            158
#> 28                          3            0         143             21
#>    total_population total_capacity percent_of_capacity available_beds
#> 23               18             36               50.00             14
#> 24              408            652               62.58            179
#> 25              140            196               71.43             36
#> 26               27             96               28.13             59
#> 27              268            595               45.04            268
#> 28              164            301               54.49            107
```
Looking at the results of `head()` and `tail()` (if this was data you'd use in your own project you'd want to look closer than just these checks) shows that we've done this correctly. The values are right and the column names are correct. Complete the rest of the PDF on your own. You can follow the same steps as above but now that we've made the `column_names` object you can reuse that for the other tables. This is only true because each page has the same column names. Otherwise you'd have to fix the column names for each page of the PDF.

So why did I choose this example when it highlights a limitation of an otherwise very effective R package? A lot of the work you do in R is going to be like the example we went through - there are tools to solve *most* of the data problems, but you'll need to spend time fixing the extra issues. And since a lot of problems are fairly unique (at least insofar as there are differences in your exact problem even if problems are generally similar) there's usually not a R function to solve everything. Below is another (brief) example of the `tabulizer` package working perfectly - but with a few issues just due to how the data is arranged on the PDF. 

## Pregnant Women Incarcerated

We'll finish this lesson with another example of data from Texas - this time using data on the number of pregnant women booked in Texas county jails. This data has a unique challenge, it has 10 columns but we want to make it have only 2. In the data (shown below), it starts with a column of county names, then a column of the number of pregnant women booked into that county's jail. Next is another column of county names - instead of continuing onto another page, this data just makes new columns when it runs out of room. We'll scrape this PDF using `tabulizer()` and then work to fix this multiple-column issue. The file is called "PregnantFemaleReportingCurrent.pdf" and is available on GitHub [here](https://github.com/jacobkap/crimebythenumbers/blob/master/data/PregnantFemaleReportingCurrent.pdf). Make sure to download this file and put it in the proper working directory for the `extract_tables()` function we use below.

![](images/pregnant.PNG)

Notice that this data doesn't even have column names. Whereas earlier in this chapter we have to combine multiple rows to form the column names, here we will have to create the names entirely ourselves. This is always a bit risky as maybe next month the table will change and if we hard-code any column names, we'll either have code that breaks or - much more dangerous - mislabel the columns without noticing. In cases like this we have no other choice, but if you intend to scrape something that recurring - that is, that you'll scrape a future version of - be careful about situations like this.

We'll start scraping this PDF using the standard `extract_tables()` function without any parameters other than the file name. This is usually a good start since it's quick and often works - and if it doesn't, we haven't lost much time checking. Since we know `extract_tables()` will return a list by default, we'll save the result of `extract_tables()` as an object called `data` and then just pull the first element (i.e. the only element if this works) from that list.


```r
data <- extract_tables(file = "data/PregnantFemaleReportingCurrent.pdf")
data <- data[[1]]
data
#>       [,1]            [,2] [,3]          [,4] [,5]            [,6]
#>  [1,] "Anderson"      "0"  "Delta"       "0"  "Irion"         "0" 
#>  [2,] "Andrews"       "1"  "Denton"      "3"  "Jack"          "0" 
#>  [3,] "Angelina"      "0"  "DeWitt"      "0"  "Jackson"       "1" 
#>  [4,] "Aransas"       "0"  "Dickens"     "0"  "Jasper"        "0" 
#>  [5,] "Archer"        "1"  "Dickens (P)" "0"  "Jeff Davis"    "0" 
#>  [6,] "Armstrong"     "0"  "Dimmit"      "0"  "Jefferson"     "0" 
#>  [7,] "Atascosa"      "0"  "Donley"      "0"  "Jefferson (P)" "0" 
#>  [8,] "Austin"        "0"  "Duval"       "0"  "Jim Hogg"      "0" 
#>  [9,] "Bailey"        "0"  "Eastland"    "0"  "Jim Wells"     "0" 
#> [10,] "Bandera"       "0"  "Ector"       "3"  "Johnson"       "2" 
#> [11,] "Bastrop"       "0"  "Edwards"     "0"  "Jones"         "0" 
#> [12,] "Baylor"        "0"  "El Paso"     "8"  "Karnes"        "0" 
#> [13,] "Bee"           "0"  "Ellis"       "0"  "Karnes (P)"    "0" 
#> [14,] "Bell"          "9"  "Erath"       "0"  "Kaufman"       "3" 
#> [15,] "Bexar"         "27" "Falls"       "0"  "Kendall"       "1" 
#> [16,] "Blanco"        "0"  "Fannin 1(P)" "0"  "Kenedy"        "0" 
#> [17,] "Borden"        "0"  "Fannin 2(P)" "2"  "Kent"          "0" 
#> [18,] "Bosque"        "0"  "Fayette"     "0"  "Kerr"          "1" 
#> [19,] "Bowie (P)"     "0"  "Fisher"      "0"  "Kimble"        "0" 
#> [20,] "Brazoria"      "2"  "Floyd"       "0"  "King"          "0" 
#> [21,] "Brazos"        "5"  "Foard"       "0"  "Kinney"        "0" 
#> [22,] "Brewster"      "0"  "Fort Bend"   "4"  "Kleberg"       "1" 
#> [23,] "Briscoe"       "0"  "Franklin"    "0"  "Knox"          "0" 
#> [24,] "Brooks"        "0"  "Freestone"   "1"  "La Salle"      "0" 
#> [25,] "Brooks (P)"    "1"  "Frio (P)"    "0"  "Lamar"         "0" 
#> [26,] "Brown"         "1"  "Gaines"      "0"  "Lamb"          "0" 
#> [27,] "Burleson"      "1"  "Galveston"   "5"  "Lampasas"      "0" 
#> [28,] "Burnet 1(P)"   "5"  "Garza"       "0"  "Lavaca"        "0" 
#> [29,] "Caldwell"      "0"  "Gillespie"   "0"  "Lee"           "0" 
#> [30,] "Calhoun"       "1"  "Glasscock"   "0"  "Leon"          "0" 
#> [31,] "Callahan"      "0"  "Goliad"      "0"  "Liberty (P)"   "3" 
#> [32,] "Cameron"       "6"  "Gonzales"    "1"  "Limestone"     "0" 
#> [33,] "Camp"          "0"  "Gray"        "1"  "Lipscomb"      "0" 
#> [34,] "Carson"        "0"  "Grayson"     "4"  "Live Oak"      "0" 
#> [35,] "Cass"          "0"  "Gregg"       "1"  "Llano"         "1" 
#> [36,] "Castro"        "0"  "Grimes"      "0"  "Loving"        "0" 
#> [37,] "Chambers"      "0"  "Guadalupe"   "6"  "Lubbock"       "9" 
#> [38,] "Cherokee"      "0"  "Hale"        "1"  "Lynn"          "0" 
#> [39,] "Childress"     "0"  "Hall"        "0"  "Madison"       "0" 
#> [40,] "Clay"          "0"  "Hamilton"    "0"  "Marion"        "0" 
#> [41,] "Cochran"       "0"  "Hansford"    "0"  "Martin"        "0" 
#> [42,] "Coke"          "0"  "Hardeman"    "0"  "Mason"         "0" 
#> [43,] "Coleman"       "0"  "Hardin"      "0"  "Matagorda"     "0" 
#> [44,] "Collin"        "9"  "Harris"      "19" "Maverick"      "1" 
#> [45,] "Collingsworth" "0"  "Harrison"    "0"  "Maverick (P)"  "0" 
#> [46,] "Colorado"      "0"  "Haskell (P)" "2"  "McCulloch"     "0" 
#> [47,] "Comal"         "0"  "Hays"        "0"  "McLennan"      "6" 
#> [48,] "Comanche"      "0"  "Hemphill"    "0"  "McLennan 1(P)" "0" 
#> [49,] "Concho"        "0"  "Henderson"   "2"  "McLennan 2(P)" "0" 
#> [50,] "Cooke"         "2"  "Hidalgo"     "6"  "McMullen"      "0" 
#> [51,] "Coryell"       "1"  "Hidalgo (P)" "0"  "Medina"        "0" 
#> [52,] "Cottle"        "0"  "Hill"        "0"  "Menard"        "0" 
#> [53,] "Crane"         "0"  "Hockley"     "1"  "Midland"       "2" 
#> [54,] "Crockett"      "0"  "Hood"        "3"  "Milam"         "0" 
#> [55,] "Crosby"        "0"  "Hopkins"     "1"  "Mills"         "0" 
#> [56,] "Culberson"     "0"  "Houston"     "0"  "Mitchell"      "0" 
#> [57,] "Dallam"        "0"  "Howard"      "2"  "Montague"      "0" 
#> [58,] "Dallas"        "22" "Hudspeth"    "0"  "Montgomery"    "9" 
#> [59,] "Dawson"        "0"  "Hunt"        "2"  "Moore"         "0" 
#> [60,] "Deaf Smith"    "0"  "Hutchinson"  "0"  "Morris"        "0" 
#>       [,7]            [,8] [,9]            [,10]
#>  [1,] "Motley"        "0"  "Upton"         "0"  
#>  [2,] "Nacogdoches"   "2"  "Uvalde"        "0"  
#>  [3,] "Navarro"       "2"  "Val Verde (P)" "1"  
#>  [4,] "Newton"        "0"  "Van Zandt"     "0"  
#>  [5,] "Newton (P)"    "0"  "Victoria"      "1"  
#>  [6,] "Nolan"         "2"  "Walker"        "1"  
#>  [7,] "Nueces"        "4"  "Waller"        "0"  
#>  [8,] "Ochiltree"     "0"  "Ward"          "0"  
#>  [9,] "Oldham"        "0"  "Washington"    "0"  
#> [10,] "Orange"        "0"  "Webb"          "3"  
#> [11,] "Palo Pinto"    "1"  "Wharton"       "1"  
#> [12,] "Panola"        "0"  "Wheeler"       "0"  
#> [13,] "Parker"        "1"  "Wichita"       "3"  
#> [14,] "Parmer"        "0"  "Wilbarger"     "0"  
#> [15,] "Pecos"         "0"  "Willacy"       "0"  
#> [16,] "Polk"          "0"  "Williamson"    "2"  
#> [17,] "Polk (P)"      "0"  "Wilson"        "0"  
#> [18,] "Potter"        "4"  "Winkler"       "0"  
#> [19,] "Presidio"      "0"  "Wise"          "1"  
#> [20,] "Rains"         "0"  "Wood"          "0"  
#> [21,] "Randall"       "0"  "Yoakum"        "0"  
#> [22,] "Reagan"        "0"  "Young"         "0"  
#> [23,] "Real"          "0"  "Zapata"        "0"  
#> [24,] "Red River"     "0"  "Zavala"        "0"  
#> [25,] "Reeves"        "0"  "Zavala (P)"    "0"  
#> [26,] "Refugio"       "1"  ""              ""   
#> [27,] "Roberts"       "0"  ""              ""   
#> [28,] "Robertson"     "0"  ""              ""   
#> [29,] "Rockwall"      "0"  ""              ""   
#> [30,] "Runnels"       "0"  ""              ""   
#> [31,] "Rusk"          "0"  ""              ""   
#> [32,] "Sabine"        "0"  ""              ""   
#> [33,] "San Augustine" "0"  ""              ""   
#> [34,] "San Jacinto"   "0"  ""              ""   
#> [35,] "San Patricio"  "0"  ""              ""   
#> [36,] "San Saba"      "0"  ""              ""   
#> [37,] "Schleicher"    "0"  ""              ""   
#> [38,] "Scurry"        "0"  ""              ""   
#> [39,] "Shackelford"   "0"  ""              ""   
#> [40,] "Shelby"        "0"  ""              ""   
#> [41,] "Sherman"       "0"  ""              ""   
#> [42,] "Smith"         "9"  ""              ""   
#> [43,] "Somervell"     "0"  ""              ""   
#> [44,] "Starr"         "0"  ""              ""   
#> [45,] "Stephens"      "1"  ""              ""   
#> [46,] "Sterling"      "0"  ""              ""   
#> [47,] "Stonewall"     "0"  ""              ""   
#> [48,] "Sutton"        "0"  ""              ""   
#> [49,] "Swisher"       "0"  ""              ""   
#> [50,] "Tarrant"       "34" ""              ""   
#> [51,] "Taylor"        "6"  ""              ""   
#> [52,] "Terrell"       "0"  ""              ""   
#> [53,] "Terry"         "1"  ""              ""   
#> [54,] "Throckmorton"  "0"  ""              ""   
#> [55,] "Titus"         "0"  ""              ""   
#> [56,] "Tom Green"     "2"  ""              ""   
#> [57,] "Travis"        "10" ""              ""   
#> [58,] "Trinity"       "0"  ""              ""   
#> [59,] "Tyler"         "0"  ""              ""   
#> [60,] "Upshur"        "0"  ""              ""
```

If we check the output from the above code to the PDF, we can see that it worked. Every column in the PDF is in our output and the values were scraped correctly. This is great! Now we want to make two columns - "county" and "pregnant_females_booked" (or whatever you'd like to call it) - from these 10. As usual with R, there are a few ways we can do this. We'll just do two ways. First, since there are only 10 columns, we can just do it manually. We can use square bracket [] notation to grab specific columns using the column number (since the data is a matrix and not a data.frame we can't use dollar sign notation even if we wanted to). Let's print out the head of all the county columns. We can see from the PDF that these are columns 1, 3, 5, 7, and 9. So can use a vector of numbers to get that `c(1, 3, 5, 7, 9)`.


```r
head(data[, c(1, 3, 5, 7, 9)])
#>      [,1]        [,2]          [,3]         [,4]          [,5]           
#> [1,] "Anderson"  "Delta"       "Irion"      "Motley"      "Upton"        
#> [2,] "Andrews"   "Denton"      "Jack"       "Nacogdoches" "Uvalde"       
#> [3,] "Angelina"  "DeWitt"      "Jackson"    "Navarro"     "Val Verde (P)"
#> [4,] "Aransas"   "Dickens"     "Jasper"     "Newton"      "Van Zandt"    
#> [5,] "Archer"    "Dickens (P)" "Jeff Davis" "Newton (P)"  "Victoria"     
#> [6,] "Armstrong" "Dimmit"      "Jefferson"  "Nolan"       "Walker"
```

Now again for the "pregnant_females_booked" column.


```r
head(data[, c(2, 4, 6, 8, 10)])
#>      [,1] [,2] [,3] [,4] [,5]
#> [1,] "0"  "0"  "0"  "0"  "0" 
#> [2,] "1"  "3"  "0"  "2"  "0" 
#> [3,] "0"  "0"  "1"  "2"  "1" 
#> [4,] "0"  "0"  "0"  "0"  "0" 
#> [5,] "1"  "0"  "0"  "0"  "1" 
#> [6,] "0"  "0"  "0"  "2"  "1"
```

These results look right so we can make a data.frame using the `data.frame()` and having the input be from the above code - removing the `head()` function since we want every now. Conveniently, `data.frame()` allows us to name the columns we are making so we'll name the two columns "county" and "pregnant_females_booked". We'll save the result as `data` and check out the `head()` and `tail()` of that data.frame.


```r
data <- data.frame(county = c(data[, c(1, 3, 5, 7, 9)]),
              pregnant_females_booked = c(data[, c(2, 4, 6, 8, 10)]))
head(data)
#>      county pregnant_females_booked
#> 1  Anderson                       0
#> 2   Andrews                       1
#> 3  Angelina                       0
#> 4   Aransas                       0
#> 5    Archer                       1
#> 6 Armstrong                       0
tail(data)
#>     county pregnant_females_booked
#> 295                               
#> 296                               
#> 297                               
#> 298                               
#> 299                               
#> 300
```

These results look good! We now have only two columns and the fix six rows (from `head()`) look right. Why are the last six rows all empty? Look back at the PDF. The final two columns are shorter than the others, so `extract_tables()` interprets them as empty strings "". We can subset those away using a conditional statement remove any row with an empty string in either column. Since we know that if there's an empty string in one of the columns it will also be there in the other, we only need to run this once.


```r
data <- data[data$county != "", ]
head(data)
#>      county pregnant_females_booked
#> 1  Anderson                       0
#> 2   Andrews                       1
#> 3  Angelina                       0
#> 4   Aransas                       0
#> 5    Archer                       1
#> 6 Armstrong                       0
tail(data)
#>         county pregnant_females_booked
#> 260       Wood                       0
#> 261     Yoakum                       0
#> 262      Young                       0
#> 263     Zapata                       0
#> 264     Zavala                       0
#> 265 Zavala (P)                       0
```

Now the results from `tail()` look right. First, I'm rerunning the code to scrape the PDF since now our `data` data set is already cleaned from above. 


```r
data <- extract_tables(file = "data/PregnantFemaleReportingCurrent.pdf")
data <- data[[1]]
```

We'll use a toy example now with a vector of numbers from 1 to 10 `1:10` which we can call `x`.


```r
x <- 1:10
x
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

Now say we want every value of x and want to use Booleans (true or false value) to get it. Since we need a vector of 10 values since we'd need one for every element in `x`. Specifically, we'd be using square bracket [] notation to subset (in this case not really a true subset since we'd return all the original values) and write ten TRUEs in the square brackets [].


```r
x[c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)]
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

If you're reading the code carefully, you might have notices that I only wrote nine TRUE values. Since R was expecting 10 values, when I only gave it nine, it started again from the beginning and used the first value in place of the expected tenth value. If we only wrote one TRUEs, R would just repeat that all 10 times.


```r
x[c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)]
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

What happens when the value isn't always TRUE? It'll recycle it the exact same way. Let's try using now a vector `c(TRUE, FALSE)`.


```r
x[c(TRUE, FALSE)]
#> [1] 1 3 5 7 9
```

It returns only the odd numbers. That's because the first value in our vector is TRUE so it returns the first value of `x` which is 1. The next value is FALSE so it does not return the second value of `x` which is 2. R then "recycles" our vector and uses the first value in our vector (TRUE) to interpret how to subset the third value of `x` (3). Since it's TRUE, it returns 3. But now the value for 4 is FALSE so it doesn't return it. The process repeats again until the end of the subset. Since every other value is returned, it returns only the odd numbers. We can use R's method of "recycling" a vector that is shorter than it expects to solve our pregnant females booked issue. Indeed we can use this exact `c(TRUE, FALSE)` vector to select only the odd columns. Reversing it to `c(FALSE, TRUE)` gives us only the even columns. So we'll copy over the code that made the data.frame last time and change the `c(data[, c(1, 3, 5, 7, 9)]` to `c(data[, c(TRUE, FALSE)])` and the `c(data[, c(2, 4, 6, 8, 10)])` to `c(data[, c(FALSE, TRUE)])`. Since the issue of empty strings is still there, we'll reuse the `data <- data[data$county != "", ]` we made above to fix it. 


```r
data <- data.frame(county = c(data[, c(TRUE, FALSE)]),
                   pregnant_females_booked = c(data[, c(FALSE, TRUE)]))
data <- data[data$county != "", ]
head(data)
#>      county pregnant_females_booked
#> 1  Anderson                       0
#> 2   Andrews                       1
#> 3  Angelina                       0
#> 4   Aransas                       0
#> 5    Archer                       1
#> 6 Armstrong                       0
tail(data)
#>         county pregnant_females_booked
#> 260       Wood                       0
#> 261     Yoakum                       0
#> 262      Young                       0
#> 263     Zapata                       0
#> 264     Zavala                       0
#> 265 Zavala (P)                       0
```

## Making PDF-scraped data available to others

You've now seen two examples of scraping tables from PDFs using the `tabulizer()` package and a few more from the `pdftools` package in Chapter \@ref(scrape-table). These lessons should get you started on most PDF scraping, but every PDF is different so don't rely on the functions alone to do all of the work. You'll still likely have to spend some time cleaning up the data afterwards to make it usable. This chapter is being written in 2020 which should be long after we ever need to get data from PDFs - it should be available in much easier to access formats. However, often we still need to scrape PDFs to get data necessary for research. 

Given the effort you'll spend in scraping a PDF - and the relative rarity of this skill in criminology - I recommend that you help others by making your data available to the public. There are several current websites that let you do this but I recommend [openICPSR](https://www.icpsr.umich.edu/web/pages/NACJD/index.html). openICPSR is the version of [ICPSR](https://www.icpsr.umich.edu/web/pages/) (Inter-university Consortium for Political and Social Research) which is essentially a massive repository of data. openICPSR lets people submit data for free (under a certain limit, 3GB per submission as of mid-2020) and has a number of features to make it easier to store and document the data. This includes a section to describe your data in text form, fill out tags to help people search for the data, and answer (optional) questions on how the data collection and the geographic and temporal scope of the data. If you decide to update the data, it'll keep a link to your older submission so you essentially have versions of the data. When you update the data, I recommend having a section on the submission description describing the changes in each version. This is useful for record-keeping and (though be careful because the link to the submission also changes when you update it so you'll need to change that if you have links on any document such as a CV). Below are a few images showing the submission page for one of my submissions that has many versions (and corresponding version notes). 

![](images/openICPSR1.PNG)

![](images/openICPSR2.PNG)

![](images/openICPSR3.PNG)
