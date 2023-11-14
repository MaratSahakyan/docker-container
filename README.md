# Order

## Build images

### Frontend

docker pull node:18 nginx:alpine node:latest

```console
export CP_PATH="classic_token"
echo $CP_PATH | docker login ghcr.io -u yourDockerUsername --password-stdin

docker build -t ghcr.io/gitHubUserNameLowerCase/vue-order-service . -f dockerfiles/front.dockerfile
docker push ghcr.io/gitHubUserNameLowerCase/vue-order-service:latest

### Backend

console
docker build -t ghcr.io/gitHubUserNameLowerCase/nest-order-service . -f dockerfiles/back.dockerfile
docker push ghcr.io/gitHubUserNameLowerCase/nest-order-service:latest

## Run compose

console
docker-compose --file docker-compose.yml --env-file=.env up -d --remove-orphans

## Setup ghcr

### Add token

console
export CP_PATH="classic_token"

### Authentication

console
echo $CP_PATH | docker login ghcr.io -u gitHubUserNameLowerCase --password-stdin

## Docker push images

console
docker push ghcr.io/gitHubUserNameLowerCase/vue-order-service:latest
docker push ghcr.io/gitHubUserNameLowerCase/nest-order-service:latest
```
