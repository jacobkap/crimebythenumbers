# Data types and structures {#data-types}

## Data types {#section-data-types}

When you read a sentence like "two plus two" you know the answer is four. R doesn't know that. This is because R takes things very literally. It will read "two" as a word, not as a number. For R to understand numbers you need to specify that you're talking about numbers, and not just words. Let's look at an example, making two variables which each have the value of "2".


```r
a <- "2"
b <- "2"
```

We now have a and b that are equal to "2" (in quotes!). Let's try to add them.


```r
a + b
#> Error in a + b: non-numeric argument to binary operator
```

We get an error that is a technical way of saying that we did math on something that isn't a number. That's because we made a and b get "2" with quotes around it, which R interpreted as a word, not as a number. If we change a and b to 2 (without quotes), then R will know that the 2 is a number, and will do math on it.


```r
a <- 2
b <- 2
a + b
#> [1] 4
```
This may seem like a pretty simple concept but is fundamental to how R works, and can trip up new and experienced programmers alike. R trusts you. It only knows what you tell it. If you tell it that something is a word (by including quotes), it will treat it as a word, even if it looks to you like a number. So we must be very precise about what code we write, as R won't (for the most part) fix our mistakes - though it will give us an error if we try to do something it doesn't like, like add two words. 

There are three main data types that are important to know for using R to do research: numeric, character, and logical. 

A numeric type is a number, and this includes both integers like 2 and decimals like 2.5. You can tell something is numeric if it is a number and there are no quotes around it. 2 is a number, "2" is not. For real data this will likely be something like the age of an individual or the number of crimes in a city. We want it as numeric type because we can do math on numbers. For example, we can find the average age of victims of crimes, or the median number of crimes in a city each week. This won't work unless R knows that these values are numbers.

A character is just a word or a set of words. If it is in quotes it's a character. Other programming languages generally call this a string instead of a character, but they mean the same thing. Pretty much anything that you'd write in English class fits in here. 

Finally, a logical data type is just a true or false value, though in R it must be written all in capital letters: TRUE or FALSE. This is also referred to as a Boolean value. Booleans or logical data are useful when comparing two things. For example, we can see if 2 is equal to 3. 


```r
2 == 3
#> [1] FALSE
```
It's not, so R returned FALSE (the == just compares the thing on the left to the thing on the right). This is very useful when we want to keep only certain rows in our data. For example, if we had data on multiple years of crime and we only wanted to keep a single year (let's say 2020), we could tell R to keep only rows where the year equals 2020 - where it is TRUE that that row's year column is equal to what year we want. We'll cover this in great detail in Chapter \@ref(subsetting-intro).

While you could try to figure out what type of data something is just by looking at it, R has a number of functions to check for you. We'll look at a few general functions that tell you the type of data something is, and then ones that check if the data is a specific type. 

First, the `is()` function tells you all of the types of data something is - and a value can actually have multiple types. While it can't be both, for example, numeric and character, it can have other data types that we'll look at in the next section. First, let's look at what `is()` returns (prints out to the console) for a few simple examples.


```r
is(2)
#> [1] "numeric" "vector"
```

Checking what 2 is tells us that it is both a "numeric" type and a "vector" type. 


```r
is("2")
#> [1] "character"           "vector"              "data.frameRowLabels"
#> [4] "SuperClassMethod"
```

Checking "2" (in quotes), gives us four different types of data for this value: "character", "vector", "data.frameRowLabels", and "SuperClassMethod". You can ignore the last two types, we just are interested in that it is a "character" type and, like the type of 2, is a "vector".


```r
is(TRUE)
#> [1] "logical" "vector"
```

Finally, checking what TRUE is returns both "logical" and "vector". We expected logical since TRUE is a logical type. Again, we see that it is also a vector type. TRUE has to be both in capital letters and not be in quotes. If we write it in quotes then R will think it is a character and if we have it lowercase and without quotes R will think that it is an object (such as something we make using `<-` and not a Boolean).


```r
is("TRUE")
#> [1] "character"           "vector"              "data.frameRowLabels"
#> [4] "SuperClassMethod"
```


```r
is(true)
#> Error in is(true): object 'true' not found
```


