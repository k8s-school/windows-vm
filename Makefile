-include .env

.PHONY: up down logs status rdp

up: ## Start the Windows VM (first run downloads and installs Windows, ~20 min)
	@test -e /dev/kvm || { echo "ERROR: /dev/kvm missing, enable virtualization (VT-x/AMD-V)"; exit 1; }
	@mkdir -p storage shared
	docker compose up -d
	@echo "Web viewer: http://localhost:8006  |  RDP: localhost:3389"

down: ## Stop the VM (Windows is shut down gracefully, disk kept in ./storage)
	docker compose down

logs: ## Follow installation/boot logs
	docker compose logs -f

status: ## Show container status
	docker compose ps

rdp: ## Connect with FreeRDP
	xfreerdp3 /v:localhost:3389 /u:$(or $(WIN_USER),user) /p:$(or $(WIN_PASSWORD),changeme) /dynamic-resolution /cert:ignore
