#!/bin/bash
# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="GWAS"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4

# Use this email address:
#SBATCH --mail-user=jmmans@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-1:00:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# needed modules
module purge
module load Mash/2.1-intel-2017.u2
module load PopPUNK/1.1.3-intel-2017.u2-Python-3.6.4
module load Python/3.6.4-intel-2017.u2
module load GCC/6.2.0
module load zlib/1.2.9-intel-2017.u2

# variables used 
out="/data/cephfs/punim0599/Jesse/emm75/GAS_query/GASupdate"
cd $out

# popPUNK
poppunk --refine-model --accessory-only --indiv-refine --ref-db /data/cephfs/punim0599/Jesse/emm75/GAS_query/GASupdate --distances GASupdate.dists --q-files /data/cephfs/punim0599/Jesse/emm75/poppunklist.txt --output GASupdateacc --full-db --threads 4
done
