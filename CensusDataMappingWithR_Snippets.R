
#####
##Accessing and mapping data from the US Census Bureau API and exporting associated SHP and KML files
##Census API info https://cran.r-project.org/web/packages/censusapi/vignettes/getting-started.html
#####


#####
##Below following https://rpubs.com/DanielSLee/censusMap (great guidance!)
##To select and map the data
#####
#install.packages(c("tidycensus","tidyverse","sf","mapview"))
library(tidycensus)
library(tidyverse)
library(sf)
library(mapview)

##Get US Census Bureau API key (https://api.census.gov/data/key_signup.html) and fill in below ('key=""')
census_api_key(key="")

##Get dataset with geometry set to TRUE
MedianHomeValue_Tract <- get_acs(geography = "tract", state = c("AK", "AL", "AR"), #Haven't tried with all states - if doesn't work, will try https://mattherman.info/blog/tidycensus-mult/
                    #county = c("Anchorage"), 	#Within individual states, can select counties, etc
                    variable = "B25077_001", 	#Full list of tables available at https://www.census.gov/programs-surveys/acs/technical-documentation/table-shells.html
                    geometry = TRUE)		#Page with guidance for including multiple variables and years: https://www.jtimm.net/2018/03/29/historical-socio-demographic-profiles/  

MedianHomeValue_ZCTA <- get_acs(geography = "zcta", #I think no state selection option
                    variable = "B25077_001", 	#Full list of tables available at https://www.census.gov/programs-surveys/acs/technical-documentation/table-shells.html
                    geometry = TRUE)		#Page with guidance for including multiple variables and years: https://www.jtimm.net/2018/03/29/historical-socio-demographic-profiles/  

##Plot the estimate to view a map of the data
##This may not work well for multiple states or nationwide at once
#plot(MedianHomeValue_ZCTA["estimate"])

##Map the dataset interactively
##This may not work well for multiple states or nationwide at once
#mapview(MedianHomeValue_ZCTA)

##Map the dataset interactively by the estimate column
##This may not work well for multiple states or nationwide at once
#mapView(MedianHomeValue_ZCTA, zcol = "estimate")
#####


#####
##Below following https://mgimond.github.io/Spatial/reading-and-writing-spatial-data-in-r.html (also great guidance!)
##To export SHP and KML files
#####
st_write(MedianHomeValue_ZCTA, "C:/Users/ehunsing/Desktop/MedianHomeValue_ZCTA.kml", driver="kml")  			#export to a kml
st_write(MedianHomeValue_ZCTA, "C:/Users/ehunsing/Desktop/MedianHomeValue_ZCTA.shp", driver="ESRI Shapefile") 		#export to a shapefile 

