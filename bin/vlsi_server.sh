#!/bin/bash

for host_number in {1..32}; do
	port=$(printf "330%02d" "$host_number")
	host=$(printf "ece-kh2120-%02d.ece.umn.edu:22" "$host_number")

	fuser -k $port/tcp 2>/dev/null
	socat "TCP-LISTEN:$port",bind=127.0.0.1,reuseaddr,fork \
		"SYSTEM:'ssh -W $host vlsi-jump'" &>/dev/null &
done

sleep infinity
