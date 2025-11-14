COLOR := "\e[1;36m%s\e[0m\n"
RED :=   "\e[1;31m%s\e[0m\n"

################ Main Targets ################

# Initialize git submodules

init: update-submodule start

init-submodules:
	@git submodule update --init --recursive

update-submodule:
	@git submodule update --remote --merge

start:
	@docker compose up --build -d

stop:
	@docker compose down 

status:
	@docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"

restart: stop start

rm-vol:
	@docker volume prune -f

rm-img:
	@docker compose down --rmi all