#!/usr/bin/env make

PROJECT?=simple-sensor
NAMESPACE?=retr0h
VERSION?=$(shell git describe --tags --always)

CONTAINER?=$(NAMESPACE)/$(PROJECT):$(VERSION)
CONTAINER_LATEST?=$(NAMESPACE)/$(PROJECT):latest

DOCKER_BIN=$(shell which docker)
DOCKER_FILE=zeek/Dockerfile

.PHONY: docker-build
docker-build:
	docker build -f $(DOCKER_FILE) -t $(CONTAINER) .
	docker tag $(CONTAINER) $(CONTAINER_LATEST)
