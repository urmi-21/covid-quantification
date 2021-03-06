import sys

with open('human_data/Sars_cov_2.ASM985889v3.cdna.all.fa') as f:
    data=f.read().splitlines()

for l in data:
    if '>' in l:
        #ENSSAST00005000002.1 cdna primary_assembly:ASM985889v3:MN908947.3:266:21555:1 gene:ENSSASG00005000002.1 gene_biotype:protein_coding transcript_biotype:protein_coding gene_symbol:ORF1ab description:ORF1a polyprotein;ORF1ab polyprotein [Source:NCBI gene (formerly Entrezgene);Acc:43740578]
        temp=l.split()
        gid=temp[0].split('.')[0].replace('>','')
        desc=l.split('description:')[1]
        chrloc='SARSCOV2_ASM985889v3'
        strand='1'
        gname='SarsCov2_'+l.split('gene_symbol:')[1].split()[0]
        gc='0'
        gtype='protein_coding'

        print ('\t'.join([gid,desc,chrloc,strand,gname,gc,gtype]))

