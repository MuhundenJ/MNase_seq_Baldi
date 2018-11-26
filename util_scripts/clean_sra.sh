#! /bin/bash

##########################################################################################
# purge the SRA files
##########

SRA_DIR=/work/project/tobias/sra

while read line
do
	set $line
	sfile=${SRA_DIR}/sra/${5}.sra
	if [ -f "$sfile" ] 
	then 
		rm ${sfile} 
		echo ${sfile}
	fi
done < SraRunTable.txt
