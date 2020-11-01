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

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# working around poor coding constraints
cd /data/cephfs/punim0599/Jesse/emm75/contigs
ls | while read line; do
phano="/home/jmmans/PHANOTATE/phanotate.py"

# work
$phano $line > data/cephfs/punim0599/Jesse/emm75/phage/${line:0:-2}.txt

# make a single output file

done
