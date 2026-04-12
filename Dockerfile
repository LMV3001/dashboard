# Étape 1 : Construction (Build)
FROM node:20-slim AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Étape 2 : Production (Serveur Nginx)
FROM nginx:stable-alpine AS production-stage
# On copie les fichiers compilés depuis l'étape précédente
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
