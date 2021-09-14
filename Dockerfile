# Stage 1
FROM node:16-alpine as build-step
RUN mkdir -p /app

WORKDIR /app
COPY package.json /app

RUN npm install
RUN npm npm install -g npm@7.23.0

RUN npm rebuild node-sass --force

RUN npm install node-sass

COPY . /app

RUN npm run build --prod

# Stage 2

FROM nginx:1.17.1-alpine
COPY --from=build-step /app/docs /usr/share/nginx/html
