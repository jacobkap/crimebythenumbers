
# Functions

So far you have seen several built-in functions in R, like `max()`, `head()`, and `table()`. These functions help us complete tasks that normally would take several lines of R code. They also make it easy to read R code. It's easy to know what `max(c(1,3,5,7,9))` means. In R you can also write your own functions. Let's say we want a function that adds the number 2 to any number we input. 

## A simple function


```r
add_2 <- function(number) {
  number <- number + 2
  return(number)
}
```

As you can see, the basic template of an R function is:

function_name <- function(parameters) { 
  code 
  return(output)
}

There are five essential parts of a function

  + function_name  - This is just the name we give to the function. It can be anything but, like when making other objects, call it something where it is easy to remember what it does.
  + parameters  - Here is where we say what goes into the function. In most cases you will want to put some data in and expect something new out. For example, for the function `mean()` you put in a vector of numbers in the () section and it returns the mean of those numbers. Here is also where you can put any options to affect how the code is run.
  + code - This is the code you write to do the thing you want the function to do. In the above example our code is `number <- number + 2`. For any number inputted, our code adds 2 to it and saves it back into the object number. 
  + return - This is something new in this class, here you use `return()` and inside the () you put the object you want to be outputted. In our example we have "number" inside the `return()` as that's what we want to come out of the function. It is not always necessary to end your function with `return()` but is highly recommended to make sure you're outputting what it is you want to output.
  + The final piece is the structure of your function. After the function_name (whatever it is you call it) you always need the text "<- function()" where the parameters (if any) are in the (). After the closing parentheses put a "{" and at the very end of the function, after the `return()`, close those squiggly brackets with a "}". The "<- function()" tells R that you are making a function rather than some other type of object. And the "{" and "}" tell R that all the code in between are part of that function.
  
Our function here adds 2 to any number we input. 


```r
add_2(2)
#> [1] 4
```


```r
add_2(5)
#> [1] 7
```

## Adding parameters 

Let's add a single parameter which multiplies the result by 5 if selected.


```r
add_2 <- function(number, times_5 = FALSE) {
  number <- number + 2
  return(number)
}
```

Now we have added a meter parameter, called "time_5" to the () part of the function and set it the be FALSE by default. Right now it doesn't do anything so we need to add code to saw what happens if it is TRUE (remember in R true and false must always be all capitalized letters).


```r
add_2 <- function(number, times_5 = FALSE) {
  number <- number + 2
  
  if (times_5 == TRUE) {
    number <- number * 5
  }
  
  return(number)
}
```

Now our code says if the parameter "times_5" is TRUE, then do the thing in the squiggly brackets {} below. Note that we use the same squiggly brackets as when making the entire function. That just tells R that the code in those brackets belong together. Let's try out our function.


```r
add_2(2)
#> [1] 4
```

It returns 4, as expected. Note that as the paramter "times_5" is FALSE by default. When we don't tell the function that we want it to be TRUE, the code in our "if statement" doesn't run.


```r
add_2(2, times_5 = TRUE)
#> [1] 20
```

## Making a function to scrape movie data

In \@ref(scraping-one-page) we wrote some code to scrape data from the website [The-Numbers](/www.the-numbers.com) for a single day. We are going to turn that code into a function here. The benefit is that our input to the function will be a date and then it returns the scraped data for that date. If we want multiple dates (and for webscraping you usually do), we just change the date we input without changing the code at all.

We used the `rvest` package so we need to tell R want to use it again.


```r
library(rvest)
#> Loading required package: xml2
```

Let's start by writing a shell of the function - everything but the code. We can call it "scrape_movie_data" (though any name would work), add in the "<- function()" and put "date" (without quotes) in the () as our input for the function is a date. We want the function to return the movie data for that date so we include `return(movie_data)`. And don't forget the "{" after the end of the `function()` and "}" at the very end of the function. Now we need to add the code that takes the date, scrapes the website, and saves that data into an object called "movie_data".


```r
scrape_movie_data <- function(date) {
  
  return(movie_data)
}
```

Since we have the code from an earlier lesson, we can copy and paste that code into the function and make a small change to get a working function.


```r
scrape_movie_data <- function(date) {
  
  movie_data <- read_html("http://www.the-numbers.com/box-office-chart/daily/2018/07/04")
  movie_data <- html_nodes(movie_data, "#page_filling_chart > center:nth-child(2) > table")
  movie_data <- html_table(movie_data)
  movie_data <- movie_data[[1]]
  
  return(movie_data)
}
```

