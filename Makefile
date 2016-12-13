# Makefile for python-facebook-chatbot.

# Configuration.
SHELL = /bin/bash
ROOT_DIR = $(shell pwd)
BIN_DIR = $(ROOT_DIR)/bin
DATA_DIR = $(ROOT_DIR)/var
SCRIPT_DIR = $(ROOT_DIR)/script

WGET = wget

# Bin scripts
CLEAN = $(shell) $(SCRIPT_DIR)/clean.sh
GVM = $(shell) $(SCRIPT_DIR)/gvm.sh
GRIP = $(shell) $(SCRIPT_DIR)/grip.sh
PYENV = $(shell) $(SCRIPT_DIR)/pyenv.sh
INSTALL = $(shell) $(SCRIPT_DIR)/install.sh
LINTCODE = $(shell) $(SCRIPT_DIR)/lintcode.sh
TEST = $(shell) $(SCRIPT_DIR)/test.sh
SYNC = $(shell) $(SCRIPT_DIR)/sync.sh
WATCH = $(shell) $(SCRIPT_DIR)/watch.sh


clean:
	$(CLEAN)


distclean: clean
	rm -rf $(ROOT_DIR)/lib
	rm -rf $(ROOT_DIR)/*.egg-info
	rm -rf $(ROOT_DIR)/demo/*.egg-info


environment:
	$(PYENV)
	$(GVM)
	$(INSTALL)


grip:
	$(GRIP)


install:
	$(INSTALL)


maintainer-clean: distclean
	rm -rf $(BIN_DIR)
	rm -rf $(ROOT_DIR)/lib/


lintcode:
	$(LINTCODE)


sync:
	$(SYNC)


watch:
	$(WATCH)


test:
	$(TEST)
