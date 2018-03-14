#!/usr/bin/bash

sleepTime=5
waitBuffer=5

for child in child*.js; do
	childNum=$(echo "$child" | grep -o '[[:digit:]]*');
	cp -a "paperclips/" "paperclips_$childNum/";
	mv "$child" "paperclips_$childNum/paperclips-auto.js";
	echo "Running bot $childNum";
	./runBot.py "$childNum" "$sleepTime" &
done;

# wait for results
# TODO wait for processes to finish, using their PIDs
sleep $((sleepTime+waitBuffer));

# Collect results, choose winners
maxFitness0=0
maxFitness0Child=0
maxFitness1=0
maxFitness1Child=0
for result in *.result; do
	resultNum=$(echo "$result" | grep -o '[[:digit:]]*');
	resultVal=$(tail -1 "$result");
	echo "$resultNum: $resultVal";
	if [ $resultVal -gt $maxFitness0 ]; then
		# move former champion to second place
		maxFitness1=$maxFitness0
		maxFitness1Child=$maxFitness0Child
		# claim first place
		maxFitness0=$resultVal;
		maxFitness0Child=$resultNum;
	elif [ $resultVal -ge $maxFitness1 ]; then
		# if champion can't be beaten, try second place
		maxFitness1=$resultVal;
		maxFitness1Child=$resultNum;
	fi;
done;

# make winners new parents
mv "child$maxFitness0Child.js" "parent0.js";
mv "child$maxFitness1Child.js" "parent1.js";

# TODO cleanup and repeat (e. g. wrap this in a while loop where the user has to confirm the continuation for each generation)
