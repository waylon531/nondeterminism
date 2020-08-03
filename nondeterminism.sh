#!/usr/bin/env bash

dir="$1"
commit="$2"
cmd="$3"

function random_type {
	num=$(($RANDOM % 10))
	case $num in
	0)
		echo "RANDOM_BUG_A"
		;;
	1)
		echo "RANDOM_BUG_B"
		;;
	2)
		echo "RANDOM_BUG_C"
		;;
	3)
		echo "RANDOM_BUG_D"
		;;
	4)
		echo "RANDOM_BUG_E"
		;;
	5)
		echo "RANDOM_BUG_F"
		;;
	6)
		echo "RANDOM_BUG_G"
		;;
	7)
		echo "RANDOM_BUG_H"
		;;
	8)
		echo "RANDOM_BUG_I"
		;;
	9)
		echo "RANDOM_BUG_J"
		;;
	*)
		echo "RANDOM_BUG_Z"
		;;
	esac
}

function random_result {

	lineCount="$(wc -l source.c | cut -d ' ' -f 1)"
	lineNumber=$(($RANDOM % $lineCount))
	bugType="$(random_type)"

	jq -M -n --arg line $lineNumber --arg bug_type $bugType \
		'{type: $bug_type, message: ("Random bug was found on line " + $line + ". It looks extremely scary."), file: "source.c", line: $line | tonumber}'

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
	numBugs=$((3 + ($RANDOM % 10)))
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

