## Terragrunt
.PHONY: terragrunt.help
TERRAFORM_VERSION := 0.10.0
TERRAFORM_DIR:=$(PROVISION_DIR)/terraform

terraform:
	make terraform.help

terraform.help:
	@echo '    terraform:'
	@echo ''
	@echo '        terraform                 Apply all'
	@echo '        terraform.encrypt         encrypt by stage'
	@echo '        terraform.decrypt         decrypt by stage'
	@echo '        terraform.plan            plan by stage'
	@echo '        terraform.apply           apply by stage'
	@echo '        terraform.destroy         destroy by stage'
	@echo ''

terraform.encrypt: clean
	@ansible-vault encrypt "${TERRAFORM_DIR}/us-east-1/${stage}/variables.tf" \
		--vault-password-file "${HOME}/${PROJECT}.txt" && echo $(MESSAGE_HAPPY)

terraform.decrypt: clean
	@ansible-vault decrypt "${TERRAFORM_DIR}/us-east-1/${stage}/variables.tf" \
		--vault-password-file "${HOME}/${PROJECT}.txt" && echo $(MESSAGE_HAPPY)

terraform.plan: clean
	@cd "${TERRAFORM_DIR}/us-east-1/${stage}/" && $(terraform) plan

terraform.apply: clean terraform.plan
	@cd "${TERRAFORM_DIR}/us-east-1/${stage}/" && $(terraform) apply

terraform.destroy: clean terraform.plan
	@cd "${TERRAFORM_DIR}/us-east-1/${stage}/" && $(terraform) destroy
