#---------------------------------------------------------
# @author: SIANA
# @date: 08/2020
# @brief: Admin makefile to build docker/keras image.
# @ref: tagging = https://blog.container-solutions.com/tagging-docker-images-the-right-way
#---------------------------------------------------------

help:
	@cat Makefile

# Docker image info
NAME="siana/tf1.15-keras2.3.1-cpu"
VERSION="v2"
DOCKER_FILE=Dockerfile
DOCKER=docker

# Docker-Hub
TAG=$$(git log -1 --pretty=%!H(MISSING))
IMAGE=${NAME}:${TAG}
BUILD=${NAME}:${VERSION}
LATEST=${NAME}:latest

# configuration
BACKEND=tensorflow
PYTHON_VERSION?=3.6
TEST=tests/
SRC?=$(shell dirname `pwd`)

# ADMIN Tasks

build:
	docker build --no-cache -t $(IMAGE) --build-arg python_version=$(PYTHON_VERSION) -f $(DOCKER_FILE) .
        docker tag $(IMAGE) $(BUILD)
        docker tag $(IMAGE) $(LATEST)

push:
        docker push $(NAME)

# USER Tasks

bash: build
	$(DOCKER) run -it -v $(SRC):/src/workspace --env KERAS_BACKEND=$(BACKEND) $(IMAGE) bash

ipython: build
	$(DOCKER) run -it -v $(SRC):/src/workspace --env KERAS_BACKEND=$(BACKEND) $(IMAGE) ipython

notebook: build
	$(DOCKER) run -it -v $(SRC):/src/workspace --net=host --env KERAS_BACKEND=$(BACKEND) $(IMAGE)

test: build
	$(DOCKER) run -it -v $(SRC):/src/workspace --env KERAS_BACKEND=$(BACKEND) $(IMAGE) py.test $(TEST)

