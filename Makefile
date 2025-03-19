PROJECT_NAME = inception

make: all

build:
	mkdir -p /home/afavier/data/wordpress
	mkdir -p /home/afavier/data/mariadb
	sudo docker-compose -f srcs/docker-compose.yml build

up: build
	sudo docker-compose -f srcs/docker-compose.yml up -d

all: build up

down:
	sudo docker-compose -f srcs/docker-compose.yml down --volumes

clean: down
	sudo rm -rf /home/afavier/data/wordpress
	sudo rm -rf /home/afavier/data/mariadb

mariadb:
	docker-compose -f srcs/docker-compose.yml logs -f mariadb

wordpress:
	docker-compose -f srcs/docker-compose.yml logs -f wordpress

nginx:
	docker-compose -f srcs/docker-compose.yml logs -f nginx

logs:
	docker-compose -f srcs/docker-compose.yml logs -f


.PHONY :build up clean down logs all mariadb wordpress nginx 
