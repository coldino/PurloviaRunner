#!/bin/bash
JOBUSER="purlovia"
BASEDIR="$(dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd ))"

if [[ `whoami` != "$JOBUSER" ]]; then
	echo "This script can be only ran by user \"$JOBUSER\""
	exit 1
fi

if [[ `pwd` != "$BASEDIR" ]]; then
	echo "This script can be only ran inside of \"$BASEDIR\""
	exit 1
fi

function _selfupdate() {
	# Update runner scripts
	git fetch origin master || exit 3
	git reset --hard origin/master || exit 3
}

function _run_container() {
	docker-compose pull || exit 4
	exec docker-compose run --rm purlovia > /dev/null
}

case "$1" in
	container)
		_run_container
		;;
	update)
		_selfupdate
		;;
	job)
		_selfupdate
		exec bash "$0" container
		;;
	*)
		echo "Unrecognized action: \"$1\""
		exit 2
		;;
esac
