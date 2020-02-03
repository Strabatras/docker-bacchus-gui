# Подготовка GUI к деплою

## Очередность запуска

- docker-compose build
- docker-compose up -d

- docker-compose run -e BUILD=css nodejs
- docker-compose run php
- docker-compose run -e BUILD=js nodejs
- docker-compose run yui
- docker-compose run -e BUILD=gzip nodejs