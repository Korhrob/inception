PROJECT_NAME	=	inception
SERVICES		=	mariadb nginx wordpress
DOCKER_COMPOSE	=	srcs/docker-compose.yml

.PHONY: build force up down restart re wordpress mariadb nginx logs logs-follow ps

build: create_dir
	@echo "Building Docker images..."
	docker-compose -f $(DOCKER_COMPOSE) build $(SERVICES)

up:
	@echo "Starting containers..."
	docker-compose -f $(DOCKER_COMPOSE) up -d $(SERVICES)

down:
	@echo "Stopping containers..."
	docker-compose -f $(DOCKER_COMPOSE) down --remove-orphans

restart: down up

re: clean build

wordpress:
	@echo "Rebuilding Wordpress container..."
	docker-compose -f $(DOCKER_COMPOSE) build --no-cache wordpress

mariadb:
	@echo "Rebuilding MariaDB container..."
	docker-compose -f $(DOCKER_COMPOSE) build --no-cache mariadb

nginx:
	@echo "Rebuilding NGINX container..."
	docker-compose -f $(DOCKER_COMPOSE) build --no-cache nginx

clean: down
	@echo "Stopping containers and cleaning volumes..."
	docker-compose -f $(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans
	@echo "Cleaning up unused Docker images and data..."
	docker system prune -a -f
	docker volume prune -f

# have to manually remove these because they require sudo rights
#rm -rf /home/robert/data/mariadb
#rm -rf /home/robert/data/wordpress

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
