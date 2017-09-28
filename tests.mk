#
# See ./CONTRIBUTING.rst
#

test.lint: clean
	pre-commit run --all-files --verbose

test.syntax: clean
	@echo $(MESSAGE) Running tests $(END)
	ansible-playbook tests/test.yaml -i tests/inventory --syntax-check