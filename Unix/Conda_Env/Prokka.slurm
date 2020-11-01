#!/bin/bash

# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="Snippy_code"

# array
#SBATCH --array=1-8

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

# delay - a decent delay
wt=$((${SLURM_ARRAY_TASK_ID} * 15))
sleep $wt

#dependencies
source activate prokka

# like a for loop but better
cd /data/cephfs/punim0599/Jesse/emm75/contigs
ls | while read line; do
        if [[ ${line} == *".fa"* ]]; then
line1=${line:0:-3}
fi

#variable shortening
out='/data/cephfs/punim0599/Jesse/emm75/prokka'
files='/data/cephfs/punim0599/Jesse/emm75/contigs/${line}'

#prokka called, will run on any fasta only run on whole genomes not contigs
# will be really weird if mapped contigs from snippy or such are used
prokka --prefix ${line1} --outdir $out/${line1} ${files} --addgenes --locustag --genus Streptococcus --usegenus --force

done
