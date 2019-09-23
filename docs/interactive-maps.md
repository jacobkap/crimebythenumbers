
# Interactive maps

While maps of data are useful, their ability to show incident-level information is quite limited. They tend to show broad trends - where crime happened in a city - rather than provide information about specific crime incidents. While broad trends are important, there are significant drawbacks about being unable to get important information about an incident without having to check the data. An interactive map bridges this gap by showing trends while allowing you to zoom into individual incidents and see information about each incident.

For this lesson we will be using data on every marijuana dispensary in San Francisco that have an active dispensary license as of late September 2019. The file is called "san_francisco_marijuana_geocoded.csv".

When downloaded from California's Bureau of Cannabis Control ([here](https://aca5.accela.com/bcc/customization/bcc/cap/licenseSearch.aspx) if you're interested) the data contains the address of each dispensary but does not have coordinates. Without coordinates we are unable to map points, meaning we need to 
geocode them. Geocoding is the process of taking an address and getting the longitude and latitude of that address for mapping. For this lesson I've already geocoded the data and we'll learn how to do so in Chapter \@ref(geocoding).


```r
library(readr)
marijuana <- read_csv("data/san_francisco_marijuana_geocoded.csv")
#> Parsed with column specification:
#> cols(
#>   License_Number = col_character(),
#>   License_Type = col_character(),
#>   Business_Owner = col_character(),
#>   Business_Contact_Information = col_character(),
#>   Business_Structure = col_character(),
#>   Premise_Address = col_character(),
#>   Status = col_character(),
#>   Issue_Date = col_character(),
#>   Expiration_Date = col_character(),
#>   Activities = col_character(),
#>   `Adult-Use/Medicinal` = col_character(),
#>   lon = col_double(),
#>   lat = col_double()
#> )
marijuana <- as.data.frame(marijuana)
```


## Why do interactive graphs matter?

### Understanding your data

The most important thing to learn from this course is that understanding your data is crucial to good research. Making interactive maps is a very useful way to better understand your data as you can immediately see geographic patterns and quickly look at characteristics of those incidents to understand them. 

In this lesson we will make a map of each officer-involved shooting that lets you click on the shooting and see some information about it. If we see a cluster of shootings, we can click on each shooting to see if they are similar. Though it is possible to find these patterns just looking at the data, it is easier to be able to see a geographic pattern and immediately look at information about each incident.

### Police departments use them

Interactive maps are popular in large police departments such as Philadelphia and New York City. They allow easy understanding of geographic patterns in the data and, importantly, allow such access to people who do not have the technical skills necessary to create the maps. If nothing else, learning interactive maps may help you with a future job. 

## Making the interactive map 

As usual, let's take a look at the top 6 rows of the data.


```r
head(marijuana)
#>    License_Number                License_Type   Business_Owner
#> 1 C10-0000614-LIC Cannabis - Retailer License     Terry Muller
#> 2 C10-0000586-LIC Cannabis - Retailer License    Jeremy Goodin
#> 3 C10-0000587-LIC Cannabis - Retailer License     Justin Jarin
#> 4 C10-0000539-LIC Cannabis - Retailer License Ondyn Herschelle
#> 5 C10-0000522-LIC Cannabis - Retailer License      Ryan Hudson
#> 6 C10-0000523-LIC Cannabis - Retailer License      Ryan Hudson
#>                                                                                                           Business_Contact_Information
#> 1                             OUTER SUNSET HOLDINGS, LLC  : Barbary Coast Sunset : Email- terry@barbarycoastsf.com : Phone- 5107173246
#> 2                           URBAN FLOWERS  : Urban Pharm : Email- hilary@urbanpharmsf.com : Phone- 9168335343 : Website- www.up415.com
#> 3                      CCPC, INC.  : The Green Door : Email- alicia@greendoorsf.com : Phone- 4155419590 : Website- www.greendoorsf.com
#> 4 SEVENTY SECOND STREET  : Flower Power SF : Email- flowerpowersf@hotmail.com : Phone- 5103681262 : Website- flowerpowerdispensary.com
#> 5   HOWARD STREET PARTNERS, LLC  : The Apothecarium : Email- Ryan@apothecarium.com : Phone- 4157469001 : Website- www.apothecarium.com
#> 6              DEEP THOUGHT, LLC  : The Apothecarium : Email- ryan@pothecarium.com : Phone- 4157469001 : Website- www.Apothecarium.com
#>          Business_Structure                         Premise_Address Status
#> 1 Limited Liability Company  2165 IRVING ST san francisco, CA 94122 Active
#> 2               Corporation 122 10TH ST SAN FRANCISCO, CA 941032605 Active
#> 3               Corporation   843 Howard ST SAN FRANCISCO, CA 94103 Active
#> 4               Corporation    70 SECOND ST SAN FRANCISCO, CA 94105 Active
#> 5 Limited Liability Company   527 Howard ST San Francisco, CA 94105 Active
#> 6 Limited Liability Company 2414 Lombard ST San Francisco, CA 94123 Active
#>   Issue_Date Expiration_Date                Activities Adult-Use/Medicinal
#> 1  9/13/2019       9/12/2020 N/A for this license type                BOTH
#> 2  8/26/2019       8/25/2020 N/A for this license type                BOTH
#> 3  8/26/2019       8/25/2020 N/A for this license type                BOTH
#> 4   8/5/2019        8/4/2020 N/A for this license type                BOTH
#> 5  7/29/2019       7/28/2020 N/A for this license type                BOTH
#> 6  7/29/2019       7/28/2020 N/A for this license type                BOTH
#>         lon      lat
#> 1 -122.4811 37.76337
#> 2 -122.4156 37.77496
#> 3 -122.4037 37.78245
#> 4 -122.4003 37.78837
#> 5 -122.3967 37.78798
#> 6 -122.4413 37.79920
```

This data ishas information about the type of license, who the owner is, where the dispensary is (as an address and as coordinates), and contact information. We'll be making a map showing every dispensary in the city and make it so when you click a dot it'll make a popup showing information about that dispensary. 

We will use the package `leaflet` for our interactive map. `leaflet` produces maps similar to Google Maps with circles (or any icon we choose) for each value we add to the map. It allows you to zoom in, scroll around, and provides context to each incident that isn't available on a static map. 


```r
install.packages("leaflet")
```


