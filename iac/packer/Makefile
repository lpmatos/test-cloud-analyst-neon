.PHONY: build validate

DOCKER=docker run -it --rm --env-file credentials -v ${PWD}:/opt -w /opt hashicorp/packer:latest

build:
	${DOCKER} build ./apache.json

validate:
	${DOCKER} validate ./apache.json
