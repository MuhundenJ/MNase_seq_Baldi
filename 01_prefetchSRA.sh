#! /bin/bash

# fetch the data to local cache
# iterate through runinfo table from SRA

module load ngs/sratoolkit/2.8.0
SRA_DIR=/work/project/tobias/sra

i=1
while read line
do
	test $i -eq 1 && ((i=i+1)) && continue
	set $line
	sfile=${SRA_DIR}/sra/{5}.sra
	if ! [ -f "$sfile" ] 
	then 
		prefetch --max-size 200G ${5} 
	fi
done < SraRunTable.txt
