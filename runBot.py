#!/usr/bin/python
import os, time, sys
from splinter import Browser


if len(sys.argv) < 2:
    sys.stderr.write("No child number given\n")
    sys.exit(1)

child = sys.argv[1];
deadline = 5


outFile = open(child + ".result", "w")

def runBot():
    # run
    browser = Browser('firefox')
    cwd = os.path.dirname(os.path.realpath(__file__))
    browser.visit("file://" + cwd + "/paperclips_" + child + "/index.html")

    # wait
    time.sleep(deadline)
    result = int(browser.find_by_id('clips').value)

    # close
    try:
        for w in browser.windows:
            w.close()
    except:
        sys.stderr.write("Error closing browser window\n")

    # deliver
    return result

outFile.write(str(runBot()))
