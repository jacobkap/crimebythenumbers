library(dplyr)      # Used to aggregate data
library(ggplot2)    # Used to make the graph
library(crimeutils) # Used to capitalize words in a column
library(tidyr)      # Used to reshape the data

# Load in the data
shr <- readRDS("data/shr_1976_2020.rds") 


agencies_2019 <- shr$ori[shr$year == 2019]
agencies_2020 <- shr$ori[shr$year == 2020]

agencies_in_both <- agencies_2019[agencies_2019 %in% agencies_2020]


shr_2019_2020 <- shr[shr$year %in% 2019:2020,]
shr_2019_2020 <- shr_2019_2020[shr_2019_2020$ori  %in% 
                                 agencies_in_both,]
shr_2019_2020 <- shr_2019_2020[shr_2019_2020$homicide_type %in% 
                                 "murder and nonnegligent manslaughter",]


shr_difference <- 
  shr_2019_2020 %>%
  group_by(year) %>%
  count(victim_1_relation_to_offender_1) %>%
  spread(year, n) %>%
  mutate(difference = `2020` - `2019`,
         percent_change = difference / `2019` * 100,
         victim_1_relation_to_offender_1 = 
           capitalize_words(victim_1_relation_to_offender_1)) %>%
  filter(`2019` >= 50) %>%
  arrange(percent_change)

shr_difference$victim_1_relation_to_offender_1 <- 
  factor(shr_difference$victim_1_relation_to_offender_1,
         levels = shr_difference$victim_1_relation_to_offender_1)

shr_difference$percent_change <- shr_difference$percent_change / 100

grDevices::pdf("cover_photo.pdf",  width = 13, height = 13*0.618, onefile = TRUE)
ggplot(shr_difference, aes(x = victim_1_relation_to_offender_1, 
                           y = percent_change,
                           fill = percent_change)) +
  geom_bar(stat = "identity") +
  ylab("% Change, 2020 vs. 2019") +
  xlab("Who Victim Is Relative to Murderer") + 
  coord_flip() +
  theme_crim() +
  scale_fill_gradient2(low='#008837', mid='#f7f7f7', high='#7b3294') +
  theme(legend.position = "none")  + 
  scale_y_continuous(labels = scales::percent) + 
  ggtitle("Murders in the United States, by relationship type")
grDevices::dev.off()