.PHONY: clean clean-build clean-pyc clean-test coverage dist docs help install lint lint/flake8 lint/black
.DEFAULT_GOAL := help

VENV = $(shell if [ -d venv ]; then echo `pwd`/venv/bin/; else echo ''; fi)
PYTHON = $(VENV)python

PYTHONPATH ?= $(shell pwd)
export PYTHONPATH

define BROWSER_PYSCRIPT
import os, webbrowser, sys

from urllib.request import pathname2url

webbrowser.open("file://" + pathname2url(os.path.abspath(sys.argv[1])))
endef
export BROWSER_PYSCRIPT

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

BROWSER ?= python -c "$$BROWSER_PYSCRIPT"

PYTHON_VERSION ?= 3.10

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean: clean-build clean-pyc clean-test clean-docs ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache

clean-docs: ## remove docs generated files
	make -C docs clean


docs: ## Generate docs
	$(MAKE) -C docs clean
	$(VENV)sphinx-apidoc -o docs/ anubis/assignment
	$(MAKE) -C docs PYTHON=$(PYTHON) html
	echo $(BROWSER) docs/html/index.html

venv: ## create venv
	virtualenv -p $(shell which python$(PYTHON_VERSION)) venv
	venv/bin/pip install -r requirements.txt  -r requirements_dev.txt
