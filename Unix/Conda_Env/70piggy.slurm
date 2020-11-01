#!/bin/bash

# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="Piggy"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-3:00:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# dependencies
module load Miniconda3
source activate piggy

#Piggy needs an existing outdrive
rm /data/cephfs/punim0599/Jesse/emm75/piggy/70
mkdir /data/cephfs/punim0599/Jesse/emm75/piggy/70

# work
/home/jmmans/piggy/bin/piggy -i /data/cephfs/punim0599/Jesse/emm75/prokka/*/*.gff -o /data/cephfs/punim0599/Jesse/emm75/piggy/70 -r /data/cephfs/punim0599/Jesse/emm75/roary/70

done
