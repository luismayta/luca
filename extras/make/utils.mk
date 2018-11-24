#
# See ./CONTRIBUTING.rst
#
.PHONY: utils.help

utils.help:
	@echo '    utils:'
	@echo ''
	@echo '        utils                      help utils'
	@echo '        utils.generate             generate key ssh by stage'
	@echo '        utils.convert              convert id_rsa to pem by stage'
	@echo ''

utils: clean
	make utils.help

utils.generate: clean
	ssh-keygen -t rsa -b 4096 -C "admin@${PROJECT}-${stage}.com"

utils.convert: clean
	openssl rsa -in "${PROJECT}-${stage}" -outform pem > "${PROJECT}-${stage}".pem
	chmod 0400 "${PROJECT}-${stage}".pem
