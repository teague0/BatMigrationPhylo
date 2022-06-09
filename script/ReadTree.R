library(ape)
library(dplyr)

treesfile <- "./data/trees/Bat Pruned Vertlife Trees/output.nex"
bats <- ape::read.nexus(treesfile)
batDat <- read.csv("./data/vertLifeBats.csv")
fams <- batDat %>% dplyr::select(fam, Species_Name)


oneBat <- consensus(bats, p=1, check.labels = TRUE, rooted = TRUE)
names <- as.data.frame(oneBat$tip.label)
names <- names %>% left_join(fams, by = c("oneBat$tip.label" = "Species_Name"))

oneBat$family <- names$fam

plot(oneBat, cex = 0.8)

library(ggtree)
ggtree(oneBat)
