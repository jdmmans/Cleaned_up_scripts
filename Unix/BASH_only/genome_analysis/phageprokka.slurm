#!/bin/bash

# Partition for the job:
#SBATCH --partition=cloud,physical

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="phage-pro-kka"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12

# Use this email address:
#SBATCH --mail-user=jmmans@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-0:15:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# delay - a decent delay

#dependencies
module load Barrnap/0.6-intel-2016.u3
module load Prokka/1.13-intel-2016.u3-BioPerl-1.6.924
module load Java/9.0.4
module load BLAST+/2.7.1-GCC-6.2.0-Python-3.5.2

# like a for loop but better
cd /data/cephfs/punim0599/Jesse/emm75/phagecontent/phage_fa
ls | while read line; do
line1=${line:0:-3}

#variable shortening
out='/data/cephfs/punim0599/Jesse/emm75/phagecontent/prokka'
files='/data/cephfs/punim0599/Jesse/emm75/phagecontent/phage_fa/${line}'

#prokka called, will run on any fasta only run on whole genomes not contigs
# will be really weird if mapped contigs from snippy or such are used
prokka --prefix ${line1} --outdir $out/${line1} ${line}
done
