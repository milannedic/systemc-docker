# SystemC on Docker

This repository contains an a dockerfile in order to run systemc. It contains systemc 2.3.3. The only thing you need for this is this repository and a working installation of docker.

On default, the docker command in run_docker.sh mounts a volume with the folder srcfiles. This is not a necessary step, but can make life easier.

The systemC libraries are directly downloaded from [Accellera](https://www.accellera.org/downloads/standards/systemc).

# How to install docker?

[install](https://docs.docker.com/engine/install/)

# Build command

```
docker build -f ubuntu.dockerfile -t systemc:2.3.3-ubuntu .
```

or

```
docker build -f alpine.dockerfile -t systemc:2.3.3-alpine .

```
```
// added gtkwave
sudo docker build -f ubuntu.dockerfile -t systemc-2.3.3_ubuntu:0.1 .

// added gtkwave and verilator
sudo docker build -f ubuntu-verilator-gtkwave.dockerfile -t systemc-2.3.3_ubuntu-verilator-gtkwave:0.2 .
```

check available Docker images:
```
sudo docker images
```

# Run command

```
sudo docker run -ti --rm -v "$(pwd)"/srcfiles/:/usr/srcfile/ systemc:2.3.3-ubuntu
```
or
```
sudo docker run -ti --rm -v "$(pwd)"/srcfiles/:/usr/srcfile/ systemc:2.3.3-alpine
```

When using container with gtkwave+verilator installed, these are the commands:
```
xhost +local:docker
sudo docker run -ti --rm \
                -e DISPLAY=$DISPLAY \
                -v /tmp/.X11-unix:/tmp/.X11-unix \
                -v "$(pwd)"/srcfiles/:/usr/srcfile/ systemc-2.3.3_ubuntu:0.1
                
or
```

```
sudo docker run -ti --rm \
                -e DISPLAY=$DISPLAY \
                -v /tmp/.X11-unix:/tmp/.X11-unix \
                -v "$(pwd)"/srcfiles/:/usr/srcfile/ systemc-2.3.3_ubuntu-verilator-gtkwave:0.2
```



# Important locations

1. Systemc is installed in:      /usr/local/systemc-2.3.3
1. Mounted volume:               /usr/srcfile/

This repository is based on  [marczwalua's repo](https://github.com/marczwalua/systemc).

