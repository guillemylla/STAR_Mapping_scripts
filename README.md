# Scripts for mapping RNA-seq datasets in bulk and generate mapping stats report
---

Guillem Ylla

January 2019

---
**Run_batch_STAR_cluster.sbatch** Script to map RNA-seq data to genomes in bulk using STAR on a cluster.

**STAR_report.py** Script to obtain a tabulated file with the number and percentage of mapped reads from each sample from the STAR log files. It also works with RSEM+STAR output if intermediate files are saved.
    
## Re-scaffolding gryllus genome using PE RNA-seq data

There are several programs for using RNA-seq data in order to improve the genome assembly quality using RNA-seq data.

One of the most recent softwares published for this purpose is the "P_RNA_scaffolding". 

Ideally, it is used for scaffolding the contigs, but I'm going to try to use it for fixing the current assembly. I=The old version of this program (that uses SE RNA-seq) has been nused for the same purpose in some good genome publication.

For this trial I will used the RNA-seq data from the embryo development experiment (although few reads ant not of great quality).

The software ocumentation can be found at http://www.fishbrowser.org/software/P_RNA_scaffolder/index.php/Home/Index/Documentation.html


### Pipeline

1- Indexgenome with HISAT

```
srun -p test --pty --mem 20gb -n 4 -N 1 -t 0-06:00 /bin/bash

module load hisat2/2.1.0-fasrc01 

cd /n/regal/extavour_lab/gylla/Rescaffold_gryllus_v0/genomes/Gbimaculatus_V1.0.1

hisat2-build -p 4  Gbimaculatus.genome.v1.0.1.fa hisat2index


#V1.0.1
cd /n/regal/extavour_lab/gylla/Rescaffold_gryllus_v0/genomes/Gbimaculatus_V1.0.1
hisat2-build -p 4  Gbimaculatus.genome.v1.0.1.fa hisat2index

#V1.0
cd 
hisat2-build -p 4   hisat2index



```

2- Join all R1 and all R2 reads in 2 files.

```
srun -p test --pty --mem 20gb -n 4 -N 1 -t 0-06:00 /bin/bash

cd fastq  # I do not copy all files, I directly concatenate R1 and R1

zcat /n/regal/extavour_lab/gylla/Gryllus_Embryo_Map_v0/fastqs/*R1_001.fastq.gz > EmbryoDev_R1.fastq 
zcat /n/regal/extavour_lab/gylla/Gryllus_Embryo_Map_v0/fastqs/*R2_001.fastq.gz > EmbryoDev_R2.fastq



 
```

