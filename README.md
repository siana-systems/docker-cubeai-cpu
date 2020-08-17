# SIANA Cube-AI Development Docker for CPU-Host

This repo is used to build a docker image for deep-learning development targeting the STMicroelectronics Cube-AI platform.

At its core, it includes a cube-ai compatible versions of TensorFlow and Keras, aka keras.io. In addition, several typical packages are included to help with parsing data (images and audio, refer to the Dockerfile for details.) Note: this dockerfile is based on the `Dockerfile` of the [official Keras-Docker](https://github.com/keras-team/keras/tree/master/docker), which initially targetted GPU host machines.

## Pre-requisites
Notes:
  * the following instructions were tested on Linux/Ubuntu 18.04
  * the following instructions assumed the root path under: ~/docker-keras-cpu
 
You will need:
  * to install [Docker Engine](https://docs.docker.com/engine/install/)
  * a copy of ST Cube-AI in ./cubeai:
    ** download / install the [STM32CubeMX](https://www.st.com/en/development-tools/stm32cubemx.html)
    ** install the [X-Cube-AI](https://www.st.com/content/st_com/en/products/embedded-software/mcu-mpu-embedded-software/stm32-embedded-software/stm32cube-expansion-packages/x-cube-ai.html) 
    ** create a simlink in ~/docker-keras-cpu/cubeai to your installed X-Cube-AI version (typically under: ~/STM32Cube/Repository/Packs/STMicroelectronics/X-Cube-AI/<M.m.b>)

## Building the image
Open a terminal into your ~/docker-keras-cpu and run:
```console
 foo@bar: ~/docker-keras-cpu$ make build
```
Docker will launch and proceed to build a new image named: "tf1.15-keras2.3.1-cpu"

On completion, you should see the new image listed: 
```console
foo@bar: ~/docker-keras-cpu$ docker image list
```

## Running the container
To run the container, from your <root> simply run:
 ```console
 foo@bar: ~/docker-keras-cpu$ make bash
 ```
 
 The doker container maps /src/workspace/ to you ~/docker-keras-cpu folder on the host side.
 
 From the terminal, you can then run your TensorFlow/Keras python scripts and the Cube-AI CLI (stm32cubeai.)

