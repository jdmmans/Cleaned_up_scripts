#!/bin/bash

# Created by the University of Melbourne job script generator for SLURM
# Tue Apr 02 2019 10:31:59 GMT+1100 (Australian Eastern Daylight Time)

# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="roary"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12

# Use this email address:
#SBATCH --mail-user=jmmans@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-0:45:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

#modules
module load Miniconda3
source activate roary
# CDhit is currently not working via conda
module load CD-HIT/4.6.1-intel-2016.u3-2012-08-27
module load GNU
module load GCC

#variable shortening
rm -R /data/cephfs/punim0599/Jesse/emm75/roary/ST150
out='/data/cephfs/punim0599/Jesse/emm75/roary/ST150'

#roary
roary -f $out -p 8 -i 90 -s /data/cephfs/punim0599/Jesse/emm75/ST150/gff/*
done

