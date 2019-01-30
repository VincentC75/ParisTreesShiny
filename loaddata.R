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
dftrees$latitude <- as.numeric(dftrees1$coord1)
dftrees$longitude <- as.numeric(dftrees1$coord2)
dftrees$height <- as.numeric(dftrees$HAUTEUR..m.)
dftrees[dftrees$height > 30,]$height <- 0
dftrees$geo_point_2d <- NULL
dftrees$HAUTEUR..m. <- NULL
rm(dftrees1)

save(dftrees,file="dftrees_all.Rda")

dftrees <- dftrees %>% 
  filter(REMARQUABLE == 1)
#%>%
#  select(LIBELLEFRANCAIS,lat,lon)

save(dftrees,file="dftrees_filtered.Rda")
