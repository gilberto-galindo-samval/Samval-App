# Etapa 1: Build Angular
FROM node:18-alpine AS build

WORKDIR /app

# Instalar dependencias
COPY package*.json ./
RUN npm install

# Copiar código fuente
COPY . .

# Compilar Angular en producción
RUN npm run build

# Etapa 2: Servir con nginx
FROM nginx:alpine

# Copiar archivos válidos (la carpeta browser)
COPY --from=build /app/dist/samval-ui/browser /usr/share/nginx/html

# Angular routing fallback
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
