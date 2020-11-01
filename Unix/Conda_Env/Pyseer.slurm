#!/bin/bash
# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

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

Module load Miniconda3
source activate pyseer

# vairables
## traits.tsv is a binary version of phenotypes present (i.e emm75 or AMR) to allow comparison with scoary outputs
## kmers is the output file produced by unitig-counter
## mash.tsv is a simple matrix of genetic distances produced by mash 
out="/data/cephfs/punim0599/Jesse/emm75/pyseer/pyseer.assoc"
phen="/data/cephfs/punim0599/Jesse/emm75/pyseer/phenotypes/traits.tsv"
uni="/data/cephfs/punim0599/Jesse/emm75/pyseer/kmers/unitigs.txt" 
msh="/data/cephfs/punim0599/Jesse/emm75/pyseer/MASH/mash.tsv"

# work by pyseer
[[ -d "$out" ]] || pyseer --phenotypes ${phen} --kmers ${uni} --uncompressed --distances ${msh} --min-af 0.01 --max-af 0.99 --cpu 12 --filter-pvalue 1E-8 > $out

done
