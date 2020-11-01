#!/bin/bash
# Created by the University of Melbourne job script generator for SLURM
# Tue Apr 02 2019 10:31:59 GMT+1100 (Australian Eastern Daylight Time)

# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

#array
#SBATCH --array=1-8

# The name of the job:
#SBATCH --job-name="Snippy_code"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

# Use this email address:
#SBATCH --mail-user=jmmans@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-0:59:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# The modules to load:
module load Snippy/4.3.6-intel-2017.u2

# delay - a decent delay
wt=$((${SLURM_ARRAY_TASK_ID} * 60))
sleep $wt

#  setting file name as strain name - stripping extension 
cd /data/cephfs/punim0599/Jesse/emm75/snippy/input/
ls | while read line; do
	if [[ "$line" == *"_1"* ]] ; then
		 var1=${line:0:-11}
			var2=${var1}_2.fastq.gz
fi

# troubleshooting variables used
echo $var1 
echo $var2
out="/data/cephfs/punim0599/Jesse/emm75/snippy/output/${var1}"
echo $out
spyo="/data/cephfs/punim0599/Jesse/emm75/Spartan_import/STAB14018.fasta"
echo $spyo
read1="/data/cephfs/punim0599/Jesse/emm75/snippy/input/${line}"
echo $read1
read2="/data/cephfs/punim0599/Jesse/emm75/snippy/input/${var2}"
echo $read2

# snippy actual code - why must it all be on one line Torsten? 
[[ -d "$out" ]] || snippy --cpus 8 --outdir $out --ref $spyo --R1 $read1 --R2 $read2 

done
