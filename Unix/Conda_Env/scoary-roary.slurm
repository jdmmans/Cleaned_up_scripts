#!/bin/bash

# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="Scoary"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-1:00:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# modules
module load Miniconda3
source activate scoary

# paths to dependencies 
csvpath="/data/cephfs/punim0599/Jesse/emm75/roary/90/gene_presence_absence.csv"
traits="/data/cephfs/punim0599/Jesse/emm75/traits-altered.csv"

# correct drive
mkdir /data/cephfs/punim0599/Jesse/emm75/scoary/edited
cd /data/cephfs/punim0599/Jesse/emm75/scoary/edited

### need to use pip install scoary and have a custom python install via conda before running script 

#work
scoary -g ${csvpath} -t ${traits}

done
