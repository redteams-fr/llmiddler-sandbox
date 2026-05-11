.PHONY: help run shell pull

.DEFAULT_GOAL := help

# Variables
IMAGE_NAME ?= redteamsfr/llmiddler-sandbox
IMAGE_TAG  ?= latest-light
ENV_FILE   ?= ./.env
TZ         ?= Europe/Paris


help:
	@echo "llmiddler-sandbox - Commandes disponibles:"
	@echo ""
	@echo "  make run          - Lancer un conteneur interactif (image complète)"
	@echo "  make shell        - Alias de 'run'"
	@echo "  make pull         - Récupérer la dernière version de l'image"
	@echo ""
	@echo "Variables:"
	@echo "  IMAGE_NAME=$(IMAGE_NAME)"
	@echo "  IMAGE_TAG=$(IMAGE_TAG)"
	@echo "  ENV_FILE=$(ENV_FILE)  (relatif au dossier llmiddler-sandbox)"
	@echo "  TZ=$(TZ)"
	@echo ""

pull:
	docker pull $(IMAGE_NAME):$(IMAGE_TAG)

shell: run

run: pull
	docker run --init -p 8090:8090 -p 9090:9090 --env-file $(ENV_FILE) -e TZ=$(TZ) -it --rm $(IMAGE_NAME):$(IMAGE_TAG) bash

