## examining Admixture data ##
rm(list = ls())

library(tidyverse)
library(gridExtra)

setwd("C:/Users/Cerca/Desktop/tmp/admixtureSparrows/03_allData/")

#we need the ind.species.pop.tsv file which is a "awk-modified" file from plink.fam
#the .Q files (they contain admixture proportions)
#the cv_error file :-)

# first read in and examine cross-validation error
cv_error<- tbl_df(read.table("./cv_error_formated.tsv", sep="\t", header=T))

# read in individual data
myData <- tbl_df(read.table("./individuals_populations_species.tsv", col.names = c("ind","species","site")))
#The ind.pop.species was created with a custom awk script based on the .fam file

# plot
a <- ggplot(cv_error, aes(K, error))+ geom_point() + geom_line()
a + ylab("Cross-valudation error") + theme_light()

## K2
# set up the dataset
K2 <- tbl_df(read.table("./admixture.input.2.Q",
                        col.names = c("one", "two")))
# add individuals
K2 <- mutate(K2, ind = myData$ind, species = myData$species, site = myData$site)
# gather to plot
K2 <- gather(K2, key = cluster, value = q, -ind, -site, -species)


## K3
# set up the dataset
K3 <- tbl_df(read.table("./admixture.input.3.Q",
                        col.names = c("one", "two", "three")))

# add individuals
K3 <- mutate(K3, ind = myData$ind, species = myData$species, site = myData$site)
# gather to plot
K3 <- gather(K3, key = cluster, value = q, -ind, -site, -species)


## K4
# set up the dataset
K4 <- tbl_df(read.table("./admixture.input.4.Q",
                        col.names = c("one", "two", "three", "four")))

# add individuals
K4 <- mutate(K4, ind = myData$ind, species = myData$species, site = myData$site)
# gather to plot
K4 <- gather(K4, key = cluster, value = q, -ind, -site, -species)


## K5
# set up the dataset
K5 <- tbl_df(read.table("./admixture.input.5.Q",
                        col.names = c("one", "two", "three", "four", "five")))
# add individuals
K5 <- mutate(K5, ind = myData$ind, species = myData$species, site = myData$site)
# gather to plot
K5 <- gather(K5, key = cluster, value = q, -ind, -site, -species)


##K6
# set up the dataset
K6 <- tbl_df(read.table("./admixture.input.6.Q",
                        col.names = c("one", "two", "three", "four", "five","six")))
# add individuals
K6 <- mutate(K6, ind = myData$ind, species = myData$species, site = myData$site)
# gather to plot
K6 <- gather(K6, key = cluster, value = q, -ind, -site, -species)

##K7
# set up the dataset
K7 <- tbl_df(read.table("./admixture.input.7.Q",
                        col.names = c("one", "two", "three", "four", "five","six","seven")))
# add individuals
K7 <- mutate(K7, ind = myData$ind, species = myData$species, site = myData$site)
# gather to plot
K7 <- gather(K7, key = cluster, value = q, -ind, -site, -species)

##K8
# set up the dataset
K8 <- tbl_df(read.table("./admixture.input.8.Q",
                        col.names = c("one", "two", "three", "four", "five","six","seven","eight")))
# add individuals
K8 <- mutate(K8, ind = myData$ind, species = myData$species, site = myData$site)
# gather to plot
K8 <- gather(K8, key = cluster, value = q, -ind, -site, -species)

##K9
# set up the dataset
K9 <- tbl_df(read.table("./admixture.input.9.Q",
                        col.names = c("one", "two", "three", "four", "five","six","seven","eight","nine")))
# add individuals
K9 <- mutate(K9, ind = myData$ind, species = myData$species, site = myData$site)
# gather to plot
K9 <- gather(K9, key = cluster, value = q, -ind, -site, -species)

##K10
# set up the dataset
K10 <- tbl_df(read.table("./admixture.input.10.Q",
                        col.names = c("one", "two", "three", "four", "five","six","seven","eight","nine","ten")))
