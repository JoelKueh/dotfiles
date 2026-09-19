#!/bin/bash

HOST_NUMBER="${1:-18}"
PORT=$(printf "330%02d" "$HOST_NUMBER")
HOST=$(printf "ece-kh2120-%02d.ece.umn.edu:22" "$HOST_NUMBER")

fuser -k $PORT/tcp 2>/dev/null
nohup socat "TCP-LISTEN:$PORT",bind=127.0.0.1,reuseaddr,fork \
	"SYSTEM:'ssh -W $HOST vlsi-jump'" &>/dev/null &
