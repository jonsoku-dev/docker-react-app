# 여기 FROM 부터 다음 FROM 전까지는 모두 builder stage 라는 것을 명시
FROM node:16 as builder
WORKDIR /usr/src/app
COPY ./package*.json ./
RUN npm install
COPY ./ ./
RUN npm run build # CMD 는 다음 스테이지를 기다려주지 않는다.
# 여기까지의 목표는 빌드 파일들을 생성하는 것. 리액트에서 생성된 파일과 폴더들은 /usr/src/app/build 에 들어간다.

FROM nginx
EXPOSE 80
# 다른 stage 에 있는 파일을 복사 할 때 다른 stage 이름을 명시
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

