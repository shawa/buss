#!/bin/sh
readonly CREDENTIALS="$1"
readonly STOP="$2"
readonly OUTFILE="index.html"
readonly FIFO="bus_tmp_fifo.txt"

clean() {
	[ -f $OUTFILE ] && rm $OUTFILE
	[ -f $FIFO ] && rm $FIFO
	printf "\r"
}

regen() {
	./build_page.sh "$CREDENTIALS" "$STOP" "$OUTFILE" "$FIFO"
	printf "\rRefreshed $(date "+%H:%M:%S")"
}

trap "clean; exit 1" 2
echo "Running, stop $STOP"

regen
open $OUTFILE

while :
do
	sleep 60
	regen
done
