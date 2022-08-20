perl fasta_split_certain_length.pl pUC19-HBV-pUC19.fa 60 > pUC19-HBV-pUC19.60.fa

cp Mus_musculus_c57bl6nj.C57BL_6NJ_v1.dna_sm.toplevel.fa \
Mus_musculus_c57bl6nj.C57BL_6NJ_v1.dna_sm.toplevel.pUC19-HBV-pUC19.fa

cat pUC19-HBV-pUC19.60.fa >> \
Mus_musculus_c57bl6nj.C57BL_6NJ_v1.dna_sm.toplevel.pUC19-HBV-pUC19.fa

bwa index  Mus_musculus_c57bl6nj.C57BL_6NJ_v1.dna_sm.toplevel.pUC19-HBV-pUC19.fa -p c57bl6_pUC19-HBV-pUC19

bwa mem -t 40 -o all.sam\
./c57bl6_pUC19-HBV-pUC19 \
/home/guanguiwen/data2/zengwanjia/c57bl6_pUC19-HBV-pUC19/L1EGF080745--HBVTGmiceZWJ.R1.raw.fastq.gz \
/home/guanguiwen/data2/zengwanjia/c57bl6_pUC19-HBV-pUC19/L1EGF080745--HBVTGmiceZWJ.R2.raw.fastq.gz

samtools view -bS -@ 40 all.sam > all.bam

sort -m 1G -@ 44 all.bam >all.sort.bam

samtools index all.sort.bam

samtools view -h all.sort.bam pUC19-HBV-pUC19 >all.sort.bam.HBV.sam

perl extract_sam_read_from_another_sam_by_name.pl all.sort.bam.HBV.sam all.sam \
> all.pUC19-HBV-pUC19.complete.sam

perl Complete_sam_for_bedtools.pl all.pUC19-HBV-pUC19.all.sam \
>all.pUC19-HBV-pUC19.all.complete.sam

bedtools bamtobed -bedpe -i all.pUC19-HBV-pUC19.all.complete.sam \
>all.pUC19-HBV-pUC19.all.complete.sam.bedpe

sort  -k 1,1 -k 4,4 -k 2n,2n -k 5n,5n all.pUC19-HBV-pUC19.all.complete.sam.bedpe \
>all.pUC19-HBV-pUC19.all.complete.sam.sort.bedpe


