.PHONY: deps deps_arch run clean

deps: deps_arch
	sudo pip install splinter

deps_arch: runBot.py
	sudo pacman -Sy --needed python-pip geckodriver

run: paperclips-auto/paperclips-auto.js
	if [ ! -e parent0.js ]; then cp paperclips-auto/paperclips-auto.js parent0.js; fi
	if [ ! -e parent1.js ]; then cp paperclips-auto/paperclips-auto.js parent1.js; fi
	./recombine.pl parent0.js parent1.js 5
	# TODO run children, compare results

clean:
	rm -rf $(wildcard parent*) $(wildcard child*) $(wildcard *~) geckodriver.log
