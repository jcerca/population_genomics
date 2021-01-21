#ml R/3.6.2-fosscuda-2019b
#R

# ld decay binning and plotting
rm(list = ls())

library(readr)
library(dplyr)
library(getopt)

# specify command line options
spec <- matrix(c(
  'infile', 'i', 1, 'character', 'specify path to input files',
  'outfile', 'o', 1, 'character', 'specify path to output file'), ncol = 5, byrow = T)

# set command line options
opt = getopt(spec)

# show help if asked for
if (!is.null(opt$help)) {
  cat(paste(getopt(spec, usage=T),"\n"));
  q();
}

# set variables for call
infile <- opt$infile
outfile <- opt$outfile



myData <- read_table2("ld.tetragnatha.tsv", skip = 1, col_names = F)

# rename
colnames(myData) <- c("R2","dist")

# create breaks, labels etc
#The following lines do not work because the dataset is too big. So(see ahead)
#The longest scaffold has 5,861,297 bp ... so max will can be 5862000
max(myData$dist)
100000
breaks <- seq(0, 100000, 1000)
labels <- seq(0, 100000-1000, 1000)

# bin here
myData$dist_bin <- cut(myData$dist, breaks = breaks, labels = labels)



# mean R2 per bin
bin_data <- myData %>% group_by(dist_bin) %>% summarise(mean_R2 = mean(R2))

write.csv(bin_data, "bin_data.forplotting.tsv", quote = F, row.names = F)


library(tidyverse)

#plot
pdf("tetragnatha_LD.pdf",width=6,height=4,paper='special')
ggplot(bin_data, aes(dist_bin, mean_R2)) + geom_point()
ggplot(bin_data, aes(dist_bin, mean_R2, group=1)) + geom_line()
dev.off()
