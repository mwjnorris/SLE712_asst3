#!/bin/bash


#format a blast db
formatdb -p F -o T -i Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa

#for loop nucleotide number of mismatches
for i in $(seq 50 50 750); do

#printing i
echo $i

#for loop 
for ((k=1; k<101; k++)) ; do

#incorporate mismatches
msbar -sequence 2.fa -count $i -point 4 -block 0 -codon 0 -outseq mysample_mutated.fa 

blast2 -p blastn -e 0.001 -m 8 -d Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa -i mysample_mutated.fa | grep "AAC76901" | head -1 | wc -l 
done | numaverage
done > res.txt

#formating output
paste - - < res.txt 
