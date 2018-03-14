#!/usr/bin/bash

amountOfChildren=$1
sleepTime=$2
if [[ ! "$1" =~ ^[0-9]+$ || ! "$2" =~ ^[0-9]+$ ]]; then
	echo "Args have to be numbers";
	exit;
fi

# Around the amount of seconds of overhead (starting and ending browsers)
# 4 times the amount of children works well in my experience.
overheadBufferTime=$((4 * $amountOfChildren));

run="yep"
while [ $run ]; do
	run=''

	# recombine parents into children
	./recombine.pl "parent0.js" "parent1.js" "$amountOfChildren"

	# prepare and run the children 
	for child in child*.js; do
		childNum=$(echo "$child" | grep -o '[[:digit:]]*');
		cp -a "paperclips/" "paperclips_$childNum/";
		mv "$child" "paperclips_$childNum/paperclips-auto.js";
		echo "Running bot $childNum";
		./runBot.py "$childNum" "$sleepTime" &
	done;

	# wait for results
	# TODO wait for processes to finish, using their PIDs
	echo "Sleeping $sleepTime + $overheadBufferTime = $((sleepTime+overheadBufferTime)) seconds";
	sleep $((sleepTime+overheadBufferTime));
	echo "Assuming all children are done. Moving on...";

	# Collect results, choose winners
	maxFitness0=0
	maxFitness0Child=1
	maxFitness1=0
	maxFitness1Child=2
	for result in *.result; do
		resultNum=$(echo "$result" | grep -o '[[:digit:]]*');
		resultVal=$(tail -1 "$result");
		if [ -z $resultVal ]; then
			(>&2 echo "Child $resultNum did not deliver results. Skipping.");
		else
			echo "$resultNum: $resultVal";
			if [ $resultVal -gt $maxFitness0 ]; then
				# move former champion to second place
				maxFitness1=$maxFitness0
				maxFitness1Child=$maxFitness0Child
				# claim first place
				maxFitness0=$resultVal;
				maxFitness0Child=$resultNum;
			elif [ $resultVal -gt $maxFitness1 ]; then
				# if champion can't be beaten, try second place
				maxFitness1=$resultVal;
				maxFitness1Child=$resultNum;
			fi;
		fi;
	done;

	# make winners new parents
	echo "Children $maxFitness0Child and $maxFitness1Child will be the new parents. Congratulations!";
	cp "paperclips_$maxFitness0Child/paperclips-auto.js" "parent0.js";
	cp "paperclips_$maxFitness1Child/paperclips-auto.js" "parent1.js";

	# Ask user if to continue
	echo -n "Want to spawn a new generation? [y/N] ";
	read answer
	if [[ "$answer" =~ ^[yY]$ ]]; then
		run='ANOTHER';
	else
		echo "Alright. Cleaning up.";
		make clean;
		echo "Done cleaning. I left the two parents for your next run ;)";
	fi;
done;
