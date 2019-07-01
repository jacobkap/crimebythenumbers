
# Types of objects

## Vectors

## Data frames
A data frame is a special case of a list where all the components of the list have the same number of elements. Think about each component of the list being a "column" in your dataset. R can load in datasets from numerous sources (plain text, Excel files, databases, websites, etc.) including .RData format, R's unique data format. There is an extensive guide to [importing and exporting datasets](https://cran.r-project.org/doc/manuals/r-release/R-data.pdf).



## Lists 

So far we have worked with very simple collections of numbers or text or logical values. Eventually we will need to work with more complicated kinds of data, like datasets, maps, and other objects. R stores these more complex objects in a list. A list is essentially a collection of objects, potentially of different types. Let's start with a simple list.

```r
a <- list(1:3,5:1,1:10)
a
[[1]]
[1] 1 2 3

[[2]]
[1] 5 4 3 2 1

[[3]]
 [1]  1  2  3  4  5  6  7  8  9 10
```
The list `a` has three components, each of which is a collection of values and each has different length. Here's another list consisting of three components, each of which is a collection of different types, numeric, text, and logical values.

```r
b <- list(0:9, c("A","B","C"),c(TRUE,FALSE,NA))
b
[[1]]
 [1] 0 1 2 3 4 5 6 7 8 9

[[2]]
[1] "A" "B" "C"

[[3]]
[1]  TRUE FALSE    NA
```
We use a double set of square brackets to access the components of a list. Let's say we just want the first component of `a`, just the part with the numbers 1, 2, and 3.

```r
a[[1]]
[1] 1 2 3
```
We can even grab the first element in the first component of the list `a`.

```r
a[[1]][1]
[1] 1
```
Or we just select the first and third component of the list `a`. This will return a new list, but just without the second component.

```r
a[c(1,3)]
[[1]]
[1] 1 2 3

[[2]]
 [1]  1  2  3  4  5  6  7  8  9 10
```

`lapply()` means "list apply" and lets us apply a given function to every item in a list and obtain a list in return. Let's say we want to sort each of the components in `a`. It would take too much typing to run `sort(a[[1]])` and `sort(a[[2]])` and `sort(a[[3]])`. Instead, `lapply()` can apply the sort function to each of the three components in `a`.

```r
lapply(a,sort)
[[1]]
[1] 1 2 3

[[2]]
[1] 1 2 3 4 5

[[3]]
 [1]  1  2  3  4  5  6  7  8  9 10
```
There is also a function `sapply()` that works in a manner quite similar to `lapply()`. The only difference is that `sapply()` will try to simplify the results. Think about the "s" meaning "simplified". Let's compute the number of elements in each component and the average of the numbers in each component.

```r
sapply(a,length)
sapply(a,mean)
[1]  3  5 10
[1] 2.0 3.0 5.5
```
Since `length()` and `mean()` will return a single number for each component, the result can be simplified into a collection of three values, one for each component of the list.

Let's find the component that has the most values in it.

```r
i <- which.max(sapply(a,length))
a[[i]]
 [1]  1  2  3  4  5  6  7  8  9 10
```
If `sapply()` is not able to simplify the result, then the result is just like `lapply()`.

```r
sapply(a,sort)
[[1]]
[1] 1 2 3

[[2]]
[1] 1 2 3 4 5

[[3]]
 [1]  1  2  3  4  5  6  7  8  9 10
```

Let's return to our state example. Before we just had a collection of 51 postal codes. Instead, let's create a list that separates them into three components depending on whether they are in the west, east, or central United States.

```r
state.list <- list(
   west=c("AK","HI","WA","NV","CA","CO","UT","OR","AZ","NM","ID"),
   east=c("KY","RI","PA","DE","DC","NJ","WV","MA","SC","NH","GA","CT","NY","IN",
          "MS","AL","OH","NC","MD","VA","VT","FL","ME","TN"),
   central=c("SD","MO","MN","ND","WY","OK","MI","IL","IA","LA","WI","MT","NE",
             "AR","TX","KS"))
```

We can now use `lapply()` to ask R to sort each region, sample three states from each region, and tell us how many states are in each region.


```r
lapply(state.list,sort)
$west
 [1] "AK" "AZ" "CA" "CO" "HI" "ID" "NM" "NV" "OR" "UT" "WA"

$east
 [1] "AL" "CT" "DC" "DE" "FL" "GA" "IN" "KY" "MA" "MD" "ME" "MS" "NC" "NH"
[15] "NJ" "NY" "OH" "PA" "RI" "SC" "TN" "VA" "VT" "WV"

$central
 [1] "AR" "IA" "IL" "KS" "LA" "MI" "MN" "MO" "MT" "ND" "NE" "OK" "SD" "TX"
[15] "WI" "WY"
lapply(state.list,sample,size=3,replace=FALSE)
$west
[1] "OR" "AK" "NV"

$east
[1] "VA" "GA" "MD"

$central
[1] "IL" "SD" "ND"
sapply(state.list,length)
   west    east central 
     11      24      16 
```

Notice here that we have given names (west, east, and central) to each of the three components of `state.list`. We can ask R to tell us what the names of the `state.list` components are.


```r
names(state.list)
[1] "west"    "east"    "central"
```

We can use the double square brackets to extract the western states. Since they are first in the list we use `[[1]]`


```r
state.list[[1]]
 [1] "AK" "HI" "WA" "NV" "CA" "CO" "UT" "OR" "AZ" "NM" "ID"
```

However, this can be dangerous. Are we sure the first component has the western states? A safer approach is to call it by name inside the square brackets.


```r
state.list[["west"]]
 [1] "AK" "HI" "WA" "NV" "CA" "CO" "UT" "OR" "AZ" "NM" "ID"
```

We can also use the `$` to extract a named component from a list. 


```r
state.list$west
 [1] "AK" "HI" "WA" "NV" "CA" "CO" "UT" "OR" "AZ" "NM" "ID"
```

The dollar sign in R is going to be extremely important. We will be using it a lot to extract variables, map components, and other values from lists.

You can use the `$` to add new components to a list. Let's add all the postal codes for all of the United States territories.

```r
state.list$other <- c("AS","GU","MP","PR","VI","UM","FM","MH","PW")
```

What happens if we ran just the following?
```
other <- c("AS","GU","MP","PR","VI","UM","FM","MH","PW")
```
This creates a separate object called `other`, unconnected to our `state.list`. By using the `$` we add our new collection of states (other) to `state.list`.

We have now created a lot of objects. At any time you can run `ls()` to list all the objects that R has in memory.

```r
ls()
[1] "a"          "b"          "i"          "state.list"
```
Assuming you are using R Studio, you can also see the objects stored in memory by clicking on the Environment tab.
