#! /bin/bash

NUMRUNS=`sed 1d SraRunTable.txt |wc -l | awk '{print($1)}'`
if [ $NUMRUNS -ge 0 ]; then
	jid1=$(sbatch --parsable --array=1-$NUMRUNS align_array.sbatch)
fi

sbatch --dependency=afterany:$jid1 util_scripts/cleanup.sh