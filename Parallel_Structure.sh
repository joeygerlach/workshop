#! /bin/bash

#running structure on the command line
#ensure structure, param files and input file are in the working directory
#just fill in the following 3 variables (and make sure the param files are completed
#need to change extraparams file "#define RANDOMIZE" =0 and remove # from in front of "#define SEED"

NAME=Testdata1			#supply file name suffix
MINK=1					#supply minimum K value (usually 1)
MAXK=5					#supply max number of K value to test (K = 1-? )
NREP=10					#supply number of reps for each Kvalue test

if [ ! -d ./results ]
then mkdir results
fi
if [ -f ./commands.txt ]
then rm commands.txt
fi

echo "Structure analysis started at $(date)"

COUNTER=$MINK 
while [  $COUNTER -le $MAXK  ]; do 
	REP=1
	while [ $REP -le $NREP ]; do
		echo "./structure -e extraparams_p -m mainparams_p -D $[RANDOM % 999999999] -K $COUNTER -o ./results/"$NAME"_K"$COUNTER"_rep"$REP" " >> commands.txt
		REP=$((REP+1))
		done
	let COUNTER=COUNTER+1
done	
nohup parallel < commands.txt 2>&1 &
sleep 2
echo "analysis started at $(date)"
echo "*"
echo "*"
echo "Enter 'top' to see Structure processes running"
echo "*"
echo "*"

wait
echo "STRUCTURE analysis complete"
echo "completed at $(date)"	

