PROJECT_NAME	=	inception
SERVICES	=	mariadb #nginx wordpress
DOCKER_COMPOSE	=	srcs/docker-compose.yml

.PHONY: build up down restart nginx logs ps

build:
	@echo "Building Docker images..."
	docker-compose -f $(DOCKER_COMPOSE) build --no-cache $(SERVICES)

up:
	@echo "Starting containers..."
	docker-compose -f $(DOCKER_COMPOSE) up -d $(SERVICES)

down:
	@echo "Stopping containers..."
	docker-compose -f $(DOCKER_COMPOSE) down

restart: down up

re: down
	@echo "Stating containers with --build..."
	docker-compose -f $(DOCKER_COMPOSE) up -d --build $(SERVICES)

wordpress: down
	@echo "Rebuilding Wordpress container..."
	docker-compose -f $(DOCKER_COMPOSE) build --build wordpress

mariadb: down
	@echo "Rebuilding MariaDB container..."
	docker-compose -f $(DOCKER_COMPOSE) build --build mariadb

nginx: down
	@echo "Rebuildin NGINX container..."
	docker-compose -f $(DOCKER_COMPOSE) build --build nginx

run-mariadb: down
	@echo "Restarting MariaDB container..."
	docker-compose -f $(DOCKER_COMPOSE) up -d --build mariadb

run-nginx: down
	@echo "Restarting NGINX container..."
	docker-compose -f $(DOCKER_COMPOSE) up -d --build nginx

prune: down
	@echo "Pruning docker images..."
	docker image prune -f

clean:
	@echo "Closing and cleaning containers..."
	docker-compose -f $(DOCKER_COMPOSE) down -v --remove-orphans

logs:
	@echo "Displaying logs..."
	docker-compose -f $(DOCKER_COMPOSE) logs

ps:
	@echo "Showing container status..."
	docker-compose -f $(DOCKER_COMPOSE) ps
