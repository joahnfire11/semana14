# Dockerfile
FROM node:22-alpine

# Crear directorio de la aplicación
WORKDIR /usr/src/app

# Copiar archivos al contenedor
COPY package*.json ./
COPY . .

# Instalar dependencias con npm
RUN npm install && chown -R node:node /usr/src/app

# Cambiar al usuario node para evitar permisos problemáticos
USER node

# Exponer el puerto de la aplicación
EXPOSE 3000

# Comando para iniciar la aplicación
CMD ["node", "index.js"]
