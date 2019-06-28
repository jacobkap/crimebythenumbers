*-------------------------------------------------------------------------*
*                                                                          
*                     SPSS SETUP FILE FOR ICPSR 37065
*              UNIFORM CRIME REPORTING PROGRAM DATA: NATIONAL
*          INCIDENT-BASED REPORTING SYSTEM, [UNITED STATES], 2016
*              (DATASET 0008: GROUP B ARREST REPORT SEGMENT)
* 
*
*  SPSS setup sections are provided for the ASCII version of this data
*  collection.  These sections are listed below:
*
*  DATA LIST:  assigns the name, type, decimal specification (if any),
*  and specifies the beginning and ending column locations for each
*  variable in the data file. Users must replace the "data-filename"
*  in the DATA LIST statement with a filename specifying the directory
*  on the user's computer system in which the downloaded and unzipped
*  data file is physically located (e.g., "c:\temp\37065-0008-data.txt").
*
*  VARIABLE LABELS:  assigns descriptive labels to all variables.
*  Labels and variable names may be identical for some data files.
*
*  MISSING VALUES: declares user-defined missing values. Not all
*  variables in this data set necessarily have user-defined missing
*  values. These values can be treated specially in data transformations,
*  statistical calculations, and case selection.
*
*  VALUE LABELS: assigns descriptive labels to codes found in the data
*  file.  Not all codes necessarily have assigned value labels.
*
*  VARIABLE LEVEL: assigns measurement level to each variable (scale,
*  nominal, or ordinal).
*
*  NOTE:  Users should modify this setup file to suit their specific
*  needs. The MISSING VALUES section has been commented out (i.e., '*').
*  To include the MISSING VALUES section in the final SPSS setup, remove
*  the comment indicators from the desired section.
*
*  CREATING A PERMANENT SPSS DATA FILE: If users wish to create and save
*  an SPSS data file for further analysis using SPSS for Windows, the
*  necessary "SAVE OUTFILE" command is provided in the last line of
*  this file.  To activate the command, users must delete the leading
*  asterisk (*) and replace "spss-filename" with a filename specifying
*  the location on the user's computer system to which the new data file
*  will be saved (e.g., SAVE OUTFILE="c:\spsswin\data\da37065-0008.sav").
*
*-------------------------------------------------------------------------.

* SPSS FILE HANDLE AND DATA LIST COMMANDS.

FILE HANDLE DATA / NAME="data-filename" LRECL=59.
DATA LIST FILE=DATA /
           V7001 1-2 (A)               V7002 3-4
          V7003 5-13 (A)         V7004 14-25 (A)             V7005 26-33
             V7006 34-35         V7007 36-39 (A)            V7008 40 (A)
         V7009 41-43 (A)         V7010 44-46 (A)         V7011 47-49 (A)
             V7012 50-51            V7013 52 (A)            V7014 53 (A)
            V7015 54 (A)            V7016 55 (A)            V7017 56 (A)
             V7018 57-59
   .

* SPSS VARIABLE LABELS COMMAND

VARIABLE LABELS
   V7001     'SEGMENT LEVEL' /
   V7002     'NUMERIC STATE CODE' /
   V7003     'ORIGINATING AGENCY IDENTIFIER' /
   V7004     'INCIDENT NUMBER' /
   V7005     'INCIDENT DATE' /
   V7006     'ARRESTEE SEQUENCE NUMBER' /
   V7007     'CITY SUBMISSION' /
   V7008     'TYPE OF ARREST' /
   V7009     'UCR GROUP B ARREST OFFENSE' /
   V7010     'WEAPON 1' /
   V7011     'WEAPON 2' /
   V7012     'AGE (OF ARRESTEE)' /
   V7013     'SEX (OF ARRESTEE)' /
   V7014     'RACE (OF ARRESTEE)' /
   V7015     'ETHNICITY (OF ARRESTEE)' /
   V7016     'RESIDENT STATUS (OF ARRESTEE)' /
   V7017     'DISPOSITION OF ARRESTEE UNDER 18' /
   V7018     'N 07 RECORDS PER ORI-INCIDENT NUMBER' /
   .


* SPSS VALUE LABELS COMMAND.

