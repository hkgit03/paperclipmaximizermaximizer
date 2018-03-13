#!/usr/bin/bash

# TODO: Wrap this in a while loop where the user has to confirm the continuation for each generation

for child in child*.js; do
	childNum=$(echo "$child" | grep -o '[[:digit:]]*')
	cp -a "paperclips/" "paperclips_$childNum/";
	mv "$child" "paperclips_$childNum/paperclips-auto.js"
	echo "Running bot $childNum";
	./runBot.py "$childNum" & #> "$childNum.result";
done;

# TODO Collect results, choose parents, repeat
