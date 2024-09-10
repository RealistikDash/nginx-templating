#!/usr/bin/make
build:
	docker build . -t nginx-templated:latest
