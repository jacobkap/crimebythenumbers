shr_difference$victim_1_relation_to_offender_1 <- 
  factor(shr_difference$victim_1_relation_to_offender_1,
         levels = shr_difference$victim_1_relation_to_offender_1)

shr_difference$percent_change <- shr_difference$percent_change / 100
ggplot(shr_difference, aes(x = victim_1_relation_to_offender_1, 
                           y = percent_change,
                           fill = percent_change)) +
  geom_bar(stat = "identity") +
  ylab("% Change, 2020 vs. 2019") +
  xlab("Who Victim Is Relative to Murderer") + 
  coord_flip() +
  theme_crim() +
  scale_fill_gradient2(low='#008837', mid='#f7f7f7', high='#7b3294') +
  theme(legend.position = "none") +
  scale_y_continuous(labels = scales::percent)
