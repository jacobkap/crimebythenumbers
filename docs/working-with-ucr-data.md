
# (PART) Data {-}

# Uniform Crime Report (UCR) Data

The Uniform Crime Reports (UCR) is an annual collection of agency-level crime data published by the FBI. Nearly every police agency in the United States - approximately 18,000 agencies including state, local (city, county, college), tribal and federal police departments - now reports their data to the FBI which compiles are releases the UCR data. This data is available since 1960 though early years have many fewer agencies reporting than do so in later years. 

The data file has annual data on the number of crimes reported, the number of crimes cleared, the number cleared where all offenders are under age 18, and the number of unfounded crimes. We'll discuss each of this a bit further as we dive into the data. Thus, the data isn't "incident-level" data - in contrast to the Chicago data that we've worked with. The data instead includes crime counts for each agency. You can read more about the UCR program and all the data sets it includes on the National Archive of Criminal Justice Data page [here](https://www.icpsr.umich.edu/icpsrweb/content/NACJD/guides/ucr.html).

Due to it's longevity (it has data since 1960) and ubiquity (almost every agency reports and has done so for decades) it is a popular data set for criminologists. 

## Exploring the UCR data

We are going to work with the combined annual count of crimes for every year available, 1960-2017. The FBI releases the data as a single file per year and each file has monthly counts of crime. This data set does some cleaning for us by aggregating yearly and making it a single file for the whole time period. The first step when working with this UCR data is loading it into R. As with loading any data, make sure that your path is correctly set using `setwd()` so R knows which folder the data is in. 


```r

load("data/offenses_known_yearly_1960_2017.rda")
```

Let's start with a basic examination of the data. First, how big it is, what variables it has, and what the units are. 

To see how big a data set is, use `ncol()` to see the number of columns and `nrow()` to see the number of rows. The `names()` function tells us every column name. For all of these functions we need to put the data set name inside the ().


```r
ncol(offenses_known_yearly_1960_2017)
#> [1] 159
```


```r
nrow(offenses_known_yearly_1960_2017)
#> [1] 959010
```