# add individuals
K10 <- mutate(K10, ind = myData$ind, species = myData$species, site = myData$site)
# gather to plot
K10 <- gather(K10, key = cluster, value = q, -ind, -site, -species)

##K11
# set up the dataset
K11 <- tbl_df(read.table("./admixture.input.11.Q",
                        col.names = c("one", "two", "three", "four", "five","six","seven","eight","nine","ten","eleven")))
# add individuals
K11 <- mutate(K11, ind = myData$ind, species = myData$species, site = myData$site)
# gather to plot
K11 <- gather(K11, key = cluster, value = q, -ind, -site, -species)

##K12
# set up the dataset
K12 <- tbl_df(read.table("./admixture.input.12.Q",
                        col.names = c("one", "two", "three", "four", "five","six","seven","eight","nine","ten","eleven","twelve")))
# add individuals
K12 <- mutate(K12, ind = myData$ind, species = myData$species, site = myData$site)
# gather to plot
K12 <- gather(K12, key = cluster, value = q, -ind, -site, -species)

##K6
# set up the dataset
K13 <- tbl_df(read.table("./admixture.input.13.Q",
                        col.names = c("one", "two", "three", "four", "five","six","seven","eight","nine","ten","eleven","twelve","thirteen")))
# add individuals
K13 <- mutate(K13, ind = myData$ind, species = myData$species, site = myData$site)
# gather to plot
K13 <- gather(K13, key = cluster, value = q, -ind, -site, -species)

# set colour palettes
k2_cols <- c("dodgerblue", "firebrick1")
k3_cols <- c("dodgerblue", "forestgreen",  "firebrick1")
k4_cols <- c("dodgerblue", "forestgreen",  "firebrick1", "gold")
k5_cols <- c("dodgerblue", "forestgreen",  "firebrick1", "gold", "darkorchid")
k6_cols <- c("dodgerblue", "forestgreen",  "firebrick1", "gold", "darkorchid", "grey66")
k7_cols <- hcl.colors(7, palette="Dark 2")
k8_cols <- hcl.colors(8, palette="Dark 2")
k9_cols <- hcl.colors(9, palette="Dark 2")
k10_cols <- hcl.colors(10, palette="Dark 2")
k11_cols <- hcl.colors(11, palette="Dark 2")
k12_cols <- hcl.colors(12, palette="Dark 2")
k13_cols <- hcl.colors(13, palette="Dark 2")

k3_cols <- c("#9ACD31",
             "#1D90FF",
             "#FF8001")
             
             
# K2 - by species
c <- ggplot(K2, aes(as.character(ind), q, fill = cluster)) + geom_bar(stat = "identity")
c <- c + scale_fill_manual(values = k2_cols)
c <- c + xlab(NULL) + ylab("Ancestry") + scale_y_continuous(limits = c(0,1.01), expand = c(0, 0))
c <- c + facet_wrap(~species, scales = "free_x")
c <- c + theme_light() + theme(legend.position = "none",
                               panel.border = element_blank(),
                               panel.grid = element_blank(),
                               axis.text.y = element_text(size = 10),
                               axis.text.x = element_text(size = 6, angle = 90),
                               axis.ticks.x = element_blank(),
                               strip.text.x = element_text(colour = "black", face = "bold"),
                               strip.background = element_rect(colour = "black", fill = "white"))
c

# K3 - by species
d <- ggplot(K3, aes(ind, q, fill = cluster)) + geom_bar(stat = "identity")
d <- d + scale_fill_manual(values = k3_cols)
d <- d + xlab(NULL) + ylab("Ancestry") + scale_y_continuous(limits = c(0,1.01), expand = c(0, 0))
d <- d + facet_wrap(~species, scales = "free_x")
d <- d + theme_light() + theme(legend.position = "none",
                               panel.border = element_blank(),
                               panel.grid = element_blank(),
                               axis.text.y = element_text(size = 10),
                               axis.text.x = element_text(size = 6, angle = 90),
                               axis.ticks.x = element_blank(),
                               strip.text.x = element_text(colour = "black", face = "bold"),
                               strip.background = element_rect(colour = "black", fill = "white"))
