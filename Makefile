PROJECT_NAME	=	inception
SERVICES	=	mariadb nginx wordpress
DOCKER_COMPOSE	=	srcs/docker-compose.yml

.PHONY: build up down restart nginx logs ps

build:
	@echo "Building Docker images..."
	docker-compose -f $(DOCKER_COMPOSE) build $(SERVICES)

up:
	@echo "Starting containers..."
	docker-compose -f $(DOCKER_COMPOSE) up -d  $(SERVICES)

down:
	@echo "Stopping containers..."
	docker-compose -f $(DOCKER_COMPOSE) down -v --remove-orphans

restart: down up

re:
	@echo "Stating containers with --build..."
	docker-compose -f $(DOCKER_COMPOSE) up -d --build $(SERVICES)

prune:
	docker image prune -f

wordpress:
	@echo "Rebuilding Wordpress container..."
	docker-compose -f $(DOCKER_COMPOSE) build --build -d wordpress

mariadb:
	@echo "Rebuilding MariaDB container..."
	docker-compose -f $(DOCKER_COMPOSE) build --build -d mariadb

nginx:
	@echo "Rebuildin NGINX container..."
	docker-compose -f $(DOCKER_COMPOSE) build --build -d nginx

logs:
	@echo "Displaying logs..."
	docker-compose -f $(DOCKER_COMPOSE) logs -f

ps:
	@echo "Showing container status..."
	docker-compose -f $(DOCKER_COMPOSE) ps