```r
names(offenses_known_yearly_1960_2017)
#>   [1] "ori"                            "ori9"                          
#>   [3] "agency_name"                    "state"                         
#>   [5] "state_abb"                      "year"                          
#>   [7] "number_of_months_reported"      "fips_state_code"               
#>   [9] "fips_county_code"               "fips_state_county_code"        
#>  [11] "fips_place_code"                "fips_state_place_code"         
#>  [13] "agency_type"                    "agency_subtype_1"              
#>  [15] "agency_subtype_2"               "crosswalk_agency_name"         
#>  [17] "census_name"                    "population"                    
#>  [19] "population_group"               "country_division"              
#>  [21] "juvenile_age"                   "core_city_indication"          
#>  [23] "last_update"                    "fbi_field_office"              
#>  [25] "followup_indication"            "zip_code"                      
#>  [27] "covered_by_ori"                 "agency_count"                  
#>  [29] "date_of_last_update"            "month_included_in"             
#>  [31] "special_mailing_group"          "special_mailing_address"       
#>  [33] "first_line_of_mailing_address"  "second_line_of_mailing_address"
#>  [35] "third_line_of_mailing_address"  "fourth_line_of_mailing_address"
#>  [37] "officers_killed_by_felony"      "officers_killed_by_accident"   
#>  [39] "officers_assaulted"             "actual_murder"                 
#>  [41] "actual_manslaughter"            "actual_rape_total"             
#>  [43] "actual_rape_by_force"           "actual_rape_attempted"         
#>  [45] "actual_robbery_total"           "actual_robbery_with_a_gun"     
#>  [47] "actual_robbery_with_a_knife"    "actual_robbery_other_weapon"   
#>  [49] "actual_robbery_unarmed"         "actual_assault_total"          
#>  [51] "actual_assault_with_a_gun"      "actual_assault_with_a_knife"   
#>  [53] "actual_assault_other_weapon"    "actual_assault_unarmed"        
#>  [55] "actual_assault_simple"          "actual_burg_total"             
#>  [57] "actual_burg_force_entry"        "actual_burg_nonforce_entry"    
#>  [59] "actual_burg_attempted"          "actual_theft_total"            
#>  [61] "actual_mtr_veh_theft_total"     "actual_mtr_veh_theft_car"      
#>  [63] "actual_mtr_veh_theft_truck"     "actual_mtr_veh_theft_other"    
#>  [65] "actual_all_crimes"              "actual_assault_aggravated"     
#>  [67] "actual_index_violent"           "actual_index_property"         
#>  [69] "actual_index_total"             "tot_clr_murder"                
#>  [71] "tot_clr_manslaughter"           "tot_clr_rape_total"            
#>  [73] "tot_clr_rape_by_force"          "tot_clr_rape_attempted"        
#>  [75] "tot_clr_robbery_total"          "tot_clr_robbery_with_a_gun"    
#>  [77] "tot_clr_robbery_with_a_knife"   "tot_clr_robbery_other_weapon"  
#>  [79] "tot_clr_robbery_unarmed"        "tot_clr_assault_total"         
#>  [81] "tot_clr_assault_with_a_gun"     "tot_clr_assault_with_a_knife"  
#>  [83] "tot_clr_assault_other_weapon"   "tot_clr_assault_unarmed"       
#>  [85] "tot_clr_assault_simple"         "tot_clr_burg_total"            
#>  [87] "tot_clr_burg_force_entry"       "tot_clr_burg_nonforce_entry"   
#>  [89] "tot_clr_burg_attempted"         "tot_clr_theft_total"           
#>  [91] "tot_clr_mtr_veh_theft_total"    "tot_clr_mtr_veh_theft_car"     
#>  [93] "tot_clr_mtr_veh_theft_truck"    "tot_clr_mtr_veh_theft_other"   
#>  [95] "tot_clr_all_crimes"             "tot_clr_assault_aggravated"    
#>  [97] "tot_clr_index_violent"          "tot_clr_index_property"        
#>  [99] "tot_clr_index_total"            "clr_18_murder"                 
#> [101] "clr_18_manslaughter"            "clr_18_rape_total"             
#> [103] "clr_18_rape_by_force"           "clr_18_rape_attempted"         
#> [105] "clr_18_robbery_total"           "clr_18_robbery_with_a_gun"     
#> [107] "clr_18_robbery_with_a_knife"    "clr_18_robbery_other_weapon"   
#> [109] "clr_18_robbery_unarmed"         "clr_18_assault_total"          
#> [111] "clr_18_assault_with_a_gun"      "clr_18_assault_with_a_knife"   
#> [113] "clr_18_assault_other_weapon"    "clr_18_assault_unarmed"        
#> [115] "clr_18_assault_simple"          "clr_18_burg_total"             
#> [117] "clr_18_burg_force_entry"        "clr_18_burg_nonforce_entry"    
#> [119] "clr_18_burg_attempted"          "clr_18_theft_total"            
#> [121] "clr_18_mtr_veh_theft_total"     "clr_18_mtr_veh_theft_car"      
#> [123] "clr_18_mtr_veh_theft_truck"     "clr_18_mtr_veh_theft_other"    
#> [125] "clr_18_all_crimes"              "clr_18_assault_aggravated"     
#> [127] "clr_18_index_violent"           "clr_18_index_property"         
#> [129] "clr_18_index_total"             "unfound_murder"                
#> [131] "unfound_manslaughter"           "unfound_rape_total"            
#> [133] "unfound_rape_by_force"          "unfound_rape_attempted"        
#> [135] "unfound_robbery_total"          "unfound_robbery_with_a_gun"    
#> [137] "unfound_robbery_with_a_knife"   "unfound_robbery_other_weapon"  
#> [139] "unfound_robbery_unarmed"        "unfound_assault_total"         
#> [141] "unfound_assault_with_a_gun"     "unfound_assault_with_a_knife"  
#> [143] "unfound_assault_other_weapon"   "unfound_assault_unarmed"       
#> [145] "unfound_assault_simple"         "unfound_burg_total"            
#> [147] "unfound_burg_force_entry"       "unfound_burg_nonforce_entry"   
#> [149] "unfound_burg_attempted"         "unfound_theft_total"           
#> [151] "unfound_mtr_veh_theft_total"    "unfound_mtr_veh_theft_car"     
#> [153] "unfound_mtr_veh_theft_truck"    "unfound_mtr_veh_theft_other"   
#> [155] "unfound_all_crimes"             "unfound_assault_aggravated"    
#> [157] "unfound_index_violent"          "unfound_index_property"        
#> [159] "unfound_index_total"
```

