#!/bin/python
import os, time
from splinter import Browser


deadline = 5


def runBot():
    # run
    browser = Browser('firefox')
    #browser.visit('http://www.decisionproblem.com/paperclips/index2.html')
    browser.visit("file://" + os.path.dirname(os.path.realpath(__file__)) + "/paperclips/index.html")

    # wait
    time.sleep(deadline)
    result = int(browser.find_by_id('clips').value)

    # close
    try:
        for w in browser.windows:
            w.close()
    except:
        print("Could not close browser window. Please close manually.")

    # deliver
    return result


print(runBot())
