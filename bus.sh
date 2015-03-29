#!/bin/sh
readonly CREDENTIALS=$1; shift;

readonly URL="http://dublinked.ie/cgi-bin/rtpi/realtimebusinformation?stopid=$1&routeid=$2"

filter() {
	jq -r \
	'.results[] |
	"\(.route);\(.destination);\(.duetime);\(.arrivaldatetime[11:20])" '
}

curl -su "$CREDENTIALS" "$URL" | filter | column -t -s ';'
