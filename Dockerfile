FROM node:20-slim AS BUILDER
ARG BUILD_ENV=production

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .

ARG ENV_FILE_NAME=environment.$BUILD_ENV.ts
RUN sed -i "s|##ENV_NAME_PLACEHOLDER##|$BUILD_ENV|g" src/environments/$ENV_FILE_NAME

RUN npm run build -- --configuration=$BUILD_ENV

# Segunda etapa
FROM nginx:alpine

# ¡IMPORTANTE! Referenciar la etapa con el mismo nombre en mayúsculas
COPY --from=BUILDER /app/dist/samval-ui/ /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
