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
#SBATCH --time=0-0:15:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# The modules to load:
module load BioPerl/1.7.2-spartan_intel-2017.u2-Perl-5.26.0 
module load Java/9.0.4
module load seqtk/1.2-r94-intel-2016.u3
module load Vt/0.5772-spartan_gcc-6.2.0
module load Snippy/4.3.6-spartan_intel-2017.u2
module load BEDTools/2.28.0-spartan_intel-2017.u2
module load SAMtools/1.9-intel-2018.u4
module load minimap2/2.11-intel-2017.u2
module load snp-sites/2.4.1-spartan_intel-2017.u2
module load Biopython/1.61-intel-2016.u3-Python-2.7.10
module load Perl/5.20.0-intel-2016.u3-bio
module load BioPerl/1.6.924-intel-2016.u3-Perl-5.20.0-bio

# change drive - set reference genome as reference 
cd  /data/cephfs/punim0599/Jesse/emm75/snpanalysis

# work 
snippy-clean_full_aln snpcore.full.aln > clean.full.aln

done
