#格式化HBV基因组，并追加到c57参考基因组中
perl fasta_split_certain_length.pl pUC19-HBV-pUC19.fa 60 > pUC19-HBV-pUC19.60.fa

cp Mus_musculus_c57bl6nj.C57BL_6NJ_v1.dna_sm.toplevel.fa \
Mus_musculus_c57bl6nj.C57BL_6NJ_v1.dna_sm.toplevel.pUC19-HBV-pUC19.fa

cat pUC19-HBV-pUC19.60.fa >> \
Mus_musculus_c57bl6nj.C57BL_6NJ_v1.dna_sm.toplevel.pUC19-HBV-pUC19.fa


#对HBV_c57混合基因组建立bwa的index
bwa index  Mus_musculus_c57bl6nj.C57BL_6NJ_v1.dna_sm.toplevel.pUC19-HBV-pUC19.fa -p c57bl6_pUC19-HBV-pUC19

#序列比对及排序
bwa mem -t 40 -o all.sam\
./c57bl6_pUC19-HBV-pUC19 \
/home/guanguiwen/data2/zengwanjia/c57bl6_pUC19-HBV-pUC19/L1EGF080745--HBVTGmiceZWJ.R1.raw.fastq.gz \
/home/guanguiwen/data2/zengwanjia/c57bl6_pUC19-HBV-pUC19/L1EGF080745--HBVTGmiceZWJ.R2.raw.fastq.gz

samtools view -bS -@ 40 all.sam > all.bam

sort -m 1G -@ 44 all.bam >all.sort.bam

samtools index all.sort.bam

#提取HBV序列
samtools view -h all.sort.bam pUC19-HBV-pUC19 >all.sort.bam.HBV.sam

#通过脚本提取带有HBV整合的全部比对信息
perl extract_sam_read_from_another_sam_by_name.pl all.sort.bam.HBV.sam all.sam \
> all.pUC19-HBV-pUC19.complete.sam

#给补充匹配结果填补配对read信息，以达到bedtools软件的要求
perl Complete_sam_for_bedtools.pl all.pUC19-HBV-pUC19.all.sam \
>all.pUC19-HBV-pUC19.all.complete.sam

#sam 文件转bedpe格式
bedtools bamtobed -bedpe -i all.pUC19-HBV-pUC19.all.complete.sam \
>all.pUC19-HBV-pUC19.all.complete.sam.bedpe

#结果排序
sort  -k 1,1 -k 4,4 -k 2n,2n -k 5n,5n all.pUC19-HBV-pUC19.all.complete.sam.bedpe \
>all.pUC19-HBV-pUC19.all.complete.sam.sort.bedpe


