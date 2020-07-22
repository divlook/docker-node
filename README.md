# README

개발 환경에서 NodeJs를 사용하기 위한 도커 이미지입니다.

- NodeJs LTS : [node:lts](https://hub.docker.com/_/node)

- Timezone : Asia/Seoul (default)

    `timezone`은 `Asia/Seoul`이 기본값이며, `docker-node.env`에서 수정할 수 있습니다.

- Built-in : vim, git, bash

## Repository

- https://hub.docker.com/r/divlook/node
- https://github.com/divlook/docker-node

## Quick Start

### Pull Image

```bash
docker pull divlook/node
```

### Create Env File

작업할 공간에 `docker-node.env` 파일을 생성해주세요.

```yml
TZ="Asia/Seoul"
GIT_USER_NAME="username"
GIT_USER_EMAIL="username@example.com"
```

| 이름            | 기본값       | 설명      |
| -------------- | ---------- | -------- |
| TZ             | Asia/Seoul | timezone |
| GIT_USER_NAME  | node       | username |
| GIT_USER_EMAIL |            | email    |

### Docker Run

`docker run` 명령어를 사용한 방법입니다.

```bash
docker run \
    -it \
    --rm \
    --name divlook-node \
    --env-file "./docker-node.env" \
    -p "3000:3000" \
    -v "$PWD:/app" \
    -v "$HOME/.ssh/id_rsa:/root/.ssh/id_rsa" \
    -w "/app" \
    divlook/node
```

### Docker Compose (Recommend)

`docker-compose`를 사용한 방법입니다.

#### docker-compose 설정 파일 생성

작업할 공간에 `docker-compose.yml` 파일을 생성해주세요.

```yml
version: "3"
services:
    app:
        env_file:
            - ./docker-node.env
        image: "divlook/node"
        container_name: "divlook-node"
        ports:
            - "3000:3000"
        network_mode: "bridge"
        volumes:
            - ".:/app"
            - "~/.ssh/id_rsa:/root/.ssh/id_rsa"
        working_dir: "/app"
        stdin_open: true
        tty: true
```
#### docker-compose 실행

작업 공간에서 아래 명령어를 실행하세요.

```bash
docker-compose up
```

## Develop Guide

### 이미지 빌드

```
docker build --pull -t divlook/node .
docker build --pull --no-cache -t divlook/node .
```

### 컨테이너 실행

```
docker run -it --rm --name divlook-node divlook/node bash
```
