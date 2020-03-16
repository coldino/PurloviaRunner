#!/bin/bash
BASEDIR=$HOME/runner

if [[ `pwd` != "$BASEDIR" ]]; then
	echo "Start the script from \"$BASEDIR\""
	exit 1
fi

function _selfupdate() {
	# Update runner scripts
	git fetch origin master || exit 3
	git reset --hard origin/master || exit 3
}

function _run_container() {
	docker-compose pull || exit 4
	exec docker-compose run --rm purlovia
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
