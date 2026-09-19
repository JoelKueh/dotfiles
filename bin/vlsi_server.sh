#!/bin/bash

HOST_NUMBER="${1:-18}"

fuser -k 33022/tcp 2>/dev/null
nohup socat "TCP-LISTEN:330$HOST_NUMBER",bind=127.0.0.1,reuseaddr,fork \
	"SYSTEM:'ssh -W ece-kh2120-${HOST_NUMBER}.ece.umn.edu:22 vlsi-jump'" &>/dev/null &
