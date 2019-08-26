
# Uniform Crime Report (UCR) - Offenses Known and Clearances by Arrest {#ucr}

The Uniform Crime Report (UCR) are an collection of agency-level crime data published by the FBI. There are a number of different data sets included in the UCR including data on crime, arrests, hate crimes, arson, and stolen property. We'll be using the Offenses Known and Clearances by Arrest data set (the "crime" data set), which is the most commonly used data set in the UCR and is sometimes used as a shorthand for UCR data. In this lesson we'll use "UCR" and "Offenses Known and Clearances by Arrest" interchangeably but keep in mind that doing so is technically incorrect. 

You can read more about the UCR program and all of the data sets it includes on the National Archive of Criminal Justice Data page [here](https://www.icpsr.umich.edu/icpsrweb/content/NACJD/guides/ucr.html). You can also check out my site [Crime Data Tool](http://crimedatatool.com) which visualizes several of the UCR data sets and has info in the [FAQ page](http://crimedatatool.com/faq.html)explaining the data.

Nearly every police agency in the United States - approximately 18,000 agencies including state, local (city, county, college), tribal, and federal police departments - now report their data to the FBI which compiles and releases the UCR data (some states have their agencies report to a state department which then sends the data to the FBI). This data is available since 1960 though early years have many fewer agencies reporting than do so in later years. 

The data file has annual data on the number of crimes reported, the number of crimes cleared, the number cleared where all offenders are under age 18, and the number of unfounded crimes. We'll discuss each of these a bit further as we dive into the data. Agencies report the monthly number of each crime though the data we'll work with has aggregated that to annual counts. 

Due to it's longevity (it has data since 1960) and ubiquity (almost every agency reports and has done so for many years) it is a popular data set for criminologists. 

## Exploring the UCR data

We are going to look at data with the combined annual count of crimes for every year available - 1960-2017 - which I've made available [here](http://doi.org/10.3886/E100707V11). The FBI releases the data as a single file per year and each file has monthly counts of crime. This data set does some cleaning for us by aggregating yearly and making it a single file for the whole time period. The first step when working with this UCR data is loading it into R. As with loading any data, make sure that your working directory path is correctly set using `setwd()` so R knows which folder the data is in. 


```r
load("data/offenses_known_yearly_1960_2017.rda")
```

Let's start with a basic examination of the data. First, how big it is, what variables it has, and what the units are. 


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

We can see this is a very big file - 159 columns and nearly a million rows! Normally we'd use the `head()` function to see the first 6 rows of every column but since this data has so many columns we won't do that as it'd be hard to read. Instead we can use `View()` to open what's essentially an Excel file showing our data. This is useful to quickly glance at the data but is limited as it can bias us to believe that the first several rows are representative of the data (an issue also present with `head()`). But, for a first glance it is useful and will be supplemented by better checks below.


```r
View(offenses_known_yearly_1960_2017)
```

From looking at the data in `View()` we can see that the units are agency-years. Each row is a single agency for a single year. This is useful because it tells us we will have crime in agencies over time, which is a very common type of crime data. Let's take a look at how many agencies report each year using the `table()` function which says how many times each value occurs for the column we select. This is also a useful check on if every year from 1960 to 2017 is actually available - don't just trust that the data has what it says it has!


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

From these results it's clear that there are huge differences in how many agencies report in early years compared to more recent years. Is this an issue in an analysis? From the above table it is concerning but not entirely clear there is an issue depending on our specific analysis. It we only care about recent years then it wouldn't matter. If we only use large agencies, then knowing that relatively few agencies reported in 1960 doesn't mean that few large agencies reported. For that you'd have to look closer at only the agencies you want to study - we won't do that here but keep it in mind. 

## ORIs - Unique agency identifiers

In the UCR and other FBI data sets, agencies are identified using **OR**iginating Agency **I**dentifiers or ORIs. These are unique ID codes used to identify an agency. If we used the agency's normal name we'd end up with some duplicates For example, if you looked for the Philadelphia Police Department using the agency name, you'd find both the "Philadelphia Police Department" in Pennsylvania and the one in Mississippi. 


```r
head(offenses_known_yearly_1960_2017$ori)
#> [1] "AK00101" "AK00101" "AK00101" "AK00101" "AK00101" "AK00101"
```

Each ORI is a 7-digit value starting with the state abbreviation (for some reason the FBI incorrectly puts the abbreviation for Nebraska as NB instead of NE) followed by 5 numbers. In the NIBRS data (another FBI data set which we'll explore in Chapter \@ref(nibrs)) the ORI uses a 9-digit code - expanding the 5 numbers to 7 numbers. When dealing with specific agencies, make sure to use the ORI rather than the agency name to avoid any mistakes. 

For an easy way to find the ORI number of an agency, use this [site](http://crimedatatool.com/crosswalk.html). Type an agency name or an ORI code into the search section and it will return everything that is a match.

## Hierarchy Rule

The UCR has what is called the Hierarchy Rule where only the most serious crime in an incident is reported (except for motor vehicle theft which is always included). For example if there is an incident where the victim is robbed and then murdered, only the murder is counted as it is considered more serious than the robbery.  

How much does this affect our data in practice? Actually very little. Though the Hierarchy Rule does mean this data is an under-count, data from other sources indicate that it isn't much of an under count. The FBI's other data set, the National Inicident-Based Reporting System (NIBRS) contains every crime that occurs in an incident (i.e. it doesn't use the Hierarchy Rule). Using this we can measure how many crimes the Hierarchy Rule excludes (Most major cities do not report to NIBRS so what we find in NIBRS may not apply to them). In over 90% of incidents, only one crime is committed. Additionally, when people talk about "crime" they usually mean murder which, while incomplete to discuss crime, means the UCR data here is accurate on that measure.

## Which crimes are included

If you look back at the output when we ran `names(offenses_known_yearly_1960_2017)` you'll see that it produced five broad categories of columns. The first was information about the agency including population and geographic info, then came four columns with the same values except starting with "actual", "tot_clr", "clr_18", and "unfound". Following these starting values was 30 crime categories. We'll discuss what each of those starting values mean in a bit, let's first talk about which crimes are included and what that means for research. 

### Index Crimes

The Offenses Known and Clearances by Arrest data set contains information on the number of "Index Crimes" (sometimes called Part I crimes) reported to each agency. These index crimes are a collection of eight crimes that, for historical reasons based largely by perceived importance in the 1920's when the UCR program was first developed, are used as the primary measure of crime today. Other data sets in the UCR, such as the Arrests by Age, Sex, and Race data and the Hate Crime data have more crimes reported. 

The crimes are, in order by the Hierarchy Rule - 

1. Homicide     
    + Murder and non-negligent manslaughter   
    + Manslaughter by negligence   
2. Rape     
    + Rape     
    + Attempted rape     
3. Robbery     
    + With a firearm     
    + With a knife of cutting instrument     
    + With a dangerous weapon not otherwise specified     
    + Unarmed - using hands, fists, feet, etc.     
4. Aggravated Assault (assault with a weapon or causing serious bodily injury)     
    + With a firearm     
    + With a knife of cutting instrument     
    + With a dangerous weapon not otherwise specified     
    + Unarmed - using hands, fists, feet, etc.     
5. Burglary     
    + With forcible entry     
    + Without forcible entry      
    + Attempted burglary with forcible entry     
6. Theft (other than of a motor vehicle)     
7. Motor Vehicle Theft     
    + Cars     
    + Trucks and buses     
    + Other vehicles          
8. Arson     
9. Simple Assault     

For a full definition of each of the index crimes see the FBI's Offense Definitions page [here](https://ucrdatatool.gov/offenses.cfm).

Arson is considered an index crime but is not reported in this data - you need to use the separate Arson data set of the UCR to get access to arson counts. The ninth crime on that list, simple assault, is not considered an index crime but is nevertheless included in this data. 

Each of the crimes in the list above, and their subcategories, are included in the UCR data. In most reports, however, you'll see them reported as the total number of index crimes, summing up categories 1-7 and reporting that as "crime". These index crimes are often divided into violent index crimes - murder, rape, robbery, and aggravated assault - and property index crimes - burglary, theft, motor vehicle theft. 

### The problem with using index crimes 

The biggest problem with index crimes is that it is simply the sum of 8 (or 7 since arson data usually isn't available) crimes. Index crimes have a huge range in their seriousness - it includes both murder and theft.This is clearly wrong as 100 murders is more serious than 100 thefts. This is especially a problem as less serious crimes (theft mostly) are far more common than more serious crimes (in 2017 there were 1.25 million violent index crimes in the United States. That same year had 5.5 million thefts.). So index crimes under-count the seriousness of crimes. Looking at total index crimes is, in effect, mostly just looking at theft.

This is especially a problem because it hide trends in violent crimes. San Francisco, as an example, has had a huge increase in index crimes in the last several years. When looking closer, that increase is driven almost entirely by the near doubling of theft since 2011. During the same years, violent crime has stayed fairly steady. So the city isn't getting more dangerous but it appears like it is due to just looking at total index crimes.

Many researchers divide index crimes into violent and nonviolent categories, which helps but is still not entirely sufficient. Take Chicago as an example. It is a city infamous for its large number of murders. But as a fraction of index crimes, Chicago has a rounding error worth of murders. Their 653 murders in 2017 is only 0.5% of total index crimes. For violent index crimes, murder makes up 2.2%. What this means is that changes in murder are very difficult to detect. If Chicago had no murders this year, but a less serious crime (such as theft) increased slightly, we couldn't tell from looking at the number of index crimes.

### Rape definition change

Starting in 2013, rape has a new, broader definition in the UCR to include oral and anal penetration (by a body part or object) and allow men to be victims. The previous definition included only forcible intercourse against a woman. As this revised definition is broader than the original one post-2013 rape data is not comparable to pre-2013 data. 

## Actual offenses, clearances, and unfounded offenses

For each crime we have four different categories indicating the number of crimes actually committed, the number cleared, and the number determined to not have occurred. 

### Actual

This is the number of offenses that occurred, simply a count of the number of crimes that month. For example if 10 people are murdered in a city the number of "actual murders" would be 10. 

### Total Cleared

A crime is cleared when an offender is arrested or when the case is considered cleared by exceptional means. When a single offender for a crime is arrested, that crime is considered cleared. If multiple people committed a crime, only a single person must be arrested for it to be cleared, and as the UCR data is at the offense level, making multiple arrests for an incident only counts as one incident cleared. So if 10 people committed a murder and all 10 were arrested, it would report one murder cleared not 10. If only one of these people are arrested it would still report one murder cleared - the UCR does not even say how many people commit a crime.

A crime is considered exceptionally cleared if the police can identify the offender, have enough evidence to arrest the offender, know where the offender is, but is unable to arrest them. Some examples of this are the death of the offender or when the victim refuses to cooperate in the case. 

Unfortunately this data does not differentiate between clearances by arrest or by exceptional means. For a comprehensive report on how this variable can be exploited to exaggerate clearance rates, see [this report by ProPublica](https://www.propublica.org/article/when-it-comes-to-rape-just-because-a-case-is-cleared-does-not-mean-solved) on exceptional clearances with rape cases. 

### Cleared Where All Offenders Are Under 18

This variable is very similar to Total Cleared except is only for offenses in which **every** offender is younger than age 18. 

### Unfounded

An unfounded crime is one in which a police investigation has determined that the reported crime did not actually happen. For example if the police are called to a possible burglary but later find out that a burglary did not occur they would put it down as 1 unfounded burglary. This is based on police investigation rather than the decision of any other party such as a coroner, judge, jury, or prosecutor.

## Number of months reported

UCR data is reported monthly though even agencies that decide to report their data may not do so every month. As we don't want to compare an agency which reports 12 months to one that reports fewer, the variable *number_of_months_reported* is way keep only agencies that report 12 months, or deal with those that report fewer. 


```r
table(offenses_known_yearly_1960_2017$number_of_months_reported)
#> 
#>      0      1      2      3      4      5      6      7      8      9 
#> 229843   2514   2522   2926   2633   2875   3876   3350   4013   4693 
#>     10     11     12 
#>   6416  14940 678409
```

From our `table()` output it seems that when agencies do report, they do so for all 12 months of the year. However, this variable is seriously flawed, and its name is quite misleading. In reality this variable is actually just whichever the last month reported was. If an agency reported every month of the year, meaning December is the last month, they would have a value of 12. If the agency **only** reported in December, they would also have a value of 12. While there are ways in the monthly data to measure actual number of months reported, these ways are also flawed. So be cautious about this data and particularly the value of this variable. 
