################ Main Targets ################
init: init-submodules update-submodule start

init-submodules:
	@git submodule update --init --recursive

start:
	@docker compose up --build -d

stop:
	@docker compose down

################ Utility Targets ################
update-submodule:
	@git submodule update --remote --merge --recursive

status:
	@docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"

rm-vol:
	@docker volume prune -f

rm-img:
	@docker compose down --rmi all

reload: reload-nginx

reload-nginx:
	@docker exec -it nginx nginx -s reload

reload-postgres:
	@docker compose stop postgres
	@docker compose rm -f postgres
	@docker volume rm $$(docker volume ls -q | grep postgres || true)
	@docker compose up -d postgres
	@printf $(COLOR) "Postgres fully reset."

################ Colors and Variables ################
COLOR := "\e[1;36m%s\e[0m\n"
RED :=   "\e[1;31m%s\e[0m\n"
PARENT_NAME := $(notdir $(abspath $(dir $(lastword $(MAKEFILE_LIST)))))
