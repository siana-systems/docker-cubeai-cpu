#------------------------------------------------------------------------------------------
# @author: SIANA
# @date: 06/2022 (update)
# @brief: Admin makefile to build a Cube.AI docker/keras image for CPU host.
# @description:
#       This image is meant to be used to train models using TF/Keras that are intended
#       to run on STM32 MCUs using Cube-AI. As such, it includes Cube-AI compatible
#       versions of TF/Keras and the Cube-AI CLI. It also includes typical packages used
#       to process data (images and audio.) See the Dockerfile for details.
#
# @note: The docker image is tagged using a human-readable version and its git commit#
#       
# @ref: tagging = https://blog.container-solutions.com/tagging-docker-images-the-right-way
#------------------------------------------------------------------------------------------

help:
	@cat Makefile

# Docker image info
NAME="siana/tf-cubeai-cpu"
VERSION="v2.1"
DOCKER_FILE=Dockerfile 
DOCKER=docker

# Docker-Hub
TAG=$(shell git log -1 --pretty=%h)
IMAGE=$(NAME):$(TAG)
BUILD=$(NAME):$(VERSION)
LATEST=$(NAME):latest

# configuration
BACKEND=tensorflow
PYTHON_VERSION?=3.6
TEST=tests/
SRC?=$(shell dirname `pwd`)

#--->> ADMIN Tasks <<------

version:
	@echo IMAGE is $(IMAGE)
	@echo BUILD is $(BUILD)

build:
	$(DOCKER) build --no-cache -t $(IMAGE) --build-arg python_version=$(PYTHON_VERSION) -f $(DOCKER_FILE) .
	$(DOCKER) tag $(IMAGE) $(BUILD)
	$(DOCKER) tag $(IMAGE) $(LATEST)

push:
	$(DOCKER) push $(LATEST)
	$(DOCKER) push $(BUILD)

#--->> USER Tasks <<-------

pull:
	$(DOCKER) pull $(NAME)

bash:
	$(DOCKER) run -it -v $(SRC):/src/workspace --env KERAS_BACKEND=$(BACKEND) $(LATEST) bash

ipython:
	$(DOCKER) run -it -v $(SRC):/src/workspace --env KERAS_BACKEND=$(BACKEND) $(LATEST) ipython

notebook:
	$(DOCKER) run -it -v $(SRC):/src/workspace --net=host --env KERAS_BACKEND=$(BACKEND) $(LATEST)

test:
	$(DOCKER) run -it -v $(SRC):/src/workspace --env KERAS_BACKEND=$(BACKEND) $(LATEST) py.test $(TEST)

