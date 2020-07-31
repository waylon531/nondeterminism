#!/usr/bin/env bash

dir="$1"
commit="$2"
cmd="$3"

function random_result {

	lineCount="$(wc -l source.c | cut -d ' ' -f 1)"
	lineNumber=$(($RANDOM % $lineCount))

	jq -M -n --arg ln $lineNumber '{type: "RANDOM_BUG", message: "Random bug was found. It looks extremely scary.", file: "source.c", line: $ln}'

}

case "$cmd" in

version)
	echo 1
	exit 0
	;;
	
applicable)
	echo true
	exit 0
	;;

run)
	numBugs=$(($RANDOM % 10))
	jq --slurp '.' <<< "$(
	for _i in $(seq 1 $numBugs); do
		random_result
	done )"
	exit 0
	;;
	
*)
	echo "Usage: ./nondeterminism.sh PATH COMMIT COMMAND"
	exit 1
	;;

esac

