## Terragrunt
.PHONY: terragrunt.help
TERRAFORM_VERSION := 0.10.0
TERRAFORM_DIR:=$(PROVISION_DIR)/terraform
terragrunt := terragrunt

terragrunt.help:
	@echo '    terragrunt:'
	@echo ''
	@echo '        terragrunt                 Apply all'
	@echo '        terragrunt.init            Init download dependences terraform'
	@echo '        terragrunt.encrypt         encrypt by stage'
	@echo '        terragrunt.decrypt         decrypt by stage'
	@echo '        terragrunt.plan            plan by stage'
	@echo '        terragrunt.apply           apply by stage'
	@echo '        terragrunt.output          output by stage'
	@echo '        terragrunt.refresh         refresh by stage'
	@echo '        terragrunt.destroy         destroy by stage'
	@echo ''

terragrunt: clean
	make terragrunt.help

terragrunt.encrypt: clean
	@ansible-vault encrypt "${TERRAFORM_DIR}/us-east-1/${stage}/variables.tf" \
		--vault-password-file "${HOME}/${PROJECT}.txt" && echo $(MESSAGE_HAPPY)

terragrunt.decrypt: clean
	@ansible-vault decrypt "${TERRAFORM_DIR}/us-east-1/${stage}/variables.tf" \
		--vault-password-file "${HOME}/${PROJECT}.txt" && echo $(MESSAGE_HAPPY)

terragrunt.init: clean
	@if [ -z "${stage}" ]; then \
		cd "${TERRAFORM_DIR}/us-east-1/" && $(terragrunt) init --reconfigure; \
	else \
		cd "${TERRAFORM_DIR}/us-east-1/${stage}/" && $(terragrunt) init --reconfigure; \
	fi

terragrunt.plan: clean
	@if [ -z "${stage}" ]; then \
		cd "${TERRAFORM_DIR}/us-east-1/" && $(terragrunt) plan-all --terragrunt-source-update; \
	else \
		cd "${TERRAFORM_DIR}/us-east-1/${stage}/" && $(terragrunt) plan --terragrunt-source-update; \
	fi

terragrunt.apply: clean
	@if [ -z "${stage}" ]; then \
		cd "${TERRAFORM_DIR}/us-east-1/" && $(terragrunt) apply-all --terragrunt-source-update; \
	elif [ -n "${stage}" ] && [ -z "${region}" ]; then \
		cd "${TERRAFORM_DIR}/us-east-1/${stage}/" && $(terragrunt) apply --terragrunt-source-update; \
	elif [ -n "${stage}" ] && [ -n "${region}" ]; then \
		cd "${TERRAFORM_DIR}/${region}/${stage}/" && $(terragrunt) apply --terragrunt-source-update; \
	fi

terragrunt.destroy: clean
	@if [ -z "${stage}" ] && [ -z "${region}" ]; then \
		cd "${TERRAFORM_DIR}/us-east-1/" && $(terragrunt) destroy-all --terragrunt-source-update; \
	elif [ -n "${stage}" ] && [ -z "${region}" ]; then \
		cd "${TERRAFORM_DIR}/us-east-1/${stage}/" && $(terragrunt) destroy --terragrunt-source-update; \
	elif [ -n "${stage}" ] && [ -n "${region}" ]; then \
		cd "${TERRAFORM_DIR}/${region}/${stage}/" && $(terragrunt) destroy --terragrunt-source-update; \
	fi

terragrunt.output: clean
	@if [ -z "${stage}" ]; then \
		cd "${TERRAFORM_DIR}/us-east-1/" && $(terragrunt) output-all --terragrunt-source-update; \
	else \
		cd "${TERRAFORM_DIR}/us-east-1/${stage}/" && $(terragrunt) output --terragrunt-source-update; \
	fi

terragrunt.refresh: clean
	@cd "${TERRAFORM_DIR}/us-east-1/${stage}/" && $(terragrunt) refresh
