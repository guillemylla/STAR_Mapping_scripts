#!/bin/sh
#SBATCH --job-name=NAME    # Job name
#SBATCH --mail-type=ALL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=EMAIL     # Where to send mail	
#SBATCH -n 10                # Number of cores
#SBATCH -N 1                # Ensure that all cores are on one machine
#SBATCH -p serial_requeue   # Partition to submit to
#SBATCH --mem=60gb                     # Job memory request
#SBATCH --time=20:00:00               # Time limit hrs:min:sec
#SBATCH -o out_NAME_%j.log   # Standard output and error log
#SBATCH -e error_NAME_%j.err   # Standard output and error log

pwd; hostname; date


echo "load modules"

module load STAR/2.6.0c-fasrc01

indexname="INDEXEX GENOME DIR"
outputpath="OUTPUT DIR MUST EXIST"


echo "Start mapping"

cd "FASTQ DIRECTORY"

for R1 in $(find . -type f  -name "*_R1_001.fastq.gz")
do

    R2=`echo $R1 | sed 's/_R1_/_R2_/'`
    prebasename=`echo $R1 | sed 's/_.\+_L008_R1_001.fastq.gz//'`
    fname=$(basename $prebasename)



    printf "\n"
        echo Mapping:
	echo $R1
	echo "and"
	echo $R2   
        echo "Output base name:" $fname	
    printf "\n"
    
    STAR  --runThreadN $SLURM_NTASKS \
          --genomeDir $indexname \
          --readFilesIn $R1 $R2 \
          --readFilesCommand zcat\
          --outFileNamePrefix $outputpath/genomev01_$fname


    printf "\n"
    echo  Done with $fname 
    printf "\n"
done;


