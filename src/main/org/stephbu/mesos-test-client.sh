#!/bin/bash
# mesos-test-client

exit_flag='false'

trap 'signal_sigterm' SIGTERM
signal_sigterm()
{
    dt=$(date '+%d/%m/%Y %H:%M:%S');
    echo "$dt signal_sigterm"
    exit_flag='true'
}

trap 'signal_sigusr1' SIGUSR1
signal_sigusr1()
{
    dt=$(date '+%d/%m/%Y %H:%M:%S');
    echo "$dt signal_sigusr1"
    exit_flag='true'
}

trap 'signal_sigusr2' SIGUSR2
signal_sigusr2()
{
    dt=$(date '+%d/%m/%Y %H:%M:%S');
    echo "$dt signal_sigusr2"
    exit_flag='true'
}

trap 'signal_sigint' SIGINT
signal_sigint()
{
    dt=$(date '+%d/%m/%Y %H:%M:%S');
    echo "$dt signal_sigint"
    exit_flag='true'
}

until [ $exit_flag == 'true' ]
do
    # sit waiting for process to exit
    dt=$(date '+%d/%m/%Y %H:%M:%S');
    echo "$dt running"
    sleep 15s
done

dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "$dt exited"
