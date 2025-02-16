PROJECT_NAME = inception

build:
	  docker-compose -f srcs/docker-compose.yml build

up:
	  docker-compose -f srcs/docker-compose.yml up -d

down:
	  docker-compose -f srcs/docker-compose.yml down --volumes
logs:
	docker-compose -f srcs/docker-compose.yml logs -f mariadb
