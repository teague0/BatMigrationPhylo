#BCI Tree
library(ggtree)

treesfile <- "./data/trees/BCI/BCI Tree/output.nex"
bciTree <- ape::read.nexus(treesfile)
batDat <- read.csv("./data/vertLifeBats.csv")
fams <- batDat %>% dplyr::select(fam, Species_Name)

bciCons <- consensus(bciTree, p=1, check.labels = TRUE, rooted = TRUE)
names <- as.data.frame(bciCons$tip.label)
names <- names %>% left_join(fams, by = c("bciCons$tip.label" = "Species_Name"))
library(stringr)

bciCons$tip.label <- str_replace(bciCons$tip.label, "Mimon_crenulatum","Gardnernycteri_crenulatum") 
bciCons$tip.label <- str_replace(bciCons$tip.label, "Molossus_currentium","Molossus_bondae")
bciCons$tip.label <- str_replace(bciCons$tip.label, "_"," ")


bciCons$family <- names$fam
p <- ggtree(bciCons)+
  geom_tiplab(align=TRUE,size=2)+
  xlim(NA, 25)


edge=data.frame(bciCons$edge, edge_num=1:nrow(bciCons$edge))
colnames(edge)=c("parent", "node", "edge_num")
#p %<+% edge + geom_label(aes(x=branch, label=edge_num))

# Edges
# 4: Phyllostomidae
# 78: Mormoopidae
# 86: Noctilionidae
# 83: Thyropteridae
# 91: Molossidae
# 105: Vespertilionidae
# 120: Natalidae
# 121: Emballonuridae

p <- ggtree(bciCons)+
  geom_tiplab(align=TRUE,size=2)+
  xlim(NA, 30)
p+geom_cladelab(node=20, 
                 label="Natalidae",
                 offset=5.5, align=TRUE, size = 2)+
   geom_cladelab(node=82, 
               label="Phyllostomidae",
               color="red2", offset=5.5, align=TRUE)+
  geom_cladelab(node=121,
                label="Mormoopidae",
                offset=5.5, align=TRUE, size = 2)+
  geom_cladelab(node=125,
                label="Noctilionidae",
                offset=5.5, align=TRUE, size = 2)+
  geom_cladelab(node=124,
                label="Thyropteridae",
                offset=5.5, align=TRUE, size = 2)+
  geom_cladelab(node=128,
                label="Molossidae",
                offset=5.5, align=TRUE, size = 2)+
  geom_cladelab(node=132,
                label="Vespertilionidae",
                offset=5.5, align=TRUE, size = 2)+
  geom_cladelab(node=139, 
                label="Emballonuridae",
                offset=5.5, align=TRUE, size = 2)
ggsave("./BCI_PhylogenyTO_Vertlife Upham2019.pdf", width = 8, height = 10)  
  
  





