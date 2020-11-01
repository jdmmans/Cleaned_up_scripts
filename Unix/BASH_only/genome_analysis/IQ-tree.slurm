#!/bin/bash
# Created by the University of Melbourne job script generator for SLURM
# Tue Apr 02 2019 10:31:59 GMT+1100 (Australian Eastern Daylight Time)

# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="IQTREE_code"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8

# Use this email address:
#SBATCH --mail-user=jmmans@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-1:00:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# The modules to load:
module load IQ-TREE/1.6.7-spartan_intel-2017.u2

# The work, the 10 hrs is since with 284 isolates several models take upwards of 20 miuntes to run on the full snpcore
mkdir -p /data/cephfs/punim0599/Jesse/emm75/iqtree/
cd /data/cephfs/punim0599/Jesse/emm75/iqtree/
iqtree -redo -m GTR+F+G4 -fconst 136072,168154,181086,125593 -bb 1000 -v -nt 8 -s /data/cephfs/punim0599/Jesse/emm75/snpanalysis/clean.core.aln 

