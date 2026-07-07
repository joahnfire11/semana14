# Dockerfile
FROM node:22-alpine
 
# Crear directorio de la aplicación
WORKDIR /usr/src/app
 
# Copiar archivos al contenedor
COPY package*.json ./
COPY index.js .
 
# Usar Yarn en lugar de npm para evitar el bug de bloqueo en Windows/WSL2
RUN yarn install --frozen-lockfile || yarn install
 
# Exponer el puerto de la aplicación
EXPOSE 3000
 
# Comando para iniciar la aplicación
CMD ["node", "index.js"]
