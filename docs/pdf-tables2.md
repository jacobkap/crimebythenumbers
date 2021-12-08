# More scraping tables from PDFs {#scrape-table2}

For this chapter you'll need the following files, which are available for download [here](https://github.com/jacobkap/r4crimz/tree/master/data): AbbreRptCurrent.pdf and PregnantFemaleReportingCurrent.pdf.


In Chapter \@ref(scrape-table) we used the package `pdftools` to scrape tables on arrests/seizures from the United States Border Patrol that were only available in a PDF. Given the importance of PDF scraping, in this chapter we'll continue working on scraping tables from PDFs. Here we will use the package `tabulizer` which has a number of features making it especially useful for grabbing tables from PDFs.

One issue which we saw in Chapter \@ref(scrape-table) is that the table may not be the only thing on the page - the page could also have a title, page number, etc. When using `pdftools` we use regular expressions and subsetting to remove all the extra lines. Using `tabulizer` we can simply say (through a handy function) that we only want a part of the page, so we only scrape the table itself.  For more info about the `tabulizer` package please see its site [here](https://docs.ropensci.org/tabulizer/). 

## Texas jail data

For this chapter we'll scrape data from the Texas Commission on Jail Standards - Abbreviated Population Report. This is a report that shows monthly data on people incarcerated in jails for counties in Texas. This PDF is 9 pages long because of how many counties there are in Texas. Let's take a look at what the first page looks like. If you look at the PDF yourself you'll see that every page follows the format of the 1st page, which greatly simplifies our scrape. The data is in county-month units which means that each row of data has info for a single county in a single month. We know that because the first column is "County" and each row is a single county (this is not true is every case. For example, on page 3 there are the rows 'Fannin 1(P)' and 'Fannin 2(P)', possibly indicating that there are two jails in that county. It is unclear from this PDF what the '(P)' means.). For knowing that the data is monthly, the title of this document says 'for 06/01/2020' indicating that it is for that date, though this doesn't by itself mean the data is monthly - it could be daily based only on this data. 

To know for sure that it is monthly data we'd have to go to the original source on the Texas Commission on Jail Standards website [here](https://www.tcjs.state.tx.us/historical-population-reports/#1580454195676-420daca6-0a306). On this page it says that 'Monthly population reports are available for review below," which tells us that the data is monthly. It's important to know the unit so you can understand the data properly - primarily so you know what kinds of questions you can answer. If someone asks whether yearly trends on jail incarceration change in Texas, you can answer that with this data. If they ask whether more people are in jail on a Tuesday than on a Friday, you can't.

Just to understand what units our data is in we had to look at both the PDF itself and the site it came from. This kind of multi-step process is tedious but often necessary to truly understand your data. And even now we have questions - what does the (P) that's in some rows mean? For this we'd have to email or call the people who handle the data and ask directly. This is often the easiest way to answer your question, though different organizations have varying speeds in responding - if ever. 

Now let's look at what columns are available. It looks like each column is the number of people incarcerated in the jail, broken down into categories of people. For example, the first two columns after County are "Pretrial Felons" and "Conv. Felons" so those are probably how many people are incarcerated who are awaiting trial for a felony and those already convicted of a felony. The other columns seem to follow this same format until the last few ones which describe the jails capacity (i.e. how many people they can hold), what percent of capacity they are at, and specifically how many open beds they have. 

<img src="images/tabulizer1.PNG" width="90%" style="display: block; margin: auto;" />

Now that we've familiarized ourselves with the data, let's begin scraping this data using `tabulizer`. If you don't have this package installed, you'll need to install it using `install.packages("tabulizer")`. Then we'll need to run `library(tabulizer)`.


```r
install.packages("tabulizer")
```



```r
library(tabulizer)
```

The main function that we'll be using from the `tabulizer` package is `extract_tables()`. In the parentheses we need to put the name of our PDF (in quotes). This function basically looks at a PDF page, figures out which part of the page is a table, and then scrapes just that table. As we'll see, it's not always perfect at figuring out what part of the page is a table so we can also tell it exactly where to look. You can look at all of the features of `extract_tables()` by running `help(extract_tables)`. 


```r
data <- extract_tables(file = "data/AbbreRptCurrent.pdf")
```

Normally we'd now look at the `head()` of our data object, but if we did that it would print out a very large amount of information. Instead, we'll check how long our object is using `length()` which tells us how many elements a vector or list has. We'll also check what type of data it is since different types of data (e.g. vector, data.frame) operate differently.


```r
length(data)
#> [1] 18
is(data)
#> [1] "list"   "vector"
```


We learn that it is a list of length of 18, or has 18 elements in it. Why is this? We have 9 pages so it is reasonable that we would have 9 lists since we have one table per page, but we shouldn't have 18 tables. 

Back in Section \@ref(other-data-structures) I said that lists are one of the data types that we don't have to worry about as we don't use them much in this book. That's still true. Our data object is a list and we want to convert this to a data.frame as quickly as possible. The important thing to know when interacting with a list is that subsetting here uses two pairs of square brackets `[[]]` instead of one pair of square brackets for a normal vector.

Let's look again at just the first table in our object, subsetting using `[[1]]`.


```r
data[[1]]
#>      [,1]     [,2]       [,3]     [,4]           [,5]       
#> [1,] ""       ""         ""       "Conv. Felons" ""         
#> [2,] ""       ""         ""       "Sentenced to" ""         
#> [3,] ""       ""         ""       "County Jail"  ""         
#> [4,] ""       "Pretrial" "Conv."  ""             "Parole"   
#> [5,] ""       ""         ""       "time"         ""         
#> [6,] "County" "Felons"   "Felons" ""             "Violators"
#>      [,6]         [,7]       [,8]    [,9]       [,10]     [,11]     
#> [1,] "Parole"     ""         ""      ""         ""        ""        
#> [2,] "Violators"  ""         ""      ""         ""        ""        
#> [3,] "with a New" ""         ""      ""         ""        ""        
#> [4,] ""           "Pretrial" "Conv." "Bench"    ""        "Pretrial"
#> [5,] "Charge"     ""         ""      ""         ""        ""        
#> [6,] ""           "Misd."    "Misd." "Warrants" "Federal" "SJF"     
#>      [,12]         [,13]           [,14]    [,15]   [,16]     
#> [1,] "Conv. SJF"   "Conv."         ""       ""      ""        
#> [2,] "Sentenced"   "SJF"           ""       ""      ""        
#> [3,] "to Co. Jail" "Sentenced"     ""       ""      ""        
#> [4,] ""            ""              "Total"  "Total" "Total"   
#> [5,] "Time"        "to State Jail" ""       ""      ""        
#> [6,] ""            ""              "Others" "Local" "Contract"
#>      [,17]        [,18]      [,19]      [,20]      
#> [1,] ""           ""         ""         ""         
#> [2,] ""           ""         ""         ""         
#> [3,] ""           ""         ""         ""         
#> [4,] "Total"      "Total"    "% of"     "Available"
#> [5,] ""           ""         ""         ""         
#> [6,] "Population" "Capacity" "Capacity" "Beds"
```

The results from `data[[1]]` provide some answers. It has the right number of columns but only 6 rows! This is our first table so should be the entire table we can see on page 1. Instead, it appears to be just the column names, with 6 rows because some column names are on multiple rows. Here's the issue, we can read the table and easily see that the column names may be on multiple rows but belong together, and that they are part of the table. `tabulizer` can't see this obvious fact. It must rely on a series of rules to indicate what is part of a table and what isn't. 

For example, having white space between columns and thin black lines around rows tells it where each row and column is. Our issue is that the column names appear to just be text until there is a thick black line and (in `tabulizer's` mind) the table begins, so it keeps the column name part separate from the rest of the table. Now let's look closer at the second element in our data object and see if it is correct for the table on page 1 of our PDF. 


```r
head(data[[2]])
#>      [,1]        [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
#> [1,] "Anderson"  "81" "13" "3"  "1"  "5"  "12" "1"  "0"  "0"   "21" 
#> [2,] "Andrews"   "23" "11" "0"  "2"  "4"  "11" "0"  "0"  "0"   "5"  
#> [3,] "Angelina"  "79" "35" "4"  "6"  "0"  "14" "0"  "3"  "0"   "23" 
#> [4,] "Aransas"   "23" "10" "0"  "2"  "6"  "7"  "0"  "6"  "73"  "2"  
#> [5,] "Archer"    "12" "3"  "0"  "0"  "1"  "3"  "1"  "1"  "2"   "5"  
#> [6,] "Armstrong" "1"  "1"  "0"  "0"  "0"  "0"  "0"  "0"  "0"   "0"  
#>      [,12] [,13] [,14] [,15] [,16] [,17] [,18] [,19]   [,20]
#> [1,] "0"   "1"   "0"   "138" "0"   "138" "300" "46.00" "132"
#> [2,] "0"   "6"   "0"   "35"  "0"   "35"  "50"  "70.00" "10" 
#> [3,] "0"   "3"   "1"   "168" "0"   "168" "279" "60.22" "83" 
#> [4,] "0"   "0"   "0"   "56"  "73"  "129" "212" "60.85" "62" 
#> [5,] "0"   "0"   "1"   "26"  "9"   "35"  "48"  "72.92" "0"  
#> [6,] "0"   "0"   "0"   "2"   "0"   "2"   "8"   "25.00" "0"
tail(data[[2]])
#>       [,1]         [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
#> [24,] "Brooks"     "15" "1"  "1"  "1"  "0"  "0"  "0"  "0"  "0"  
#> [25,] "Brooks (P)" "0"  "0"  "0"  "0"  "0"  "0"  "0"  "0"  "164"
#> [26,] "Brown"      "70" "20" "0"  "7"  "20" "9"  "0"  "2"  "0"  
#> [27,] "Burleson"   "19" "2"  "0"  "2"  "0"  "3"  "0"  "0"  "0"  
#> [28,] "Burnet"     "57" "23" "1"  "5"  "9"  "3"  "0"  "1"  "0"  
#> [29,] "Caldwell"   "89" "4"  "0"  "3"  "2"  "26" "1"  "2"  "19" 
#>       [,11] [,12] [,13] [,14] [,15] [,16] [,17] [,18] [,19]   [,20]
#> [24,] "0"   "0"   "0"   "0"   "18"  "0"   "18"  "36"  "50.00" "14" 
#> [25,] "0"   "0"   "0"   "0"   "0"   "408" "408" "652" "62.58" "179"
#> [26,] "0"   "3"   "0"   "2"   "133" "7"   "140" "196" "71.43" "36" 
#> [27,] "0"   "0"   "0"   "1"   "27"  "0"   "27"  "96"  "28.13" "59" 
#> [28,] "10"  "1"   "0"   "0"   "110" "158" "268" "595" "45.04" "268"
#> [29,] "13"  "0"   "3"   "0"   "143" "21"  "164" "301" "54.49" "107"
```

We're looking just at the `head()` and `tail()` to get the first and last six rows as otherwise we'd print out all 29 rows in that table. When you are exploring you own data, you'll probably want to be more thorough and ensure that rows around the middle are also correct - but this is a good first pass. If you look at the output we just printed out and compare it to the PDF, you'll see that the scrape was successful. Every row is where it should be and the columns are correct - unlike when using `pdftools()`, we have the results already in proper columns.

One thing to note is that this data isn't in a data.frame format, it's in a matrix. Matrices are the default output of `extract_tables()` though you can set it to output a data.frame by setting the parameter `output = "data.frame"`. In our case we actually wouldn't want that due to the issue of the column names. As shown below, outputting to a data.frame will automatically take the first row of data and convert that to column names. So now we have our first county as the column names, which is not correct. Note too that the function added "X" before the column names which are numbers. That's because column names cannot start with a number so the function tries to fix it by adding the "X" to the start. 


```r
data <- extract_tables(file = "data/AbbreRptCurrent.pdf", output = "data.frame")
head(data[[2]])
#>    Anderson X81 X13 X3 X1 X5 X12 X1.1 X0 X0.1 X21 X0.2 X1.2 X0.3 X138
#> 1   Andrews  23  11  0  2  4  11    0  0    0   5    0    6    0   35
#> 2  Angelina  79  35  4  6  0  14    0  3    0  23    0    3    1  168
#> 3   Aransas  23  10  0  2  6   7    0  6   73   2    0    0    0   56
#> 4    Archer  12   3  0  0  1   3    1  1    2   5    0    0    1   26
#> 5 Armstrong   1   1  0  0  0   0    0  0    0   0    0    0    0    2
#> 6  Atascosa  54   2  0  8  4  21    0  5    0  29    0    4    0  127
#>   X0.4 X138.1 X300 X46.00 X132
#> 1    0     35   50  70.00   10
#> 2    0    168  279  60.22   83
#> 3   73    129  212  60.85   62
#> 4    9     35   48  72.92    0
#> 5    0      2    8  25.00    0
#> 6   29    156  250  62.40   69
```

Let's rerun the `extract_tables()` function, this time keeping it as outputting a matrix.


```r
data <- extract_tables(file = "data/AbbreRptCurrent.pdf")
```

Since the column names are the same of each page, we can set the names manually. There are 20 columns so this will be a lot of writing, but it's simpler and quicker than trying to do it programmatically. Since each table will have the same column names, we'll want to create a vector with the column names to use for every table. Following normal naming conventions, we'll make everything lowercase and the only punctuation we'll use is an underscore.


```r
column_names <- c("county",
                  "pretrial_felons",
                  "conv_felons",
                  "conv_felons_sentence_to_county_jail_time",
                  "parole_violators",
                  "parole_violators_with_a_new_charge",
                  "pretrial_misd",
                  "conv_misd",
                  "bench_warrants",
                  "federal",
                  "pretrial_sjf",
                  "conv_sjf_sentenced_to_co_jail_time",
                  "conv_sjf_sentence_to_state_jail",
                  "total_others",
                  "total_local",
                  "total_contract",
                  "total_population",
                  "total_capacity",
                  "percent_of_capacity",
                  "available_beds")
```

We can combine the results from this vector with that of the second table to have a complete table from page 1 of our PDF. We do this first by making the second element from our data object into a data.frame. Then we use `names()` and assign the column names to that of the vector of names we just made. Since this is the table from page 1 of the PDF, we'll call the object `page1_table`.


```r
page1_table <- data[[2]]
page1_table <- data.frame(page1_table)
names(page1_table) <- column_names
page1_table
#>        county pretrial_felons conv_felons
#> 1    Anderson              81          13
#> 2     Andrews              23          11
#> 3    Angelina              79          35
#> 4     Aransas              23          10
#> 5      Archer              12           3
#> 6   Armstrong               1           1
#> 7    Atascosa              54           2
#> 8      Austin              17           2
#> 9      Bailey              10           2
#> 10    Bandera              26           8
#> 11    Bastrop             111           4
#> 12     Baylor               7           1
#> 13        Bee              24           5
#> 14       Bell             365          74
#> 15      Bexar            1552         225
#> 16     Blanco               7           2
#> 17     Borden               1           0
#> 18     Bosque               4           1
#> 19  Bowie (P)              31          29
#> 20   Brazoria             219         167
#> 21     Brazos             200          78
#> 22   Brewster               3           0
#> 23    Briscoe               0           0
#> 24     Brooks              15           1
#> 25 Brooks (P)               0           0
#> 26      Brown              70          20
#> 27   Burleson              19           2
#> 28     Burnet              57          23
#> 29   Caldwell              89           4
#>    conv_felons_sentence_to_county_jail_time parole_violators
#> 1                                         3                1
#> 2                                         0                2
#> 3                                         4                6
#> 4                                         0                2
#> 5                                         0                0
#> 6                                         0                0
#> 7                                         0                8
#> 8                                         0                1
#> 9                                         0                0
#> 10                                        0                1
#> 11                                        0               13
#> 12                                        0                0
#> 13                                        1                0
#> 14                                        1               32
#> 15                                       56              288
#> 16                                        0                1
#> 17                                        0                0
#> 18                                        0                0
#> 19                                        0                2
#> 20                                       10               17
#> 21                                        3               16
#> 22                                        0                0
#> 23                                        0                0
#> 24                                        1                1
#> 25                                        0                0
#> 26                                        0                7
#> 27                                        0                2
#> 28                                        1                5
#> 29                                        0                3
#>    parole_violators_with_a_new_charge pretrial_misd conv_misd
#> 1                                   5            12         1
#> 2                                   4            11         0
#> 3                                   0            14         0
#> 4                                   6             7         0
#> 5                                   1             3         1
#> 6                                   0             0         0
#> 7                                   4            21         0
#> 8                                   3             3         0
#> 9                                   0             4         0
#> 10                                  3             3         2
#> 11                                 11            22         1
#> 12                                  0             2         0
#> 13                                  8             4         0
#> 14                                 53            55        13
#> 15                                302           253        10
#> 16                                  0             1         0
#> 17                                  0             2         0
#> 18                                  1             1         1
#> 19                                  5            22         4
#> 20                                 29            34        18
#> 21                                 66            37         8
#> 22                                  0             0         0
#> 23                                  0             0         0
#> 24                                  0             0         0
#> 25                                  0             0         0
#> 26                                 20             9         0
#> 27                                  0             3         0
#> 28                                  9             3         0
#> 29                                  2            26         1
#>    bench_warrants federal pretrial_sjf
#> 1               0       0           21
#> 2               0       0            5
#> 3               3       0           23
#> 4               6      73            2
#> 5               1       2            5
#> 6               0       0            0
#> 7               5       0           29
#> 8               0       0            5
#> 9               0      56            0
#> 10              0       0            1
#> 11              4      70           17
#> 12              0       0            0
#> 13              2      21            0
#> 14              1      11           66
#> 15             52       2          287
#> 16              0       0            1
#> 17              0       0            0
#> 18              1       0            1
#> 19              2      47           24
#> 20             15       0           96
#> 21              6       0           52
#> 22              0      38            0
#> 23              0       0            0
#> 24              0       0            0
#> 25              0     164            0
#> 26              2       0            0
#> 27              0       0            0
#> 28              1       0           10
#> 29              2      19           13
#>    conv_sjf_sentenced_to_co_jail_time conv_sjf_sentence_to_state_jail
#> 1                                   0                               1
#> 2                                   0                               6
#> 3                                   0                               3
#> 4                                   0                               0
#> 5                                   0                               0
#> 6                                   0                               0
#> 7                                   0                               4
#> 8                                   0                               0
#> 9                                   0                               2
#> 10                                  0                               1
#> 11                                  1                               0
#> 12                                  0                               0
#> 13                                  0                               0
#> 14                                  0                              10
#> 15                                  5                              52
#> 16                                  0                               0
#> 17                                  0                               0
#> 18                                  0                               0
#> 19                                  2                               4
#> 20                                  0                              35
#> 21                                  0                              20
#> 22                                  0                               0
#> 23                                  0                               0
#> 24                                  0                               0
#> 25                                  0                               0
#> 26                                  3                               0
#> 27                                  0                               0
#> 28                                  1                               0
#> 29                                  0                               3
#>    total_others total_local total_contract total_population
#> 1             0         138              0              138
#> 2             0          35              0               35
#> 3             1         168              0              168
#> 4             0          56             73              129
#> 5             1          26              9               35
#> 6             0           2              0                2
#> 7             0         127             29              156
#> 8             2          32              0               32
#> 9             1          19             59               78
#> 10            0          45             11               56
#> 11            0         184             72              256
#> 12            0           0              0                0
#> 13            2          46             21               67
#> 14            3         672             11              683
#> 15          379        3461             11             3472
#> 16            0          12              0               12
#> 17            0           0              0                0
#> 18            2          12              0               12
#> 19            1         126            490              616
#> 20           14         654              0              654
#> 21           24         510              0              510
#> 22            0           3             38               41
#> 23            0           0              0                0
#> 24            0          18              0               18
#> 25            0           0            408              408
#> 26            2         133              7              140
#> 27            1          27              0               27
#> 28            0         110            158              268
#> 29            0         143             21              164
#>    total_capacity percent_of_capacity available_beds
#> 1             300               46.00            132
#> 2              50               70.00             10
#> 3             279               60.22             83
#> 4             212               60.85             62
#> 5              48               72.92              0
#> 6               8               25.00              0
#> 7             250               62.40             69
#> 8              90               35.56             49
#> 9              96               81.25              0
#> 10             96               58.33             30
#> 11            400               64.00            104
#> 12              0                0.00              0
#> 13            128               52.34             48
#> 14           1184               57.69            383
#> 15           5108               67.97           1125
#> 16             56               21.43             38
#> 17              0                0.00              0
#> 18             64               18.75             46
#> 19            921               66.88            213
#> 20           1170               55.90            399
#> 21           1089               46.83            470
#> 22             56               73.21              0
#> 23              0                0.00              0
#> 24             36               50.00             14
#> 25            652               62.58            179
#> 26            196               71.43             36
#> 27             96               28.13             59
#> 28            595               45.04            268
#> 29            301               54.49            107
```

Looking at the results, we've done this correctly. The values are right and the column names are correct. We've done it for one page but now must add the remaining pages. We'll do this through a for loop. We want to take the code we used above and loop through each of the tables we have. Since have of our tables are just the column names and not actual data, we need to skip those elements in our for loop. Luckily, our data follows a pattern where the first element is the column names from page 1, the second is the data from page 1, the third is the column names from page 2, the fourth is the data from page 2, and so on. So we need only every other value from 1 to 18, or every even number. We can get every other value using logical values, as shown in the next section, but since we only have 18 elements we'll just create the simple vector ourselves: c(2, 4, 6, 8, 10, 12, 14, 16, 18). 

For our for loop we can copy the code above but let's change the object name from "page1_table" to "temp" as each iteration will be of a different page so "page1_table" doesn't make sense.


```r
for (i in c(2, 4, 6, 8, 10, 12, 14, 16, 18)) {
  temp        <- data[[i]]
  temp        <- data.frame(temp)
  names(temp) <- column_names
}
```

Running the above code runs our for loop successfully but doesn't assign the output anywhere. It just runs one iteration, assigns it to temp, and then overwrites temp for the next iteration. What we really want is a single object which will end up having every single row of data from every page in one data.frame. To do this we make an empty data.frame by saying some object gets `data.frame()` without anything in the parentheses. And then for every iteration of the loop we add the data that is in temp to this empty data.frame (which will soon fill up with data). 

By creating an empty data.frame at the start we avoid having to name any of the column names or say how many rows of data there will be. To add data to this data.frame each iteration we will use the function `bind_rows()` from `dplyr` which stacks data sets on top of each other. Let's first look at a simple example of this before including it in our for loop. To use `bind_rows()` we put two (or more) data.frames as the parameters and it will return a single data set will all rows stacked together. Let's create two data.frames that each have the rows of `head(mtcars)` as a demonstration.


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
example1 <- head(mtcars)
example2 <- head(mtcars)
bind_rows(example1, example2)
#>                         mpg cyl disp  hp drat    wt  qsec vs am gear
#> Mazda RX4...1          21.0   6  160 110 3.90 2.620 16.46  0  1    4
#> Mazda RX4 Wag...2      21.0   6  160 110 3.90 2.875 17.02  0  1    4
#> Datsun 710...3         22.8   4  108  93 3.85 2.320 18.61  1  1    4
#> Hornet 4 Drive...4     21.4   6  258 110 3.08 3.215 19.44  1  0    3
#> Hornet Sportabout...5  18.7   8  360 175 3.15 3.440 17.02  0  0    3
#> Valiant...6            18.1   6  225 105 2.76 3.460 20.22  1  0    3
#> Mazda RX4...7          21.0   6  160 110 3.90 2.620 16.46  0  1    4
#> Mazda RX4 Wag...8      21.0   6  160 110 3.90 2.875 17.02  0  1    4
#> Datsun 710...9         22.8   4  108  93 3.85 2.320 18.61  1  1    4
#> Hornet 4 Drive...10    21.4   6  258 110 3.08 3.215 19.44  1  0    3
#> Hornet Sportabout...11 18.7   8  360 175 3.15 3.440 17.02  0  0    3
#> Valiant...12           18.1   6  225 105 2.76 3.460 20.22  1  0    3
#>                        carb
#> Mazda RX4...1             4
#> Mazda RX4 Wag...2         4
#> Datsun 710...3            1
#> Hornet 4 Drive...4        1
#> Hornet Sportabout...5     2
#> Valiant...6               1
#> Mazda RX4...7             4
#> Mazda RX4 Wag...8         4
#> Datsun 710...9            1
#> Hornet 4 Drive...10       1
#> Hornet Sportabout...11    2
#> Valiant...12              1
```
The data that is printed out has 12 rows and in this example the first six and the last six rows are identical. `bind_rows()` took the second object in the parentheses (example2) and stacked it right below the last row in example1. In this case the columns are already in the same order but if they weren't, `bind_rows()` is smart enough to arrange the columns in the second object to be the same as the first object.

Now we can run our for loop and create a single data set with every row from our 9 pages of data. We start by creating our empty data.frame and we'll call that "final." At the end of our loop we say that final gets `bind_rows(final, temp)` meaning that temp is stacked to the bottom of final every time the loop runs. We'll end this code chunk by looking at `head()` and `tail()` of final to be sure it worked correctly.


```r
final <- data.frame()
for (i in c(2, 4, 6, 8, 10, 12, 14, 16, 18)) {
  temp        <- data[[i]]
  temp        <- data.frame(temp)
  names(temp) <- column_names
  final       <- bind_rows(final, temp)
}
#> New names:
#> * NA -> ...21
head(final)
#>      county pretrial_felons conv_felons
#> 1  Anderson              81          13
#> 2   Andrews              23          11
#> 3  Angelina              79          35
#> 4   Aransas              23          10
#> 5    Archer              12           3
#> 6 Armstrong               1           1
#>   conv_felons_sentence_to_county_jail_time parole_violators
#> 1                                        3                1
#> 2                                        0                2
#> 3                                        4                6
#> 4                                        0                2
#> 5                                        0                0
#> 6                                        0                0
#>   parole_violators_with_a_new_charge pretrial_misd conv_misd
#> 1                                  5            12         1
#> 2                                  4            11         0
#> 3                                  0            14         0
#> 4                                  6             7         0
#> 5                                  1             3         1
#> 6                                  0             0         0
#>   bench_warrants federal pretrial_sjf
#> 1              0       0           21
#> 2              0       0            5
#> 3              3       0           23
#> 4              6      73            2
#> 5              1       2            5
#> 6              0       0            0
#>   conv_sjf_sentenced_to_co_jail_time conv_sjf_sentence_to_state_jail
#> 1                                  0                               1
#> 2                                  0                               6
#> 3                                  0                               3
#> 4                                  0                               0
#> 5                                  0                               0
#> 6                                  0                               0
#>   total_others total_local total_contract total_population
#> 1            0         138              0              138
#> 2            0          35              0               35
#> 3            1         168              0              168
#> 4            0          56             73              129
#> 5            1          26              9               35
#> 6            0           2              0                2
#>   total_capacity percent_of_capacity available_beds ...21
#> 1            300               46.00            132  <NA>
#> 2             50               70.00             10  <NA>
#> 3            279               60.22             83  <NA>
#> 4            212               60.85             62  <NA>
#> 5             48               72.92              0  <NA>
#> 6              8               25.00              0  <NA>
tail(final)
#>         county pretrial_felons conv_felons
#> 264     Yoakum                           6
#> 265      Young                          19
#> 266     Zapata                          15
#> 267     Zavala                          16
#> 268 Zavala (P)                           0
#> 269                      Total       29173
#>     conv_felons_sentence_to_county_jail_time parole_violators
#> 264                                        1                0
#> 265                                        5                0
#> 266                                        1                0
#> 267                                        0                0
#> 268                                        0                0
#> 269                                     5814              383
#>     parole_violators_with_a_new_charge pretrial_misd conv_misd
#> 264                                  0             0         1
#> 265                                  5             1         3
#> 266                                  0             0         5
#> 267                                  3             0         4
#> 268                                  0             0         0
#> 269                               2700          3180      3370
#>     bench_warrants federal pretrial_sjf
#> 264              0       0            0
#> 265              1       0            0
#> 266              0       1           58
#> 267              0       0            0
#> 268              0       0            0
#> 269            415     816         4354
#>     conv_sjf_sentenced_to_co_jail_time
#> 264                                  2
#> 265                                  6
#> 266                                  5
#> 267                                  0
#> 268                                  0
#> 269                               4195
#>     conv_sjf_sentence_to_state_jail total_others total_local
#> 264                               0            0           0
#> 265                               1            0           0
#> 266                               0            0           0
#> 267                               0            0           0
#> 268                               0            0           0
#> 269                             161         1186        2790
#>     total_contract total_population total_capacity
#> 264              9               21             30
#> 265             41                2             43
#> 266             27               58             85
#> 267             22               17             39
#> 268              0                0              0
#> 269          53017             6696          59713
#>     percent_of_capacity available_beds ...21
#> 264                  48          62.50    13
#> 265                 144          29.86    87
#> 266                 240          35.42   131
#> 267                  66          59.09    20
#> 268                   0                    0
#> 269               93991          63.53 24681
```

## Pregnant women incarcerated

We'll finish this lesson with another example of data from Texas - this time using data on the number of pregnant women booked in Texas county jails. This data has a unique challenge, it has 10 columns but we want to make it have only 2. In the data (shown below), it starts with a column of county names, then a column of the number of pregnant women booked into that county's jail. Next is another column of county names - instead of continuing onto another page, this data just makes new columns when it runs out of room. We'll scrape this PDF using `tabulizer()` and then work to fix this multiple-column issue. 

<img src="images/pregnant.PNG" width="90%" style="display: block; margin: auto;" />

Notice that this data doesn't even have column names so we'll have to make them ourselves. This is always a bit risky as maybe next month the table will change and if we hard-code any column names, we'll either have code that breaks or - much more dangerous - mislabel the columns without noticing. In cases like this we have no other choice, but if you intend to scrape something that recurring - that is, that you'll scrape a future version of - be careful about situations like this.

We'll start scraping this PDF using the standard `extract_tables()` function without any parameters other than the file name. This is usually a good start since it's quick and often works - and if it doesn't, we haven't lost much time checking. Since we know `extract_tables()` will return a list by default, we'll assign the result of `extract_tables()` to an object called `data` and then just pull the first element (the only element if this works) from that list.


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

If we check the output from the above code to the PDF, we can see that it worked. Every column in the PDF is in our output and the values were scraped correctly. This is great! Now we want to make two columns - "county" and "pregnant_females_booked" (or whatever you'd like to call it) - from these 10. As usual with R, there are a few ways we can do this. We'll just so two ways. 

First, since there are only 10 columns, we can just do it manually. We can use square bracket `[]` notation to grab specific columns using the column number (since the data is a matrix and not a data.frame we can't use dollar sign notation even if we wanted to). Let's print out the head of all the county columns. We can see from the PDF that these are columns 1, 3, 5, 7, and 9. So can use a vector of numbers to get that `c(1, 3, 5, 7, 9)`.


```r
head(data[, c(1, 3, 5, 7, 9)])
#>      [,1]        [,2]          [,3]         [,4]         
#> [1,] "Anderson"  "Delta"       "Irion"      "Motley"     
#> [2,] "Andrews"   "Denton"      "Jack"       "Nacogdoches"
#> [3,] "Angelina"  "DeWitt"      "Jackson"    "Navarro"    
#> [4,] "Aransas"   "Dickens"     "Jasper"     "Newton"     
#> [5,] "Archer"    "Dickens (P)" "Jeff Davis" "Newton (P)" 
#> [6,] "Armstrong" "Dimmit"      "Jefferson"  "Nolan"      
#>      [,5]           
#> [1,] "Upton"        
#> [2,] "Uvalde"       
#> [3,] "Val Verde (P)"
#> [4,] "Van Zandt"    
#> [5,] "Victoria"     
#> [6,] "Walker"
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

These results look good! We now have only two columns and the first six rows (from `head()`) look right. Why are the last six rows all empty? Look back at the PDF. The final two columns are shorter than the others, so `extract_tables()` interprets them as empty strings "". We can subset those away using a conditional statement to remove any row with an empty string in either column. Since we know that if there's an empty string in one of the columns it will also be there in the other, we only need to run this once.


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

Now the results from `tail()` look right. 

We can now use the second method which will use logical values to only keep odd or even columns (as the columns we want are conveniently all odd or all even columns). First, I'm rerunning the code to scrape the PDF since now our `data` data set is already cleaned from above. 


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

Now say we want every value of x and want to use logical values (also called Booleans) to get it. We need a vector of 10 values since we'd need one for every element in `x`. Specifically, we'd be using square bracket `[]` notation to subset (in this case not really a true subset since we'd return all the original values) and write ten TRUEs in the square brackets `[]`.


```r
x[c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)]
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

If you're reading the code carefully, you might have notices that I only wrote nine TRUE values. Since R was expecting 10 values, when I only gave it nine, it started again from the beginning and used the first value in place of the expected tenth value. If we only wrote one TRUE value, R would just repeat that all 10 times.


```r
x[TRUE]
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

What happens when the value isn't always TRUE? It'll recycle it the exact same way. Let's try using now a vector `c(TRUE, FALSE)`.


```r
x[c(TRUE, FALSE)]
#> [1] 1 3 5 7 9
```

It returns only the odd numbers. That's because the first value in our vector is TRUE so it returns the first value of `x` which is 1. The next value is FALSE so it does not return the second value of `x` which is 2. R then "recycles" our vector and uses the first value in our vector (TRUE) to interpret how to subset the third value of `x` (3). Since it's TRUE, it returns 3. But now the value for 4 is FALSE so it doesn't return it. The process repeats again until the end of the subset. Since every other value is returned, it returns only the odd numbers. 

We can use R's method of "recycling" a vector that is shorter than it expects to solve our pregnant females booked issue. Indeed we can use this exact `c(TRUE, FALSE)` vector to select only the odd columns. Reversing it to `c(FALSE, TRUE)` gives us only the even columns. 

So we'll copy over the code that made the data.frame last time and change the `c(data[, c(1, 3, 5, 7, 9)]` to `c(data[, c(TRUE, FALSE)])` and the `c(data[, c(2, 4, 6, 8, 10)])` to `c(data[, c(FALSE, TRUE)])`. Since the issue of empty strings is still there, we'll reuse the `data <- data[data$county != "", ]` we made above to fix it. 


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

You've now seen two examples of scraping tables from PDFs using the `tabulizer()` package and a few more examples from the `pdftools` package in Chapter \@ref(scrape-table). These lessons should get you started on most PDF scraping, but every PDF is different so don't rely on the functions alone to do all of the work. You'll still likely have to spend some time cleaning up the data afterwards to make it usable. 

Given the effort you'll spend in scraping a PDF - and the relative rarity of this skill in criminology - I recommend that you help others by making your data available to the public. There are several current websites that let you do this but I recommend [openICPSR](https://www.icpsr.umich.edu/web/pages/NACJD/index.html). openICPSR lets people submit data for free (under a certain limit, 3GB per submission as of mid-2020 though you can ask for a limit increase) and has a number of features to make it easier to store and document the data. This includes a section to describe your data in text form, fill out tags to help people search for the data, and answer (optional) questions on how the data was collected and the geographic and temporal scope of the data.

If you decide to update the data, it'll keep a link to your older submission so you essentially have versions of the data. When you update the data, I recommend having a section on the submission description describing the changes in each version. As an example of what it looks like when submitting data to openICPSR, below are a few images showing the submission page for one of my submissions that has many versions (and corresponding version notes). 

<img src="images/openICPSR1.PNG" width="90%" style="display: block; margin: auto;" />

<img src="images/openICPSR2.PNG" width="90%" style="display: block; margin: auto;" />

<img src="images/openICPSR3.PNG" width="90%" style="display: block; margin: auto;" />

## Practice problems

For answers, please see Section \@ref(problem-answers-chapter-24). Please keep in mind that the goal is to have your answers be the same as mine, even if the code isn't. With R you can answer a question in multiple ways, so different code can lead to the same answer.
