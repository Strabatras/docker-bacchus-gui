# Подготовка GUI к деплою

## Node
Documentation : options [see](https://nodejs.org/api/cli.html#cli_node_options_options)

## Очистка докера
How To Remove Docker Images, Containers, and Volumes : [see](https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes).

- docker rm -f $(docker ps -aq)
- docker rmi $(docker images -a -q)
- docker volume prune

## Сборка контейнера
- docker-compose build
- docker-compose up -d | docker-compose up --remove-orphans

## Очередность запуска
- docker-compose run -e BUILD=css nodejs
- docker-compose run -e BUILD=messages php
- docker-compose run -e BUILD=js nodejs
- docker-compose run yui
- docker-compose run -e BUILD=gzip nodejs
- docker-compose run -e BUILD=archive php