d

# K4 - by species
e <- ggplot(K4, aes(ind, q, fill = cluster)) + geom_bar(stat = "identity")
e <- e + scale_fill_manual(values = k4_cols)
e <- e + xlab(NULL) + ylab("Ancestry") + scale_y_continuous(limits = c(0,1.01), expand = c(0, 0))
e <- e + facet_wrap(~species, scales = "free_x")
e <- e + theme_light() + theme(legend.position = "none",
                               panel.border = element_blank(),
                               panel.grid = element_blank(),
                               axis.text.y = element_text(size = 10),
                               axis.text.x = element_text(size = 6, angle = 90),
                               axis.ticks.x = element_blank(),
                               strip.text.x = element_text(colour = "black", face = "bold"),
                               strip.background = element_rect(colour = "black", fill = "white"))
e


# K5 - by species
f <- ggplot(K5, aes(ind, q, fill = cluster)) + geom_bar(stat = "identity")
f <- f + scale_fill_manual(values = k5_cols)
f <- f + xlab(NULL) + ylab("Ancestry") + scale_y_continuous(limits = c(0,1.01), expand = c(0, 0))
f <- f + facet_wrap(~species, scales = "free_x")
f <- f + theme_light() + theme(legend.position = "none",
                               panel.border = element_blank(),
                               panel.grid = element_blank(),
                               axis.text.y = element_text(size = 10),
                               axis.text.x = element_text(size = 6, angle = 90),
                               axis.ticks.x = element_blank(),
                               strip.text.x = element_text(colour = "black", face = "bold"),
                               strip.background = element_rect(colour = "black", fill = "white"))
f

# K6 - by species
g <- ggplot(K6, aes(ind, q, fill = cluster)) + geom_bar(stat = "identity")
g <- g + scale_fill_manual(values = k6_cols)
g <- g + xlab(NULL) + ylab("Ancestry") + scale_y_continuous(limits = c(0,1.01), expand = c(0, 0))
g <- g + facet_wrap(~species, scales = "free_x")
g <- g + theme_light() + theme(legend.position = "none",
                               panel.border = element_blank(),
                               panel.grid = element_blank(),
                               axis.text.y = element_text(size = 10),
                               axis.text.x = element_text(size = 6, angle = 90),
                               axis.ticks.x = element_blank(),
                               strip.text.x = element_text(colour = "black", face = "bold"),
                               strip.background = element_rect(colour = "black", fill = "white"))
g

# K7 - by species
h <- ggplot(K7, aes(ind, q, fill = cluster)) + geom_bar(stat = "identity")
h <- h + scale_fill_manual(values = k7_cols)
h <- h + xlab(NULL) + ylab("Ancestry") + scale_y_continuous(limits = c(0,1.01), expand = c(0, 0))
h <- h + facet_wrap(~species, scales = "free_x")
h <- h + theme_light() + theme(legend.position = "none",
                               panel.border = element_blank(),
                               panel.grid = element_blank(),
                               axis.text.y = element_text(size = 10),
                               axis.text.x = element_text(size = 6, angle = 90),
                               axis.ticks.x = element_blank(),
                               strip.text.x = element_text(colour = "black", face = "bold"),
                               strip.background = element_rect(colour = "black", fill = "white"))
h

# K8 - by species
i <- ggplot(K8, aes(ind, q, fill = cluster)) + geom_bar(stat = "identity")
i <- i + scale_fill_manual(values = k8_cols)
i <- i + xlab(NULL) + ylab("Ancestry") + scale_y_continuous(limits = c(0,1.01), expand = c(0, 0))
i <- i + facet_wrap(~species, scales = "free_x")
i <- i + theme_light() + theme(legend.position = "none",
                               panel.border = element_blank(),
                               panel.grid = element_blank(),
                               axis.text.y = element_text(size = 10),
                               axis.text.x = element_text(size = 6, angle = 90),
                               axis.ticks.x = element_blank(),
                               strip.text.x = element_text(colour = "black", face = "bold"),
                               strip.background = element_rect(colour = "black", fill = "white"))