All three of the values we checked say that they are a "vector" type. We'll cover vectors in the next section, but for now let's see one other function that tell us the type of data something is. If we use `class()` instead of `is()` we'll get just the first value returned in the types of data that we input.


```r
class(2)
#> [1] "numeric"
class("2")
#> [1] "character"
class(TRUE)
#> [1] "logical"
```

In a lot of cases we'll want to check if some data is a specific type. For example, we might want to check that the year column of a data set is numeric, rather than say character. We do this with three functions, each of which checks that the data input (the data put in the parentheses of the function) is that type of data or not. These functions are: `is.numeric()`, `is.character()`, and `is.logical()`.

Running any of these functions will actually return a logical value, either TRUE or FALSE telling us if the value inputted is that type.


```r
is.numeric(2)
#> [1] TRUE
is.character("2")
#> [1] TRUE
is.character(2)
#> [1] FALSE
is.logical(TRUE)
#> [1] TRUE
```

So far we've just been checking the value of a single thing: a single number, a single character/string, or a single logical/Boolean value. In practice almost everything we do will be on a column of a data set. These functions still work in the exact same way. We input the column (using the data$column syntax discussed in Chapter \@ref(intro-to-r) to specify which data set we want and specifically which column in that data set) and the function will behave just like it did above. That's because each column can only be a single type of data; if the column is numeric, all values will be numeric; if the column is character, all values in that column are character; if the column is logical, every value in that column is also logical. 

Let's use the UCR data from 2017 that was introduced in Chapter \@ref(intro-to-r). Remember that the data must be in your working directory to load it. And here I have "data/" before the data name because the data is in a folder called "data" in my working directory. For more on working directories, please see Section \@ref(setting-the-working-directory).


```r
load("data/ucr2017.rda")
```

We need to know the column names before using them, so we can use the `names()` function to get a list of all of the column names (the `colnames()` function does the same thing).


```r
names(ucr2017)
#> [1] "ori"                       "year"                     
#> [3] "agency_name"               "state"                    
#> [5] "population"                "actual_murder"            
#> [7] "actual_rape_total"         "actual_robbery_total"     
#> [9] "actual_assault_aggravated"
```

Now we can check the types of some of the columns. Let's check the year column as an example. A year is a number so we may expect it to be numeric but there's technically nothing stopping that data from being character type. It can't be logical type because then instead of a year value it'd just be TRUE or FALSE, which is certainly not what a year is.


```r
is(ucr2017$year)
#> [1] "numeric" "vector"
```
And we can use `is.numeric()` as another way to see if this column is numeric.


```r
is.numeric(ucr2017$year)
#> [1] TRUE
```

## Data structures

We'll look in detail about two important data structures - vectors and data.frames - and then talk briefly about two other structures that are not that important in this book, but are nonetheless good to know that they exist. So far we've just been looking at either a single value, such as `a <- 1` or more complicated structures such as the ucr2017 data set which is called a data.frame - R's version of an Excel file. Data structures each operate a little differently from each other so it's good to understand what they are and how they work. We'll cover much more of how they work in Chapter \@ref(subsetting-intro) which covers how to subset data - which is just how to keep only certain values (such as specific rows or columns) in the data.

### Vectors (collections of "things") {#vectors}

The first data structure we'll discuss is a vector. A vector is a collection of same type (numeric, character, logical, Date) values in a single object. When we made "a" in Chapter \@ref(intro-to-r), we assigned it only a single value, such as `a <- 1`. Usually we'll want to have a group of values - such as a set of years or a group of crime types - rather than just a single value. We can do this by using the same assignment method as `a <- 1` but put all of the values we want to assign to a into the function `c()` and separate each value by a comma. The `c()` function **c**ombines each value together into a single vector.

Now, technically a single value, such as our object called "a" which now equals 1, is still a vector. In this case it'd be a vector of length 1, since there is only one value in it. But when we generally talk about vectors there are multiple elements in it. 

Here's an example of making the object a be a vector with three values: 1, 2, and 3 (in that order). 


```r
a <- c(1, 2, 3)
```

It is absolutely crucial to have the `c()` function, otherwise we'd get an error from R.


