# README

![Docker CI](https://github.com/divlook/docker-node/workflows/Docker%20CI/badge.svg)

개발 환경에서 NodeJs를 사용하기 위한 도커 이미지입니다.

- NodeJs LTS : [node:lts](https://hub.docker.com/_/node)

- Timezone : Asia/Seoul (default)

    `timezone`은 `Asia/Seoul`이 기본값이며, `docker-node.env`에서 수정할 수 있습니다.

- Built-in : vim, git, bash, yarn

## Repository

- Github : https://github.com/divlook/docker-node
- Docker Hub : https://hub.docker.com/r/divlook/node
- GitHub Packages : https://github.com/users/divlook/packages/container/package/node

## Quick Start

### Pull Image

#### Docker Hub

`Docker Hub` 정책이 변경되어 6개월 미사용시 저장소가 삭제될 수 있는 문제가 발생하였습니다. 이를 대비하여 `GitHub Packages`에도 동일한 이미지를 업로드하고 있습니다. 이 이미지를 장기적으로 사용하실 분은 [GitHub Packages](#GitHub-Packages)의 이미지를 `pull` 받아주세요.

```bash
docker pull divlook/node:latest
```

#### GitHub Packages

```bash
docker pull ghcr.io/divlook/node:latest
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
    divlook/node \
    "yarn && yarn dev"
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
        command: ['yarn && yarn dev']
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
