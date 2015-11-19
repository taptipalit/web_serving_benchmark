#!/bin/bash

minScale=$1
maxScale=$2

function launchRemote () {
	scale="$1"
	ansible-playbook -i ansible-inventory.ini -v gen_faban_workload.yml --extra-vars "scale=$scale"
	ansible-playbook -i ansible-inventory.ini -v launch_benchmark.yml --extra-vars "scale=$scale"
	grep -q "<passed>false</passed>" summary.xml
	if grep -q "<passed>false</passed>" summary.xml; then
		benchmarkSuccess=0
	else
		benchmarkSuccess=1
	fi
}

# Test for minScale
launchRemote $minScale

if [ $benchmarkSuccess -eq 0 ]
then
  echo "Benchmark failed for $minScale sessions"
  echo "Minimum Limit for scale too high."
  exit 0
else
  echo "Benchmark succeeded for $minScale sessions"
fi
# Test for minScale
launchRemote $maxScale

if [ $benchmarkSuccess -eq 1 ]
then
  echo "Benchmark succeeded for $maxScale sessions"
  echo "Maximum limit for scale too low."
  exit 0
else
  echo "Benchmark failed for $maxScale sessions"
fi

minNumSessions=$minScale
maxNumSessions=$maxScale

# Launch binary search
while :
do
  diff=$[maxNumSessions-minNumSessions]
  if [ $diff -le 50 ]
  then
    maxThroughput=$[$numSessions*$numTotalClients]
    echo "Benchmark succeeded for maximum scale: $maxThroughput"
    exit 0
  fi
  delta=$[(maxNumSessions-minNumSessions)/2]
  numSessions=$[minNumSessions+delta]
  launchRemote $numSessions
  if [ "$benchmarkSuccess" -eq 0 ]
  then
    maxNumSessions=$numSessions
  else
    minNumSessions=$numSessions
  fi
done
