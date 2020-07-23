FROM node:lts
LABEL maintainer="uihyeon.cha@gmail.com"

ARG TZ="Asia/Seoul"
ARG GIT_USER_NAME="node"
ARG GIT_USER_EMAIL=""

# timezone 설정
ENV TZ="${TZ}"
ENV GIT_USER_NAME="${GIT_USER_NAME}"
ENV GIT_USER_EMAIL="${GIT_USER_EMAIL}"

# 필요한 패키지 설치
RUN apt-get update -y
RUN apt-get install -y vim

# .ssh 폴더 미리 생성
RUN mkdir -m 700 /root/.ssh
WORKDIR /root/.ssh
COPY ./src/root/.ssh/config config
RUN chmod 400 /root/.ssh/config

# /utils/startup.sh 파일 추가
WORKDIR /utils
COPY ./src/utils/startup.sh ./startup.sh
RUN chmod 700 -R /utils

# /app 디렉토리 생성 및 이동
WORKDIR /app

# /utils/startup.sh 파일 실행 후
ENTRYPOINT [ "/utils/startup.sh" ]
# 컨테이너 유지를 위해 bash 실행
CMD [ "bash" ]
