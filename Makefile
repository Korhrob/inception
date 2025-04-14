PROJECT_NAME	=	inception
SERVICES		=	mariadb nginx wordpress
DOCKER_COMPOSE	=	srcs/docker-compose.yml

.PHONY: build force up down restart re wordpress mariadb nginx logs logs-follow ps

build: create_dir down
	@echo "Building Docker images..."
	docker-compose -f $(DOCKER_COMPOSE) build $(SERVICES)

force: create_dir down
	@echo "Forcing Docker image builds..."
	docker-compose -f $(DOCKER_COMPOSE) build --no-cache $(SERVICES)

up:
	@echo "Starting containers..."
	docker-compose -f $(DOCKER_COMPOSE) up -d --build $(SERVICES)

down:
	@echo "Stopping containers..."
	docker-compose -f $(DOCKER_COMPOSE) down

restart: down up

re: down
	@echo "Stating containers with --build..."
	docker-compose -f $(DOCKER_COMPOSE) up -d --build $(SERVICES)

wordpress: down
	@echo "Rebuilding Wordpress container..."
	docker-compose -f $(DOCKER_COMPOSE) build --no-cache wordpress

mariadb: down
	@echo "Rebuilding MariaDB container..."
	docker-compose -f $(DOCKER_COMPOSE) build --no-cache mariadb

nginx: down
	@echo "Rebuildin NGINX container..."
	docker-compose -f $(DOCKER_COMPOSE) build --no-cache nginx

clean: down
	@echo "Closing and cleaning containers..."
	docker-compose -f $(DOCKER_COMPOSE) down -v --remove-orphans
	@echo "Pruning docker images..."
	docker image prune -f

logs:
	@echo "Displaying logs..."
	docker-compose -f $(DOCKER_COMPOSE) logs $(SERVICES)

logs-follow:
	@echo "Following logs..."
	docker-compose -f $(DOCKER_COMPOSE) logs -f $(SERVICES)

ps:
	@echo "Showing container status..."
	docker-compose -f $(DOCKER_COMPOSE) ps

create_dir:
	@mkdir -p /home/robert/data/mariadb
	@mkdir -p /home/robert/data/wordpress