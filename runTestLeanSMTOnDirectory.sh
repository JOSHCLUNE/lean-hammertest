#!/bin/sh

COUNT=1
TOTAL=976

for f in $(ls ListNames)
do
	if [ $COUNT -lt 1 ]; then
		echo "Skipping $f ($COUNT / $TOTAL)"
		COUNT=$(($COUNT+1))
		continue	
	fi
	
	echo "About to check $f ($COUNT / $TOTAL)"
	echo "ListNames/$f" > nextFile.txt
	echo " " >> TestLeanSMT.lean # Hack to ensure that lake build TestLeanSMT actually rebuilds

	executable="lake build TestLeanSMT"
	timeout 30 $executable >> /dev/null 2> /dev/null
	if [ $? -eq 124 ]; then
		echo "$f :: Bash timeout" >> results/ListNamesAll.result
	fi
	
	COUNT=$(($COUNT+1))
done

