PROJECT_NAME = inception

build:
	mkdir -p /home/afavier/data/wordpress
	mkdir -p /home/afavier/data/mariadb
	sudo docker-compose -f srcs/docker-compose.yml build

up: build
	sudo docker-compose -f srcs/docker-compose.yml up


.PHONY :build up clean down logs

down:
	sudo docker-compose -f srcs/docker-compose.yml down --volumes

clean: down
	sudo rm -rf /home/afavier/data/wordpress
	sudo rm -rf /home/afavier/data/mariadb

logs:
	docker-compose -f srcs/docker-compose.yml logs -f mariadb
