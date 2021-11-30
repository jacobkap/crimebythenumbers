library(dplyr)      # Used to aggregate data
library(ggplot2)    # Used to make the graph
library(crimeutils) # Used to capitalize words in a column
library(tidyr)      # Used to reshape the data

# Load in the data
shr <- readRDS("data/shr_1976_2020.rds") 

# See which agencies reported in 2019 and 2020
# An "ori" is a unique identified for agencies in FBI data
agencies_2019 <- shr$ori[shr$year == 2019]
agencies_2020 <- shr$ori[shr$year == 2020]
# Get which agencies reported in both years so we have an apples-to-apples comparison
agencies_in_both <- agencies_2019[agencies_2019 %in% agencies_2020]

# Keep just data from 2019 and 2020 and where the agencies is one of the
# agencies chosen above. Also keep only murder and nonnegligent manslaughter (so excluding 
# negligent manslaughter). 
shr_2019_and_2020 <- shr[shr$year %in% 2019:2020,]
shr_2019_and_2020 <- shr_2019_and_2020[shr_2019_and_2020$ori  %in% agencies_in_both,]
shr_2019_and_2020 <- shr_2019_and_2020[shr_2019_and_2020$homicide_type %in% "murder and nonnegligent manslaughter",]

# Get the number of murders by victim-offender relationship in 2019 and 2020
# Then find the percent change in murders by this group from 2019 to 2020
# Sort data by largest to smallest percent change
shr_difference <- 
  shr_2019_and_2020 %>%
  group_by(year) %>%
  count(victim_1_relation_to_offender_1) %>%
  spread(year, n) %>%
  mutate(difference = `2020` - `2019`,
         percent_change = difference / `2019` * 100,
         victim_1_relation_to_offender_1 = capitalize_words(victim_1_relation_to_offender_1)) %>%
  filter(`2019` >= 50) %>%
  arrange(percent_change)

# This is only for the graph. By default graphs order alphabetically but this makes
# sure it orders it based on the ordering we made above (largest to smallest percent
# change)
shr_difference$victim_1_relation_to_offender_1 <- 
  factor(shr_difference$victim_1_relation_to_offender_1,
         levels = shr_difference$victim_1_relation_to_offender_1)

# Makes a barplot showing the percent change from 2019 to 2020 in number of murders
# by victim group. Labels the x-axis and the y-axis, shifts the graph
# so that relationship labels are on the y-axis for easy reading. And finally
# uses the "crim" theme that changes the colors in the graph to make it a little
# easier to see.
ggplot(shr_difference, aes(x = victim_1_relation_to_offender_1, 
                                        y = percent_change)) +
  geom_bar(stat = "identity") +
  ylab("Percent Change, 2020 Vs. 2019") +
  xlab("Who Victim Is Relative to Murderer") + 
  coord_flip() +
  theme_crim() 

library(dplyr)    
library(ggplot2)    
library(crimeutils) 
library(tidyr)      

shr <- readRDS("data/shr_1976_2020.rds") 

agencies_2019 <- shr$ori[shr$year == 2019]
agencies_2020 <- shr$ori[shr$year == 2020]
agencies_in_both <- agencies_2019[agencies_2019 %in% agencies_2020]


shr_2019_and_2020 <- shr[shr$year %in% 2019:2020,]
shr_2019_and_2020 <- shr_2019_and_2020[shr_2019_and_2020$ori  %in% agencies_in_both,]
shr_2019_and_2020 <- shr_2019_and_2020[shr_2019_and_2020$homicide_type %in% "murder and nonnegligent manslaughter",]

shr_difference <- 
  shr_2019_and_2020 %>%
  group_by(year) %>%
  count(victim_1_relation_to_offender_1) %>%
  spread(year, n) %>%
  mutate(difference = `2020` - `2019`,
         percent_change = difference / `2019` * 100,
         victim_1_relation_to_offender_1 = capitalize_words(victim_1_relation_to_offender_1)) %>%
  filter(`2019` >= 50) %>%
  arrange(percent_change)
shr_difference

shr_difference$victim_1_relation_to_offender_1 <- 
  factor(shr_difference$victim_1_relation_to_offender_1,
         levels = shr_difference$victim_1_relation_to_offender_1)

ggplot(shr_difference, aes(x = victim_1_relation_to_offender_1, 
                                        y = percent_change)) +
  geom_bar(stat = "identity") +
  ylab("Percent Change, 2020 Vs. 2019") +
  xlab("Who Victim Is Relative to Murderer") + 
  coord_flip() +
  theme_crim() 

shr_difference <- 
  shr_2019_and_2020 %>%
  group_by(year) %>%
  count(offender_1_weapon) %>%
  spread(year, n) %>%
  mutate(difference = `2020` - `2019`,
         percent_change = difference / `2019` * 100,
         offender_1_weapon = capitalize_words(offender_1_weapon)) %>%
  filter(`2019` >= 50) %>%
  arrange(percent_change)

shr_difference$offender_1_weapon <- 
  factor(shr_difference$offender_1_weapon,
         levels = shr_difference$offender_1_weapon)
ggplot(shr_difference, aes(x = offender_1_weapon, 
                                        y = percent_change)) +
  geom_bar(stat = "identity") +
  ylab("Percent Change, 2020 Vs. 2019") +
  xlab("Offender Weapon") + 
  coord_flip() +
  theme_crim() 
