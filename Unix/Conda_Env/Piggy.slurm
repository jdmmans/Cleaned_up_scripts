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
#SBATCH --time=0-0:45:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# dependencies
source activate roary

# work
/home/jmmans/piggy/bin/piggy -i /data/cephfs/punim0599/Jesse/emm75/prokka/*/* -o /data/cephfs/punim0599/Jesse/emm75/piggy -r /data/cephfs/punim0599/Jesse/emm75/roary

done
