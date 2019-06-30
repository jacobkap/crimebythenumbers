officer_shootings_geocoded <- st_as_sf(officer_shootings_geocoded, 
              coords = c("lon", "lat"), 
              crs = "+proj=longlat +ellps=WGS84 +no_defs")
officer_shootings_geocoded <- st_transform(officer_shootings_geocoded, crs = 2272)

plot(philly_tracts$geometry)
plot(data$geometry, col = "red", add = TRUE)






z <- st_join(data, philly_tracts)
head(z)
table(z$GEOID10)
z$shootings <- 1

z <- aggregate(shootings ~ GEOID10, data = z, FUN = sum)
summary(z$shootings)


z2 <- dplyr::left_join(philly_tracts, z)
head(z2)
table(z2$shootings)
z2[is.na(z2)] <- 0
z2 <- st_as_sf(z2)
table(z2$shootings)

plot(z2$geometry, col = z2$shootings)



ggplot(plot.data, aes(x = long, y = lat, group = group, fill = dog)) +
  geom_polygon() +
  coord_equal()


plot(z2["shootings"])

z2 %>%
  dplyr::mutate(shootings = as.character(shootings)) %>%
  ggplot() +
  geom_sf(aes(fill = shootings)) +
  scale_fill_brewer(palette = "OrRd") 

pal <- brewer.pal(9, "OrRd")
pal <- c("#ffffff", pal)

ggplot(z2) +
  geom_sf(aes(fill = shootings)) +
  scale_fill_manual(values = pal) 

z2 %>%
  dplyr::mutate(shootings = as.character(shootings)) %>%
  ggplot() +
  geom_sf(aes(fill = shootings)) +
  scale_fill_manual(values = pal) +
  labs(fill = "# of Police Shootings",
         ggtitle = "Police Shootings in Philadelphia by Census Tract") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank())


z2 %>%
  dplyr::mutate(shootings = as.character(shootings)) %>%
  ggplot() +
  geom_sf(aes(fill = shootings)) +
  scale_fill_manual(values = pal) +
  labs(fill = "# of Police Shootings",
       title = "Police Shootings in Philadelphia by Census Tract",
       subtitle = "January 2007 - Early 2019") +
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank()) 
