help:
	@cat Makefile

#IMAGE="siana/keras-cpu"
IMAGE="siana/tf1.15-keras2.3.1-cpu"
DOCKER_FILE=Dockerfile
DOCKER=docker
BACKEND=tensorflow
PYTHON_VERSION?=3.6
TEST=tests/
SRC?=$(shell dirname `pwd`)

build:
	docker build --no-cache -t $(IMAGE) --build-arg python_version=$(PYTHON_VERSION) -f $(DOCKER_FILE) .

bash: build
	$(DOCKER) run -it -v $(SRC):/src/workspace --env KERAS_BACKEND=$(BACKEND) $(IMAGE) bash

ipython: build
	$(DOCKER) run -it -v $(SRC):/src/workspace --env KERAS_BACKEND=$(BACKEND) $(IMAGE) ipython

notebook: build
	$(DOCKER) run -it -v $(SRC):/src/workspace --net=host --env KERAS_BACKEND=$(BACKEND) $(IMAGE)

test: build
	$(DOCKER) run -it -v $(SRC):/src/workspace --env KERAS_BACKEND=$(BACKEND) $(IMAGE) py.test $(TEST)

