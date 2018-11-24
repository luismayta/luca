# Zappa
.PHONY: zappa.help
PATH_DOCKER_COMPOSE:=provision/docker-compose
SERVICE:=zappa

zappa:
	@if [[ -z "${command}" ]]; then \
		make zappa.help;\
	fi
	@if [ -n "${stage}" ] && [ -n "${command}" ]; then \
		$(docker-compose) -f "${PATH_DOCKER_COMPOSE}"/dev.yml run --rm "$(SERVICE)" bash -c ". /bot/venv/bin/activate; zappa ${command} ${stage}"; \
	fi

zappa.help:
	@echo '    Zappa:'
	@echo ''
	@echo '        zappa                    command=(certify|deploy|update|undeploy), stage=(prod, staging)'
	@echo '        zappa.encrypt            encrypt by stage'
	@echo '        zappa.decrypt            decrypt by stage'
	@echo '        zappa.run 	            run by stage'
	@echo ''


zappa.encrypt: clean
	@ansible-vault encrypt "zappa_settings.json" \
		--vault-password-file "${HOME}/${PROJECT}.txt" && echo $(MESSAGE_HAPPY)

zappa.decrypt: clean
	@ansible-vault decrypt "zappa_settings.json" \
		--vault-password-file "${HOME}/${PROJECT}.txt" && echo $(MESSAGE_HAPPY)

zappa.run: clean
	@if [ -z "${env}" ]; then \
		$(docker-compose) -f "${PATH_DOCKER_COMPOSE}"/dev.yml run --rm ${SERVICE} bash; \
	else \
		$(docker-compose) -f "${PATH_DOCKER_COMPOSE}"/"${env}".yml run --rm ${SERVICE} bash; \
	fi

