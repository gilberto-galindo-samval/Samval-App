FROM node:20-slim as builder
ARG BUILD_ENV=production

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .

ARG ENV_FILE_NAME=environment.$BUILD_ENV.ts
RUN sed -i "s|##ENV_NAME_PLACEHOLDER##|$BUILD_ENV|g" src/environments/$ENV_FILE_NAME

RUN npm run build -- --configuration=$BUILD_ENV

FROM nginx:alpine

COPY --from=builder /app/dist/samval-ui/browser/ /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
