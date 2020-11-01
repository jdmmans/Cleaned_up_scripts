#!/bin/bash

# Created by the University of Melbourne job script generator for SLURM
# Tue Apr 02 2019 10:31:59 GMT+1100 (Australian Eastern Daylight Time)

# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="Snippy_code"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8

# Use this email address:
#SBATCH --mail-user=jmmans@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-4:00:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

#mods needed
module load Python/2.7.9-GCC-4.9.2
module load Biopython/1.61-intel-2016.u3-Python-2.7.10
module load DendroPy/4.1.0-intel-2016.u3-Python-2.7.10
module load Pillow/2.8.1-intel-2016.u3-Python-2.7.10
module load GCC/4.9.2
module load FastTree/2.1.7-intel-2016.u3
module load RAxML/8.2.9-GCC-4.9.2-pthreads-avx2
module load Gubbins/2.3.4-intel-2016.u3-Python-3.5.2

#work
run_gubbins.py /data/cephfs/punim0599/Jesse/emm75/snpanalysis/ST49core.aln

run_gubbins.py /data/cephfs/punim0599/Jesse/emm75/snpanalysis/ST150core.aln

done
