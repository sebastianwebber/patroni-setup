# Patroni SET UP

This repo is inspired by [this post](https://pgstef.github.io/2022/07/11/patroni_on_pure_raft.html) and it consists in the set up of 3 "VMs with ssh" started by vagrant, and the ansible setup(that runs on docker too) to install patroni.


## Requirements

To run this repo is necessary to install:

* GNU Make
* Docker: https://docs.docker.com/get-docker/
* Vagrant: https://developer.hashicorp.com/vagrant/downloads
* Docker Provider for Vagrant: https://developer.hashicorp.com/vagrant/docs/provisioning/docker

Tested on M1 and intel macbooks.

## Usage

To create the vms, run:

```bash
make create-machines
```

Once the were created, test the ansible connection:

```bash
make ansible-ping
```

If the connection working, setup patroni in the nodes:

```bash
make ansible-setup
```

### checking if patroni is working

connect in any of the nodes, like below:

```bash
ssh -F vagrant-ssh.cfg db-node-1
```

In the node run:

```bash
sudo su - postgres -c "patronictl -c /etc/patroni.yaml topology"
```

## cleanup

To remove the vagrant machines, run:

```bash
make clean
``` 