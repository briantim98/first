#!/bin/bash
#The reason of this script is to check whether the files are empty in a certain directory
#
dir=/home/brian/Documents

for file in "$dir"/* ; do
	if [ -s "$file" ]; then
		echo "$file file has data"
	else 
		echo "$file file is empty"
	fi
done
