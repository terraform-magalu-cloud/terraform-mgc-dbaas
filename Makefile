# ==============================================================================
# Makefile para o módulo terraform-mgc-dbaas
# ==============================================================================

SHELL := /bin/bash
PATH  := $(HOME)/.local/bin:$(PATH)

# Dummy API Key para testes unitários locais se não fornecida
export MGC_API_KEY ?= 00000000-0000-4000-8000-000000000000

# Ferramentas
TERRAFORM      ?= terraform
TERRAFORM_DOCS ?= $(shell which terraform-docs 2>/dev/null || echo $(HOME)/.local/bin/terraform-docs)
PRE_COMMIT     ?= $(shell which pre-commit 2>/dev/null || echo $(HOME)/.local/bin/pre-commit)

# Cores
BLUE   := \033[36m
GREEN  := \033[32m
YELLOW := \033[33m
RED    := \033[31m
RESET  := \033[0m

.DEFAULT_GOAL := help

.PHONY: help
help: ## Exibe este menu de ajuda
	@echo -e "$(BLUE)Comandos disponíveis no projeto:$(RESET)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-18s$(RESET) %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: init
init: ## Inicializa o Terraform e atualiza os providers
	@echo -e "$(BLUE)==> Inicializando Terraform...$(RESET)"
	$(TERRAFORM) init -upgrade

.PHONY: fmt
fmt: ## Formata todo o código Terraform (.tf e .tftest.hcl)
	@echo -e "$(BLUE)==> Formatando arquivos HCL...$(RESET)"
	$(TERRAFORM) fmt -recursive

.PHONY: fmt-check
fmt-check: ## Verifica se todos os arquivos estão formatados (sem alterar)
	@echo -e "$(BLUE)==> Verificando formatação de código...$(RESET)"
	$(TERRAFORM) fmt -check -recursive

.PHONY: validate
validate: init ## Valida a sintaxe e configuração do módulo Terraform
	@echo -e "$(BLUE)==> Validando sintaxe do módulo...$(RESET)"
	$(TERRAFORM) validate

.PHONY: docs
docs: ## Gera e atualiza a documentação do README.md via terraform-docs
	@echo -e "$(BLUE)==> Atualizando README.md com terraform-docs...$(RESET)"
	@if command -v $(TERRAFORM_DOCS) >/dev/null 2>&1; then \
		$(TERRAFORM_DOCS) markdown table --config .terraform-docs.yml .; \
		echo -e "$(GREEN)Documentação atualizada com sucesso!$(RESET)"; \
	else \
		echo -e "$(RED)Erro: terraform-docs não encontrado em $(TERRAFORM_DOCS)$(RESET)"; \
		exit 1; \
	fi

.PHONY: test
test: init ## Executa a suíte de testes nativa do Terraform (tests/*.tftest.hcl)
	@echo -e "$(BLUE)==> Executando testes unitários nativos (terraform test)...$(RESET)"
	$(TERRAFORM) test

.PHONY: test-verbose
test-verbose: init ## Executa os testes do Terraform com saída detalhada (-verbose)
	@echo -e "$(BLUE)==> Executando testes com saída detalhada...$(RESET)"
	$(TERRAFORM) test -verbose

.PHONY: pre-commit
pre-commit: ## Executa todos os hooks do pre-commit nos arquivos modificados
	@echo -e "$(BLUE)==> Executando pre-commit em todos os arquivos...$(RESET)"
	@if command -v $(PRE_COMMIT) >/dev/null 2>&1; then \
		$(PRE_COMMIT) run --all-files; \
	else \
		echo -e "$(RED)Erro: pre-commit não encontrado em $(PRE_COMMIT)$(RESET)"; \
		exit 1; \
	fi

.PHONY: clean
clean: ## Remove arquivos temporários, caches do Terraform e lockfiles locais
	@echo -e "$(YELLOW)==> Limpando artefatos temporários e cache do Terraform...$(RESET)"
	rm -rf .terraform .terraform.lock.hcl
	find examples/ -name ".terraform" -type d -exec rm -rf {} + 2>/dev/null || true
	find examples/ -name ".terraform.lock.hcl" -type f -delete 2>/dev/null || true
	rm -f crash.log crash.*.log tfplan
	@echo -e "$(GREEN)Ambiente limpo!$(RESET)"

.PHONY: check
check: fmt-check validate docs test ## Pipeline completo local: fmt-check -> validate -> docs -> test
	@echo -e "$(GREEN)==> Todas as validações e testes passaram com sucesso!$(RESET)"