We can see this is a very big file - 159 columns and nearly a million rows! Normally we'd use the `head()` function to see the first 6 rows of every column but since this data has so many columns we won't do that as it'd be hard to read. 

Using `View()` opens up what is essentially an Excel file showing the data. This is a convenient way to quickly get a sense of what is available, what variables mean, and what units the data is in. This method has some limitations though as it encourages us to make decisions based on the first several rows of data, which may be a mistake if there is some bias further on - such as older data being worse quality and having more missing values. But, for a first glance it is useful and will be supplemented by better checks below.


```r
View(offenses_known_yearly_1960_2017)
```

From looking at the data in `View()` we can see that the units are agency-years. Each row is a single agency for a single year. This is useful because it tells us we will have crime in agencies over time, which is a very common type of crime data - and one often used in Master's theses. Let's take a look at how many agencies report each year using the `table()` function which says how many times each value occurs for the column we select. This is also a useful check on if every year 1960-2017 is actually available - don't just trust that the data has what it says it has!


```r
table(offenses_known_yearly_1960_2017$year)
#> 
#>  1960  1961  1962  1963  1964  1965  1966  1967  1968  1969  1970  1971 
#>  8452  8456  7825  8713  9038  9097  9147  9275  9398  9477  9835 10509 
#>  1972  1973  1974  1975  1976  1977  1978  1979  1980  1981  1982  1983 
#> 11302 12002 12510 13516 14518 15230 15770 16176 16413 16614 16792 16913 
#>  1984  1985  1986  1987  1988  1989  1990  1991  1992  1993  1994  1995 
#> 17037 17267 17441 17527 17298 17430 17608 17852 18012 18195 18367 18482 
#>  1996  1997  1998  1999  2000  2001  2002  2003  2004  2005  2006  2007 
#> 18536 18921 18510 18778 19655 19820 20214 20388 20585 20739 21011 21219 
#>  2008  2009  2010  2011  2012  2013  2014  2015  2016  2017 
#> 21353 21583 21771 21897 22049 22202 22332 22524 22645 22784
```

From these results it's clear that there are huge differences in how many agencies report in early years compared to more recent years. Is this an issue in an analysis? From the above table it is concerning but not entirely clear there is an issue depending on our analysis. It we only care about recent years then it wouldn't matter. If we only use large agencies, then knowing that relatively few agencies reported in 1960 doesn't mean that few large agencies reported. For that you'd have to look closer at only the agencies you want to study - we won't do that here but keep it in mind. 

## Finding things in our data

For an easy way to find the ORI number of an agency, use this [site](http://crimedatatool.com/crosswalk.html).

Lets look at some summary statistics of a few columns - we don't want to run `summary()` on the whole data as it has too many columns. 


```r
summary(offenses_known_yearly_1960_2017$actual_murder)
#>      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
#>   -2.0000    0.0000    0.0000    0.9958    0.0000 2245.0000
```


```r
summary(offenses_known_yearly_1960_2017$actual_rape_total)
#>     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
#>   -3.000    0.000    0.000    4.311    1.000 4054.000
```


```r
summary(offenses_known_yearly_1960_2017$actual_robbery_with_a_gun)
#>     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
#>    -2.00     0.00     0.00     9.68     1.00 69618.00
```


## Manipulating our data



### Exercises

1. How many motor vehicle thefts were reported to the police?
2. How many rapes were reported to the police?
3. Which city had the most murders?
    + How many murders?
    + In which year?
    + For that city, what was the mean number of murders for all years included?
4. Add a new column to your data set for the burglary rate for each agency. 
    + Which agency has the highest burglary rate?
 

