# Docker
.PHONY: docker.build docker.test docker.pkg

DOCKER_NETWORK = $(PROJECT)_network

docker.run: clean
	@if [ "${env}" == "" ]; then \
		docker-compose run --rm --service-ports "${service}" bash; \
	else \
		docker-compose -f docker-compose.yml -f $(DOCKER_COMPOSE_DIR)/"${env}".yml run --rm --service-ports "${service}" bash; \
	fi

docker.build: clean
	@echo $(MESSAGE) "Building environment: ${env}"
	@if [ "${env}" == "" ]; then \
		docker-compose build; \
	else \
		docker-compose -f docker-compose.yml -f $(DOCKER_COMPOSE_DIR)/"${env}".yml build; \
	fi

docker.down: clean
	@echo $(MESSAGE) "Down Services Environment: ${env}"
	@if [ "${env}" == "" ]; then \
		docker-compose -p "${PROJECT}" down --remove-orphans; \
	else \
		docker-compose -f docker-compose.yml -f $(DOCKER_COMPOSE_DIR)/"${env}".yml down --remove-orphans; \
	fi

docker.ssh: clean
	docker exec -it $(CONTAINER) bash

docker.status: clean
	@echo $(MESSAGE) "status Services: ${env}"
	@if [ "${env}" == "" ]; then \
		docker-compose -p "${PROJECT}" ps; \
	else \
		docker-compose -p "${PROJECT}" -f docker-compose.yml -f $(DOCKER_COMPOSE_DIR)/"${env}".yml ps; \
	fi

docker.stop: clean
	@echo $(MESSAGE) "Stop Services: ${env}"
	@if [ "${env}" == "" ]; then \
		docker-compose -p "${PROJECT}" stop; \
	else \
		docker-compose -f docker-compose.yml -f $(DOCKER_COMPOSE_DIR)/"${env}".yml stop; \
	fi

docker.cleanup: clean
	@echo $(MESSAGE) "Removing dangling docker images...:"
	docker images -q --filter 'dangling=true' | xargs docker rmi

docker.verify_network: ## Verify network
	@if [ -z $$(docker network ls | grep $(DOCKER_NETWORK) | awk '{print $$2}') ]; then\
		(docker network create $(DOCKER_NETWORK));\
	fi

docker.up: clean
	@echo $(MESSAGE) "Up Services: ${env}"
	@if [ "${env}" == "" ]; then \
		docker-compose -p "${PROJECT}" up --remove-orphans; \
	else \
		docker-compose -f docker-compose.yml -f $(DOCKER_COMPOSE_DIR)/"${env}".yml up --remove-orphans; \
	fi

docker.list: clean
	@echo $(MESSAGE) "List Services: ${env}"
	@if [ "${env}" == "" ]; then \
		docker-compose -p "${PROJECT_DEV}" ps; \
	else \
		docker-compose -f docker-compose.yml -f $(DOCKER_COMPOSE_DIR)/"${env}".yml ps; \
	fi
