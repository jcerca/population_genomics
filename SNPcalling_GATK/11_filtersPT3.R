setwd("C:/Users/Cerca/Desktop/tmp")

library(tidyverse)

# Decision - 30 phred score
# Decision - trimming coverage below 5 and above 25
# Decision - cutting sites with more than 25% missing data
# Decision - cutting sites with more than 0.02 MAF (3 alleles)
# Decision - maybe remove T-kamakou 009 (2x average coverage?)

######################################
########### Variant Quality ##########
######################################


var_qual <- read_delim("./tetragnatha_subset.lqual", delim = "\t",
                       col_names = c("chr", "pos", "qual"), skip = 1)

a <- ggplot(var_qual, aes(qual)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a +
  theme_light() +
  xlim(0, 1500) +
  geom_vline(xintercept=30, linetype="dashed", color = "orangered")


print("Decision - 30 phred score")
## quality 30 (phred score represents 1 in a 1000 chance that the SNP is wrong.) The majority of our data is high quality
# :))))


######################################
############# Mean depth #############
######################################

var_depth <- read_delim("./tetragnatha_subset.ldepth.mean", delim = "\t",
                        col_names = c("chr", "pos", "mean_depth", "var_depth"), skip = 1)

a <- ggplot(var_depth, aes(mean_depth)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a +
  theme_light() +
  xlim(0, 25) +
  geom_vline(xintercept=2, linetype="dashed", color = "orangered") +
  geom_vline(xintercept=5, linetype="dashed", color = "orangered")

summary(var_depth$mean_depth)



######################################
######## Variant missingness #########
######################################
var_miss <- read_delim("./tetragnatha_subset.lmiss", delim = "\t",
                       col_names = c("chr", "pos", "nchr", "nfiltered", "nmiss", "fmiss"), skip = 1)

a <- ggplot(var_miss, aes(fmiss)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a +
  theme_light() +
  geom_vline(xintercept=0.25, linetype="dashed", color = "orangered")

summary(var_miss$fmiss)

######################################
####### Minor Allele Frequency #######
######################################


var_freq <- read_delim("./tetragnatha_subset.frq", delim = "\t",
                       col_names = c("chr", "pos", "nalleles", "nchr", "a1", "a2"), skip = 1)

var_freq$maf <- var_freq %>% select(a1, a2) %>% apply(1, function(z) min(z))

a <- ggplot(var_freq, aes(maf)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a +
  theme_light() +
  geom_vline(xintercept=0.05, linetype="dashed", color = "orangered") +
  geom_vline(xintercept=0.02, linetype="dashed", color = "orangered")


summary(var_freq$maf)


######################################
######## Mean depth per ind ##########
######################################

ind_depth <- read_delim("./tetragnatha_subset.idepth", delim = "\t",
                        col_names = c("ind", "nsites", "depth"), skip = 1)


a <- ggplot(ind_depth, aes(depth)) + geom_histogram(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a +
  theme_light() +
  geom_density()

# We will need to remove 1 individual with 2x coverage..


######################################
####### Mean missing per ind #########
######################################

ind_miss  <- read_delim("./tetragnatha_subset.imiss", delim = "\t",
                        col_names = c("ind", "ndata", "nfiltered", "nmiss", "fmiss"), skip = 1)

a <- ggplot(ind_miss, aes(fmiss)) + geom_histogram(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a + theme_light()

# No big outliers!


######################################
### Heterozygosity inbreeding coef ###
######################################


ind_het <- read_delim("./tetragnatha_subset.het", delim = "\t",
                      col_names = c("ind","ho", "he", "nsites", "f"), skip = 1)

a <- ggplot(ind_het, aes(f)) + geom_histogram(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a + theme_light()
