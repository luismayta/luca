# Flask
.PHONY: flask.help
PATH_DOCKER_COMPOSE:=provision/docker-compose
SERVICE=app
STAGE=dev

flask.help:
	@echo '    Flask:'
	@echo ''
	@echo '        flask                    command=(server|dynamodb)'
	@echo '        flask.run                run flask'
	@echo ''

flask: clean
	@if [[ -z "${command}" ]]; then \
		make flask.help;\
	fi
	@if [ -z "${stage}" ] && [ -n "${command}" ]; then \
		$(docker-compose) -f "${PATH_DOCKER_COMPOSE}"/dev.yml run --rm app bash -c "python manage.py ${command}"; \
	elif [ -n "${stage}" ] && [ -n "${command}" ]; then \
		$(docker-compose) -f "${PATH_DOCKER_COMPOSE}"/"${stage}".yml run --rm app bash -c "python manage.py ${command}"; \
	fi


flask.run: clean
	$(docker-compose) -f ${PATH_DOCKER_COMPOSE}/${STAGE}.yml run --rm --service-ports \
		app bash -c "python manage.py server --host=0.0.0.0 --port=8000" ; \

flask.gunicorn: clean
	$(docker-compose) -f ${PATH_DOCKER_COMPOSE}/${STAGE}.yml run --rm --service-ports \
		app bash -c "python manage.py gunicorn -b 0.0.0.0:8000 --workers=4 --worker-class=meinheld.gmeinheld.MeinheldWorker" ; \
