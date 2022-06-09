
vertlife <- read.csv("~/ownCloud/projects/bat migration phylogeny/vertlife_taxonomies.csv")
all <- read.csv("~/ownCloud/projects/bat migration phylogeny/taxonomy_mamPhy_5911species.csv")

library(dplyr)
library(stringr)

vMamms <- vertlife %>% filter(group == "Mammals")
bats <- all %>% filter(ord == "CHIROPTERA")

vMamms$Species_Name <- vMamms$scientificname
vMamms$Species_Name <- str_replace(vMamms$Species_Name," ", "_")

tot <- vMamms %>% left_join(bats)

chiro <- tot %>% filter(ord == "CHIROPTERA")
write.csv(chiro, file = "~/ownCloud/projects/bat migration phylogeny/vertLifeBats.csv", row.names = FALSE)
