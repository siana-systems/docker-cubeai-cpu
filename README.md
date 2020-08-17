# SIANA Cube-AI Development Docker for CPU-Host

This repo provides a docker image for deep-learning development targeting the STMicroelectronics Cube-AI platform.

At its core, it includes a cube-ai compatible versions of TensorFlow and Keras, aka keras.io. In addition, several typical packages are included to help with parsing data (images and audio, refer to the Dockerfile for details.) Note: this dockerfile is based on the `Dockerfile` of the [official Keras-Docker](https://github.com/keras-team/keras/tree/master/docker), which initially targetted GPU host machines.

## Running the SIANA image
Note: the following instructions were tested on Linux/Ubuntu 18.04

To run a container from the SIANA hosted image on Docker Hub, you'll need to:
  * instal [Docker Engine](https://docs.docker.com/engine/install/)
  * check that you have *make* installed, if not:
    * sudo apt-get update
    * sudo apt-get install make
  * download/save the Makefile in a working directory
  
Assuming that you copied the *Makefile* in your home (~/), to run the container:
 ```console
 foo@bar: ~/$ make bash
 ```
Docker will launch and proceed to download the SIANA image form Docker Hub (which may take a while...), then it'll run a container and open a bash terminal into it. From this terminal, you can then run your TensorFlow/Keras python scripts and/or the Cube-AI CLI (stm32cubeai.)
  
The doker container maps /src/workspace/ to your ~/ directory on the host side.
 
Note: review the Makefile targets for different runtime options.


## How to build a new image

### Pre-requisites
Notes:
  * the following instructions were tested on Linux/Ubuntu 18.04
  * the following instructions assumed the root path under: ~/docker-keras-cpu
 
You will need:
  * to install [Docker Engine](https://docs.docker.com/engine/install/)
  * a copy of ST Cube-AI:
    * download / install the [STM32CubeMX](https://www.st.com/en/development-tools/stm32cubemx.html)
    * install the [X-Cube-AI](https://www.st.com/content/st_com/en/products/embedded-software/mcu-mpu-embedded-software/stm32-embedded-software/stm32cube-expansion-packages/x-cube-ai.html) 
    * create a simlink in ~/docker-keras-cpu/cubeai to your installed X-Cube-AI version, typically under:  ~/STM32Cube/Repository/Packs/STMicroelectronics/X-Cube-AI/<M.m.b>

Open a terminal into your ~/docker-keras-cpu and run:
```console
 foo@bar: ~/docker-keras-cpu$ make build
```
Docker will launch and proceed to build a new image named: "tf1.15-keras2.3.1-cpu"

On completion, you should see the new image listed: 
```console
foo@bar: ~/docker-keras-cpu$ docker image list
```

