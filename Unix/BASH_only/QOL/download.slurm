#!/bin/bash
# Created by the University of Melbourne job script generator for SLURM
# Tue Apr 02 2019 10:31:59 GMT+1100 (Australian Eastern Daylight Time)

# Partition for the job:
#SBATCH --partition=physical 

# array
#SBATCH --array=1-8

# Multithreaded (SMP) job: must run on one node and the cloud partition
#SBATCH --nodes=1

# The name of the job:
#SBATCH --job-name="eudownloade"

# The project ID which this job should run under:
#SBATCH --account="punim0599"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

# Use this email address:
#SBATCH --mail-user=jmmans@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-3:00:00

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# module needed to access web
module load web_proxy/latest

# change to working directory
cd /data/cephfs/punim0599/Jesse/emm75

# delay read accessions file line by line - set strain as the line if it a sample on the EU database aka an ERR or ERS - download the file
cat /data/cephfs/punim0599/Jesse/emm75/Neededfqs.txt | while read line; do 

# change drive 
mkdir /data/cephfs/punim0599/Jesse/emm75/fastqs
cd /data/cephfs/punim0599/Jesse/emm75/fastqs

#wait
wt=$((${SLURM_ARRAY_TASK_ID}*60))
sleep $wt;

wt="0"
# take ERR### - take final character combinations for the file systen
var1="${line:0:6}"
var2="00${line: -1}"
var3="0${line: -2}"
var4="${line: -3}"

# six digit accession number
url2="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/${var1}/${line}/${line}"

# seven digit accession number
url1="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/${var1}/${var2}/${line}/${line}" 

# eight digit accession number
url3="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/${var1}/${var2}/${line}/${line}"

#nine digit accession number
url4="ftp://ftp.sra.ebi.ac.uk/vol1/fastq/${var1}/${var2}/${line}/${line}"

# actual download for R1 and R2 - after generic check for if a file by that name exists
[ -f "${line}_1.fastq.gz" ] || wget "${url1}_1.fastq.gz" ||  sleep $wt
[ -f "${line}_2.fastq.gz" ] || wget "${url1}_2.fastq.gz" ||  sleep $wt
[ -f "${line}_1.fastq.gz" ] || wget "${url2}_1.fastq.gz" ||  sleep $wt
[ -f "${line}_2.fastq.gz" ] || wget "${url2}_2.fastq.gz" ||  sleep $wt
[ -f "${line}_1.fastq.gz" ] || wget "${url3}_1.fastq.gz" ||  sleep $wt
[ -f "${line}_2.fastq.gz" ] || wget "${url3}_2.fastq.gz" ||  sleep $wt
[ -f "${line}_1.fastq.gz" ] || wget "${url4}_1.fastq.gz" ||  sleep $wt
[ -f "${line}_2.fastq.gz" ] || wget "${url4}_2.fastq.gz" ||  sleep $wt
echo 'pls work'
done
