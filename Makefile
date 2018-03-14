.PHONY: deps deps_arch run clean

deps: deps_arch
	sudo pip install splinter

deps_arch: runBot.py
	sudo pacman -Sy --needed python-pip geckodriver

run: paperclips paperclips/paperclips-auto.js recombine.pl arena.sh
	if [ ! -e parent0.js ]; then cp paperclips/paperclips-auto.js parent0.js; fi
	if [ ! -e parent1.js ]; then cp paperclips/paperclips-auto.js parent1.js; fi
	./arena.sh 5 10

clean:
	rm -rf $(wildcard *~) $(wildcard child*) $(wildcard paperclips_*) $(wildcard *.result)

purge: clean
	rm -rf $(wildcard parent*.js)
