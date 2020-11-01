#!/bin/bash
# Created by the University of Melbourne job script generator for SLURM
# Tue Apr 02 2019 10:31:59 GMT+1100 (Australian Eastern Daylight Time)

# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="Shovill"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8

# Use this email address:
#SBATCH --mail-user=jmmans@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-0:15:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# needed modules
module load shovill/1.0.4-spartan_intel-2017.u2

# setting files name
cd /data/cephfs/punim0599/Jesse/emm75/fastqs/ 
ls | while read line; do
		 var1=${line:0:-10}
			var2=${var1}2.fastq.gz

# variables used 
out="/data/cephfs/punim0599/Jesse/emm75/contigs/"
read1="/data/cephfs/punim0599/Jesse/emm75/fastqs/${line}"
read2="/data/cephfs/punim0599/Jesse/emm75/fastqs/${var2}"

# shovill actual code - why must it all be on one line Torsten? 
shovill --outdir $out --R1 $read1 --R2 $read2  

done
