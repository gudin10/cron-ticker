#Trae la version de node alpine
#FROM --platform=linux/arm64 node:19.2-alpine3.16
#docker buildx build --platform linux/amd64, linux/arm64, linux/arm64/v7, linux/arm64/v8 \
#-t intydocker21/cron-ticker --push .
#$BUILDPLATFORM : Para especificar la plataforma
#1. Primera Etapa dev
FROM node:19.2-alpine3.16 as deps
# /app

#cd
WORKDIR /app

#Dest /app
COPY package.json ./

#ejecutar comandos
RUN npm install

#2. Segunda Etapa build y test
FROM node:19.2-alpine3.16 as builder

WORKDIR /app
#trae de la imagen anterior los directorios de "deps" al nuevo stage builder
COPY --from=deps /app/node_modules ./node_modules
#copiamos lo que no este excluido en dockerignore
COPY . .
#Realizar testing
RUN npm run test
#RUN npm run build - es para prod

#Dependencias de produccion
FROM node:19.2-alpine3.16 as prod-deps
WORKDIR /app
COPY package.json ./
RUN npm install --prod


#3. Tercera etapa ejecutar la app
FROM node:19.2-alpine3.16 as runner

WORKDIR /app
#Dest /app
#COPY app.js ./ copia todo lo que esta en mi proyecto y la raiz de la imagen del workdir
COPY --from=prod-deps /app/node_modules ./node_modules

COPY app.js ./
COPY tasks/ ./tasks

#Eliminar archivos y directorios no necesarios en PROD
#RUN rm -rf test && rm -rf node_modules

#Unicamente las dependencias de prod
#RUN npm install --prod

#comando de inicio de la aplicacion
CMD [ "node","app.js" ]

