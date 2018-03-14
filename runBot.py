#!/usr/bin/python
import os, time, sys
from splinter import Browser


if len(sys.argv) < 2:
    sys.stderr.write("No child number given\n")
    sys.exit(1)
if len(sys.argv) < 3:
    sys.stderr.write("No timeout given\n")
    sys.exit(1)

child = int(sys.argv[1])
timeout = int(sys.argv[2])


outFile = open(str(child) + ".result", "w")

def runBot():
    # run
    browser = Browser('firefox')
    cwd = os.path.dirname(os.path.realpath(__file__))
    browser.visit("file://" + cwd + "/paperclips_" + str(child) + "/index.html")

    # wait
    time.sleep(timeout)
    result = int(browser.find_by_id('clips').value)

    # close
    try:
        for w in browser.windows:
            w.close()
    except:
        # TODO Somehow we always land in here
        pass

    # deliver
    return result

outFile.write(str(runBot()))
