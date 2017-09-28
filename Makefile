#
# See ./CONTRIBUTING.rst
#

TAG :=""
END :=""

.PHONY: help build up requirements clean lint test help
.DEFAULT_GOAL := help

PROJECT_NAME := python-facebook-chatbot
PROJECT_NAME_DEV := $(PROJECT_NAME)_dev
PROJECT_NAME_STAGE := $(PROJECT_NAME)_stage
PROJECT_NAME_TEST := $(PROJECT_NAME)_test

PYTHON_VERSION=3.6.0
PYENV_NAME="${PROJECT_NAME}"

# Configuration.
SHELL := /bin/bash
ROOT_DIR=$(shell pwd)
MESSAGE:=༼ つ ◕_◕ ༽つ
MESSAGE_HAPPY:="${MESSAGE} Happy Coding"
SCRIPT_DIR=$(ROOT_DIR)/extras/scripts
SOURCE_DIR=$(ROOT_DIR)/
REQUIREMENTS_DIR=$(ROOT_DIR)/requirements/
FILE_README=$(ROOT_DIR)/README.rst


include *.mk

help:
	@echo '${MESSAGE} Makefile for bot lannister'
	@echo ''
	@echo 'Usage:'
	@echo '    make environment               create environment with pyenv'
	@echo '    make install                   install dependences python by env'
	@echo '    make clean                     remove files of build'
	@echo '    make setup                     install requirements'
	@echo ''
	@echo '    Docker:'
	@echo ''
	@echo '        make docker.build         build all services with docker-compose'
	@echo '        make docker.down          down services docker-compose'
	@echo '        make docker.ssh           connect by ssh to container'
	@echo '        make docker.stop          stop services by env'
	@echo '        make docker.verify_network           verify network'
	@echo '        make docker.up             up services of docker-compose'
	@echo '        make docker.list           list services of docker'
	@echo '    Docs:'
	@echo ''
	@echo '        docs.show                  Show restview README'
	@echo '        docs.make.html             Make documentation html'
	@echo '        docs.make.pdf              Make documentation pdf'
	@echo '    Tests:'
	@echo '        test.lint                  Run all pre-commit'
	@echo '        test.syntax                Run all syntax in code'
	@echo ''

clean:
	@echo "$(TAG)"Cleaning up"$(END)"
	@rm -rf .tox *.egg dist build .coverage
	@find . -name '__pycache__' -delete -print -o -name '*.pyc' -delete -print -o -name '*.tmp' -delete -print
	@echo

setup: clean
	@make clean
	pip install -r "${REQUIREMENTS_DIR}/setup.txt"
	pre-commit install

environment: clean
	@if [ -e "$(HOME)/.pyenv" ]; then \
		eval "$(pyenv init -)"; \
		eval "$(pyenv virtualenv-init -)"; \
	fi
	pyenv virtualenv "${PYTHON_VERSION}" "${PYENV_NAME}" >> /dev/null 2>&1 || echo 'Oh Yeah!!'
	pyenv activate "${PYENV_NAME}" >> /dev/null 2>&1 || echo 'Oh Yeah!!'

install: clean
	@echo $(MESSAGE) "Deployment environment: ${env}"
	@if [ "${env}" == "" ]; then \
		pip install -r requirements.txt; \
	else \
		pip install -r "${REQUIREMENTS_DIR}/${env}.txt"; \
	fi
