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
#SBATCH --cpus-per-task=8

# Use this email address:
#SBATCH --mail-user=jmmans@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-2:00:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

#modules
module load GCC/8.2.0
module load GNU
module load Perl/5.26.2-intel-2018.u4
module load BioPerl/1.7.2-intel-2016.u3-Perl-5.26.2
module load BLAST+/2.7.1-spartan_intel-2017.u2
module load BEDTools/2.28.0-spartan_intel-2017.u2
module load CD-HIT/4.6.8-spartan_intel-2017.u2
module load parallel/20170206-intel-2017.u2
module load PRANK/170427-intel-2017.u2
module load MAFFT/7.397-spartan_intel-2017.u2-with-extensions
module load FastTree/2.1.10-spartan_intel-2017.u2
module load MCL/14.137-intel-2016.u3
module load Roary/3.12.0-spartan_intel-2017.u2-Perl-5.26.0
module load MCL/14.137-spartan_intel-2017.u2

#variable shortening
rm -R /data/cephfs/punim0599/Jesse/emm75/roary/90
out='/data/cephfs/punim0599/Jesse/emm75/roary/90'

#roary
roary -output_dir $out -p 8 -i 90 -s /data/cephfs/punim0599/Jesse/emm75/prokka/*/*.gff
done