```r
library(leaflet)
```

To make a `leaflet` map we need to run the function `leaflet()` and add a tile to the map. A tile is simply the background of the map. This [website](https://leaflet-extras.github.io/leaflet-providers/preview/) provides a large number of potential tiles to use, though many are not relevant to our purposes of crime mapping. 

We will use a standard tile from Open Street Maps. This tile gives street names and highlights important features such has parks and large stores which provides useful contexts for looking at the data. The `attribution` parameter isn't strictly necessary but it is good form to say where your tile is from.  


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors')
```

<!--html_preserve--><div id="htmlwidget-f68c25b3392ce39247fb" style="width:90%;height:415.296px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-f68c25b3392ce39247fb">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">\n                OpenStreetMap<\/a> contributors"}]}]},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

When you run the above code it shows a world map (copied several times). Zoom into it and it'll start showing relevant features of wherever you're looking.

Note the `%>%` between the `leaflet()` function and the `addTiles()` function. This is called a "pipe" in R and is used like the `+` in `ggplot()` to combine multiple functions together. This is used heavily in what is called the "tidyverse", a series of packages that are prominent in modern R and useful for data analysis. We won't be covering them in this book but for more information on them you can check the [tidyverse website](https://www.tidyverse.org/). For this lesson you need to know that each piece of the `leaflet` function must end with `%>%` for the next line to work. 

To add the points to the graph we use the function `addMarkers()` which has two parameters, `lng` and `lat`. For both parameters we put the column in which the longitude and latitude are, respectively.


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addMarkers(lng = marijuana$lon, 
             lat = marijuana$lat)
```

<!--html_preserve--><div id="htmlwidget-2f3e7ae179cd421f178b" style="width:90%;height:415.296px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-2f3e7ae179cd421f178b">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">\n                OpenStreetMap<\/a> contributors"}]},{"method":"addMarkers","args":[[37.763368513994,37.7749608909055,37.7824456322351,37.7883655156675,37.7879786211266,37.7991993439031,37.776723025795,37.7716441737549,37.7683642435144,37.7661342361937,37.7149433225515,37.7768233749783,37.7721656633102,37.7779165026544,37.7579164818224,37.7868596560969,37.7885928301402,37.7764332217669,37.7723969821552,37.7933583439031,37.7150078334871,37.780630513994,37.7439846089216,37.7296109572681,37.7106912181603,37.7758773583299,37.7818572767325,37.756626757978,37.7434740591205,37.7820036361302,37.7765260973827,37.7470720901957,37.7573373388828],[-122.481130636274,-122.415558808789,-122.403690577558,-122.400299094379,-122.396710580876,-122.441332845548,-122.401600870362,-122.416630208985,-122.427647255684,-122.419734009839,-122.442329761989,-122.414038364158,-122.429907545098,-122.415859554417,-122.418945411016,-122.419454935744,-122.403642363466,-122.41451924661,-122.422663566606,-122.399141820013,-122.442249162935,-122.471140300998,-122.421625124618,-122.430460425904,-122.404194082723,-122.438473648075,-122.407646582867,-122.418903381384,-122.421339303364,-122.408380614202,-122.414985660825,-122.418860565064,-122.388386289774],null,null,null,{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},null,null,null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[37.7106912181603,37.7991993439031],"lng":[-122.481130636274,-122.388386289774]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

It now adds an icon indicating where every dispensary in our data is. You can zoom in and scroll around to see more about where the dispensaries are. There are only a few dozen locations in the data so the popups overlapping a bit doesn't affect our map too much. If we had more - such as crime data with millions of offenses - it would make it very hard to read. To change the icons to circles we can change the function `addMarkers()` to `addCircleMarkers()`, keeping the rest of the code the same, 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$lon, 
                   lat = marijuana$lat)
```

<!--html_preserve--><div id="htmlwidget-8aaa3b2b7e523e1b07e0" style="width:90%;height:415.296px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-8aaa3b2b7e523e1b07e0">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">\n                OpenStreetMap<\/a> contributors"}]},{"method":"addCircleMarkers","args":[[37.763368513994,37.7749608909055,37.7824456322351,37.7883655156675,37.7879786211266,37.7991993439031,37.776723025795,37.7716441737549,37.7683642435144,37.7661342361937,37.7149433225515,37.7768233749783,37.7721656633102,37.7779165026544,37.7579164818224,37.7868596560969,37.7885928301402,37.7764332217669,37.7723969821552,37.7933583439031,37.7150078334871,37.780630513994,37.7439846089216,37.7296109572681,37.7106912181603,37.7758773583299,37.7818572767325,37.756626757978,37.7434740591205,37.7820036361302,37.7765260973827,37.7470720901957,37.7573373388828],[-122.481130636274,-122.415558808789,-122.403690577558,-122.400299094379,-122.396710580876,-122.441332845548,-122.401600870362,-122.416630208985,-122.427647255684,-122.419734009839,-122.442329761989,-122.414038364158,-122.429907545098,-122.415859554417,-122.418945411016,-122.419454935744,-122.403642363466,-122.41451924661,-122.422663566606,-122.399141820013,-122.442249162935,-122.471140300998,-122.421625124618,-122.430460425904,-122.404194082723,-122.438473648075,-122.407646582867,-122.418903381384,-122.421339303364,-122.408380614202,-122.414985660825,-122.418860565064,-122.388386289774],10,null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":5,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2},null,null,null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[37.7106912181603,37.7991993439031],"lng":[-122.481130636274,-122.388386289774]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

This makes the icon into circles but they are still large and cover most of the map. To adjust the size of our icons we use the `radius` parameter in `addMarkers()` or `addCircleMarkers()`. The larger the radius, the larger the icons. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$lon, 
                   lat = marijuana$lat,
                   radius = 5)
```

<!--html_preserve--><div id="htmlwidget-afb231e88b72baf5047f" style="width:90%;height:415.296px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-afb231e88b72baf5047f">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">\n                OpenStreetMap<\/a> contributors"}]},{"method":"addCircleMarkers","args":[[37.763368513994,37.7749608909055,37.7824456322351,37.7883655156675,37.7879786211266,37.7991993439031,37.776723025795,37.7716441737549,37.7683642435144,37.7661342361937,37.7149433225515,37.7768233749783,37.7721656633102,37.7779165026544,37.7579164818224,37.7868596560969,37.7885928301402,37.7764332217669,37.7723969821552,37.7933583439031,37.7150078334871,37.780630513994,37.7439846089216,37.7296109572681,37.7106912181603,37.7758773583299,37.7818572767325,37.756626757978,37.7434740591205,37.7820036361302,37.7765260973827,37.7470720901957,37.7573373388828],[-122.481130636274,-122.415558808789,-122.403690577558,-122.400299094379,-122.396710580876,-122.441332845548,-122.401600870362,-122.416630208985,-122.427647255684,-122.419734009839,-122.442329761989,-122.414038364158,-122.429907545098,-122.415859554417,-122.418945411016,-122.419454935744,-122.403642363466,-122.41451924661,-122.422663566606,-122.399141820013,-122.442249162935,-122.471140300998,-122.421625124618,-122.430460425904,-122.404194082723,-122.438473648075,-122.407646582867,-122.418903381384,-122.421339303364,-122.408380614202,-122.414985660825,-122.418860565064,-122.388386289774],5,null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":5,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2},null,null,null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[37.7106912181603,37.7991993439031],"lng":[-122.481130636274,-122.388386289774]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

Setting the `radius` option to 5 shrinks the size of the icon a lot. In your own maps you'll have to fiddle with this option to get it to look the way you want. Let's move on to adding information about each icon when clicked upon. 

## Adding popup information

The parameter `popup` in the `addMarkers()` or `addCircleMarkers()` functions lets you input a character value (if not already a character value it will convert it to one) and that will be shown as a popup when you click on the icon. Let's start simple here by inputting the business owner column in our data and then build it up to a more complicated popup. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$lon, 
             lat = marijuana$lat,
                   radius = 5,
                   popup = marijuana$Business_Owner)
```

<!--html_preserve--><div id="htmlwidget-7508f5aa8ec0b530eb19" style="width:90%;height:415.296px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-7508f5aa8ec0b530eb19">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">\n                OpenStreetMap<\/a> contributors"}]},{"method":"addCircleMarkers","args":[[37.763368513994,37.7749608909055,37.7824456322351,37.7883655156675,37.7879786211266,37.7991993439031,37.776723025795,37.7716441737549,37.7683642435144,37.7661342361937,37.7149433225515,37.7768233749783,37.7721656633102,37.7779165026544,37.7579164818224,37.7868596560969,37.7885928301402,37.7764332217669,37.7723969821552,37.7933583439031,37.7150078334871,37.780630513994,37.7439846089216,37.7296109572681,37.7106912181603,37.7758773583299,37.7818572767325,37.756626757978,37.7434740591205,37.7820036361302,37.7765260973827,37.7470720901957,37.7573373388828],[-122.481130636274,-122.415558808789,-122.403690577558,-122.400299094379,-122.396710580876,-122.441332845548,-122.401600870362,-122.416630208985,-122.427647255684,-122.419734009839,-122.442329761989,-122.414038364158,-122.429907545098,-122.415859554417,-122.418945411016,-122.419454935744,-122.403642363466,-122.41451924661,-122.422663566606,-122.399141820013,-122.442249162935,-122.471140300998,-122.421625124618,-122.430460425904,-122.404194082723,-122.438473648075,-122.407646582867,-122.418903381384,-122.421339303364,-122.408380614202,-122.414985660825,-122.418860565064,-122.388386289774],5,null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":5,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2},null,null,["Terry Muller","Jeremy Goodin","Justin Jarin","Ondyn Herschelle","Ryan Hudson","Ryan Hudson","Cameron Wald","Almir Guimaraes","Ryan Hudson","Michael Breyburg","Caleb Counts","Joseph Pearson","Joseph Pearson","Brendan Hallinan","Khader ElShawa","Clayton Kopp","Wyatt Lin","Heidi Hanley","Abdelkader Chenbod","Tara McKnight","Mikhail Mekk","Martin Higgins","Martin Higgins","Kevin Reed","Victor Nguyen","Tariq Alazraie: Tariq Alazraie","Jesse Henry","gus murad","Brian Mitchell: Brian Mitchell","Stephen Rechif","Martin Olive","Arthur Vugelman: Arthur Vugelman","Robert Watson: Robert Watson"],null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[37.7106912181603,37.7991993439031],"lng":[-122.481130636274,-122.388386289774]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

Try clicking around and you'll see that the owner of the dispensary you clicked on appears over the dot. We usually want to have a title indicating what the value in the popup means. We can do this by using the `paste()` function to combine text explaining the value with the value itself. Let's add the words "Business Owner:" before the business owner column.


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$lon, 
             lat = marijuana$lat,
                   radius = 5,
                   popup = paste("Business Owner:", marijuana$Business_Owner))
```

<!--html_preserve--><div id="htmlwidget-c5f52fd5167b7e614eef" style="width:90%;height:415.296px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-c5f52fd5167b7e614eef">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">\n                OpenStreetMap<\/a> contributors"}]},{"method":"addCircleMarkers","args":[[37.763368513994,37.7749608909055,37.7824456322351,37.7883655156675,37.7879786211266,37.7991993439031,37.776723025795,37.7716441737549,37.7683642435144,37.7661342361937,37.7149433225515,37.7768233749783,37.7721656633102,37.7779165026544,37.7579164818224,37.7868596560969,37.7885928301402,37.7764332217669,37.7723969821552,37.7933583439031,37.7150078334871,37.780630513994,37.7439846089216,37.7296109572681,37.7106912181603,37.7758773583299,37.7818572767325,37.756626757978,37.7434740591205,37.7820036361302,37.7765260973827,37.7470720901957,37.7573373388828],[-122.481130636274,-122.415558808789,-122.403690577558,-122.400299094379,-122.396710580876,-122.441332845548,-122.401600870362,-122.416630208985,-122.427647255684,-122.419734009839,-122.442329761989,-122.414038364158,-122.429907545098,-122.415859554417,-122.418945411016,-122.419454935744,-122.403642363466,-122.41451924661,-122.422663566606,-122.399141820013,-122.442249162935,-122.471140300998,-122.421625124618,-122.430460425904,-122.404194082723,-122.438473648075,-122.407646582867,-122.418903381384,-122.421339303364,-122.408380614202,-122.414985660825,-122.418860565064,-122.388386289774],5,null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":5,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2},null,null,["Business Owner: Terry Muller","Business Owner: Jeremy Goodin","Business Owner: Justin Jarin","Business Owner: Ondyn Herschelle","Business Owner: Ryan Hudson","Business Owner: Ryan Hudson","Business Owner: Cameron Wald","Business Owner: Almir Guimaraes","Business Owner: Ryan Hudson","Business Owner: Michael Breyburg","Business Owner: Caleb Counts","Business Owner: Joseph Pearson","Business Owner: Joseph Pearson","Business Owner: Brendan Hallinan","Business Owner: Khader ElShawa","Business Owner: Clayton Kopp","Business Owner: Wyatt Lin","Business Owner: Heidi Hanley","Business Owner: Abdelkader Chenbod","Business Owner: Tara McKnight","Business Owner: Mikhail Mekk","Business Owner: Martin Higgins","Business Owner: Martin Higgins","Business Owner: Kevin Reed","Business Owner: Victor Nguyen","Business Owner: Tariq Alazraie: Tariq Alazraie","Business Owner: Jesse Henry","Business Owner: gus murad","Business Owner: Brian Mitchell: Brian Mitchell","Business Owner: Stephen Rechif","Business Owner: Martin Olive","Business Owner: Arthur Vugelman: Arthur Vugelman","Business Owner: Robert Watson: Robert Watson"],null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[37.7106912181603,37.7991993439031],"lng":[-122.481130636274,-122.388386289774]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

We don't have too much information in the data but we let's add the address and license number to the popup by adding them to the `paste()` function we're using. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$lon, 
             lat = marijuana$lat,
                   radius = 5,
                   popup = paste("Business Owner:", marijuana$Business_Owner,
                                 "Address:", marijuana$Premise_Address,
                                 "License:", marijuana$License_Number))
```

<!--html_preserve--><div id="htmlwidget-59211ee56daed96d4360" style="width:90%;height:415.296px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-59211ee56daed96d4360">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">\n                OpenStreetMap<\/a> contributors"}]},{"method":"addCircleMarkers","args":[[37.763368513994,37.7749608909055,37.7824456322351,37.7883655156675,37.7879786211266,37.7991993439031,37.776723025795,37.7716441737549,37.7683642435144,37.7661342361937,37.7149433225515,37.7768233749783,37.7721656633102,37.7779165026544,37.7579164818224,37.7868596560969,37.7885928301402,37.7764332217669,37.7723969821552,37.7933583439031,37.7150078334871,37.780630513994,37.7439846089216,37.7296109572681,37.7106912181603,37.7758773583299,37.7818572767325,37.756626757978,37.7434740591205,37.7820036361302,37.7765260973827,37.7470720901957,37.7573373388828],[-122.481130636274,-122.415558808789,-122.403690577558,-122.400299094379,-122.396710580876,-122.441332845548,-122.401600870362,-122.416630208985,-122.427647255684,-122.419734009839,-122.442329761989,-122.414038364158,-122.429907545098,-122.415859554417,-122.418945411016,-122.419454935744,-122.403642363466,-122.41451924661,-122.422663566606,-122.399141820013,-122.442249162935,-122.471140300998,-122.421625124618,-122.430460425904,-122.404194082723,-122.438473648075,-122.407646582867,-122.418903381384,-122.421339303364,-122.408380614202,-122.414985660825,-122.418860565064,-122.388386289774],5,null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":5,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2},null,null,["Business Owner: Terry Muller Address: 2165 IRVING ST san francisco, CA 94122 License: C10-0000614-LIC","Business Owner: Jeremy Goodin Address: 122 10TH ST SAN FRANCISCO, CA 941032605 License: C10-0000586-LIC","Business Owner: Justin Jarin Address: 843 Howard ST SAN FRANCISCO, CA 94103 License: C10-0000587-LIC","Business Owner: Ondyn Herschelle Address: 70 SECOND ST SAN FRANCISCO, CA 94105 License: C10-0000539-LIC","Business Owner: Ryan Hudson Address: 527 Howard ST San Francisco, CA 94105 License: C10-0000522-LIC","Business Owner: Ryan Hudson Address: 2414 Lombard ST San Francisco, CA 94123 License: C10-0000523-LIC","Business Owner: Cameron Wald Address: 761 BRYANT ST SAN FRANCISCO, CA 941071014 License: C10-0000527-LIC","Business Owner: Almir Guimaraes Address: 211 12th ST San Francisco, CA 941033717 License: C10-0000512-LIC","Business Owner: Ryan Hudson Address: 2029 MARKET ST SAN FRANCISCO, CA 94114 License: C10-0000515-LIC","Business Owner: Michael Breyburg Address: 1933 MISSION ST SAN FRANCISCO, CA 941033441 License: C10-0000490-LIC","Business Owner: Caleb Counts Address: 5234 MISSION ST SAN FRANCISCO, CA 941123732 License: C10-0000501-LIC","Business Owner: Joseph Pearson Address: 1256 Mission ST San Francisco, CA 94103 License: C10-0000452-LIC","Business Owner: Joseph Pearson Address: 473 Haight ST San Francisco, CA 94117 License: C10-0000453-LIC","Business Owner: Brendan Hallinan Address: 1276 Market ST San Francisco, CA 94102 License: C10-0000427-LIC","Business Owner: Khader ElShawa Address: 2441 MISSION ST SAN FRANCISCO, CA 941102414 License: C10-0000437-LIC","Business Owner: Clayton Kopp Address: 1077 POST ST SAN FRANCISCO, CA 94109 License: C10-0000387-LIC","Business Owner: Wyatt Lin Address: 49 KEARNY ST SAN FRANCISCO, CA 94108 License: C10-0000358-LIC","Business Owner: Heidi Hanley Address: 1284 MISSION ST SAN FRANCISCO, CA 94103 License: C10-0000308-LIC","Business Owner: Abdelkader Chenbod Address: 14 VALENCIA ST SAN FRANCISCO, CA 941031102 License: C10-0000281-LIC","Business Owner: Tara McKnight Address: 212 CALIFORNIA ST SAN FRANCISCO, CA 941114405 License: C10-0000282-LIC","Business Owner: Mikhail Mekk Address: 5258 MISSION ST SAN FRANCISCO, CA 94112 License: C10-0000265-LIC","Business Owner: Martin Higgins Address: 4811 GEARY BLVD SAN FRANCISCO, CA 94118 License: C10-0000202-LIC","Business Owner: Martin Higgins Address: 33 29TH ST SAN FRANCISCO, CA 94110 License: C10-0000205-LIC","Business Owner: Kevin Reed Address: 4218 MISSION ST SAN FRANCISCO, CA 94112 License: C10-0000200-LIC","Business Owner: Victor Nguyen Address: 2442 BAYSHORE BLVD SAN FRANCISCO, CA 94134 License: C10-0000152-LIC","Business Owner: Tariq Alazraie: Tariq Alazraie Address: 1326 Grove ST San Francisco, CA 94117 License: C10-0000158-LIC","Business Owner: Jesse Henry Address: 952 MISSION ST SAN FRANCISCO, CA 941032911 License: C10-0000127-LIC","Business Owner: gus murad Address: 2520 Mission ST San Francisco, CA 94110 License: C10-0000133-LIC","Business Owner: Brian Mitchell: Brian Mitchell Address: 3326 mission ST san francisco, CA 94110 License: C10-0000053-LIC","Business Owner: Stephen Rechif Address: 471 JESSIE ST SAN FRANCISCO, CA 94103 License: C10-0000043-LIC","Business Owner: Martin Olive Address: 79 9TH ST SAN FRANCISCO, CA 941031401 License: C10-0000035-LIC","Business Owner: Arthur Vugelman: Arthur Vugelman Address: 3139 MISSION ST SAN FRANCISCO, CA 94110 License: C10-0000016-LIC","Business Owner: Robert Watson: Robert Watson Address: 2544 3RD ST SAN FRANCISCO, CA 94122 License: C10-0000005-LIC"],null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[37.7106912181603,37.7991993439031],"lng":[-122.481130636274,-122.388386289774]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

Just adding the location text makes it try to print out everything on one line which is hard to read. If we add the text `<br>` where we want a line break it will make one. `<br>` is the HTML tag for line-break which is why it works making a new line in this case. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$lon, 
             lat = marijuana$lat,
                   radius = 5,
                   popup = paste("Business Owner:", marijuana$Business_Owner,
                                 "<br>",
                                 "Address:", marijuana$Premise_Address,
                                 "<br>",
                                 "License:", marijuana$License_Number))
```

<!--html_preserve--><div id="htmlwidget-26c5b720d078a5d18948" style="width:90%;height:415.296px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-26c5b720d078a5d18948">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">\n                OpenStreetMap<\/a> contributors"}]},{"method":"addCircleMarkers","args":[[37.763368513994,37.7749608909055,37.7824456322351,37.7883655156675,37.7879786211266,37.7991993439031,37.776723025795,37.7716441737549,37.7683642435144,37.7661342361937,37.7149433225515,37.7768233749783,37.7721656633102,37.7779165026544,37.7579164818224,37.7868596560969,37.7885928301402,37.7764332217669,37.7723969821552,37.7933583439031,37.7150078334871,37.780630513994,37.7439846089216,37.7296109572681,37.7106912181603,37.7758773583299,37.7818572767325,37.756626757978,37.7434740591205,37.7820036361302,37.7765260973827,37.7470720901957,37.7573373388828],[-122.481130636274,-122.415558808789,-122.403690577558,-122.400299094379,-122.396710580876,-122.441332845548,-122.401600870362,-122.416630208985,-122.427647255684,-122.419734009839,-122.442329761989,-122.414038364158,-122.429907545098,-122.415859554417,-122.418945411016,-122.419454935744,-122.403642363466,-122.41451924661,-122.422663566606,-122.399141820013,-122.442249162935,-122.471140300998,-122.421625124618,-122.430460425904,-122.404194082723,-122.438473648075,-122.407646582867,-122.418903381384,-122.421339303364,-122.408380614202,-122.414985660825,-122.418860565064,-122.388386289774],5,null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":5,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2},null,null,["Business Owner: Terry Muller <br> Address: 2165 IRVING ST san francisco, CA 94122 <br> License: C10-0000614-LIC","Business Owner: Jeremy Goodin <br> Address: 122 10TH ST SAN FRANCISCO, CA 941032605 <br> License: C10-0000586-LIC","Business Owner: Justin Jarin <br> Address: 843 Howard ST SAN FRANCISCO, CA 94103 <br> License: C10-0000587-LIC","Business Owner: Ondyn Herschelle <br> Address: 70 SECOND ST SAN FRANCISCO, CA 94105 <br> License: C10-0000539-LIC","Business Owner: Ryan Hudson <br> Address: 527 Howard ST San Francisco, CA 94105 <br> License: C10-0000522-LIC","Business Owner: Ryan Hudson <br> Address: 2414 Lombard ST San Francisco, CA 94123 <br> License: C10-0000523-LIC","Business Owner: Cameron Wald <br> Address: 761 BRYANT ST SAN FRANCISCO, CA 941071014 <br> License: C10-0000527-LIC","Business Owner: Almir Guimaraes <br> Address: 211 12th ST San Francisco, CA 941033717 <br> License: C10-0000512-LIC","Business Owner: Ryan Hudson <br> Address: 2029 MARKET ST SAN FRANCISCO, CA 94114 <br> License: C10-0000515-LIC","Business Owner: Michael Breyburg <br> Address: 1933 MISSION ST SAN FRANCISCO, CA 941033441 <br> License: C10-0000490-LIC","Business Owner: Caleb Counts <br> Address: 5234 MISSION ST SAN FRANCISCO, CA 941123732 <br> License: C10-0000501-LIC","Business Owner: Joseph Pearson <br> Address: 1256 Mission ST San Francisco, CA 94103 <br> License: C10-0000452-LIC","Business Owner: Joseph Pearson <br> Address: 473 Haight ST San Francisco, CA 94117 <br> License: C10-0000453-LIC","Business Owner: Brendan Hallinan <br> Address: 1276 Market ST San Francisco, CA 94102 <br> License: C10-0000427-LIC","Business Owner: Khader ElShawa <br> Address: 2441 MISSION ST SAN FRANCISCO, CA 941102414 <br> License: C10-0000437-LIC","Business Owner: Clayton Kopp <br> Address: 1077 POST ST SAN FRANCISCO, CA 94109 <br> License: C10-0000387-LIC","Business Owner: Wyatt Lin <br> Address: 49 KEARNY ST SAN FRANCISCO, CA 94108 <br> License: C10-0000358-LIC","Business Owner: Heidi Hanley <br> Address: 1284 MISSION ST SAN FRANCISCO, CA 94103 <br> License: C10-0000308-LIC","Business Owner: Abdelkader Chenbod <br> Address: 14 VALENCIA ST SAN FRANCISCO, CA 941031102 <br> License: C10-0000281-LIC","Business Owner: Tara McKnight <br> Address: 212 CALIFORNIA ST SAN FRANCISCO, CA 941114405 <br> License: C10-0000282-LIC","Business Owner: Mikhail Mekk <br> Address: 5258 MISSION ST SAN FRANCISCO, CA 94112 <br> License: C10-0000265-LIC","Business Owner: Martin Higgins <br> Address: 4811 GEARY BLVD SAN FRANCISCO, CA 94118 <br> License: C10-0000202-LIC","Business Owner: Martin Higgins <br> Address: 33 29TH ST SAN FRANCISCO, CA 94110 <br> License: C10-0000205-LIC","Business Owner: Kevin Reed <br> Address: 4218 MISSION ST SAN FRANCISCO, CA 94112 <br> License: C10-0000200-LIC","Business Owner: Victor Nguyen <br> Address: 2442 BAYSHORE BLVD SAN FRANCISCO, CA 94134 <br> License: C10-0000152-LIC","Business Owner: Tariq Alazraie: Tariq Alazraie <br> Address: 1326 Grove ST San Francisco, CA 94117 <br> License: C10-0000158-LIC","Business Owner: Jesse Henry <br> Address: 952 MISSION ST SAN FRANCISCO, CA 941032911 <br> License: C10-0000127-LIC","Business Owner: gus murad <br> Address: 2520 Mission ST San Francisco, CA 94110 <br> License: C10-0000133-LIC","Business Owner: Brian Mitchell: Brian Mitchell <br> Address: 3326 mission ST san francisco, CA 94110 <br> License: C10-0000053-LIC","Business Owner: Stephen Rechif <br> Address: 471 JESSIE ST SAN FRANCISCO, CA 94103 <br> License: C10-0000043-LIC","Business Owner: Martin Olive <br> Address: 79 9TH ST SAN FRANCISCO, CA 941031401 <br> License: C10-0000035-LIC","Business Owner: Arthur Vugelman: Arthur Vugelman <br> Address: 3139 MISSION ST SAN FRANCISCO, CA 94110 <br> License: C10-0000016-LIC","Business Owner: Robert Watson: Robert Watson <br> Address: 2544 3RD ST SAN FRANCISCO, CA 94122 <br> License: C10-0000005-LIC"],null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[37.7106912181603,37.7991993439031],"lng":[-122.481130636274,-122.388386289774]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

## Dealing with too many markers

In our case with only 33 rows of data, turning the markers to circles solves our visibility issue. In cases with many more rows of data, this doesn't always work. The other solution is to cluster the data into groups where the dots only show if you zoom down. 

If we add the code `clusterOptions = markerClusterOptions()` to our `addCircleMarkers()` it will cluster for us. 


```r
leaflet() %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addCircleMarkers(lng = marijuana$lon, 
             lat = marijuana$lat,
                   radius = 5,
                   popup = paste("Business Owner:", marijuana$Business_Owner,
                                 "<br>",
                                 "Address:", marijuana$Premise_Address,
                                 "<br>",
                                 "License:", marijuana$License_Number),
                   clusterOptions = markerClusterOptions())
```

<!--html_preserve--><div id="htmlwidget-1062106dbcf5f3adf679" style="width:90%;height:415.296px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-1062106dbcf5f3adf679">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">\n                OpenStreetMap<\/a> contributors"}]},{"method":"addCircleMarkers","args":[[37.763368513994,37.7749608909055,37.7824456322351,37.7883655156675,37.7879786211266,37.7991993439031,37.776723025795,37.7716441737549,37.7683642435144,37.7661342361937,37.7149433225515,37.7768233749783,37.7721656633102,37.7779165026544,37.7579164818224,37.7868596560969,37.7885928301402,37.7764332217669,37.7723969821552,37.7933583439031,37.7150078334871,37.780630513994,37.7439846089216,37.7296109572681,37.7106912181603,37.7758773583299,37.7818572767325,37.756626757978,37.7434740591205,37.7820036361302,37.7765260973827,37.7470720901957,37.7573373388828],[-122.481130636274,-122.415558808789,-122.403690577558,-122.400299094379,-122.396710580876,-122.441332845548,-122.401600870362,-122.416630208985,-122.427647255684,-122.419734009839,-122.442329761989,-122.414038364158,-122.429907545098,-122.415859554417,-122.418945411016,-122.419454935744,-122.403642363466,-122.41451924661,-122.422663566606,-122.399141820013,-122.442249162935,-122.471140300998,-122.421625124618,-122.430460425904,-122.404194082723,-122.438473648075,-122.407646582867,-122.418903381384,-122.421339303364,-122.408380614202,-122.414985660825,-122.418860565064,-122.388386289774],5,null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":5,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2},{"showCoverageOnHover":true,"zoomToBoundsOnClick":true,"spiderfyOnMaxZoom":true,"removeOutsideVisibleBounds":true,"spiderLegPolylineOptions":{"weight":1.5,"color":"#222","opacity":0.5},"freezeAtZoom":false},null,["Business Owner: Terry Muller <br> Address: 2165 IRVING ST san francisco, CA 94122 <br> License: C10-0000614-LIC","Business Owner: Jeremy Goodin <br> Address: 122 10TH ST SAN FRANCISCO, CA 941032605 <br> License: C10-0000586-LIC","Business Owner: Justin Jarin <br> Address: 843 Howard ST SAN FRANCISCO, CA 94103 <br> License: C10-0000587-LIC","Business Owner: Ondyn Herschelle <br> Address: 70 SECOND ST SAN FRANCISCO, CA 94105 <br> License: C10-0000539-LIC","Business Owner: Ryan Hudson <br> Address: 527 Howard ST San Francisco, CA 94105 <br> License: C10-0000522-LIC","Business Owner: Ryan Hudson <br> Address: 2414 Lombard ST San Francisco, CA 94123 <br> License: C10-0000523-LIC","Business Owner: Cameron Wald <br> Address: 761 BRYANT ST SAN FRANCISCO, CA 941071014 <br> License: C10-0000527-LIC","Business Owner: Almir Guimaraes <br> Address: 211 12th ST San Francisco, CA 941033717 <br> License: C10-0000512-LIC","Business Owner: Ryan Hudson <br> Address: 2029 MARKET ST SAN FRANCISCO, CA 94114 <br> License: C10-0000515-LIC","Business Owner: Michael Breyburg <br> Address: 1933 MISSION ST SAN FRANCISCO, CA 941033441 <br> License: C10-0000490-LIC","Business Owner: Caleb Counts <br> Address: 5234 MISSION ST SAN FRANCISCO, CA 941123732 <br> License: C10-0000501-LIC","Business Owner: Joseph Pearson <br> Address: 1256 Mission ST San Francisco, CA 94103 <br> License: C10-0000452-LIC","Business Owner: Joseph Pearson <br> Address: 473 Haight ST San Francisco, CA 94117 <br> License: C10-0000453-LIC","Business Owner: Brendan Hallinan <br> Address: 1276 Market ST San Francisco, CA 94102 <br> License: C10-0000427-LIC","Business Owner: Khader ElShawa <br> Address: 2441 MISSION ST SAN FRANCISCO, CA 941102414 <br> License: C10-0000437-LIC","Business Owner: Clayton Kopp <br> Address: 1077 POST ST SAN FRANCISCO, CA 94109 <br> License: C10-0000387-LIC","Business Owner: Wyatt Lin <br> Address: 49 KEARNY ST SAN FRANCISCO, CA 94108 <br> License: C10-0000358-LIC","Business Owner: Heidi Hanley <br> Address: 1284 MISSION ST SAN FRANCISCO, CA 94103 <br> License: C10-0000308-LIC","Business Owner: Abdelkader Chenbod <br> Address: 14 VALENCIA ST SAN FRANCISCO, CA 941031102 <br> License: C10-0000281-LIC","Business Owner: Tara McKnight <br> Address: 212 CALIFORNIA ST SAN FRANCISCO, CA 941114405 <br> License: C10-0000282-LIC","Business Owner: Mikhail Mekk <br> Address: 5258 MISSION ST SAN FRANCISCO, CA 94112 <br> License: C10-0000265-LIC","Business Owner: Martin Higgins <br> Address: 4811 GEARY BLVD SAN FRANCISCO, CA 94118 <br> License: C10-0000202-LIC","Business Owner: Martin Higgins <br> Address: 33 29TH ST SAN FRANCISCO, CA 94110 <br> License: C10-0000205-LIC","Business Owner: Kevin Reed <br> Address: 4218 MISSION ST SAN FRANCISCO, CA 94112 <br> License: C10-0000200-LIC","Business Owner: Victor Nguyen <br> Address: 2442 BAYSHORE BLVD SAN FRANCISCO, CA 94134 <br> License: C10-0000152-LIC","Business Owner: Tariq Alazraie: Tariq Alazraie <br> Address: 1326 Grove ST San Francisco, CA 94117 <br> License: C10-0000158-LIC","Business Owner: Jesse Henry <br> Address: 952 MISSION ST SAN FRANCISCO, CA 941032911 <br> License: C10-0000127-LIC","Business Owner: gus murad <br> Address: 2520 Mission ST San Francisco, CA 94110 <br> License: C10-0000133-LIC","Business Owner: Brian Mitchell: Brian Mitchell <br> Address: 3326 mission ST san francisco, CA 94110 <br> License: C10-0000053-LIC","Business Owner: Stephen Rechif <br> Address: 471 JESSIE ST SAN FRANCISCO, CA 94103 <br> License: C10-0000043-LIC","Business Owner: Martin Olive <br> Address: 79 9TH ST SAN FRANCISCO, CA 941031401 <br> License: C10-0000035-LIC","Business Owner: Arthur Vugelman: Arthur Vugelman <br> Address: 3139 MISSION ST SAN FRANCISCO, CA 94110 <br> License: C10-0000016-LIC","Business Owner: Robert Watson: Robert Watson <br> Address: 2544 3RD ST SAN FRANCISCO, CA 94122 <br> License: C10-0000005-LIC"],null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[37.7106912181603,37.7991993439031],"lng":[-122.481130636274,-122.388386289774]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

Locations close to each other are grouped together in fairly arbitrary groupings and we can see how large each grouping is by moving our cursor over the circle. Click on a circle or zoom in and and it will show smaller groupings at lower levels of aggregation. Keep clicking or zooming in and it will eventually show each location as its own circle. 

This method is very useful for dealing with huge amounts of data as it avoids overflowing the map with too many icons at one time. A downside, however, is that the clusters are created arbitrarily meaning that important context, such as neighborhood, can be lost. 

## Interactive choropleth maps

In Chapter \@ref(choropleth-maps) we worked on choropleth maps which are maps with shaded regions, such as states colored by which political party won them in an election. Here we will make interactive choropleth maps where you can click on a shaded region and see information about that region. We'll make the same map as before - Census tracts with the number of officer-involved shootings. 

Let's load the tract-level officer-involved shooting data we made earlier. 


```r
load("data/philly_tracts_shootings.rda")
#> Warning in readChar(con, 5L, useBytes = TRUE): cannot open compressed
#> file 'data/philly_tracts_shootings.rda', probable reason 'No such file or
#> directory'
#> Error in readChar(con, 5L, useBytes = TRUE): cannot open the connection
```

We'll begin the `leaflet` map similar to before but use the function `addPolygons()` and our input here is the geometry column of *philly_tracts_shootings*. 


```r
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry)
#> Error in derivePolygons(data, lng, lat, missing(lng), missing(lat), "addPolygons"): object 'philly_tracts_shootings' not found
```

It gives us a blank map because our polygons are projected to Philly's projection while the `leaflet` map expects the standard CRS, WGS84 which uses longitude and latitude. So we need to change our projection to that using the `st_transform()` function from the `sf` package. 


```r
library(sf)
#> Linking to GEOS 3.6.1, GDAL 2.2.3, PROJ 4.9.3
philly_tracts_shootings <- st_transform(philly_tracts_shootings,
                                        crs = "+proj=longlat +datum=WGS84")
#> Error in st_transform(philly_tracts_shootings, crs = "+proj=longlat +datum=WGS84"): object 'philly_tracts_shootings' not found
```

Now let's try again. 


```r
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry)
#> Error in derivePolygons(data, lng, lat, missing(lng), missing(lat), "addPolygons"): object 'philly_tracts_shootings' not found
```

It made a map with large blue lines indicating each tract. Let's change the appearance of the graph a bit before making a popup or shading the tracts. The parameter `color` in `addPolygons()` changes the color of the lines - let's change it to black. The lines are also very large, blurring into each other and making the tracts hard to see. We can change the `weight` parameter to alter the size of these lines - smaller values are smaller lines. Let's try setting this to 1.


```r
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry,
              color = "black",
              weight = 1)
#> Error in derivePolygons(data, lng, lat, missing(lng), missing(lat), "addPolygons"): object 'philly_tracts_shootings' not found
```

That looks better and we can clearly distinguish each tract now. 

As we did earlier, we can add the popup text directly to the function which makes the geographic shapes, in this case `addPolygons()`. Let's add the GEOID10 column value - the unique ID code for that tract - and the number of shootings that occurred in that tract. As before when we click on a tract a popup appears with the output we specified.


```r
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Tract ID: ", philly_tracts_shootings$GEOID10,
                             "<br>",
                             "Number of Shootings: ", philly_tracts_shootings$number_shootings))
#> Error in derivePolygons(data, lng, lat, missing(lng), missing(lat), "addPolygons"): object 'philly_tracts_shootings' not found
```

For these types of maps we generally want to shade each polygon to indicate how frequently the event occured in the polygon. For this process we will make a simple function which will automatically shade the tracts by the value in the column we want it shaded by - *number_shootings*. 

We'll use the function `colorNumeric()` which takes a lot of the work out of the process of coloring in the map. This function takes two inputs, first a color palette which we can get from the site [colorbrewer2](http://colorbrewer2.org/#type=sequential&scheme=OrRd&n=3). Let's  use the fourth bar in the Sequential page, which is light orange to red. If you look in the section with each HEX value it says that the palette is "3-class OrRd". The "3-class" just means we selected 3 colors, the "OrRd" is the part we want. That will tell `colorNumeric()` to make the palette using these colors. The second parameter is the column for our numeric variable, *number_shootings*. 

We will save the output of `colorNumeric("OrRd", philly_tracts_shootings$number_shootings)` as a new variable which we'll call *pal* for convenience. Then inside of `addPolygons()` we'll set the parameter `fillColor` to `pal(philly_tracts_shootings$number_shootings)`, running this function on the column. What this really does is determine which color every tract should be based on the value in the *number_shootings* column.


```r
pal <- colorNumeric("OrRd", philly_tracts_shootings$number_shootings)
#> Error in colorNumeric("OrRd", philly_tracts_shootings$number_shootings): object 'philly_tracts_shootings' not found
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Tract ID: ", philly_tracts_shootings$GEOID10,
                             "<br>",
                             "Number of Shootings: ", philly_tracts_shootings$number_shootings),
              fillColor = pal(philly_tracts_shootings$number_shootings))
#> Error in pal(philly_tracts_shootings$number_shootings): could not find function "pal"
```

Since the tracts are transparent, it is hard to distinguish which color is shown. We can make each tract a solid color by setting the parameter `fillOpacity` inside of `addPolygons()` to 1.


```r
pal <- colorNumeric("OrRd", philly_tracts_shootings$number_shootings)
#> Error in colorNumeric("OrRd", philly_tracts_shootings$number_shootings): object 'philly_tracts_shootings' not found
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Tract ID: ", philly_tracts_shootings$GEOID10,
                             "<br>",
                             "Number of Shootings: ", philly_tracts_shootings$number_shootings),
              fillColor = pal(philly_tracts_shootings$number_shootings),
              fillOpacity = 1)
#> Error in pal(philly_tracts_shootings$number_shootings): could not find function "pal"
```

To add a legend to this we use the function `addLegend()` which takes three parameters. `pal` asks which color palette we are using - we want it to be the exact same as we use to color the tracts so we'll use the *pal* object we made. The `values` parameter is used for which column our numeric values are from, in our case the *number_shootings* column so we'll input that. Finally `opacity` determines how transparent the legend will be. As each tract is set to not be transparent at all, we'll also set this to 1. 


```r
pal <- colorNumeric("OrRd", philly_tracts_shootings$number_shootings)
#> Error in colorNumeric("OrRd", philly_tracts_shootings$number_shootings): object 'philly_tracts_shootings' not found
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Tract ID: ", philly_tracts_shootings$GEOID10,
                             "<br>",
                             "Number of Shootings: ", philly_tracts_shootings$number_shootings),
              fillColor = pal(philly_tracts_shootings$number_shootings),
              fillOpacity = 1) %>%
  addLegend(pal = pal, 
            values = philly_tracts_shootings$number_shootings,
            opacity = 1)
#> Error in pal(philly_tracts_shootings$number_shootings): could not find function "pal"
```

Finally, we can add a title to the legend using the `title` parameter inside of `addLegend()`.


```r
pal <- colorNumeric("OrRd", philly_tracts_shootings$number_shootings)
#> Error in colorNumeric("OrRd", philly_tracts_shootings$number_shootings): object 'philly_tracts_shootings' not found
leaflet()  %>% 
  addTiles('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', 
           attribution = '&copy; <a href="http://openstreetmap.org">
                OpenStreetMap</a> contributors') %>%
  addPolygons(data = philly_tracts_shootings$geometry,
              col = "black",
              weight = 1,
              popup = paste0("Tract ID: ", philly_tracts_shootings$GEOID10,
                             "<br>",
                             "Number of Shootings: ", philly_tracts_shootings$number_shootings),
              fillColor = pal(philly_tracts_shootings$number_shootings),
              fillOpacity = 1) %>%
  addLegend(pal = pal, 
            values = philly_tracts_shootings$number_shootings,
            opacity = 1,
            title = "Police Shootings")
#> Error in pal(philly_tracts_shootings$number_shootings): could not find function "pal"
```