```r
a <- (1, 2, 3)
#> Error: <text>:1:8: unexpected ','
#> 1: a <- (1,
#>            ^
```

It is likewise crucial to have a comma separating every single separate value. 


```r
a <- c(1 2 3)
#> Error: <text>:1:10: unexpected numeric constant
#> 1: a <- c(1 2
#>              ^
```

The terminology for talking about values in a vector is that each value is called an "element" and we identify them by the number they are, in order from start to finish. So here we have 1, 2, and 3, and we can say that the first element is 1, the second element is 2, the third element is 3. 

If we assigned a to b (`b <- a`) we don't need to use the `c()` again. a is already a vector so if we assign its value to something, that carries over the vector. The `c()` is only necessary when first creating the vector.

Note that vectors take values that are the same type, so all values included must be the same type such as a number or a string. If they aren't the same type, R will automatically convert it to the same type. 


```r
c("cat", "dog", 2)
#> [1] "cat" "dog" "2"
```

Above we made a vector with the values "cat", "dog" and 2 (without quotes) and it added quotes to the 2. Since everything must be the same type, R automatically converted the 2 to a string of "2".

### Data.frames {#dataframes}

Nearly everything you do in this book and in research will be through data.frames. A data.frame is basically R's version of an Excel file. More precisely, a data.frame is a collection of equal-length vectors. Each column in a data.frame is actually a vector. They must all be equal length so every column has the same number of rows. You can't have, for example, a data.frame with 10 rows of data for the city column and only 8 rows for the year column. It must be 10 for each. Since vectors can only be a single type, each row in a particular column in a data.frame must be the same type, though different columns can be different types. This is how we can have, for example, our ucr2017 data.frame which has both numeric and character type columns. 

In this book I'll refer to data.frames by keeping it all lower case and with a dot between the words. This is just because the function to make one is `data.frame()` and writing it this way is the normal convention. But writing it as a data frame is also fine. In nearly all cases we'll be using data that is loaded into R and is already in the structure of a data.frame (usually these will be Excel files or R data files like an .rda or .rds file).

If we wanted to create our own data.frame we would use the `data.frame()` function and the input would be vectors which will become our columns. Let's make a simple one. If the vector is already created then R would automatically take the name of that vector object as the column name, otherwise we could name it ourselves


```r
example <- data.frame(column_1 = c(1, 3, 5, 7, 9),
                      column2  = c("hello", "darkness", "my", "old", "friend"))
example
#>   column_1  column2
#> 1        1    hello
#> 2        3 darkness
#> 3        5       my
#> 4        7      old
#> 5        9   friend
```

Now we have a new data.frame called example which has two columns and five rows. We named the columns ourselves and in this case we don't need to put the column name in quotes, though doing so would give the same result. Here we're saying that the column "column_1" is equal to the vector `c(1, 3, 5, 7, 9)` and "column_2" is equal to the vector `c("hello", "darkness", "my", "old", "friend")`. We're essentially creating an object inside of the `data.frame()` function but in this case we need to use the equal sign and not the `<-` because R doesn't allow the use of `<-` inside of a function. 

If we forget to name the columns, and our vectors aren't already created with their own name, R will create a name based on the values in that vector. As shown below, this looks really bad so make sure to always name your columns. 


```r
example <- data.frame(c(1, 3, 5, 7, 9),
                      c("hello", "darkness", "my", "old", "friend"))
example
#>   c.1..3..5..7..9. c..hello....darkness....my....old....friend..
#> 1                1                                         hello
#> 2                3                                      darkness
#> 3                5                                            my
#> 4                7                                           old
#> 5                9                                        friend
```

If the vectors are already made then we won't have an issue. R will default to the vector name but we can override that if we want.


```r
column_1 = c(1, 3, 5, 7, 9)
column2  = c("hello", "darkness", "my", "old", "friend")
example <- data.frame(column_1, 
           overridden_name = column2)
example
#>   column_1 overridden_name
#> 1        1           hello
#> 2        3        darkness
#> 3        5              my
#> 4        7             old
#> 5        9          friend
```

As with other objects, we can use the `is()` function to see what type it is. If we use `is()` on our example object it'll tell us that it is a data.frame.


