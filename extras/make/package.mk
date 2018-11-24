#
# See ./CONTRIBUTING.rst
#

package.help:
	@echo '    Package:'
	@echo ''
	@echo '        package.build         build packages for python'
	@echo ''

package.build: clean 
	python setup.py sdist
