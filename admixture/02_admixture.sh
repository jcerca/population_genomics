ml ADMIXTURE/1.3.0

input=/cluster/projects/nn9449k/cerca/012_Iago_Radseq/03_PopGenAnalysis/03_Admixture/01_OnlyIago/01_convertFile/admixture.input.bed


for i in 2 3 4 5 6; do

K=${i}

echo "This is my K for today = $i"

cd K$i

mkdir run1 run2 run3 run4 run5

cd run1
admixture --cv $input $K -j4 | tee log
cd ..

cd run2
admixture --cv $input $K -j4 | tee log
cd ..

cd run3
admixture --cv $input $K -j4 | tee log
cd ..

cd run4
admixture --cv $input $K -j4 | tee log
cd ..

cd run5
admixture --cv $input $K -j4 | tee log
cd ..

cd ..
done
