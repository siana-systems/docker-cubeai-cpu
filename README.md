# STM32 Cube-AI Development Docker for CPU-Host

This repo provides a docker image for deep-learning development targeting the STMicroelectronics [Cube-AI](https://www.st.com/en/embedded-software/x-cube-ai.html). It includes most typical packages needed to process & train a model using TensorFlow/Keras and compiling the resulting model using the Cube-AI command-line interface.

## Running the SIANA image

Note: the following instructions were tested on Linux/Ubuntu 18.04

To run a container from the SIANA hosted image on Docker Hub, you'll need to:
  * install [Docker Engine](https://docs.docker.com/engine/install/)
  * check that you have *make* installed, if not:
    * *sudo apt-get update*
    * *sudo apt-get install make*
  * download/save the *Makefile* from this repo in your training directory
  
To run the container in bash mode:
 ```console
 foo@bar: ~/$ make bash
 ```
The fist time around, Docker will proceed to download the SIANA image form Docker Hub (which may take a while...) Then, it'll run a container and open a bash terminal into it. From this terminal, you can run your TensorFlow/Keras python scripts and/or the Cube-AI CLI (stm32cubeai.) The docker container maps its /src/workspace/ to your working/training folder on the host side.
 
Note: review the Makefile targets for different runtime options.


## How to build a new image

If you need to update the docker image...

### Pre-requisites

Notes:
  * the following instructions were tested on Linux/Ubuntu 18.04
  * the following instructions assumed the root path under: ~/docker-cubeai-cpu
 
You will need:
  * to install [Docker Engine](https://docs.docker.com/engine/install/)
  * a copy of ST Cube-AI:
    * download / install the [STM32CubeMX](https://www.st.com/en/development-tools/stm32cubemx.html)
    * install the [X-Cube-AI](https://www.st.com/content/st_com/en/products/embedded-software/mcu-mpu-embedded-software/stm32-embedded-software/stm32cube-expansion-packages/x-cube-ai.html) 
    * create a simlink in ~/docker-keras-cpu/cubeai to your installed X-Cube-AI version, typically under:  ~/STM32Cube/Repository/Packs/STMicroelectronics/X-Cube-AI/<M.m.b>

### building the image
Edit the Makefile to change the version#
Open a terminal into your ~/docker-cubeai-cpu and run:
```console
 foo@bar: ~/docker-cubeai-cpu$ make build
```
Docker will launch and proceed to build a new image named: "tf-cubeai-cpu:vx"

On completion, you should see the new image listed: 
```console
foo@bar: ~/docker-keras-cpu$ docker image list
```

