
# Scraping data from PDFs

In this section, we are going to explore officer-involved shootings (OIS) in Philadelphia. The Philadelphia Police Department posts a lot of information about officer-involved shootings online going back to 2007. Have a look at their [OIS webpage](http://www.phillypolice.com/ois/) . 

Our goal here and in the following lessons is to see how the number of officer-involved shootings changed over time and see where in Philadelphia they occurred. For this we need two pieces of information: the date each shooting occurred, and the location of each shooting. 

While a lot of information has been posted to the webpage, more information is buried in PDF files associated with each of the incidents. In order for us to explore these data, we are going to scrape the basic information from the webpage as well as the PDFs.

## Downloading officer-involved Shooting Files

We will use the package `rvest` which we used to webscrape movie data to help download these files and to get some information off the web page.

As always, we need to use `library()` to tell R we are going to use functions from this package.


```r
library(rvest)
#> Loading required package: xml2
```

The last time we used `rvest` we did so to get information about movie ticket sales by grabbing data from a table on the page. In this case we are using it for two purposes: to get the link of each PDF on the page to download and to get the address of each incident. Each year of data has it's own table with a link to the PDF and the street address of where the shooting took place. For years after 2012 it also includes some useful information about the shooting but we will not be using that information in this lesson.

First we need to get the links of each PDF to download. Since links are simply a special type of text on the page, we can use a similar method to webscraping movie data to get all of the links.

Again we start with using `read_html()` to read in the page to R and we will save that in an object called "links" since that is what we want to end up with. 


```r
links <- read_html("http://www.phillypolice.com/ois/")
```

In this case we don't need to look on the site to determine the CSS selector, we simply use "a" which will find all links on the page. `html_attr("href")` converts the XML code for the links to text which we can understand.


```r
links <- html_nodes(links, "a")
links <- html_attr(links, "href")
```

Now we can take a look at the results and check how many results there are.


```r
head(links)
#> [1] "https://www.phillypolice.com/" "/news/index.html"             
#> [3] "/districts-units/index.html"   "/accountability/index.html"   
#> [5] "/programs-services/index.html" "/forms/index.html"
length(links)
#> [1] 521
```

There are 521 results and of the first 6 none of them are PDFs. This makes sense as our code grabbed every single link on the page, PDF or not. We need a way to subset these links to just those that a PDFs. Since we know that every PDF will end with the text ".pdf" we can use `grep()` to subset the links to only return those which include ".pdf" in the name. Sometimes the .pdf extention is written .PDF so we will set the parameter `ignore.case` to TRUE to ignore capitalization.


```r
links <- links[grep(".pdf", links, ignore.case = TRUE)]
```


```r
head(links)
#> [1] "/assets/directives/D10.1.pdf"                                                          
#> [2] "/assets/directives/D10.2-UseOfModerateLimitedForce.pdf"                                
#> [3] "/assets/directives/D10.3-UseOfLessLethalForce.pdf"                                     
#> [4] "/assets/directives/D10.4-UseOfForceReviewBoard.pdf"                                    
#> [5] "/assets/crime-maps-stats/officer-involved-shootings/master-report-ois.pdf"             
#> [6] "/assets/crime-maps-stats/officer-involved-shootings/master-report-explanations-ois.pdf"
```

This looks better but there are still a few files we don't want even though they are PDFs. By looking through our list of links, and looking at the website as a comparison, it seems that the PDFs with information on officer shootings have the text "officer-involved-shootings" in the name. We can use `grep()` again to just grab those links.


```r
links <- links[grep("officer-involved-shootings", links)]
```


```r
head(links)
#> [1] "/assets/crime-maps-stats/officer-involved-shootings/master-report-ois.pdf"             
#> [2] "/assets/crime-maps-stats/officer-involved-shootings/master-report-explanations-ois.pdf"
#> [3] "/assets/crime-maps-stats/officer-involved-shootings/Citywide-SV-OIS-2019-Q2.pdf"       
#> [4] "/assets/crime-maps-stats/officer-involved-shootings/Citywide-Gun-Crime-OIS-2019-Q2.pdf"
#> [5] "/assets/crime-maps-stats/officer-involved-shootings/ois-19-04.pdf"                     
#> [6] "/assets/crime-maps-stats/officer-involved-shootings/19-06.pdf"
```

We don't want any of these links. Let's look at the first 10 rather than first 6 links to see when the files we want appear.


```r
links[1:10]
#>  [1] "/assets/crime-maps-stats/officer-involved-shootings/master-report-ois.pdf"             
#>  [2] "/assets/crime-maps-stats/officer-involved-shootings/master-report-explanations-ois.pdf"
#>  [3] "/assets/crime-maps-stats/officer-involved-shootings/Citywide-SV-OIS-2019-Q2.pdf"       
#>  [4] "/assets/crime-maps-stats/officer-involved-shootings/Citywide-Gun-Crime-OIS-2019-Q2.pdf"
#>  [5] "/assets/crime-maps-stats/officer-involved-shootings/ois-19-04.pdf"                     
#>  [6] "/assets/crime-maps-stats/officer-involved-shootings/19-06.pdf"                         
#>  [7] "/assets/crime-maps-stats/officer-involved-shootings/19-09.pdf"                         
#>  [8] "/assets/crime-maps-stats/officer-involved-shootings/19-11.pdf"                         
#>  [9] "/assets/crime-maps-stats/officer-involved-shootings/19-13.pdf"                         
#> [10] "/assets/crime-maps-stats/officer-involved-shootings/19-14.pdf"
```

The first 8 links are files that are not incident reports of a single shooting so we don't want them. Since they are the first 8 links we can simply use square bracket notation subsetting to remove them


```r
links <- links[-c(1:8)]
```

Now we have all the links we need, we can use a for loop to download them. To download files in R we will use the function `download.file()` which, as the name implies, just downloads a file from the internet to your computer. This function takes two inputs: the parameter `url` is the URL where the file to download is stored (the links in our case), and parameter `destfile` is the name we will call the file we download. 

The links we have do not actually have the full URL we need. Notice that they begin with "/assets" but if you click a link on the web page, the links all start "http://www.phillypolice.com/assets". In our code we can paste the "http://www.phillypolice.com" part to our link name to make a complete URL to download.

Since all the files have a similar pattern, we can use `gsub()` to make the name shorter than the long link it comes in. Note that for every link the pattern is the the real file name is at the very end and there are a number of categories broken up by forward slashes. For a quick `gsub()` can use the special character "." (the period or dot) to indicate anything and the special character "*" (asterix) to indicate "0 or more of the previous character" to say find every character up to and including the forward slash and replace it with nothing.

Using the very first link as an example, the `gsub()` removes everything except the very last part of the link. It replaces every character up to and including the latest forward slash with an empty string, leaving a useful file name.


```r
gsub(".*/", "", links[1])
#> [1] "19-13.pdf"
```

`download.file()`  downloads the file into the current working directory so make sure it is set to where you want the files to go (for this many files it is wise to make a new folder specifically to hold these files). We will set the parameter `mode` to "wb". This isn't strictly necessary but in some cases R has an issue downloading files and this seems to fix it. Since sometimes scraping data from the same page too often causes a download to fail, we will add the code `Sys.sleep(1)` which forces R to sleep for 1 second. This slows down the code and makes sure we don't overload the site.

There are 460 files so it will take some time to download them all. 


```r
setwd("data/philly_officer_shootings")

for (file in links) {
   url <- paste("http://www.phillypolice.com", file, sep = "")
   save_name <- gsub(".*/", "", file)
   download.file(url = url, destfile = save_name, mode = "wb")
   Sys.sleep(1)
}

```

## Scraping information from the page

We also want the date and address of every shooting. While that data is available in the PDFs, it isn't in a consistent format which would make it difficult to get. The webpage we downloaded the PDFs from does contain the address of each shooting in a convenient table so we will scrape the data from there. While the PDFs have the date for every shooting, starting in 2017 the date isn't in any easy to scrape format so we will scrape the date column that is present for all years starting in 2013. Since we will want to merge the location with the data from the PDF, we will also scrape the Police Shooting Number column so we have something consistent in both the PDF and the scraped data to merge by. 

As before, we will start by using `read_html()` to read the page into R. We will call this object "page" as we are going to use it for scraping the location, date and the shooting number so we don't want to overwrite the object.


```r
page <- read_html("http://www.phillypolice.com/ois/")
```

We need to 

![](images/pdf_scrape_2.PNG)

![](images/pdf_scrape_3.PNG)

![](images/pdf_scrape_4.PNG)

![](images/pdf_scrape_5.PNG)

![](images/pdf_scrape_6.PNG)

![](images/pdf_scrape_7.PNG)


```r
location <- html_nodes(page, ".span3 td+ td , td:nth-child(3)")
```

To convert that into values we can read, we use the function `html_text()`. This is similar to `html_table()` we used before which told R to convert the data as a table. In this case the data are strings so we use `html_text()`.


```r
location <- html_text(location)
```

If we do the same thing for the Shooting Numbers we find that the CSS selector is "td:nth-child(1)"


```r
shooting_numbers <- html_nodes(page, "td:nth-child(1)")
shooting_numbers <- html_text(shooting_numbers)
```

Finally we can get the date information. Be careful when selecting date, if you just click on a row in the Date column, it will include the Location column for years 2007-2012. This is because SelectorGadget knows you clicked the second column in a table, but doesn't know that that means Date in certain tables in Location in others. Click one of the highlighted Location rows in 2007-2012 tables to deselect them. 


```r
dates <- html_nodes(page, ".span12 td:nth-child(2)")
dates <- html_text(dates)
```

Note that there are 467 values for location and shooting_numbers, 148 values for dates, and 460 values for links of the PDFs we downloaded? Why is this? 7 of the shootings do not have a PDF associated with the shooting so there is no link to that PDF to download. As data from 2007-2012 do not have dates on the table, there is nothing to scrape, leading to many fewer values than the location or shooting_numbers. 

### Combining the data sets


```r
officer_shootings <- data.frame(shooting_number = shooting_numbers,
                                location        = location,
                                dates           = date,
                                stringsAsFactors = FALSE)
#> Error in as.data.frame.default(x[[i]], optional = TRUE): cannot coerce class '"function"' to a data.frame
```

Trying to make a data.frame this way returns an error because while there are 467 shootings, only the shooting number and location variable have all 467 values. Since the dates don't exist for 2007-2012, we only have 148 values for that data. While there are a few ways to solve this (as is true with nearly every problem in R), we will expand the "dates" object to make it 467 values long. 

The function `rep()` repeats whatever value you input as many times as you'd like.


```r
rep("hello", 10)
#>  [1] "hello" "hello" "hello" "hello" "hello" "hello" "hello" "hello"
#>  [9] "hello" "hello"
```

Above we repeated the word "hello" 10 times. To solve our issue we need to repeat some value 319 times and add that to the end of the "dates" object to make it 467 values long. For our value we will use NA to indicate that those values are missing.


```r
rep(NA, (length(location) - length(dates)))
#>   [1] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#>  [24] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#>  [47] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#>  [70] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#>  [93] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#> [116] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#> [139] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#> [162] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#> [185] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#> [208] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#> [231] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#> [254] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#> [277] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
#> [300] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
```

To combine the "dates" object with all these repeated NA's we will use c() which combines vectors. Make sure we put "dates" first to maintain the correct order.


```r
dates <- c(dates, rep(NA, (length(location) - length(dates))))
```

And we can now check the length of "dates".


```r
length(dates)
#> [1] 467
```

Since "dates" is 467 values long now, let's try making the data.frame again.


```r
officer_shootings <- data.frame(shooting_number = shooting_numbers,
                                location        = location,
                                dates           = dates,
                                stringsAsFactors = FALSE)
```

It works. Let's look at the first 6 values. We can compare our results from the table on the page to make sure we did it correctly.


```r
head(officer_shootings)
#>   shooting_number                            location      dates
#> 1           19-04          4900 block of Hazel Avenue 03/06/2019
#> 2           19-06          1300 block of Kater Street 03/28/2019
#> 3           19-09 Bridge Street & Roosevelt Boulevard 04/20/2019
#> 4           19 11         2100 block of Taney Terrace 04/25/2019
#> 5           19-13       1800 block of N. Broad Street 05/11/2019
#> 6           19 14              3400 block of G Street 05/20/2019
```

And for good measure we can look at the bottom 6 rows, expecting NAs for the dates column.


```r
tail(officer_shootings)
#>     shooting_number                    location dates
#> 462           07-83              5224 Wayne Ave  <NA>
#> 463           07-84 1500 block of N. Frazier St  <NA>
#> 464           07-85    2300 block of N. 16th St  <NA>
#> 465           07-88    100 block of Chestnut St  <NA>
#> 466           07-93    2900 block of Mascher St  <NA>
#> 467           07-94    5400 block of Erdrick St  <NA>
```


## Extracting data from PDFs

All of the shootings in 2012 and earlier are missing the incident dates. However, the PDF documents describing the incident contains the date of the incident. Rather than reading all the PDF files and transcribing the dates, we are going to have R do all the work.

The package `pdftools` includes functions for exploring PDF files. Let's install and load the library and have a look at one of the PDF files. We will write some code that scrapes the PDF to get the date. We'll then write a function that returns the date for the PDF inputted. Finally, we'll use a for loop to get the date of every single PDF and merge it with the "officer_shootings" data we created above to get a single file which has the date and location of every officer-involved shooting.


```r
install.packages("pdftools")
```


```r
library(pdftools)
```

### Scraping a single PDF

`pdf_text()` extracts all the raw text from the pdf file. The input in the () is the name (in quotes as it is saying to R, go to the file on the computer) of the PDF to be read. Make sure your working directory is set to where the file is. We will look at the last shooting in 2016 which we called "16-01.pdf".


```r
setwd("data/philly_officer_shootings")
pdf <- pdf_text("16-01.pdf")
```


```r
pdf
#> [1] "PS# 16-01\r\n1/07/16\r\nOn Thursday, January 7, 2016, at approximately 11:41 P.M., a uniformed\r\nofficer in a marked police vehicle was traveling north in the 300 block of S.\r\n60th Street, when he observed a male approaching his vehicle near the\r\nintersection of 60th and Spruce Streets. The male was armed with a firearm.\r\nWithout warning, the offender discharged the firearm, striking the officer as\r\nhe remained seated inside his police vehicle. The offender advanced to the\r\ndriver’s door of the police vehicle and leaned in through the shattered\r\nwindow, still discharging his firearm at the officer. The offender then fled on\r\nfoot, but continued to discharge his weapon at the officer. The officer exited\r\nhis police vehicle and returned fire striking the offender. The offender was\r\napprehended by responding officers in the 5900 block of Delancey Street.\r\nThe officer was transported to Penn-Presbyterian Hospital where he was\r\nadmitted.\r\nThe offender was transported to the Hospital of the University of\r\nPennsylvania for treatment.\r\nThe offender’s firearm, a Glock, 9MM, semi-automatic pistol, which had been\r\nreported stolen, was recovered empty, with the slide locked to the rear, at the\r\nscene.\r\nThere were no other injuries as a result of this firearm discharge.\r\n  *** Information posted in the original summary reflects a preliminary\r\nunderstanding of what occurred at the time of the incident. This information\r\nis posted shortly after the incident and may be updated as the investigation\r\nleads to new information. The DA’s Office is provided all the information\r\nfrom the PPD’s investigation prior to their charging decision.\r\n"
```

When we print the file we can see that it is a single big block of text. Near the beginning of the text we can see a date, 1/07/16. That's what we want. When comparing the PDF which we can read ourselves on Adobe Acrobat or a web browser, it is clear that all the line breaks in the PDF disappeared when we used `pdf_text()`. More specifically, the line breaks were replaced by `\n` which is R's way of saying "this is a line break".

![](images/pdf_scrape_1.PNG)

Note that there are scattered `\r\n` throughout. These are carriage return (`\r`) and line feed (`\n`) characters that signal the end of a line. The old printers would look for these characters to move the printer head back to the beginning of a line (carriage return) and advance the page to the next line (line feed). Nowadays, those same characters are still used to denote the end of a line. However, PCs use `\r\n`, Unix systems use `\n`, older Macs used `\r`, but Mac OS X adopted the Unix standard `\n`. Expect any of these combinations in data files. 

We want to grab just the date from this file.  Since the file is in a single block of text, we need to break it up based on where there should be a line break (turning each line back into an individual part of the file) and grab only the line with the date.

When splitting up a string (which is just what the PDF is now), we can use the function `strsplit()` which splits up a string based on some pattern.

Let's see a simple example, splitting up the word "criminology" by the letter "n". Note that it deletes the character it is splitting by!


```r
strsplit("criminology", split = "n")
#> [[1]]
#> [1] "crimi" "ology"
```

It now returns two words "crimi" amd "ology", the two parts of the word "criminology" on each side of the letter "n". It returns the value inside a list - which is why you see the [[1]] above the result. To get the value we actually want, we need to get the first element inside that list, using double bracket notation.


```r
split <- strsplit("criminology", split = "n")
split <- split[[1]]
split
#> [1] "crimi" "ology"
```

From the pattern we see in the PDF we scraped, and comparing it to the PDF we can see in Adobe Acrobat or a web browser, it is clear that we can use split at the characters "\r\n" and it will give us each line in its own element (for Mac users you may need to split at "\n" rather than "\r\n"). Let's do that and just return the first element so we don't get a list. Let's call the object we make "pdf_split".


```r
pdf_split <- strsplit(pdf, split = "\r\n")
pdf_split <- pdf_split[[1]]
pdf_split
#>  [1] "PS# 16-01"                                                                      
#>  [2] "1/07/16"                                                                        
#>  [3] "On Thursday, January 7, 2016, at approximately 11:41 P.M., a uniformed"         
#>  [4] "officer in a marked police vehicle was traveling north in the 300 block of S."  
#>  [5] "60th Street, when he observed a male approaching his vehicle near the"          
#>  [6] "intersection of 60th and Spruce Streets. The male was armed with a firearm."    
#>  [7] "Without warning, the offender discharged the firearm, striking the officer as"  
#>  [8] "he remained seated inside his police vehicle. The offender advanced to the"     
#>  [9] "driver’s door of the police vehicle and leaned in through the shattered"        
#> [10] "window, still discharging his firearm at the officer. The offender then fled on"
#> [11] "foot, but continued to discharge his weapon at the officer. The officer exited" 
#> [12] "his police vehicle and returned fire striking the offender. The offender was"   
#> [13] "apprehended by responding officers in the 5900 block of Delancey Street."       
#> [14] "The officer was transported to Penn-Presbyterian Hospital where he was"         
#> [15] "admitted."                                                                      
#> [16] "The offender was transported to the Hospital of the University of"              
#> [17] "Pennsylvania for treatment."                                                    
#> [18] "The offender’s firearm, a Glock, 9MM, semi-automatic pistol, which had been"    
#> [19] "reported stolen, was recovered empty, with the slide locked to the rear, at the"
#> [20] "scene."                                                                         
#> [21] "There were no other injuries as a result of this firearm discharge."            
#> [22] "  *** Information posted in the original summary reflects a preliminary"        
#> [23] "understanding of what occurred at the time of the incident. This information"   
#> [24] "is posted shortly after the incident and may be updated as the investigation"   
#> [25] "leads to new information. The DA’s Office is provided all the information"      
#> [26] "from the PPD’s investigation prior to their charging decision."
```

We need a way to only take the row with the date. In most cases the second row is the one with the date, however this isn't true in every case. Therefore, we can't just grab the second element. We can use `grep()` to search for a pattern that is unique to the row with the date to get that row. 

So what pattern does our date have? It is always one or two numbers followed by a / followed again by two numbers, another / and two more numbers.

1/07/16

So our pattern in grep will be 

[0-9]+/[0-9]+/[0-9]+

[0-9] means any number. The + is a special character which says "one or more of the previous character" so [0-9] means "one or more numbers". Some files (such as this one) have multiple dates in the text so we want to only get rows starting with a date. The ^ is a special character saying that whatever follows it is the start of the string.

So our search expression is

^[0-9]+/[0-9]+/[0-9]+

By default `grep()` will return a number indicating the element where it found a match. If we set the parameter `value` to TRUE, it will print out that element. 


```r
grep("^[0-9]+/[0-9]+/[0-9]+", pdf_split, value = TRUE)
#> [1] "1/07/16"
```


### Making a function

Since we need to do this process for hundreds of PDFs we will make a function and then for loop through it for every PDF. Here we are following the same steps as scraping the movie data - make code work for a single file/date, turn it into a function to work for any file/date, and write a for loop so it works for every file/date we have. That's the general process you will use when writing code meant for multiple inputs. Make sure code works first in a specific case (a specific date), then make it work in the general case (any date).

When making a function from code you've already written, a good method is to just copy all the code so it is together. Then start building the function. 


```r
setwd(here::here("data/philly_officer_shootings"))
pdf <- pdf_text("16-01.pdf")
pdf_split <- strsplit(pdf, split = "\r\n")
pdf_split <- pdf_split[[1]]
grep("^[0-9]+/[0-9]+/[0-9]+", pdf_split, value = TRUE)
#> [1] "1/07/16"
```

Above is our code, now let's make the standard function skeleton without including any code just yet. We can call the function "get_date_from_pdf" since that is a good description for what our function will do. We want to input a file name and get a date returned. So we will call our parameter in the () "file_name" and our return object "date".


```r
get_date_from_pdf <- function(file_name) {
   
   return(date)
}
```


Now we can add in our code. 


```r
get_date_from_pdf <- function(file_name) {
   setwd(here::here("data/philly_officer_shootings"))
   pdf <- pdf_text("16-01.pdf")
   pdf_split <- strsplit(pdf, split = "\r\n")
   pdf_split <- pdf_split[[1]]
   return(date)
}
```

There are two steps remaining to turn our code into a working function. As it is, the code still writes `pdf_text("16-01.pdf")`. We want it to run `pdf_text(file_name)` on any file we input so let's change "16-01.pdf" to say "file_name" (not in quotes since it is an object). And we want the function to return an object called "date" which has the date from the PDF. We know the date is printed by the `grep()` code we wrote, so let's save that as "date".


```r
get_date_from_pdf <- function(file_name) {
   setwd(here::here("data/philly_officer_shootings"))
   pdf <- pdf_text(file_name)
   pdf_split <- strsplit(pdf, split = "\r\n")
   pdf_split <- pdf_split[[1]]
   date <-  grep("^[0-9]+/[0-9]+/[0-9]+", pdf_split, value = TRUE)
   return(date)
}
```

Now let's try it our using another PDF, let's say "16-01.pdf".


```r
get_date_from_pdf("16-01.pdf")
#> [1] "1/07/16"
```

### Looping through every PDF

Before we write the for loop let's think about what our goal is and what we currently have. We have a data set which has a single row for every shooting and information about when and where each shooting took place. The object "officer_shootings" that we made earlier has most of that. It contains the location for every shooting and the date for all of those from 2013-2019. So we want to scrape the PDFs for years prior to 2013 to get the date of each shooting. And we made a function that gives us the date in the file we input. Since we know the dates for 2013-2019 (and 2017-2019 make it hard to get the date from the PDF), we only want to scrape the PDFs from 2007-2012. 

We need to do two things now: select only PDFs from 2007-2012, and, for each PDF, figure out a way to select the right now in the "officer_shootings" object to add the date. 

We can take this one piece at a time. First we need to select only PDFs from 2007-2012. The function `list.files()` will provide a list of every file in the working directory. We will use it to get a list of all files in the folder we stored the PDFs and then subset it to just keep the files we want. Let's call the object "pdf_files". 


```r
setwd("data/philly_officer_shootings")
pdf_files <- list.files()
```

Looking at `head()` we can see it is a vector of file names. 


```r
head(pdf_files)
#> [1] "07-01 4400 N 17 ST.pdf"      "07-02 2400 N 10 ST.pdf"     
#> [3] "07-03 1700 N 59 ST.pdf"      "07-04 900 MARKET ST.pdf"    
#> [5] "07-05 2800 E PACIFIC ST.pdf" "07-06 6300 DITMAN ST.pdf"
```

There is a pattern in these names where they start with two characters indicating the year (2016 starts with "PS" then "16" though since we don't need 2016 data that doesn't affect this process). We will use this pattern to just get files that start with "0" or begin "10", "11", or "12". We will use `grep()` and make use of the ^ special character which indicates that the characters following it are the start of the string. We will also use the `|` special character which indicates "thing on left or right" of the `|` are both a match.


```r
grep("^0|^10|^11|^12", pdf_files)
#>   [1]   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17
#>  [18]  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34
#>  [35]  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51
#>  [52]  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68
#>  [69]  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85
#>  [86]  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100 101 102
#> [103] 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119
#> [120] 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136
#> [137] 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153
#> [154] 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170
#> [171] 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187
#> [188] 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204
#> [205] 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221
#> [222] 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238
#> [239] 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255
#> [256] 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272
#> [273] 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289
#> [290] 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306
#> [307] 307 308 309 310 311 312 313 314 315 316 317
```

This prints out a list of which elements in "pdf_files" are a match. We can use square bracket notation [] subsetting to just keep the elements in "pdf_files" that we want. And let's save that object as "pdf_files", overwriting our initial object with just the values we want. This way we minimize the number of objects we need to keep track of. 


```r
pdf_files <- pdf_files[grep("^0|^10|^11|^12", pdf_files)]
```

We have accomplished our first task, getting just the PDFs from 2007-2012. Now we need to find a way to match the correct row in "officer_shootings" with each file. Let's think again about patterns in the file names.


```r
head(pdf_files)
#> [1] "07-01 4400 N 17 ST.pdf"      "07-02 2400 N 10 ST.pdf"     
#> [3] "07-03 1700 N 59 ST.pdf"      "07-04 900 MARKET ST.pdf"    
#> [5] "07-05 2800 E PACIFIC ST.pdf" "07-06 6300 DITMAN ST.pdf"
```

Each file name starts with the same 5 character ("year-unique ID") value indicating the shooting number that we scraped from the table. The files then occasionally have the address of the shooting and end with ".pdf". This is our match. For each file we want to just keep the first 5 characters which are an exact match to the "shooting_number" column. There are a few ways to do this but we'll use the function `substr()` as it well-suited for this task.

`substr()` takes a string and returns nth-mth characters in that string. Let's see how this works using the word "apple".


```r
substr("apple", start = 1, stop = 3)
#> [1] "app"
```

Here we input the word "apple" and set the parameter `start` to 1 and `stop` to 3. This says, take the word "apple" and return the 1st through the 3rd element (i.e. letter) in that string. This is very useful for taking only a small piece of a string. In our case we just want the first 5 characters in the PDF file name.


```r
substr(pdf_files[1], start = 1, stop = 5)
#> [1] "07-01"
```

And here we have the officer shooting number for the first PDF which we can use to match with the correct row in the "officer_shootings" file.

We can now create the for loop. Let's start with a skeleton of the for loop then slowly add our code.


```r
for (file in pdf_files) {
   
}
```

For loops take the form "for x in some group of x, do this thing". In our case our "group of x" is the "pdf_files" object, a group of file names. We want the loop to go through every file in "pdf_files", find the police shooting number from the file name to match with the correct row in "officer_shootings", get the date from the file, and then put the date in the right row. 

We can add in the code we wrote to get the police shooting number.


```r
for (file in pdf_files) {
   police_shooting_number <- substr(file, start = 1, stop = 5)
}
```

And the code to get the date from the function we made.


```r
for (file in pdf_files) {
   police_shooting_number <- substr(file, start = 1, stop = 5)
   date <- get_date_from_pdf(file)
}
```

Finally we add in code that uses square bracket notation [] to say change the value in the "dates" column in the row where the shooting number matches the shooting number we made from the file name to the date we got from the PDF. 

The for loop is done and we can run it.


```r
for (file in pdf_files) {
   police_shooting_number <- substr(file, start = 1, stop = 5)
   date <- get_date_from_pdf(file)
   officer_shootings$dates[officer_shootings$shooting_number == police_shooting_number] <- date
}
```

We have one final thing to do, make the date column Date type. The date in the "dates" column aren't in the Date format for R which means that while we can easy read it, R doesn't know that it is a date (it thinks it's just a bunch of text) and can't do any date-related functions like grabbing the year or months from it. We can use the `lubridate` package we worked with earlier to turn it into a date. Since this date is in the month-day-year order we will use the function `mdy()`.


```r
library(lubridate)
#> 
#> Attaching package: 'lubridate'
#> The following object is masked from 'package:base':
#> 
#>     date
```


```r
officer_shootings$dates <- mdy(officer_shootings$dates)
```

Now our "officer_shootings" file contains the date and address of every officer-involved shooting in Philadelphia from 2007 to early 2019. 3 of the shootings do not have a PDF associated with it. Let's remove them since we are unable to verify information on the table. These rows have a value of "" in the "shooting_number" column so we'll subset the "officer_shootings" data.frame to keep only rows where the shooting number is not "".


```r
officer_shootings <- officer_shootings[officer_shootings$shooting_number != "", ]
```

We will save the file for now and in the next lesson learn how to geocode the address into coordinates that allow us to plot the shootings onto a map of Philadelphia. 


```r
setwd(here::here("data"))
save(officer_shootings, file = "officer_shootings.rda")
```

