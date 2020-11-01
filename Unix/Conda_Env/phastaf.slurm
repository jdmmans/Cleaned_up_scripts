#!/bin/bash
# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="Phanotat"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-3:00:00

# dependency soup
conda activate phastaf

# setup
cd /data/cephfs/punim0599/Jesse/emm75/contigs
ls | while read line; do

# work
/home/jmmans/phastaf/bin/phastaf --outdir /data/cephfs/punim0599/Jesse/emm75/phastaf/${line:0:-3} ${line} --force

done
