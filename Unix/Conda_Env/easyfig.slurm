module load Python/2.7.9-intel-2017.u2
module load GCC/6.2.0
module load BLAST+
module load zlib/1.2.9-intel-2017.u2
## one of each popPUNK cluster
python /data/cephfs/punim0599/Jesse/emm75/Easyfig/Easyfig.py -o ./figure.svg -filter -svg ../contigs/{ERR1732839.fa,ERR228677.fa,ERR028583.fa,ERR2650107.fa,ERR228488.fa,ERR111860.fa,ERR485807.fa,ERR172141.fa,ERR1359529.fa}
