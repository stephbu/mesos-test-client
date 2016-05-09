import signal
import sys
import time
import os
from threading import Thread

shutdown_flag = False  # used for graceful shutdown


def main(argv=None):

    for variable in os.environ.iterkeys():
        print variable, "=", os.environ[variable]

    signal.signal(signal.SIGKILL, sighandler) # so we can handle kill gracefully
    signal.signal(signal.SIGTERM, sighandler) # so we can handle kill gracefully
    signal.signal(signal.SIGINT, sighandler) # so we can handle ctrl-c
    try:
        Thread(target=main_loop, args=()).start()
    except Exception, reason:
        print reason


def sighandler(signum, frame):
    print '[%s]' % time.strftime("%c"), 'signal handler called with signal: %s ' % signum
    global shutdown_flag
    shutdown_flag = True
    sys.exit()  # make sure you add this so the main thread exits as well.


def main_loop():
    while not shutdown_flag:
        print '[%s]' % time.strftime("%c"), 'running'
        time.sleep(5)

    print "done (killed)"


if __name__ == '__main__':
    main(sys.argv)
    while 1:  # this will force your main thread to live until you terminate it.
       time.sleep(1)