
# Regular Expressions 

A regular expression is a sequence of characters that defines a search pattern. Sometimes we use regular expressions to help us find a pattern in text that we want, like the Find functionality in Word. Other times, we use a regular expression to help us find and replace a piece of text, like the Find and Replace functionality in Word. The two main R functions that we will learn about are `grep()` and `gsub()`. You may use them in verb form (e.g., "I need to grep all the gun cases," "I was grepping like crazy to find all the opioid cases," "I first had to gsub the commas with semicolons"). Regular expressions are available in numerous other software packages, so what you learn here will port over to using regular expressions in Linux, Stata, Python, Java, ArcGIS, and many others.

The `grep()` function lets you find a pattern in the text and it will return a number saying which element has the pattern. `gsub()` lets you input a pattern to find and a pattern to replace it with, just like Find and Replace features elsewhere. You can remember the difference because `gsub()` has the word "sub" in it and what it does is substitute text with new text. 

A useful cheat sheet on regular expressions is available [here](https://www.rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf).

For this lesson we will use a vector of 50 crime categories. These are all of the crimes in San Francisco Police data. As you'll see, there are some issues with the crime names that we need to fix.


```r
crimes <- c(
  "Arson",
  "Assault",                                  
  "Burglary",                                 
  "Case Closure",                             
  "Civil Sidewalks",                          
  "Courtesy Report",                          
  "Disorderly Conduct",                       
  "Drug Offense",                             
  "Drug Violation",                           
  "Embezzlement",                             
  "Family Offense",                           
  "Fire Report",                              
  "Forgery And Counterfeiting",               
  "Fraud",                                    
  "Gambling",                                 
  "Homicide",                                 
  "Human Trafficking (A), Commercial Sex Acts",
  "Human Trafficking, Commercial Sex Acts",   
  "Juvenile Offenses",                        
  "Larceny Theft",                            
  "Liquor Laws",                              
  "Lost Property",                            
  "Malicious Mischief",                       
  "Miscellaneous Investigation",              
  "Missing Person",                           
  "Motor Vehicle Theft",                      
  "Motor Vehicle Theft?",                     
  "Non-Criminal",                             
  "Offences Against The Family And Children", 
  "Other",                                    
  "Other Miscellaneous",                      
  "Other Offenses",                           
  "Prostitution",                             
  "Rape",                                     
  "Recovered Vehicle",                        
  "Robbery",                                  
  "Sex Offense",                              
  "Stolen Property",                          
  "Suicide",                                  
  "Suspicious",                               
  "Suspicious Occ",                           
  "Traffic Collision",                        
  "Traffic Violation Arrest",                 
  "Vandalism",                                
  "Vehicle Impounded",                        
  "Vehicle Misplaced",                        
  "Warrant",                                  
  "Weapons Carrying Etc",                     
  "Weapons Offence",                          
  "Weapons Offense"
)
```

When looking closely at these crimes it is clear that some may overlap in certain categories such as theft, and there are several duplicates with slight differences in spelling. For example the last two crimes are "Weapons Offence" and "Weapons Offense". These should clearly be the same crime but the first one spelled "offense" wrong. And take a look at "motor vehicle theft". There are two crimes here because one of them adds a question mark at the end for some reason. 

## Finding patterns in text with `grep()`

First we'll learn about `grep()`, which was first developed in the early 1970s. `grep()` searches data for lines that match a given expression. The name `grep` is an acronym for "**g**lobally search a **r**egular **e**xpression and **p**rint." Some tangible examples will help us see how `grep()` works.

The syntax for `grep()` is 

grep("pattern", data)

pattern is the pattern you are searching for, such as "a" if you want to find all values with the letter a. The pattern must always be in quotes.

data is a string or vector of strings (such as "crimes" we made above) that you are searching in to find the pattern. 

The output of this function is a number which says which element(s) in the vector the pattern was found in. If it returns, for example, the numbers 1 and 3 you know that the first and third element in your vector has the pattern - and no other elements do. It is essentially returning the index where the conditional statement "is this pattern present" is true.

So since our data is "crimes" our `grep()` function will be `grep("", crimes)`. What we put in the "" is the pattern we want to search for.

Let's start with the letter "a".


```r
grep("a", crimes)
#>  [1]  2  3  4  5  9 11 14 15 17 18 20 21 23 24 28 29 31 34 42 43 44 46 47
#> [24] 48 49 50
```

It gives us a bunch of numbers where the letter "a" is present in that element of "crimes". What this is useful for is subsetting. We can use `grep()` to find all values that match a pattern we want and subset to keep just those values. This gives us the row numbers to keep.


```r
crimes[grep("a", crimes)]
#>  [1] "Assault"                                   
#>  [2] "Burglary"                                  
#>  [3] "Case Closure"                              
#>  [4] "Civil Sidewalks"                           
#>  [5] "Drug Violation"                            
#>  [6] "Family Offense"                            
#>  [7] "Fraud"                                     
#>  [8] "Gambling"                                  
#>  [9] "Human Trafficking (A), Commercial Sex Acts"
#> [10] "Human Trafficking, Commercial Sex Acts"    
#> [11] "Larceny Theft"                             
#> [12] "Liquor Laws"                               
#> [13] "Malicious Mischief"                        
#> [14] "Miscellaneous Investigation"               
#> [15] "Non-Criminal"                              
#> [16] "Offences Against The Family And Children"  
#> [17] "Other Miscellaneous"                       
#> [18] "Rape"                                      
#> [19] "Traffic Collision"                         
#> [20] "Traffic Violation Arrest"                  
#> [21] "Vandalism"                                 
#> [22] "Vehicle Misplaced"                         
#> [23] "Warrant"                                   
#> [24] "Weapons Carrying Etc"                      
#> [25] "Weapons Offence"                           
#> [26] "Weapons Offense"
```

Searching for the letter "a" isn't that useful. Let's say we want to subset the data to only include theft related crimes. From reading the list of crimes we can see there are multiple theft crimes - "Larceny Theft", "Motor Vehicle Theft", and "Motor Vehicle Theft?". We may also want to include "Stolen Property" in this search but we'll wait until later in this lesson for how to search for multiple patterns. Since those three crimes all have the word "Theft" in the name we can search for the pattern and it will return only those crimes
 

```r
grep("Theft", crimes)
#> [1] 20 26 27
```

A very useful parameter is `value`. When we set `value` to TRUE, it will print out the actual strings that are a match rather than the element number. While this prevents us from using it to subset, it is an excellent tool to check if the `grep()` was successful as we can visually confirm it returns what we want. When we start to learn about special characters soon which makes the patterns more complicated, this will be important.


```r
grep("Theft", crimes, value = TRUE)
#> [1] "Larceny Theft"        "Motor Vehicle Theft"  "Motor Vehicle Theft?"
```

Note that `grep()` (and `gsub()`) is case sensitive so you must capitalize properly.


```r
grep("theft", crimes)
#> integer(0)
```

Setting the parameter `ignore.case` to be TRUE makes `grep()` ignore capitalization.


```r
grep("theft", crimes, ignore.case = TRUE)
#> [1] 20 26 27
```

## Finding and replacing patterns in text with `gsub()`

`gsub()` stands for "global substitution." It takes patterns and replaces them with other patterns. An important use in criminology for `gsub()` is to fix spelling mistakes in the text such as the way "offense" was spelled wrong in our data. This will be a standard part of your data cleaning process but will be important as a mispelled word can cause significant issues. For example if our previous example of marijuana legalization in Colorado had half of agencies mispelling the name "Colorado", aggregating the data by the state (or simply subsetting to just Colorado agencies) would give completely different results as you'd lose half you data.

`gsub()` is also useful when you want to take subcategories and change the value to larger categories. For example we could take any crime with the word "Theft" in it and change the whole crime name to "Theft". In our data that would take 3 subcategories of thefts and turn it into a larger category we could aggregate to. This will be useful in city-level data where you may only care about violent crime but it has many violent crime categories you need to aggregate.

The syntax of `gsub()` is similar to `grep()` with the addition of a pattern to replace the pattern we found.

`gsub("find_pattern", "replace_pattern", data)`

Let's start with a simple example of finding the letter "a" and replacing it with "z". Our data will be the word "cat".


```r
gsub("a", "z", "cat")
#> [1] "czt"
```

Like `grep()`, `gsub()` is case sensitive and has the parameter `ignore.case` to ignore capitalizations.


```r
gsub("A", "z", "cat")
#> [1] "cat"
```


```r
gsub("A", "z", "cat", ignore.case = TRUE)
#> [1] "czt"
```

`gsub()` returns the same data you input but with the pattern already replaced. Above you can see that when using capital A, it returns "cat" unchanged as it never found the pattern. When `ignore.case` was set to TRUE it returned "czt" as it then matched to letter "A".

We can use `gsub()` to replace some issues in the crimes data such as "Offense" being spelled "Offence".


```r
gsub("Offence", "Offense", crimes)
#>  [1] "Arson"                                     
#>  [2] "Assault"                                   
#>  [3] "Burglary"                                  
#>  [4] "Case Closure"                              
#>  [5] "Civil Sidewalks"                           
#>  [6] "Courtesy Report"                           
#>  [7] "Disorderly Conduct"                        
#>  [8] "Drug Offense"                              
#>  [9] "Drug Violation"                            
#> [10] "Embezzlement"                              
#> [11] "Family Offense"                            
#> [12] "Fire Report"                               
#> [13] "Forgery And Counterfeiting"                
#> [14] "Fraud"                                     
#> [15] "Gambling"                                  
#> [16] "Homicide"                                  
#> [17] "Human Trafficking (A), Commercial Sex Acts"
#> [18] "Human Trafficking, Commercial Sex Acts"    
#> [19] "Juvenile Offenses"                         
#> [20] "Larceny Theft"                             
#> [21] "Liquor Laws"                               
#> [22] "Lost Property"                             
#> [23] "Malicious Mischief"                        
#> [24] "Miscellaneous Investigation"               
#> [25] "Missing Person"                            
#> [26] "Motor Vehicle Theft"                       
#> [27] "Motor Vehicle Theft?"                      
#> [28] "Non-Criminal"                              
#> [29] "Offenses Against The Family And Children"  
#> [30] "Other"                                     
#> [31] "Other Miscellaneous"                       
#> [32] "Other Offenses"                            
#> [33] "Prostitution"                              
#> [34] "Rape"                                      
#> [35] "Recovered Vehicle"                         
#> [36] "Robbery"                                   
#> [37] "Sex Offense"                               
#> [38] "Stolen Property"                           
#> [39] "Suicide"                                   
#> [40] "Suspicious"                                
#> [41] "Suspicious Occ"                            
#> [42] "Traffic Collision"                         
#> [43] "Traffic Violation Arrest"                  
#> [44] "Vandalism"                                 
#> [45] "Vehicle Impounded"                         
#> [46] "Vehicle Misplaced"                         
#> [47] "Warrant"                                   
#> [48] "Weapons Carrying Etc"                      
#> [49] "Weapons Offense"                           
#> [50] "Weapons Offense"
```

A useful pattern is an empty string "" which says replace whatever the find_pattern is with nothing, deleting it. Let's delete the letter "a" from the data. 


```r
gsub("a", "", crimes)
#>  [1] "Arson"                                  
#>  [2] "Assult"                                 
#>  [3] "Burglry"                                
#>  [4] "Cse Closure"                            
#>  [5] "Civil Sidewlks"                         
#>  [6] "Courtesy Report"                        
#>  [7] "Disorderly Conduct"                     
#>  [8] "Drug Offense"                           
#>  [9] "Drug Violtion"                          
#> [10] "Embezzlement"                           
#> [11] "Fmily Offense"                          
#> [12] "Fire Report"                            
#> [13] "Forgery And Counterfeiting"             
#> [14] "Frud"                                   
#> [15] "Gmbling"                                
#> [16] "Homicide"                               
#> [17] "Humn Trfficking (A), Commercil Sex Acts"
#> [18] "Humn Trfficking, Commercil Sex Acts"    
#> [19] "Juvenile Offenses"                      
#> [20] "Lrceny Theft"                           
#> [21] "Liquor Lws"                             
#> [22] "Lost Property"                          
#> [23] "Mlicious Mischief"                      
#> [24] "Miscellneous Investigtion"              
#> [25] "Missing Person"                         
#> [26] "Motor Vehicle Theft"                    
#> [27] "Motor Vehicle Theft?"                   
#> [28] "Non-Criminl"                            
#> [29] "Offences Aginst The Fmily And Children" 
#> [30] "Other"                                  
#> [31] "Other Miscellneous"                     
#> [32] "Other Offenses"                         
#> [33] "Prostitution"                           
#> [34] "Rpe"                                    
#> [35] "Recovered Vehicle"                      
#> [36] "Robbery"                                
#> [37] "Sex Offense"                            
#> [38] "Stolen Property"                        
#> [39] "Suicide"                                
#> [40] "Suspicious"                             
#> [41] "Suspicious Occ"                         
#> [42] "Trffic Collision"                       
#> [43] "Trffic Violtion Arrest"                 
#> [44] "Vndlism"                                
#> [45] "Vehicle Impounded"                      
#> [46] "Vehicle Misplced"                       
#> [47] "Wrrnt"                                  
#> [48] "Wepons Crrying Etc"                     
#> [49] "Wepons Offence"                         
#> [50] "Wepons Offense"
```

## Useful special characters

So far we have just searched for a single character or word and expected a return only if an exact match was found.

There are several symbols or sequences of symbols that are useful to make more sophisticated patterns. The number of symbols on the keyboard are fairly limited compared to the numerous combinations of patterns of text we might wish to find. As a result you will see that some of these symbols are used in very different ways depending on the context.

### Multiple characters `[]`

We can also search for multiple characters, instead of individual characters. We place our list of desired characters within square brackets `[]`. For example, let's find crimes that contain vowels.


```r
grep("[aeiou]", crimes, value = TRUE)
#>  [1] "Arson"                                     
#>  [2] "Assault"                                   
#>  [3] "Burglary"                                  
#>  [4] "Case Closure"                              
#>  [5] "Civil Sidewalks"                           
#>  [6] "Courtesy Report"                           
#>  [7] "Disorderly Conduct"                        
#>  [8] "Drug Offense"                              
#>  [9] "Drug Violation"                            
#> [10] "Embezzlement"                              
#> [11] "Family Offense"                            
#> [12] "Fire Report"                               
#> [13] "Forgery And Counterfeiting"                
#> [14] "Fraud"                                     
#> [15] "Gambling"                                  
#> [16] "Homicide"                                  
#> [17] "Human Trafficking (A), Commercial Sex Acts"
#> [18] "Human Trafficking, Commercial Sex Acts"    
#> [19] "Juvenile Offenses"                         
#> [20] "Larceny Theft"                             
#> [21] "Liquor Laws"                               
#> [22] "Lost Property"                             
#> [23] "Malicious Mischief"                        
#> [24] "Miscellaneous Investigation"               
#> [25] "Missing Person"                            
#> [26] "Motor Vehicle Theft"                       
#> [27] "Motor Vehicle Theft?"                      
#> [28] "Non-Criminal"                              
#> [29] "Offences Against The Family And Children"  
#> [30] "Other"                                     
#> [31] "Other Miscellaneous"                       
#> [32] "Other Offenses"                            
#> [33] "Prostitution"                              
#> [34] "Rape"                                      
#> [35] "Recovered Vehicle"                         
#> [36] "Robbery"                                   
#> [37] "Sex Offense"                               
#> [38] "Stolen Property"                           
#> [39] "Suicide"                                   
#> [40] "Suspicious"                                
#> [41] "Suspicious Occ"                            
#> [42] "Traffic Collision"                         
#> [43] "Traffic Violation Arrest"                  
#> [44] "Vandalism"                                 
#> [45] "Vehicle Impounded"                         
#> [46] "Vehicle Misplaced"                         
#> [47] "Warrant"                                   
#> [48] "Weapons Carrying Etc"                      
#> [49] "Weapons Offence"                           
#> [50] "Weapons Offense"
```

This also works for numbers though we do not have any numbers in the data.


```r
grep("[01234567890]", crimes, value = TRUE)
#> character(0)
```

So the `[]` in a regular expression means "match any of these characters." We can also place square brackets next to each other. For example, let's say we wanted to find values in "crimes" that has three adjacent vowels


```r
grep("[aeiou][aeiou][aeiou]", crimes, value = TRUE)
#> [1] "Malicious Mischief"          "Miscellaneous Investigation"
#> [3] "Other Miscellaneous"         "Suspicious"                 
#> [5] "Suspicious Occ"
```

Inside the `[]` we can also use the - to make intervals between certain values. With numbers n-m means any number between n and m (inclusive). For letters, a-z means all lowercase letters and A-Z means all uppercase letters. 

### n-many of previous character `{n}`

{n} means the preceding item will be matched exactly n times.

We can use it to rewrite the above `grep()` to saw the values in the `[]` should be repeated three times. 


```r
grep("[aeiou]{3}", crimes, value = TRUE)
#> [1] "Malicious Mischief"          "Miscellaneous Investigation"
#> [3] "Other Miscellaneous"         "Suspicious"                 
#> [5] "Suspicious Occ"
```

Note that this also matches text that has two or more vowels in a row, since if they have three numbers in a row, then they will also have two numbers in a row. 

### n-many to m-many of previous character `{n,m}`

While `{n}` says "the previous character must be present exactly n times", we can allow a range by using `{n, m}`. Here the previous character must be present between n and m times.

We can check for values where there are 2-3 vowels in a row. Note that there cannot be a space before or after the comma


```r
grep("[aeiou]{2,3}", crimes, value = TRUE)
#>  [1] "Assault"                                   
#>  [2] "Courtesy Report"                           
#>  [3] "Drug Violation"                            
#>  [4] "Forgery And Counterfeiting"                
#>  [5] "Fraud"                                     
#>  [6] "Human Trafficking (A), Commercial Sex Acts"
#>  [7] "Human Trafficking, Commercial Sex Acts"    
#>  [8] "Liquor Laws"                               
#>  [9] "Malicious Mischief"                        
#> [10] "Miscellaneous Investigation"               
#> [11] "Offences Against The Family And Children"  
#> [12] "Other Miscellaneous"                       
#> [13] "Prostitution"                              
#> [14] "Suicide"                                   
#> [15] "Suspicious"                                
#> [16] "Suspicious Occ"                            
#> [17] "Traffic Collision"                         
#> [18] "Traffic Violation Arrest"                  
#> [19] "Vehicle Impounded"                         
#> [20] "Weapons Carrying Etc"                      
#> [21] "Weapons Offence"                           
#> [22] "Weapons Offense"
```

If we wanted only crimes with exactly three vowels in a row we'd use `{3,3}`.


```r
grep("[aeiou]{3,3}", crimes, value = TRUE)
#> [1] "Malicious Mischief"          "Miscellaneous Investigation"
#> [3] "Other Miscellaneous"         "Suspicious"                 
#> [5] "Suspicious Occ"
```


If we leave n blank, such as `{,m}` it says "previous character must be present up to m times". 


```r
grep("[aeiou]{,3}", crimes, value = TRUE)
#>  [1] "Arson"                                     
#>  [2] "Assault"                                   
#>  [3] "Burglary"                                  
#>  [4] "Case Closure"                              
#>  [5] "Civil Sidewalks"                           
#>  [6] "Courtesy Report"                           
#>  [7] "Disorderly Conduct"                        
#>  [8] "Drug Offense"                              
#>  [9] "Drug Violation"                            
#> [10] "Embezzlement"                              
#> [11] "Family Offense"                            
#> [12] "Fire Report"                               
#> [13] "Forgery And Counterfeiting"                
#> [14] "Fraud"                                     
#> [15] "Gambling"                                  
#> [16] "Homicide"                                  
#> [17] "Human Trafficking (A), Commercial Sex Acts"
#> [18] "Human Trafficking, Commercial Sex Acts"    
#> [19] "Juvenile Offenses"                         
#> [20] "Larceny Theft"                             
#> [21] "Liquor Laws"                               
#> [22] "Lost Property"                             
#> [23] "Malicious Mischief"                        
#> [24] "Miscellaneous Investigation"               
#> [25] "Missing Person"                            
#> [26] "Motor Vehicle Theft"                       
#> [27] "Motor Vehicle Theft?"                      
#> [28] "Non-Criminal"                              
#> [29] "Offences Against The Family And Children"  
#> [30] "Other"                                     
#> [31] "Other Miscellaneous"                       
#> [32] "Other Offenses"                            
#> [33] "Prostitution"                              
#> [34] "Rape"                                      
#> [35] "Recovered Vehicle"                         
#> [36] "Robbery"                                   
#> [37] "Sex Offense"                               
#> [38] "Stolen Property"                           
#> [39] "Suicide"                                   
#> [40] "Suspicious"                                
#> [41] "Suspicious Occ"                            
#> [42] "Traffic Collision"                         
#> [43] "Traffic Violation Arrest"                  
#> [44] "Vandalism"                                 
#> [45] "Vehicle Impounded"                         
#> [46] "Vehicle Misplaced"                         
#> [47] "Warrant"                                   
#> [48] "Weapons Carrying Etc"                      
#> [49] "Weapons Offence"                           
#> [50] "Weapons Offense"
```

This returns every crime as "up to m times" includes zero times.

And the same works for leaving m blank but it will be "present at least n times". 


```r
grep("[aeiou]{3,}", crimes, value = TRUE)
#> [1] "Malicious Mischief"          "Miscellaneous Investigation"
#> [3] "Other Miscellaneous"         "Suspicious"                 
#> [5] "Suspicious Occ"
```

### Start of string and "not" `^`

The `^` symbol has two meanings.  When we put a `^` within square brackets, it means "not" any of the following characters in the square brackets. Let's use it for the pattern "Offense". Here we are searching and want a return for any string that does **not** have the pattern "Offense" in it.


```r
grep("[^Offense]", crimes, value = TRUE)
#>  [1] "Arson"                                     
#>  [2] "Assault"                                   
#>  [3] "Burglary"                                  
#>  [4] "Case Closure"                              
#>  [5] "Civil Sidewalks"                           
#>  [6] "Courtesy Report"                           
#>  [7] "Disorderly Conduct"                        
#>  [8] "Drug Offense"                              
#>  [9] "Drug Violation"                            
#> [10] "Embezzlement"                              
#> [11] "Family Offense"                            
#> [12] "Fire Report"                               
#> [13] "Forgery And Counterfeiting"                
#> [14] "Fraud"                                     
#> [15] "Gambling"                                  
#> [16] "Homicide"                                  
#> [17] "Human Trafficking (A), Commercial Sex Acts"
#> [18] "Human Trafficking, Commercial Sex Acts"    
#> [19] "Juvenile Offenses"                         
#> [20] "Larceny Theft"                             
#> [21] "Liquor Laws"                               
#> [22] "Lost Property"                             
#> [23] "Malicious Mischief"                        
#> [24] "Miscellaneous Investigation"               
#> [25] "Missing Person"                            
#> [26] "Motor Vehicle Theft"                       
#> [27] "Motor Vehicle Theft?"                      
#> [28] "Non-Criminal"                              
#> [29] "Offences Against The Family And Children"  
#> [30] "Other"                                     
#> [31] "Other Miscellaneous"                       
#> [32] "Other Offenses"                            
#> [33] "Prostitution"                              
#> [34] "Rape"                                      
#> [35] "Recovered Vehicle"                         
#> [36] "Robbery"                                   
#> [37] "Sex Offense"                               
#> [38] "Stolen Property"                           
#> [39] "Suicide"                                   
#> [40] "Suspicious"                                
#> [41] "Suspicious Occ"                            
#> [42] "Traffic Collision"                         
#> [43] "Traffic Violation Arrest"                  
#> [44] "Vandalism"                                 
#> [45] "Vehicle Impounded"                         
#> [46] "Vehicle Misplaced"                         
#> [47] "Warrant"                                   
#> [48] "Weapons Carrying Etc"                      
#> [49] "Weapons Offence"                           
#> [50] "Weapons Offense"
```

As expected it returns all the crimes other than ones with the word "Offense" in it. This method is similar to the parameter `invert` which returns all values that do not meet the pattern.


```r
grep("Offense", crimes, invert = TRUE, value = TRUE)
#>  [1] "Arson"                                     
#>  [2] "Assault"                                   
#>  [3] "Burglary"                                  
#>  [4] "Case Closure"                              
#>  [5] "Civil Sidewalks"                           
#>  [6] "Courtesy Report"                           
#>  [7] "Disorderly Conduct"                        
#>  [8] "Drug Violation"                            
#>  [9] "Embezzlement"                              
#> [10] "Fire Report"                               
#> [11] "Forgery And Counterfeiting"                
#> [12] "Fraud"                                     
#> [13] "Gambling"                                  
#> [14] "Homicide"                                  
#> [15] "Human Trafficking (A), Commercial Sex Acts"
#> [16] "Human Trafficking, Commercial Sex Acts"    
#> [17] "Larceny Theft"                             
#> [18] "Liquor Laws"                               
#> [19] "Lost Property"                             
#> [20] "Malicious Mischief"                        
#> [21] "Miscellaneous Investigation"               
#> [22] "Missing Person"                            
#> [23] "Motor Vehicle Theft"                       
#> [24] "Motor Vehicle Theft?"                      
#> [25] "Non-Criminal"                              
#> [26] "Offences Against The Family And Children"  
#> [27] "Other"                                     
#> [28] "Other Miscellaneous"                       
#> [29] "Prostitution"                              
#> [30] "Rape"                                      
#> [31] "Recovered Vehicle"                         
#> [32] "Robbery"                                   
#> [33] "Stolen Property"                           
#> [34] "Suicide"                                   
#> [35] "Suspicious"                                
#> [36] "Suspicious Occ"                            
#> [37] "Traffic Collision"                         
#> [38] "Traffic Violation Arrest"                  
#> [39] "Vandalism"                                 
#> [40] "Vehicle Impounded"                         
#> [41] "Vehicle Misplaced"                         
#> [42] "Warrant"                                   
#> [43] "Weapons Carrying Etc"                      
#> [44] "Weapons Offence"
```

The second use of `^` signifies that what follow it is the start of the string. We put the `^` at the beginning of the quotes and then anything that follows it must be the very start of the string. As an example let's search for "Family". Our data has both the "Family Offense" crime and the "Offences Against The Family And Children" crime (which likely are the same crime written differently). If we use `^` then we should only have the first one returned.


```r
grep("^Family", crimes, value = TRUE)
#> [1] "Family Offense"
```

### End of string `$`

While we use carets `^` to signal the beginning of the text, the dollar sign `$` signals the end of the text. For example,  let's search for all crimes that end with the word "Theft".


```r
grep("Theft$", crimes, value = TRUE)
#> [1] "Larceny Theft"       "Motor Vehicle Theft"
```

Note that the crime "Motor Vehicle Theft?" doesn't get selected as it ends with a question mark.

### Anything `.`

The `.` symbol is a stand-in for any value. This is useful when you aren't sure about every part of the pattern you are searching. It can also be used when there are slight differences in words such as our incorrect "Offence" and "Offense". We can replace the "c" and "s" with the `.`.


```r
grep("Weapons Offen.e", crimes, value = TRUE)
#> [1] "Weapons Offence" "Weapons Offense"
```

### One or more of previous `+`

The `+` means at least one of the previous and is the same as `{1,}`. For example, suppose we wanted to crimes with only two words. We would start with some number of letters followed by a space followed by some more letters and the string would end.


```r
grep("^[A-Za-z]+ [A-Za-z]+$", crimes, value = TRUE)
#>  [1] "Case Closure"                "Civil Sidewalks"            
#>  [3] "Courtesy Report"             "Disorderly Conduct"         
#>  [5] "Drug Offense"                "Drug Violation"             
#>  [7] "Family Offense"              "Fire Report"                
#>  [9] "Juvenile Offenses"           "Larceny Theft"              
#> [11] "Liquor Laws"                 "Lost Property"              
#> [13] "Malicious Mischief"          "Miscellaneous Investigation"
#> [15] "Missing Person"              "Other Miscellaneous"        
#> [17] "Other Offenses"              "Recovered Vehicle"          
#> [19] "Sex Offense"                 "Stolen Property"            
#> [21] "Suspicious Occ"              "Traffic Collision"          
#> [23] "Vehicle Impounded"           "Vehicle Misplaced"          
#> [25] "Weapons Offence"             "Weapons Offense"
```

### Zero or more of previous `*`

The `*` special character says match zero or more of the previous character and is the same as `{0,}`. Combining `.` with `*` is very powerful when used in `gsub()` to delete text before or after a pattern. Let's write a pattern that searches a text for the word "Weapons" and then deletes any text after that. 

Our pattern would be "Weapons.*" - The word "Weapons" followed by anything zero or more times. 


```r
gsub("Weapons.*", "Weapons", crimes)
#>  [1] "Arson"                                     
#>  [2] "Assault"                                   
#>  [3] "Burglary"                                  
#>  [4] "Case Closure"                              
#>  [5] "Civil Sidewalks"                           
#>  [6] "Courtesy Report"                           
#>  [7] "Disorderly Conduct"                        
#>  [8] "Drug Offense"                              
#>  [9] "Drug Violation"                            
#> [10] "Embezzlement"                              
#> [11] "Family Offense"                            
#> [12] "Fire Report"                               
#> [13] "Forgery And Counterfeiting"                
#> [14] "Fraud"                                     
#> [15] "Gambling"                                  
#> [16] "Homicide"                                  
#> [17] "Human Trafficking (A), Commercial Sex Acts"
#> [18] "Human Trafficking, Commercial Sex Acts"    
#> [19] "Juvenile Offenses"                         
#> [20] "Larceny Theft"                             
#> [21] "Liquor Laws"                               
#> [22] "Lost Property"                             
#> [23] "Malicious Mischief"                        
#> [24] "Miscellaneous Investigation"               
#> [25] "Missing Person"                            
#> [26] "Motor Vehicle Theft"                       
#> [27] "Motor Vehicle Theft?"                      
#> [28] "Non-Criminal"                              
#> [29] "Offences Against The Family And Children"  
#> [30] "Other"                                     
#> [31] "Other Miscellaneous"                       
#> [32] "Other Offenses"                            
#> [33] "Prostitution"                              
#> [34] "Rape"                                      
#> [35] "Recovered Vehicle"                         
#> [36] "Robbery"                                   
#> [37] "Sex Offense"                               
#> [38] "Stolen Property"                           
#> [39] "Suicide"                                   
#> [40] "Suspicious"                                
#> [41] "Suspicious Occ"                            
#> [42] "Traffic Collision"                         
#> [43] "Traffic Violation Arrest"                  
#> [44] "Vandalism"                                 
#> [45] "Vehicle Impounded"                         
#> [46] "Vehicle Misplaced"                         
#> [47] "Warrant"                                   
#> [48] "Weapons"                                   
#> [49] "Weapons"                                   
#> [50] "Weapons"
```

And now our last three crimes are all identical. 

### Multiple patterns `|`

The vertical bar functions as an "or." Suppose we wanted to get both the word "Drug" and the word "Weapons". We could write "Drug|Weapon" which searches for "Drug" or "Weapons" in the text. 


```r
grep("Drug|Weapons", crimes, value = TRUE)
#> [1] "Drug Offense"         "Drug Violation"       "Weapons Carrying Etc"
#> [4] "Weapons Offence"      "Weapons Offense"
```

### Parentheses `()`

Parentheses group together characters as words. For example, suppose we wanted to find the word "Offense".


```r
grep("(Offense)", crimes, value = TRUE)
#> [1] "Drug Offense"      "Family Offense"    "Juvenile Offenses"
#> [4] "Other Offenses"    "Sex Offense"       "Weapons Offense"
```

On its own the parentheses are no different than just running the regular expression "Offense" with no parentheses. However, in combination with `|` it gets more interesting and powerful.

Running just "(Offense)" returns values for multiple types of offenses. Let's say we just care about Drug and Weapon Offenses. We can search for "Offense" normally and combine `()` and `|` to say "search for either the word "Drug" or the word "Family" and they should be followed by the word "Offense".


```r
grep("(Drug|Weapons) Offense", crimes, value = TRUE)
#> [1] "Drug Offense"    "Weapons Offense"
```

And it returns only the values we want. 

###  Optional text `?`

The question mark indicates that the character immediately before the ? is optional.

Let's search for the term "offens" and add a ? at the end. This says search for the pattern "offen" and we expect an exact match for that pattern. And if the letter "s" follows "offen" return that too, but it isn't required to be there. 


```r
grep("Offens?", crimes, value = TRUE)
#> [1] "Drug Offense"                            
#> [2] "Family Offense"                          
#> [3] "Juvenile Offenses"                       
#> [4] "Offences Against The Family And Children"
#> [5] "Other Offenses"                          
#> [6] "Sex Offense"                             
#> [7] "Weapons Offence"                         
#> [8] "Weapons Offense"
```

We can further combine it with `()` and `|` to get both spellings of Weapon Offense.


```r
grep("(Drug|Weapons) Offens?", crimes, value = TRUE)
#> [1] "Drug Offense"    "Weapons Offence" "Weapons Offense"
```

### Back-referencing `()`

We will finish this discussion of special characters by discussing back-referencing, a very powerful technique in `gsub()` of saving parts of a pattern. 

## Changing capitalization

If you're dealing with data where the only difference is capitalization (as is common in crime data) instead of using `gsub()` to change individual values, you can use the functions `toupper()` and `tolower()`. These functions take as an input a vector of strings (or a column from a data.frame) and return those strings either upper or lowercased. They will change the case of every letter in the string.


```r
toupper(crimes)
#>  [1] "ARSON"                                     
#>  [2] "ASSAULT"                                   
#>  [3] "BURGLARY"                                  
#>  [4] "CASE CLOSURE"                              
#>  [5] "CIVIL SIDEWALKS"                           
#>  [6] "COURTESY REPORT"                           
#>  [7] "DISORDERLY CONDUCT"                        
#>  [8] "DRUG OFFENSE"                              
#>  [9] "DRUG VIOLATION"                            
#> [10] "EMBEZZLEMENT"                              
#> [11] "FAMILY OFFENSE"                            
#> [12] "FIRE REPORT"                               
#> [13] "FORGERY AND COUNTERFEITING"                
#> [14] "FRAUD"                                     
#> [15] "GAMBLING"                                  
#> [16] "HOMICIDE"                                  
#> [17] "HUMAN TRAFFICKING (A), COMMERCIAL SEX ACTS"
#> [18] "HUMAN TRAFFICKING, COMMERCIAL SEX ACTS"    
#> [19] "JUVENILE OFFENSES"                         
#> [20] "LARCENY THEFT"                             
#> [21] "LIQUOR LAWS"                               
#> [22] "LOST PROPERTY"                             
#> [23] "MALICIOUS MISCHIEF"                        
#> [24] "MISCELLANEOUS INVESTIGATION"               
#> [25] "MISSING PERSON"                            
#> [26] "MOTOR VEHICLE THEFT"                       
#> [27] "MOTOR VEHICLE THEFT?"                      
#> [28] "NON-CRIMINAL"                              
#> [29] "OFFENCES AGAINST THE FAMILY AND CHILDREN"  
#> [30] "OTHER"                                     
#> [31] "OTHER MISCELLANEOUS"                       
#> [32] "OTHER OFFENSES"                            
#> [33] "PROSTITUTION"                              
#> [34] "RAPE"                                      
#> [35] "RECOVERED VEHICLE"                         
#> [36] "ROBBERY"                                   
#> [37] "SEX OFFENSE"                               
#> [38] "STOLEN PROPERTY"                           
#> [39] "SUICIDE"                                   
#> [40] "SUSPICIOUS"                                
#> [41] "SUSPICIOUS OCC"                            
#> [42] "TRAFFIC COLLISION"                         
#> [43] "TRAFFIC VIOLATION ARREST"                  
#> [44] "VANDALISM"                                 
#> [45] "VEHICLE IMPOUNDED"                         
#> [46] "VEHICLE MISPLACED"                         
#> [47] "WARRANT"                                   
#> [48] "WEAPONS CARRYING ETC"                      
#> [49] "WEAPONS OFFENCE"                           
#> [50] "WEAPONS OFFENSE"
```


```r
tolower(crimes)
#>  [1] "arson"                                     
#>  [2] "assault"                                   
#>  [3] "burglary"                                  
#>  [4] "case closure"                              
#>  [5] "civil sidewalks"                           
#>  [6] "courtesy report"                           
#>  [7] "disorderly conduct"                        
#>  [8] "drug offense"                              
#>  [9] "drug violation"                            
#> [10] "embezzlement"                              
#> [11] "family offense"                            
#> [12] "fire report"                               
#> [13] "forgery and counterfeiting"                
#> [14] "fraud"                                     
#> [15] "gambling"                                  
#> [16] "homicide"                                  
#> [17] "human trafficking (a), commercial sex acts"
#> [18] "human trafficking, commercial sex acts"    
#> [19] "juvenile offenses"                         
#> [20] "larceny theft"                             
#> [21] "liquor laws"                               
#> [22] "lost property"                             
#> [23] "malicious mischief"                        
#> [24] "miscellaneous investigation"               
#> [25] "missing person"                            
#> [26] "motor vehicle theft"                       
#> [27] "motor vehicle theft?"                      
#> [28] "non-criminal"                              
#> [29] "offences against the family and children"  
#> [30] "other"                                     
#> [31] "other miscellaneous"                       
#> [32] "other offenses"                            
#> [33] "prostitution"                              
#> [34] "rape"                                      
#> [35] "recovered vehicle"                         
#> [36] "robbery"                                   
#> [37] "sex offense"                               
#> [38] "stolen property"                           
#> [39] "suicide"                                   
#> [40] "suspicious"                                
#> [41] "suspicious occ"                            
#> [42] "traffic collision"                         
#> [43] "traffic violation arrest"                  
#> [44] "vandalism"                                 
#> [45] "vehicle impounded"                         
#> [46] "vehicle misplaced"                         
#> [47] "warrant"                                   
#> [48] "weapons carrying etc"                      
#> [49] "weapons offence"                           
#> [50] "weapons offense"
```


