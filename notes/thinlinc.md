
# Description

The problem with proxy jump is that ThinLinc creates multiple ssh connections to the target server.
The first uses the ssh config file, subsequent requests use the machines address directly. To fix
this, we set up `~/.thinlinc/tlclient.conf` to reroute requests from our machine to a `socat` tcp
tunnel to the remote mahcine. The socat tunnel reroutes all requests to `localhost:33022` to
`vlsi:22` so that using `ssh -p 33022 localhost` actually connects you to the remote vlsi machine.

# Configuration

## ThinLinc Configuration

### ~/.thinlinc/tlclient.conf

Update the "HOST_ALIASES" key to reroute connections to ece-kh... to localhost tunnel.

```
HOST_ALIASES=ece-kh2120-01.ece.umn.edu:33001=localhost:33001 ece-kh2120-02.ece.umn.edu:33002=localhost:33002 ece-kh2120-03.ece.umn.edu:33003=localhost:33003 ece-kh2120-04.ece.umn.edu:33004=localhost:33004 ece-kh2120-05.ece.umn.edu:33005=localhost:33005 ece-kh2120-06.ece.umn.edu:33006=localhost:33006 ece-kh2120-07.ece.umn.edu:33007=localhost:33007 ece-kh2120-08.ece.umn.edu:33008=localhost:33008 ece-kh2120-09.ece.umn.edu:33009=localhost:33009 ece-kh2120-10.ece.umn.edu:33010=localhost:33010 ece-kh2120-11.ece.umn.edu:33011=localhost:33011 ece-kh2120-12.ece.umn.edu:33012=localhost:33012 ece-kh2120-13.ece.umn.edu:33013=localhost:33013 ece-kh2120-14.ece.umn.edu:33014=localhost:33014 ece-kh2120-15.ece.umn.edu:33015=localhost:33015 ece-kh2120-16.ece.umn.edu:33016=localhost:33016 ece-kh2120-17.ece.umn.edu:33017=localhost:33017 ece-kh2120-18.ece.umn.edu:33018=localhost:33018 ece-kh2120-19.ece.umn.edu:33019=localhost:33019 ece-kh2120-20.ece.umn.edu:33020=localhost:33020 ece-kh2120-21.ece.umn.edu:33021=localhost:33021 ece-kh2120-22.ece.umn.edu:33022=localhost:33022 ece-kh2120-23.ece.umn.edu:33023=localhost:33023 ece-kh2120-24.ece.umn.edu:33024=localhost:33024 ece-kh2120-25.ece.umn.edu:33025=localhost:33025 ece-kh2120-26.ece.umn.edu:33026=localhost:33026 ece-kh2120-27.ece.umn.edu:33027=localhost:33027 ece-kh2120-28.ece.umn.edu:33028=localhost:33028 ece-kh2120-29.ece.umn.edu:33029=localhost:33029 ece-kh2120-30.ece.umn.edu:33030=localhost:33030 ece-kh2120-31.ece.umn.edu:33031=localhost:33031 ece-kh2120-32.ece.umn.edu:33032=localhost:33032
```

## Local SSH Configuration

### ~/.ssh/config

Add vlsi machine targets to ssh config.

```
Host *
	SetEnv TERM=xterm-256color
    ControlMaster auto
    ControlPath ~/.ssh/sockets/%r@%h:%p
    ControlPersist 1h

Host vlsi
	Hostname ece-kh2120-1.ece.umn.edu
	User kuehn348
	ProxyJump csel
    RequestTTY force
    RemoteCommand /bin/zsh -l

Host vlsi-jump
	HostName csel-kh1262-24.cselabs.umn.edu
	User kuehn348
	ServerAliveInterval 30
	ServerAliveCountMax 3

Host vlsi01
	Hostname ece-kh2120-01.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi02
	Hostname ece-kh2120-02.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi03
	Hostname ece-kh2120-03.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi04
	Hostname ece-kh2120-04.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi05
	Hostname ece-kh2120-05.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi06
	Hostname ece-kh2120-06.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi07
	Hostname ece-kh2120-07.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi08
	Hostname ece-kh2120-08.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi09
	Hostname ece-kh2120-09.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi10
	Hostname ece-kh2120-10.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi11
	Hostname ece-kh2120-11.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi12
	Hostname ece-kh2120-12.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi13
	Hostname ece-kh2120-13.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi14
	Hostname ece-kh2120-14.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi15
	Hostname ece-kh2120-15.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi16
	Hostname ece-kh2120-16.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi17
	Hostname ece-kh2120-17.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi18
	Hostname ece-kh2120-18.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi19
	Hostname ece-kh2120-19.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi20
	Hostname ece-kh2120-20.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi21
	Hostname ece-kh2120-21.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi22
	Hostname ece-kh2120-22.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi23
	Hostname ece-kh2120-23.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi24
	Hostname ece-kh2120-24.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi25
	Hostname ece-kh2120-25.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi26
	Hostname ece-kh2120-26.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi27
	Hostname ece-kh2120-27.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi28
	Hostname ece-kh2120-28.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi29
	Hostname ece-kh2120-29.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi30
	Hostname ece-kh2120-30.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi31
	Hostname ece-kh2120-31.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l

Host vlsi32
	Hostname ece-kh2120-32.ece.umn.edu
	User kuehn348
	ProxyJump csel
	RequestTTY force
	RemoteCommand /bin/zsh -l
```

## SSH Tunnel Configuration

### ~/.local/bin/vlsi_server.sh

Spawn a socat tunnel that opens connections to the remote.

```bash
#!/bin/bash

HOST_NUMBER="${1:-18}"
PORT=$(printf "330%02d" "$HOST_NUMBER")
HOST=$(printf "ece-kh2120-%02d.ece.umn.edu:22" "$HOST_NUMBER")

fuser -k $PORT/tcp 2>/dev/null
nohup socat "TCP-LISTEN:$PORT",bind=127.0.0.1,reuseaddr,fork \
	"SYSTEM:'ssh -W $HOST vlsi-jump'" &>/dev/null &
```
