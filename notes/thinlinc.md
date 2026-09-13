
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
HOST_ALIASES=ece-kh2120-13.ece.umn.edu:33022=localhost:33022
```

## Local SSH Configuration

### ~/.ssh/config

Add vlsi machine targets to ssh config.

```
Host vlsi
	Hostname ece-kh2120-13.ece.umn.edu
	User kuehn348
	ProxyJump csel

Host vlsi-np
	Hostname ece-kh2120-13.ece.umn.edu
	User kuehn348

Host vlsi-jump
	HostName csel-kh1262-24.cselabs.umn.edu
	User kuehn348
	ControlMaster auto
	ControlPersist 5m
	ControlPath ~/.ssh/cm-%C
	ServerAliveInterval 30
	ServerAliveCountMax 3
```

## SSH Tunnel Configuration

### ~/.local/bin/vlsi_server.sh

Spawn a socat tunnel that opens connections to the remote.

```bash
#!/bin/bash
socat TCP-LISTEN:33022,bind=127.0.0.1,reuseaddr,fork \
	EXEC:/home/joel/.local/bin/vlsi_ssh.sh
```

### ~/.local/bin/

Run by `vlsi_server.sh` to create a tunnel to the server.

```
#!/bin/sh
exec ssh -W ece-kh2120-13.ece.umn.edu:22 vlsi-jump
```
