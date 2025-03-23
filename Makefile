PROJECT_NAME	=	inception
SERVICES	=	mariadb nginx wordpress
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

re-wordpress:
	@echo "Rebuilding Wordpress container..."
	docker-compose -f $(DOCKER_COMPOSE) down -v wordpress
	docker-compose -f $(DOCKER_COMPOSE) up -d --build wordpress

re-mariadb:
	@echo "Rebuilding MariaDB container..."
	docker-compose -f $(DOCKER_COMPOSE) down -v mariadb
	docker-compose -f $(DOCKER_COMPOSE) up -d --build mariadb

re-nginx:
	@echo "Rebuildin NGINX container..."
	docker-compose -f $(DOCKER_COMPOSE) down -v nginx
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
