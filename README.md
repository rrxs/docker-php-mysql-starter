# docker-php-mysql-starter
A docker compose configuration to run multiple php applications in only one container

## Applications

- PHP 7.2
- Apache
- MySQL
- PhpMyAdmin

## Getting started

Run the following commands to start containers.

```bash
git clone https://github.com/rrxs/docker-php-mysql-starter.git
cd docker-php-mysql-starter
docker-compose up -d
```

Navigate into `www` folder and start your project.

```
cd www
git clone ...
```

### Ports

- http://localhost:8000 (apache)
- http://localhost:8001 (phpMyAdmin) (user: **root**, pass: **admin**)
- MySQL should be runnig on default port `3306`

### Locating container ip

To identify the ip to access mysql from inside the container run the following commands.

```bash
docker network ls
#search for something like 'docker-php-mysql-starter_default'

docker network inspect <NETWORK ID> | grep "Gateway"
```
