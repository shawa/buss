#!/bin/sh
readonly CREDENTIALS=$1
readonly STOP=$2
readonly OUTFILE=$3
readonly FIFO=$4

[ ! -p $FIFO ] && mkfifo $FIFO
./bus.sh $CREDENTIALS $STOP > $FIFO &
sed "/<pre/r $FIFO" sign.template.html > "$OUTFILE"
rm $FIFO

