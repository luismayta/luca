#
# See ./CONTRIBUTING.rst
#

TAG :=""
END :=""

.PHONY: help build up requirements clean lint test help
.DEFAULT_GOAL := help

PROJECT := python-facebook-chatbot
PROJECT_DEV := $(PROJECT)_dev
PROJECT_STAGE := $(PROJECT)_stage
PROJECT_TEST := $(PROJECT)_test
PYTHON_VERSION=3.6.1
PYENV_NAME="${PROJECT}"
TERRAFORM_VERSION := 0.10.0
# Git
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

# Configuration.
SHELL := /bin/bash
ROOT_DIR=$(shell pwd)
MESSAGE:=༼ つ ◕_◕ ༽つ
MESSAGE_HAPPY:="${MESSAGE} Happy Coding"
EXTRAS_DIR:= $(ROOT_DIR)/extras
SCRIPT_DIR=$(EXTRAS_DIR)/scripts
SOURCE_DIR=$(ROOT_DIR)/
REQUIREMENTS_DIR=$(ROOT_DIR)/requirements/
FILE_README=$(ROOT_DIR)/README.rst

include *.mk

help:
	@echo '${MESSAGE} Makefile for ${PROJECT}'
	@echo ''
	@echo 'Usage:'
	@echo '    environment               create environment with pyenv'
	@echo '    install                   install dependences python by env'
	@echo '    clean                     remove files of build'
	@echo '    setup                     install requirements'
	@echo '    hooks                     copy hooks for git'
	@echo ''
	@echo '    Docker:'
	@echo ''
	@echo '        docker.build         build all services with docker-compose'
	@echo '        docker.cleanup       Clean images docker unnecesary'
	@echo '        docker.down          down services docker-compose'
	@echo '        docker.list          list services of docker'
	@echo '        docker.ssh           connect by ssh to container'
	@echo '        docker.stop          stop services by env'
	@echo '        docker.status        status container by env'
	@echo '        docker.verify_network           verify network'
	@echo '        docker.up             up services of docker-compose'
	@echo '        docker.run            run {service} {env}'
	@echo '        docker.list           list services of docker'
	@echo ''
	@echo '    Docs:'
	@echo ''
	@echo '        docs.show                  Show restview README'
	@echo '        docs.make.html             Make documentation html'
	@echo '        docs.make.pdf              Make documentation pdf'
	@echo ''
	@echo '    Tests:'
	@echo ''
	@echo '        test                       Run All tests with coverage'
	@echo '        test.lint                  Run all pre-commit'
	@echo '        test.syntax                Run all syntax in code'
	@echo ''

clean:
	@echo "$(TAG)"Cleaning up"$(END)"
	@rm -rf .tox *.egg dist build .coverage
	@find . -name '__pycache__' -delete -print -o -name '*.pyc' -delete -print -o -name '*.tmp' -delete -print
	@echo

hook:
	cp -rf $(EXTRAS_DIR)/git/hooks/prepare-commit.msg .git/hooks/
	chmod a+x .git/hooks/prepare-commit.msg

setup: clean
	$(pip_install) "${REQUIREMENTS_DIR}/setup.txt"
	pre-commit install
	cp -rf .env-sample .env

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
		$(pip_install) requirements.txt; \
	else \
		$(pip_install) "${REQUIREMENTS_DIR}/${env}.txt"; \
	fi