VALUE LABELS
   V7001     '07' 'Group B Arrest Report Segment Level' /
   V7002     1 'AL' 2 'AZ' 3 'AR' 4 'CA' 5 'CO' 6 'CT' 7 'DE' 8 'DC' 9 'FL'
             10 'GA' 11 'ID' 12 'IL' 13 'IN' 14 'IA' 15 'KS' 16 'KY' 17 'LA'
             18 'ME' 20 'MA' 21 'MI' 22 'MN' 23 'MS' 24 'MO' 25 'MT' 26 'NB'
             27 'NV' 28 'NH' 29 'NJ' 30 'NM' 31 'NY' 32 'NC' 33 'ND' 34 'OH'
             35 'OK' 36 'OR' 37 'PA' 38 'RI' 39 'SC' 40 'SD' 41 'TN' 42 'TX'
             43 'UT' 44 'VT' 45 'VA' 46 'WA' 47 'WV' 48 'WI' 49 'WY' 50 'AK'
             51 'HI' 52 'CZ' 53 'PR' 54 'AS' 55 'GM' 62 'VI' /
   V7008
 'O' 'On-view arrest (taken into custody without a warrant or previous incident report)'
             'S' 'Summoned/cited (not taken into custody)'
  'T' 'Taken into custody (based on warrant and/or previous incident report)'
             /
   V7009     '90A' 'Bad checks' '90B' 'Curfew/loitering/vagrancy violations'
             '90C' 'Disorderly conduct' '90D' 'Driving under the influence'
             '90E' 'Drunkenness' '90F' 'Family offenses, nonviolent'
             '90G' 'Liquor law violations' '90H' 'Peeping tom'
             '90I' 'Runaway' '90J' 'Trespass of real property'
             '90Z' 'All other offenses' /
   V7010     '01' 'Unarmed' '11' 'Firearm (type not stated)' '12' 'Handgun'
             '13' 'Rifle' '14' 'Shotgun' '15' 'Other firearm'
             '16' 'Lethal cutting instrument (e.g., switchblade knife, etc.)'
             '17' 'Club/blackjack/Brass Knuckles'
             '11A' 'Firearm (type not stated), automatic'
             '12A' 'Handgun, automatic' '13A' 'Rifle, automatic'
             '14A' 'Shotgun, automatic' '15A' 'Other firearm, automatic' /
   V7011     '01' 'Unarmed' '11' 'Firearm (type not stated)' '12' 'Handgun'
             '13' 'Rifle' '14' 'Shotgun' '15' 'Other firearm'
             '16' 'Lethal cutting instrument'
             '17' 'Club/blackjack/Brass Knuckles'
             '11A' 'Firearm (type not stated), automatic'
             '12A' 'Handgun, automatic' '13A' 'Rifle, automatic'
             '14A' 'Shotgun, automatic' '15A' 'Other firearm, automatic' /
   V7012     0 'Unknown' 99 'Over 98 years old' /
   V7013     'F' 'Female' 'M' 'Male' /
   V7014     'A' 'Asian' 'B' 'Black or African American'
             'I' 'American Indian/Alaska Native'
             'P' 'Native Hawaiian or other Pacific Islander' 'U' 'Unknown'
             'W' 'White' /
   V7015     'H' 'Hispanic or Latino origin'
             'N' 'Not Hispanic or Latino origin' 'U' 'Unknown' /
   V7016     'N' 'Nonresident' 'R' 'Resident' 'U' 'Unknown' /
   V7017
 'H' 'Handled within department (e.g., released to parents, released with warning, etc.)'
 'R' 'Referred to Other Authorities (e.g., turned over to juvenile court, probation department - see codebook)'
             /
   .

EXECUTE.

* SPSS VARIABLE LEVEL COMMAND.

VARIABLE LEVEL
   V7005
   V7006
   V7012
   V7018
    (scale).

VARIABLE LEVEL
   V7001
   V7002
   V7003
   V7004
   V7007
   V7008
   V7009
   V7010
   V7011
   V7013
   V7014
   V7015
   V7016
   V7017
    (nominal).

* SPSS FORMAT COMMAND.

FORMAT
    V7001 (A2) /
    V7002 (F2.0) /
    V7003 (A9) /
    V7004 (A12) /
    V7005 (F8.0) /
    V7006 (F2.0) /
    V7007 (A4) /
    V7008 (A1) /
    V7009 (A3) /
    V7010 (A3) /
    V7011 (A3) /
    V7012 (F2.0) /
    V7013 (A1) /
    V7014 (A1) /
    V7015 (A1) /
    V7016 (A1) /
    V7017 (A1) /
    V7018 (F3.0) /

* Create SPSS system file.

*SAVE OUTFILE="spss-filename.sav".
