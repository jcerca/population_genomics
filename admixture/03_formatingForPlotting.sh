###F irst, we create a file consisting of:
# <indivdual><tab><species><population>
# In this dataset it looks like this..
awk '{print $1}' ../01_convertFile/admixture.input.fam | awk -F "_" '{print $0 "\t" $1 "\t" $2}' > individuals_populations_species.tsv

### Next, we need the cv_errors to plot.
cat ../02_admixture/K*/run*/log | grep "CV error" > cv_error.tsv
