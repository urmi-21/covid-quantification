#!/bin/bash
set -e

mkdir -p human_data
cd human_data

echo "[1] Downloading Transcriptome"
#download human transcriptome
wget -q ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_36/gencode.v36.transcripts.fa.gz
#human genome
echo "[2] Downloading Genome"
wget -q ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for_alignment_pipelines.ucsc_ids/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz

#download covid seq
echo "[3] SARS-CoV-2 Genome/Transcriptome"

#wget -q ftp://ftp.ensemblgenomes.org/pub/viruses/fasta/sars_cov_2/dna/Sars_cov_2.ASM985889v3.dna.toplevel.fa.gz

wget -q ftp://ftp.ensemblgenomes.org/pub/viruses/fasta/sars_cov_2/cdna/Sars_cov_2.ASM985889v3.cdna.all.fa.gz


echo "[4] Unzipping"
gunzip -f *.gz

echo "[5] Creating decoys"
#create decoy list
grep ">" GCA_000001405.15_GRCh38_no_alt_analysis_set.fna | cut -d " " -f 1 | tr -d ">" > decoys.txt
#grep ">" Sars_cov_2.ASM985889v3.dna.toplevel.fa | cut -d " " -f 1 | tr -d ">" >> decoys.txt

#combine transcriptome and decoy fasta files
#cat gencode.v36.transcripts.fa Sars_cov_2.ASM985889v3.cdna.all.fa GCA_000001405.15_GRCh38_no_alt_analysis_set.fna Sars_cov_2.ASM985889v3.dna.toplevel.fa > human_tr_gen_decoy.fasta
cat gencode.v36.transcripts.fa Sars_cov_2.ASM985889v3.cdna.all.fa GCA_000001405.15_GRCh38_no_alt_analysis_set.fna > human_tr_gen_decoy.fasta

echo "[6] Cleanup"
#cleanup
rm gencode.v36.transcripts.fa GCA_000001405.15_GRCh38_no_alt_analysis_set.fna 

#echo "[7] Creating Salmon index (this can take several minutes)"
#create salmon index
time salmon index -t human_tr_gen_decoy.fasta -d decoys.txt -p 15 -i salmon_index

echo "[7] Done"