```r
is(example)
#> [1] "data.frame" "list"       "oldClass"   "vector"
```

We also often will want to know how many columns and rows a data.frame has. For finding the number of rows we use the function `nrow()` and for finding the number of columns we'll use the `ncol()` function.^[We could also use the `dim()` function which tells the dimensions of the data.frame - so how many rows and columns it has. This function returns a vector showing first the number of rows and then the number of columns. But I find it easier to simply ask for the number of rows or columns separately, and to not deal with the result which has two values.] In each the "n" part of the function just stands for number. So `nrow()` is number of rows. For each we put our data.frame object in the parentheses (without quotes since it is something already loaded in R) and it will return the number of rows/columns.


```r
nrow(example)
#> [1] 5
```


```r
ncol(example)
#> [1] 2
```

Alternatively, we could have looked in the Environment tab which shows us the number of rows and columns of each data.frame that is loaded to R. For example, ucr2017 says it has "15764 obs. of 9 variables". This just means there are 15,764 rows and 9 variables. A variable in this context is just another way to say a column. However, you'll occasionally want to find the exact number of rows and columns and as you'll often delete certain rows and columns from your data this can change throughout your code. So being able to use `nrow()` and `ncol()` is easier than repeatedly checking the Environment tab. 

You may encounter something called a data.table or a tibble. These are two popular variations of data.frames that operate much the same way as data.frames but with some different features. We'll use tibbles in this book so will discuss their features when we use them.

### Other data structures

There are two other data structures that I'll mention only so you have heard of them and can look up more information on them if you'd like. However, these are not *that* important to know about for the purpose of this book. Some of these structures may come up in rare cases when you're programming, so it's important to know that they exist.

The first data structure is a list. A list is essentially a vector but where different values can be different types. Lists are actually very powerful data structures and ones that you'll encounter a lot when using R, but are almost entirely on the backend of R so not things you'll actually deal with much. For example, all data.frames are actually lists. And more specifically, they are a list of vectors. Lists can come in handy because they can store different types of data structures. A single list can, for example, have a number, a vector, a matrix (discussed below), and an entire data.frame inside. Lists can even have other lists inside of them. Let's look at an example of this.


```r
list_example <- list("hello", 1:5, 6:10, list(c(33, 66, 99)), head(mtcars))
head(list_example)
#> [[1]]
#> [1] "hello"
#> 
#> [[2]]
#> [1] 1 2 3 4 5
#> 
#> [[3]]
#> [1]  6  7  8  9 10
#> 
#> [[4]]
#> [[4]][[1]]
#> [1] 33 66 99
#> 
#> 
#> [[5]]
#>                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#> Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

The list that I called list_example contains six different elements in it: a character, two numeric vectors, a list of a numeric vector, and the first six rows of the mtcars data.frame. Lists can be useful when storing many different objects at once, but as they are not used too often for research-related programming I'll say no more of them. 

The other type of data structure is a matrix. A matrix is a two-dimensional object where every value is the same type. Think of a data.frame but each column has to be the same type. Below is an example of a matrix with values 1 through 50 and with five columns and five rows. Every value here is a number.


```r
matrix(1:50, nrow = 5, ncol = 5)
#>      [,1] [,2] [,3] [,4] [,5]
#> [1,]    1    6   11   16   21
#> [2,]    2    7   12   17   22
#> [3,]    3    8   13   18   23
#> [4,]    4    9   14   19   24
#> [5,]    5   10   15   20   25
```

If I change it to have the first value be "1" (in quotes so it is a character) and the others be the numbers 2 through 50, the matrix will automatically convert everything to a character type. So it will remain having everything be the same type, but now everything is a character.


```r
matrix(c("1", 2:50), nrow = 5, ncol = 5)
#>      [,1] [,2] [,3] [,4] [,5]
#> [1,] "1"  "6"  "11" "16" "21"
#> [2,] "2"  "7"  "12" "17" "22"
#> [3,] "3"  "8"  "13" "18" "23"
#> [4,] "4"  "9"  "14" "19" "24"
#> [5,] "5"  "10" "15" "20" "25"
```
