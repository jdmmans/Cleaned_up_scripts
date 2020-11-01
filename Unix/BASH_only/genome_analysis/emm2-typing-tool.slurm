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
#SBATCH --cpus-per-task=12

# Use this email address:
#SBATCH --mail-user=jmmans@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-4:00:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

module load BLAST+/2.7.1-intel-2016.u3
module load Bowtie2
module load SAMtools/0.1.19-GCC-4.9.2
module load Biopython/1.61-intel-2016.u3-Python-2.7.10
module load EMBOSS/6.6.0-intel-2016.u3
module load zlib/1.2.9-intel-2017.u2
module load emm-typing-tool/Feb012017-GCC-4.9.2
module load Python/2.7.10-intel-2016.u3
module load GCC/4.9.2
module load BLAST+/2.7.1-intel-2016.u3
module load zlib/1.2.9-intel-2017.u2

cd /data/cephfs/punim0599/Jesse/emm75/fastqs
ls | while read line; do
if [[ "$line" == *"_1"* ]]; then
	 var0="${line:0:-11}"
		var1="${var0}.R1.fastq.gz"
		mv ${line} ./${var1}
			var2="${var0}.R2.fastq.gz"
			mv ${var0}_2.fastq.gz ./${var2}
echo "${var0}"
echo "${var1}"
echo "${var2}"
emm_typing.py --profile_file_directory /data/cephfs/punim0599/Jesse/emm75/test/ --fastq_1 ${var1} --fastq_2 ${var2} --output_directory /data/cephfs/punim0599/Jesse/emm75/emm
fi
done
