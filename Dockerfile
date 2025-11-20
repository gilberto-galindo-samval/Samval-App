FROM node:20-slim as builder
ARG BUILD_ENV=production

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .

RUN npm run build -- --configuration=$BUILD_ENV

FROM nginx:alpine

COPY --from=builder /app/dist/samval-ui/browser/ /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
