# Load data
library(dplyr)

# Original dataset available here ; https://opendata.paris.fr/explore/dataset/les-arbres

if (!file.exists("les-arbres.csv")) {
  download.file("https://opendata.paris.fr/explore/dataset/les-arbres/download/?format=csv&timezone=Europe/Berlin&use_labels_for_header=true", destfile = "les-arbres.csv")
}


dftrees <- read.csv2("les-arbres.csv", stringsAsFactors = FALSE) 
dftrees1 <- data.frame(do.call(rbind, lapply(strsplit(dftrees$geo_point_2d,','), 
                                             function(x) {c(
                                               coord = x
                                             )})),stringsAsFactors=FALSE)
dftrees$lat <- as.numeric(dftrees1$coord1)
dftrees$lon <- as.numeric(dftrees1$coord2)
dftrees$geo_point_2d <- NULL
rm(dftrees1)

dftrees <- dftrees %>% 
  filter(REMARQUABLE == 1)
#%>%
#  select(LIBELLEFRANCAIS,lat,lon)

save(dftrees,file="dftrees_filtered.Rda")
