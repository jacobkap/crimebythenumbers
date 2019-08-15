
# National Incident-Based Reporting System (NIBRS) Data {#nibrs}

https://www.icpsr.umich.edu/icpsrweb/ICPSR/studies/25109

Through our work with the UCR, we've already discussed reported crime. Nonetheless, not all crimes are reported to the police. Also, sometimes the UCR doesn't provide us with specific information about a victim-involved crime incident such as whether the victim knew the offenders or the location of the crime incident.

Each year, the U.S. Census Bureau conducts the National Crime Victimization Survey (NCVS), which is a valuable source of self-reported victimization data. The Census Bureau interviews a sample of people about the number and characteristics of crime victimizations they experienced during the prior 6 months. In 2015, for example, they collected data from 95,760 households and 163,880 persons.

The NCVS contains valuable information about nonfatal personal crimes such as rape or robbery as well as property crimes such as burglary. Additional information about the NCVS can be found at the [BJS website](https://www.bjs.gov/index.cfm?ty=dcdetail&iid=245). To give a sense of the type of data that the NCVS contains, refer to the [Official 2012-2013 BJS Crime Victimization report](http://www.bjs.gov/content/pub/pdf/cv12.pdf).

## Downloading the data

First, we will download the [NCVS 2016] data()https://www.icpsr.umich.edu/icpsrweb/NACJD/studies/36828/datadocumentation. We want the following file: DS4 Incident Record-Type File. Click the download button to the right and select "ASCII + SPSS Setup". *Don't select R.* While NACJD does provide the data as an R file, this file has some issues where the column names are not easy to understand (e.g. Often they are just the letter V followed by a number such as V1, V2, V3). Using the ASCII+SPSS file lets us easily read in the data with usable column names. 

That'll download a zipped folder. Inside the folder is another folder called ICPSR_36828. Inside that is a folder called DS0004 (named 4 as it is the 4th file available to download on that page), and inside that are the two files we want: "36828-0004-Data.txt" and "36828-0004-Setup". Take *both* of these files and move them into your working directory. NACJD data will come with a numeric name which is just the unique identifier of that data. So I prefer to change the name to something that is easy to understand what the file holds. In this case I renamed the files to "ncvs_incident_2016.txt" and "ncvs_incident_2016.sps".

## Reading the data

(The FBI still sends out their data in this format!) To read in these files we will use the package `asciiSetupReader` which has been built for this exact purpose. 


```r
install.packages("asciiSetupReader")
```


```r
library(asciiSetupReader)
```

Unlike when reading in .rda files, with this package we read in the file to an object which we name ourselves. We will call it ncvs for ease. The relevant function is `read_ascii_setup()` which has two mandatory parameters `data` and `setup_file`. `data` is the name (in quotes) of the text (.txt) file which holds the data. `setup_file` is similar but now is the name of the setup (.sps) file, again in quotes. 
`

As a standard first step let's check the number of rows and columns in the data.


This data has 952 columns which is too many for us to run `names()` or `head()`. That many variables means that most of the columns are not relevant for our purposes here. What we want to do is make a smaller data set with only the relevant columns. That way we have data that can be easily checked with `head()` or `View()`. When dealing with enormous data sets (such as NIBRS data we'll look at soon that can have millions of rows), having smaller files makes the code run quicker and in some cases allows it to run at all (too big of a file can cause R to run extremely slowly or crash). 

Normally we would subset this data to keep only the columns we want to use. However, as we used the `asciiSetupReader` package, there is a better solution. The `read_ascii_setup()` function has a parameter `select_columns` that allows us to select the columns we want and it will only read in those columns. This is useful as it means we can start with a subsetted file which avoids any issues of reading in enormous files.

For `select_columns` we need to have a vector `c()` of either numbers or the column names (in quotes) that we want to keep. For this, open up the file "ncvs_incident_2016.sps" (this is not an R file so you can just double-click it to open on your computer's default software for this type of file, usually Microsoft Word or Wordpad). Scroll down to the selection labeled "VARIABLE LABELS" and it will show a list of variable names on the left and "cleaned" versions of their names on the right. (You can also choose columns by using the codebook included in the folder downloaded from NACJD. The codebook is helpful because it explains what each variable means and you should definitely read the codebook before working with new data. However, as NCVS data has several different files included (Address-level, Household-level, Person-level, and Incident-level), the codebook covers all of these. The file "ncvs_incident_2016.sps" includes only the incident-level data columns we are using so it is a little easier to work with in this case.)


![](images/nibrs_1.PNG)

![](images/nibrs_2.PNG)

![](images/nibrs_3.PNG)

![](images/nibrs_4.PNG)

![](images/nibrs_5.PNG)

![](images/nibrs_6.PNG)
