#!/usr/bin/bash

sleepTime=3
waitBuffer=15

for child in child*.js; do
	childNum=$(echo "$child" | grep -o '[[:digit:]]*');
	cp -a "paperclips/" "paperclips_$childNum/";
	mv "$child" "paperclips_$childNum/paperclips-auto.js";
	echo "Running bot $childNum";
	./runBot.py "$childNum" "$sleepTime" &
done;

# wait for results
# TODO wait for processes to finish, using their PIDs
echo "Sleeping $((sleepTime+waitBuffer))";
sleep $((sleepTime+waitBuffer));
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

# TODO cleanup and repeat (e. g. wrap this in a while loop where the user has to confirm the continuation for each generation)