The part inside the () of `read_html()` is the URL of the page we want to scrape. This is the part of the function that will change based on our input. Specifically, just the date will change, the rest of the URL up to the date section stays the same every time (we know this just by clicking through dates on the website and seeing how the URL changes). 

We want to make it so the date inputted is the date used in the URL of the page to scrape. So let's split up the URL into two pieces - the part that stays constant and the part that changes.

Constant - "http://www.the-numbers.com/box-office-chart/daily/"
Changes  - "2018/07/04"

And now let's make variables with these values.


```r
Constant <- "http://www.the-numbers.com/box-office-chart/daily/"
Changes  <- "2018/07/04"
```

We can use `paste()` to combine these two and set the parameter `sep` to "" so there are no spaces between the url and the date (the function `paste0()` is the same as `paste()` but defaults `set` to "" so we could use that if we wanted). We will save the result of `paste()` as an object called "url_date" but it doesn't matter what we name it.


```r
paste(Constant, Changes, sep = "")
#> [1] "http://www.the-numbers.com/box-office-chart/daily/2018/07/04"
```

Inside our function code we need to make the "Constant" variable but let's rename it "url" since that better describes what it is. Since the date is what is inputted into the function, we don't need to make that variable. Our `paste()` function is the same as above but with with these new variable names - since the parameter inputted is called "date" that is the variable name we need to include in the `paste()`. And we can call it a new name - "url_date" - in the code just to simplify things. Then put this variable in the () of `read_html()` and it will go to the proper page based on the date we input. 


```r
scrape_movie_data <- function(date) {
  url <- "http://www.the-numbers.com/box-office-chart/daily/"
  url_date <- paste(url, date, sep = "")
  
  movie_data <- read_html(url_date)
  movie_data <- html_nodes(movie_data, "#page_filling_chart > center:nth-child(2) > table")
  movie_data <- html_table(movie_data)
  movie_data <- movie_data[[1]]
  
  return(movie_data)
}
```

Now we can try it for a new date, let's say July 4th, 2015. We will save it in the object "july_2015" just to avoid it printing out every single row when the function is done.


```r
july_2015 <- scrape_movie_data("2015/7/4")
head(july_2015)
#>                       Movie        Distributor      Gross Change Thtrs.
#> 1 1 (2)      Jurassic World          Universal $8,539,045   +31%  3,737
#> 2 2 (1)          Inside Out        Walt Disney $8,209,548   +19%  4,158
#> 3 3 (-) Terminator: Genisys Paramount Pictures $7,883,583         3,758
#> 4 4 (5)               Ted 2          Universal $2,896,320   -21%  3,448
#> 5 5 (-)      Magic Mike XXL       Warner Bros. $2,512,969         3,355
#> 6 6 (6)                 Max       Warner Bros. $1,891,378   +28%  2,870
#>   Per Thtr.  Total Gross Days
#> 1    $2,285 $547,667,605   23
#> 2    $1,974 $236,889,029   16
#> 3    $2,098  $34,029,282    4
#> 4      $840  $54,725,070    9
#> 5      $749  $23,815,016    4
#> 6      $659  $23,323,044    9
```

In the next lesson we'll use "for loops" to scrape several years of data using the function we just made.

## The benefits of functions

The primary benefit of writing a function is to simplify the reading of a script. It is much easier to comprehend what a script is doing if you have code that says something like `scrape_movie_data()` rather than a bunch of code. If you have 100 lines of code to do something, it is often easier to manage by splitting it up into a number of functions. That way, even if the code is totally unchanged, you only have to worry about a small chunk at a time and can (partially) avoid being overwhelmed.

A secondary benefit is that you can use this function again and again to help solve other problems. If, for example, you have code that cleans data from Philadelphia's crime data set, if you wanted to use it for Chicago's crime data, making a single function is much easier (to read and to fix if there is an issue) than copying the code. If you wanted to use it for 20 cities, copy and pasting code quickly becomes a terrible solution - functions work much better. If you did copy and paste 20 times and you found a bug, then you'd have to fix the bug 20 times. With a function you would change the code once. 

## Understanding other people's functions

For many functions built into R you can see what they do by typing the name of the 
function and excluding the () you usually have. Here's the code R uses every time you run `IQR()`.


```r
IQR
function (x, na.rm = FALSE, type = 7) 
diff(quantile(as.numeric(x), c(0.25, 0.75), na.rm = na.rm, names = FALSE, 
    type = type))
<bytecode: 0x0000000014e54220>
<environment: namespace:stats>
```


You can see that it computes the 0.25 quantile and the 0.75 quantile and uses the function `diff()` to compute their difference. 
