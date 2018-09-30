help:
	@cat Makefile

DOCKER_FILE=Dockerfile
DOCKER=docker
BACKEND=tensorflow
PYTHON_VERSION?=3.6
TEST=tests/
SRC?=$(shell dirname `pwd`)

build:
	docker build -t keras --build-arg python_version=$(PYTHON_VERSION) -f $(DOCKER_FILE) .

bash: build
	$(DOCKER) run -it -v $(SRC)/..:/src/workspace --env KERAS_BACKEND=$(BACKEND) keras bash

ipython: build
	$(DOCKER) run -it -v $(SRC)/..:/src/workspace --env KERAS_BACKEND=$(BACKEND) keras ipython

notebook: build
	$(DOCKER) run -it -v $(SRC)/..:/src/workspace --net=host --env KERAS_BACKEND=$(BACKEND) keras

test: build
	$(DOCKER) run -it -v $(SRC)/..:/src/workspace --env KERAS_BACKEND=$(BACKEND) keras py.test $(TEST)

