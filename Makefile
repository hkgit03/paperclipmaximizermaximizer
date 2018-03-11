.PHONY: deps deps_arch run clean

deps: deps_arch
	sudo pip install splinter

deps_arch: runBot.py
	sudo pacman -Sy --needed python-pip geckodriver

run: paperclips-auto/paperclips-auto.js
	./runBot.py

clean:
	rm -rf $(wildcard *~) geckodriver.log