i

# K9 - by species
j <- ggplot(K9, aes(ind, q, fill = cluster)) + geom_bar(stat = "identity")
j <- j + scale_fill_manual(values = k9_cols)
j <- j + xlab(NULL) + ylab("Ancestry") + scale_y_continuous(limits = c(0,1.01), expand = c(0, 0))
j <- j + facet_wrap(~species, scales = "free_x")
j <- j + theme_light() + theme(legend.position = "none",
                               panel.border = element_blank(),
                               panel.grid = element_blank(),
                               axis.text.y = element_text(size = 10),
                               axis.text.x = element_text(size = 6, angle = 90),
                               axis.ticks.x = element_blank(),
                               strip.text.x = element_text(colour = "black", face = "bold"),
                               strip.background = element_rect(colour = "black", fill = "white"))
j

# K10 - by species
l <- ggplot(K10, aes(ind, q, fill = cluster)) + geom_bar(stat = "identity")
l <- l + scale_fill_manual(values = k10_cols)
l <- l + xlab(NULL) + ylab("Ancestry") + scale_y_continuous(limits = c(0,1.01), expand = c(0, 0))
l <- l + facet_wrap(~species, scales = "free_x")
l <- l + theme_light() + theme(legend.position = "none",
                               panel.border = element_blank(),
                               panel.grid = element_blank(),
                               axis.text.y = element_text(size = 10),
                               axis.text.x = element_text(size = 6, angle = 90),
                               axis.ticks.x = element_blank(),
                               strip.text.x = element_text(colour = "black", face = "bold"),
                               strip.background = element_rect(colour = "black", fill = "white"))
l

# K11 - by species
m <- ggplot(K11, aes(ind, q, fill = cluster)) + geom_bar(stat = "identity")
m <- m + scale_fill_manual(values = k11_cols)
m <- m + xlab(NULL) + ylab("Ancestry") + scale_y_continuous(limits = c(0,1.01), expand = c(0, 0))
m <- m + facet_wrap(~species, scales = "free_x")
m <- m + theme_light() + theme(legend.position = "none",
                               panel.border = element_blank(),
                               panel.grid = element_blank(),
                               axis.text.y = element_text(size = 10),
                               axis.text.x = element_text(size = 6, angle = 90),
                               axis.ticks.x = element_blank(),
                               strip.text.x = element_text(colour = "black", face = "bold"),
                               strip.background = element_rect(colour = "black", fill = "white"))
m


n

# K13 - by species
o <- ggplot(K13, aes(ind, q, fill = cluster)) + geom_bar(stat = "identity")
o <- o + scale_fill_manual(values = k13_cols)
o <- o + xlab(NULL) + ylab("Ancestry") + scale_y_continuous(limits = c(0,1.01), expand = c(0, 0))
o <- o + facet_wrap(~species, scales = "free_x")
o <- o + theme_light() + theme(legend.position = "none",
                               panel.border = element_blank(),
                               panel.grid = element_blank(),
                               axis.text.y = element_text(size = 10),
                               axis.text.x = element_text(size = 6, angle = 90),
                               axis.ticks.x = element_blank(),
                               strip.text.x = element_text(colour = "black", face = "bold"),
                               strip.background = element_rect(colour = "black", fill = "white"))
o


pdf(file="all_species.pdf")
c
d
e
f
g
h
i
j
l
m
n
o
dev.off()
######
grid.arrange(b + theme(axis.text.x = element_blank(),
                       axis.ticks.x = element_blank()),
             d + theme(axis.text.x = element_blank(),
                       axis.ticks.x = element_blank()))
